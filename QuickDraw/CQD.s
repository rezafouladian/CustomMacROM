            include "Include/ROMHeader.s"

            EXPORT  ACTIVATEPALETTE,AddComp,AddPt,AddSearch,AllocCursor,ALLOCRUNBUF
            EXPORT  AngleFromSlope,AnimateEntry,AnimatePalette,BackColor,BackPat,BackPixPat
            EXPORT  bAddOver,bAddPin,BARITH16SETUP,bArith16Tab,BARITH32SETUP,bArith32Tab
            EXPORT  bAvg,bcEnd0,bcEnd1,bcEnd3,bcMain0,bcMain1
            EXPORT  bcMain3,bEND0,bEND1,bEND10,bEND11,bEND2
            EXPORT  bEND3,bEND9,bHilite,bHiliteTab,BitAnd,BITBLT
            EXPORT  BitClr,BITMAPRGN,BitNot,BitOr,BitsDevLoop,BitSet
            EXPORT  BitShift,BitsToMap,BitsToPix,BitTst,BitXOr,bLeft0
            EXPORT  BLITCASE,bLONG8,bMAIN0,bMAIN1,bMAIN11,bMAIN2
            EXPORT  bMAIN3,bMAIN9,bMax,bMin,bSetup0,bSETUP10
            EXPORT  bSETUP8,bSloHilite,bSubOver,bSubPin,bTransparent,bXEND10
            EXPORT  bXEND11,bXEND9,bXLONG8,bXMAIN10,bXMAIN11,bXMAIN8
            EXPORT  bXMAIN9,CALCCMASK,CalcMask,CharExtra,CharWidth,CheckPic
            EXPORT  ClipRect,CloseCPort,ClosePicture,ClosePoly,CloseRgn,Color2Index
            EXPORT  ColorBit,ColorMap,COLORTHING2INDEX,CopyBits,CopyHandle,CopyMask
            EXPORT  CopyPalette,CopyPixMap,CopyPixPat,CopyRgn,CrsrCore,CrsrVBLTask
            EXPORT  CTab2Palette,CullPoints,DelComp,DelSearch,DiffRgn,DisposCCursor
            EXPORT  DisposCIcon,DisposCTable,DisposePalette,DisposeRgn,DisposeTempBuffer,DisposGDevice
            EXPORT  DisposPixMap,DoLine,DPutPicByte,DPutPicOp,DrawArc,DrawChar
            EXPORT  DrawLine,DrawPicture,DrawSlab,DrawString,DrawText2,EmptyRect
            EXPORT  EmptyRgn,EqualPt,EqualRect,EqualRgn,EraseArc,EraseOval
            EXPORT  ErasePoly,EraseRect,EraseRgn,EraseRoundRect,EXTBL,FASTLINE
            EXPORT  FASTSLABMODE,FASTSLANT,FillArc,FillCArc,FillCOval,FillCPoly
            EXPORT  FillCRect,FillCRgn,FillCRoundRect,FillOval,FillPoly,FillRect
            EXPORT  FillRgn,FillRoundRect,ForeColor,FrameArc,FrameOval,FramePoly
            EXPORT  FrameRect,FrameRgn,FrameRoundRect,GetBackColor,GETCCURSOR,GetCIcon
            EXPORT  GetClip,GetCPixel,GETCTABLE,GETCTSEED,GetDeviceList,GetEntryColor
            EXPORT  GetEntryUsage,GetFontInfo,GetForeColor,GetGDevice,GetMainDevice,GetMaskTab
            EXPORT  GetMaxDevice,GetNewPalette,GetNextDevice,GetPalette,GetPen,GetPenState
            EXPORT  GetPixel,GETPIXPAT,GetPort,GetSeek,GetSubTable,GlobalToLocal
            EXPORT  GrafDevice,GSEXPTBL,GSRUNTBL,gsSeekTbl,HideCursor,HidePen
            EXPORT  HiliteColor,Index2Color,InitCPort,InitCursor,InitGDevice,InitGraf
            EXPORT  InitPalettes,InitPort,InitRgn,InsetRect,InsetRgn,InvertArc
            EXPORT  InvertColor,InvertOval,InvertPoly,InvertRect,InvertRgn,InvertRoundRect
            EXPORT  ITabMatch,JACKSONPOLLOCK,KillPicture,KillPoly,Line,LineTo
            EXPORT  LocalToGlobal,MAKEGRAYITAB,MakeITable,MAKERGBPAT,MAKESCALETBL,MapPoly
            EXPORT  MapPt,MapRect,MapRgn,MeasureText,Move_,MovePortTo
            EXPORT  MoveTo,NewGDevice,NewPalette,NewPixMap,NewPixPat,NewRgn
            EXPORT  NewTempBuffer,NEWTEMPHANDLE,ObscureCursor,OffsetPoly,OffsetRect,OffsetRgn
            EXPORT  OLDPATTONEW,OPCOLOR,OpenCPicture,OpenCPort,OpenPicture,OpenPoly
            EXPORT  OpenPort,OpenRgn,PackBits,PackRgn,PaintArc,PaintOval
            EXPORT  PaintPoly,PaintRect,PaintRgn,PaintRoundRect,Palette2CTab,PATCONVERT
            EXPORT  PATDITHER,PATEXPAND,PATEXTBL,PenMode,PenNormal,PenPat
            EXPORT  PenPixPat,PenSize,PicComment,PicItem1,PINIT,PinRect
            EXPORT  PlotCIcon,PmBackColor,PmForeColor,PMgrDispatch,PortSize,PortToMap
            EXPORT  ProtectEntry,Pt2Rect,PtInRect,PtInRgn,PtToAngle,PUSHVERB
            EXPORT  PutLine,PutOval,PutRgn,QDError,QDEXTDISPATCHER,rAddOver
            EXPORT  rAddPin,Random,RARITH16TAB,RARITH32TAB,rAvg,rcMask0
            EXPORT  rcMask1,rcMask3,RealColor,RectInRgn,RectRgn,ReserveEntry
            EXPORT  RestoreEntries,RGBBackColor,RGBForeColor,RgnBlt,RgnOp,rHilite
            EXPORT  RHILITETAB,rMASK0,rMASK1,rMASK10,rMASK11,rMASK2
            EXPORT  rMASK3,rMASK8,rMASK9,rMax,rMin,RSECT
            EXPORT  rslowHilite,rSubOver,rSubPin,rTransparent,rXMASK10,rXMASK11
            EXPORT  rXMASK8,rXMASK9,SaveEntries,SCALEBLT,SCALEINDEXEDTOINDEXED,ScalePt
            EXPORT  SCDIRTAB1,SCDIRTAB16,SCDIRTAB2,SCDIRTAB32,SCDIRTAB4,SCDIRTAB8
            EXPORT  SCINDTAB1,SCINDTAB16,SCINDTAB2,SCINDTAB32,SCINDTAB4,SCINDTAB8
            EXPORT  ScrnBitMap,ScrollRect,SectRect,SectRgn,SEEDCFILL,SeedFill
            EXPORT  SeekRgn,SetCCursor,SetClientID,SetClip,SetCPixel,SETCPORTPIX
            EXPORT  SetCursor,SetDeviceAttribute,SetEmptyRgn,SetEntries,SetEntryColor,SetEntryUsage
            EXPORT  SetFillPat,SetGDevice,SetOrigin,SetPalette,SetPenState,SetPort
            EXPORT  SetPortBits,SetPt,SetRect,SetRectRgn,SetStdCProcs,SetStdProcs
            EXPORT  SETUPSTRETCH,ShieldCursor,ShowCursor,ShowPen,SLABMODE,SLADDOVER
            EXPORT  SLADDPIN,SLARITH16TAB,SLARITH32TAB,SLAVG,SLHILITE,SLMASK10
            EXPORT  SLMASK11,SLMASK8,SLMASK9,SLMAX,SLMIN,SlopeFromAngle
            EXPORT  SLSUBOVER,SLSUBPIN,SLTRANSPARENT,SLXMASK10,SLXMASK11,SLXMASK8
            EXPORT  SLXMASK9,SortPoints,SpaceExtra,stAddOver,stAddPin,STARITH16TAB
            EXPORT  STARITH32TAB,stAvg,STCOLORTAB,StdArc,StdBits,StdComment
            EXPORT  STDDEVLOOP,StdGetPic,StdLine,StdOpcodeProc,StdOval,StdPoly
            EXPORT  StdPutPic,StdRect,StdRgn,StdRRect,StdText,StdTxMeas
            EXPORT  STGRAYTAB,stHilite,stMASK0,stMASK1,stMASK2,stMASK3
            EXPORT  stMax,stMin,STNOSTACK,StretchBits,StringWidth,STSCANLOOP
            EXPORT  STSEARCHTAB,stSubOver,stSubPin,stTransparent,StuffHex,SubPt
            EXPORT  TestDeviceAttribute,TextFace,TextFont,TextMode,TextSize,TextWidth
            EXPORT  Translate24To32,TrimRect,UnionRect,UnionRgn,UnpackBits,UpdatePixMap
            EXPORT  XorRgn,XorSlab,A,GetDevPix

            SECTION "CQD",CODE

NewGDevice:
BLOCKHEAD:
            link.w  A6,#0
            movem.l A2-A3,-(SP)
            clr.l   ($E,A6)
            move.l  TheZone,-(SP)
            move.l  SysZone,TheZone
            moveq   #$3E,D0
            _ResrvMem
            bne.w   .L3
            moveq   #$3E,D0
            _NewHandleClear
            _HLock
            movea.l A0,A2
            movea.l (A2),A3
            moveq   #2,D0
            _NewHandleClear
            bne.w   .L3
            move.l  A0,(6,A3)
            moveq   #2,D0
            _NewHandleClear
            bne.b   .L3
            move.l  A0,($32,A3)
            moveq   #2,D0
            _NewHandleClear
            bne.b   .L3
            move.l  A0,($36,A3)
            moveq   #$50,D0
            _ResrvMem
            bne.b   .L3
            clr.l   -(SP)
            bsr.l   OpenPixMap
            move.l  (SP),($16,A3)
            movea.l (SP)+,A0
            _HLock
            move.l  (8,A6),D0
            cmpi.l  #$FFFFFFFF,D0
            beq.b   .L2
            cmpi.w  #$80,D0
            beq.b   .L1
            bset    #0,($15,A3)
.L1:
            move.w  ($C,A6),-(SP)
            move.l  (8,A6),-(SP)
            move.l  A2,-(SP)
            jsr     ([$16B8.w])
.L2:
            move.l  (SP)+,TheZone
            move.l  A2,($E,A6)
            movem.l (SP)+,A2-A3
            unlk    A6
            rtd     #6
.L3:
            move.l  A2,-(SP)
            jsr     DisposGDHandles
            bra.b   .L2
DisposGDevice:
            movea.l (SP)+,A1
            move.l  (SP),-(SP)
            bsr.b   DisposGDHandles
            movea.l (SP)+,A0
            _DisposHandle
            jmp     (A1)
DisposGDHandles:
            move.l  A1,-(SP)
            movea.l (8,SP),A1
            movea.l (A1),A1
            move.l  ($16,A1),-(SP)
            move.l  (6,A1),D0
            beq.b   .L1
            movea.l D0,A0
            _DisposHandle
.L1:
            move.l  ($32,A1),D0
            beq.b   .L2
            movea.l D0,A0
            _DisposHandle
.L2:
            move.l  ($36,A1),D0
            beq.b   .L3
            movea.l D0,A0
            _DisposHandle
.L3:
            move.l  (SP)+,D0
            beq.b   .L4
            move.l  D0,-(SP)
            jsr     ([$1610.w])
.L4:
            movea.l (SP)+,A1
            move.l  (SP)+,(SP)
            rts
            ds.b    8
InitGDevice:
            link.w  A6,#-$54
            movem.l D2/A2-A3,-(SP)
            movea.l (8,A6),A0
            _HGetState
            move.w  D0,(-$4E,A6)
            _HLock
            movea.l (A0),A2
            movea.l ($16,A2),A0
            _HGetState
            move.w  D0,(-$50,A6)
            _HLock
            movea.l (A0),A3
            move.l  TheGDevice,(-$54,A6)
            move.w  ($10,A6),(A2)
            move.l  ($C,A6),D0
            cmp.l   MinusOne,D0
            beq.w   .L3
            lea     (-$40,A6),A0
            clr.l   ($C,A0)
            clr.w   ($16,A0)
            move.w  ($10,A6),($18,A0)
            lea     (-$4C,A6),A1
            move.l  A1,($1C,A0)
            cmp.l   ($2A,A2),D0
            beq.w   .L1
            move.l  D0,($2A,A2)
            clr.w   ($30,A2)
            movem.l A0-A1,-(SP)
            move.w  ($10,A6),-(SP)
            move.l  ($C,A6),-(SP)
            move.l  ($16,A2),-(SP)
            pea     (4,A2)
            jsr     GetDevPixMap
            movem.l (SP)+,A0-A1
            move.w  #2,($1A,A0)
            move.l  ($C,A6),D0
            move.w  D0,(A1)
            clr.w   (6,A1)
            clr.l   (2,A1)
            _Control immed
            move.w  #5,($1A,A0)
            _Control immed
.L1:
            move.w  ($14,A2),D0
            not.w   D0
            andi.w  #1,D0
            move.b  D0,(A1)
            move.w  #6,($1A,A0)
            _Control immed
            cmpi.w  #0,(4,A2)
            bne.b   .L2
            movea.l ($2A,A3),A0
            _HLock
            movea.l (A0),A0
            clr.w   (4,A1)
            move.w  (6,A0),(6,A1)
            lea     (8,A0),A0
            move.l  A0,(A1)
            lea     (-$40,A6),A0
            move.w  #3,($1A,A0)
            move.l  A1,($1C,A0)
            _Control immed
            movea.l ($2A,A3),A0
            _HUnlock
.L2:
            cmpi.w  #2,(4,A2)
            beq.b   .L3
            move.l  ($2A,A3),-(SP)
            move.l  (6,A2),-(SP)
            moveq   #4,D0
            move.w  D0,($A,A2)
            move.w  D0,-(SP)
            jsr     ([$16E4.w])
.L3:
            cmpi.l  #$FFFFFFFF,($DC8).w
            beq.b   .L4
            moveq   #2,D0
            move.l  (8,A6),-(SP)
            _PaletteDispatch
.L4:
            lea     (6,A3),A0
            lea     ($22,A2),A1
            move.w  ($14,A2),D0
            btst    #$A,D0
            beq.b   .L5
            exg     A0,A1
.L5:
            move.l  (A0)+,(A1)+
            move.l  (A0)+,(A1)+
            move.l  (-$54,A6),TheGDevice
            movea.l ($16,A2),A0
            move.w  (-$50,A6),D0
            _HSetState
            movea.l (8,A6),A0
            move.w  (-$4E,A6),D0
            _HSetState
            movem.l (SP)+,D2/A2-A3
            unlk    A6
            rtd     #$A
            ds.b    12
GetDevPixMap:
            link.w  A6,#-$3A
            movem.l D3-D5/A2-A4,-(SP)
            movea.l ($C,A6),A0
            _HGetState
            move.w  D0,(-$3A,A6)
            _HLock
            movea.l (A0),A2
            move.w  ($14,A6),D0
            not.w   D0
            asl.w   #2,D0
            movea.l UTableBase,A1
            movea.l (0,A1,D0.w),A3
            movea.l (A3),A1
            lea     (-$38,A6),A0
            move.b  ($28,A1),($31,A0)
            move.b  ($29,A1),($32,A0)
            move.b  ($32,A1),($33,A0)
            _sRsrcInfo
            bne.w   .L6
            move.l  ($2A,A1),D3
            move.l  ($10,A6),D0
            move.b  D0,($32,A0)
            _sFindStruct
            bne.w   .L6
            movea.l (4,A0),A4
            clr.w   D4
            move.b  #4,($32,A0)
            _sReadWord
            bne.b   .L1
            move.w  (2,A0),D4
.L1:
            movea.l (8,A6),A1
            move.w  D4,(A1)
            move.b  #1,($32,A0)
            _sGetBlock
            bne.w   .L6
            movea.l (A0),A1
            add.l   (A1),D3
            move.l  D3,(A2)+
            move.w  (4,A1),D0
            ori.w   #$8000,D0
            move.w  D0,(A2)+
            move.l  (6,A1),(A2)+
            move.l  ($A,A1),(A2)+
            move.w  ($E,A1),(A2)+
            clr.w   (A2)+
            clr.l   (A2)+
            move.l  ($16,A1),(A2)+
            move.l  ($1A,A1),(A2)+
            move.w  ($1E,A1),(A2)+
            move.w  ($20,A1),D5
            move.w  D5,(A2)+
            move.w  ($22,A1),(A2)+
            move.w  ($24,A1),(A2)+
            move.l  ($26,A1),(A2)+
            move.l  A1,(4,A0)
            _sDisposePtr
            move.l  A4,(4,A0)
            cmpi.w  #1,D4
            beq.b   .L3
            cmpi.w  #0,D4
            bne.b   .L4
.L2:
            clr.l   -(SP)
            move.w  D5,-(SP)
            jsr     ([$1660.w])
            move.l  (SP)+,D0
            beq.w   .L5
            move.l  D0,-(SP)
            move.l  D0,-(SP)
            move.l  (A2),-(SP)
            jsr     ([$1A14.w])
            jsr     ([$1690.w])
            bra.b   .L5
.L3:
            move.b  #2,($32,A0)
            _sReadPBSize
            bne.b   .L2
            subq.l  #4,(8,A0)
            move.l  (8,A0),D0
            movea.l (A2),A0
            _SetHandleSize
            movea.l (A0),A1
            lea     (-$38,A6),A0
            move.l  A1,(A0)
            _sReadStruct
            subq.w  #4,SP
            jsr     ([$16A0.w])
            move.l  (SP)+,(A1)
            move.l  A4,(4,A0)
            bra.b   .L5
.L4:
            movea.l ($C,A6),A0
            movea.l (A0),A0
            move.w  ($24,A0),D0
            mulu.w  ($22,A0),D0
            movea.l ($2A,A0),A0
            movea.l (A0),A0
            move.l  D0,(A0)
.L5:
            movea.l (A2),A0
            movea.l (A0),A0
            move.w  #$8000,(4,A0)
            addq.w  #4,A2
            clr.l   (A2)+
            nop
.L6:
            movea.l ($C,A6),A0
            move.w  (-$3A,A6),D0
            _HSetState
            movem.l (SP)+,D3-D5/A2-A4
            unlk    A6
            rtd     #$E
            addq.w  #4,SP
            bra.b   .L6
CheckDevices:
            link.w  A6,#-$88
            movem.l D6-D7/A2-A4,-(SP)
            movea.l DeviceList,A0
            movea.l (A0),A0
            move.w  ($14,A0),D0
            btst    #$C,D0
            bne.w   GammaControl.L9
            tst.b   VidType
            beq.w   GammaControl.L9
            clr.l   -(SP)
            move.l  #'scrn',-(SP)
            clr.w   -(SP)
            jsr     ([$1480.w])
            move.l  (SP)+,D0
            beq.w   GammaControl.L9
            movea.l DeviceList,A0
            movea.l (A0),A0
            bset    #$C,($14,A0)
            move.l  D0,-(SP)
            movea.l D0,A0
            _HLock
            movea.l (A0),A4
            move.l  A4,(-$88,A6)
            move.w  (A4)+,D7
            lea     (-$78,A6),A0
            move.l  #$30001,($28,A0)
            move.w  #1,($2C,A0)
            move.b  #1,($30,A0)
            clr.b   ($31,A0)
            clr.b   ($32,A0)
            clr.b   ($33,A0)
.L1:
            lea     (-$78,A6),A0
            _sNextTypesRsrc
            beq.b   .L2
            tst.w   D7
            beq.w   .L9
            bra.b   .L7
.L2:
            move.w  (A4)+,D0
            cmp.w   ($2E,A0),D0
            bne.b   .L7
            move.w  (A4)+,D0
            cmp.b   ($31,A0),D0
            bne.b   .L7
            move.w  ($26,A0),D0
            not.w   D0
            asl.w   #2,D0
            movea.l UTableBase,A1
            movea.l (0,A1,D0.w),A3
            movea.l (A3),A1
            move.l  ($2A,A1),D0
            cmp.l   (A4)+,D0
            bne.b   .L7
            movea.l DeviceList,A3
            move.w  ($26,A0),D1
.L3:
            movea.l (A3),A1
            cmp.w   (A1),D1
            beq.b   .L4
            move.l  ($1E,A1),D0
            movea.l D0,A3
            bne.b   .L3
            bra.b   .L7
.L4:
            lea     ($A,A4),A4
            move.w  (4,A4),D0
            sub.w   (A4),D0
            cmp.w   ($26,A1),D0
            bne.b   .L7
            move.w  (6,A4),D0
            sub.w   (2,A4),D0
            cmp.w   ($28,A1),D0
            bne.b   .L7
            addq.w  #8,A4
            move.w  (A4)+,D0
            bra.b   .L6
.L5:
            move.l  (A4)+,D1
            adda.w  D1,A4
.L6:
            dbra    D0,.L5
            subq.w  #1,D7
            bmi.b   .L7
            bra.w   .L1
.L7:
            movea.l DeviceList,A0
            movea.l (A0),A0
            move.w  ($28,A0),D1
.L8:
            move.l  ($1E,A0),D0
            beq.w   GammaControl.L8
            movea.l D0,A0
            movea.l (A0),A0
            add.w   D1,($24,A0)
            add.w   D1,($28,A0)
            movea.l ($16,A0),A1
            movea.l (A1),A1
            add.w   D1,(8,A1)
            add.w   D1,($C,A1)
            move.w  ($28,A0),D1
            bra.b   .L8
.L9:
            jsr     ([$F48.w])
            move.b  #1,CrsrBusy
            movea.l CrsrDevice,A0
            movea.l (A0),A0
            move.l  ($22,A0),D0
            sub.w   D0,($832).w
            swap    D0
            sub.w   D0,Mouse
            move.l  Mouse,MTemp
            move.l  Mouse,RawMouse
            movea.l (-$88,A6),A4
            move.w  (A4)+,D7
            subq.w  #1,D7
.L10:
            lea     (-$78,A6),A0
            move.l  #$30001,($28,A0)
            move.w  #1,($2C,A0)
            move.w  (A4)+,($2E,A0)
            clr.b   ($30,A0)
            move.w  (A4)+,D0
            move.b  D0,($31,A0)
            clr.b   ($32,A0)
            clr.b   ($33,A0)
            _sNextTypesRsrc
            bne.w   .L7
            move.w  ($26,A0),D1
            movea.l DeviceList,A3
.L11:
            movea.l (A3),A0
            cmp.w   (A0),D1
            beq.b   .L12
            move.l  ($1E,A0),D0
            movea.l D0,A3
            bne.b   .L11
            bra.w   .L7
.L12:
            move.l  (A4)+,D0
            movea.l (A3),A1
            move.w  ($14,A1),D0
            and.w   (2,A4),D0
            or.w    (4,A4),D0
            bset    #$A,D0
            bset    #$D,D0
            move.w  D0,($14,A1)
            move.w  ($14,A1),D0
            btst    #$B,D0
            beq.b   .L13
            move.l  A3,MainDevice
            move.l  A3,TheGDevice
            move.l  A3,SrcDevice
            movea.l (A3),A0
            movea.l ($16,A0),A0
            movea.l (A0),A0
            move.l  (A0),D0
            move.l  D0,ScrnBase
            lea     (-$78,A6),A0
            move.w  (A4),D0
            move.b  #$80,($32,A0)
            _sFindStruct
            move.b  #1,($32,A0)
            _sGetBlock
            movea.l (A0),A1
            move.w  (4,A1),ScreenRow
            move.w  ($16,A1),ScrHRes
            move.w  ($1A,A1),ScrVRes
            move.l  A1,(4,A0)
            _sDisposePtr
.L13:
            move.w  D1,-(SP)
            move.w  (A4)+,-(SP)
            clr.w   -(SP)
            move.l  A3,-(SP)
            jsr     ([$16B8.w])
            addq.w  #4,A4
            move.w  (2,A4),D0
            cmpi.w  #$FFFF,D0
            beq.b   GammaControl.L1
            cmpi.w  #$FFFE,D0
            bne.b   .L14
            lea     (-$84,A6),A1
            clr.l   (A1)
            bsr.b   GammaControl
            bra.b   GammaControl.L1
.L14:
            clr.l   -(SP)
            move.l  #'gama',-(SP)
            move.w  D0,-(SP)
            jsr     ([$1480.w])
            move.l  (SP)+,D0
            beq.b   GammaControl.L1
            move.l  D0,-(SP)
            movea.l D0,A0
            _HLock
            lea     (-$84,A6),A1
            move.l  (A0),(A1)
            bsr.b   GammaControl
            movea.l (SP),A0
            _HUnlock
            jsr     ([$148C.w])
            bra.b   GammaControl.L1
GammaControl:
            lea     (-$40,A6),A0
            move.l  A1,($1C,A0)
            move.w  #4,($1A,A0)
            clr.l   ($C,A0)
            clr.w   ($16,A0)
            movea.l (A3),A1
            move.w  (A1),($18,A0)
            _Control immed
            rts
.L1:
            movea.l (A3),A1
            movea.l ($16,A1),A0
            movea.l (A0),A0
            move.w  ($20,A0),D0
            cmpi.w  #2,(4,A1)
            beq.w   .L5
            btst    #0,($15,A1)
            bne.b   .L2
            cmpi.w  #2,D0
            ble.b   .L3
            addi.w  #$20,D0
            bra.b   .L4
.L2:
            move.w  D0,D1
            andi.w  #9,D1
            bne.b   .L3
            addi.w  #$40,D0
            bra.b   .L4
.L3:
            move.w  (A4),D1
            cmpi.w  #$FFFF,D1
            bne.w   .L4
            cmpi.w  #$FFFF,(2,A4)
            beq.b   .L5
.L4:
            clr.l   -(SP)
            move.w  D0,-(SP)
            jsr     ([$1660.w])
            move.l  (SP)+,D0
            beq.b   .L5
            movea.l (A3),A0
            movea.l ($16,A0),A0
            movea.l (A0),A0
            move.l  ($2A,A0),-(SP)
            move.l  D0,-(SP)
            move.l  D0,-(SP)
            move.l  ($2A,A0),-(SP)
            jsr     ([$1A14.w])
            jsr     ([$1690.w])
            movea.l (SP),A0
            _HLock
            lea     (-$84,A6),A1
            movea.l (A0),A0
            clr.w   (4,A1)
            move.w  (6,A0),(6,A1)
            lea     (8,A0),A0
            move.l  A0,(A1)
            lea     (-$40,A6),A0
            move.l  A1,($1C,A0)
            move.w  #3,($1A,A0)
            clr.l   ($C,A0)
            clr.w   ($16,A0)
            movea.l (A3),A1
            move.w  (A1),($18,A0)
            _Control immed
            movea.l (SP),A0
            _HUnlock
            movea.l (A3),A1
            move.l  (6,A1),-(SP)
            moveq   #4,D0
            move.w  D0,($A,A1)
            move.w  D0,-(SP)
            jsr     ([$16E4.w])
.L5:
            addq.w  #4,A4
            movea.l (A3),A0
            movea.l ($16,A0),A1
            movea.l (A1),A1
            addq.w  #6,A1
            lea     ($22,A0),A0
            move.l  (A4)+,D0
            move.l  D0,(A1)+
            move.l  D0,(A0)+
            move.l  (A4),(A1)
            move.l  (A4)+,(A0)+
            move.w  (A4)+,D6
            bra.b   .L7
.L6:
            lea     (-$40,A6),A0
            lea     (4,A4),A1
            move.l  A1,($1C,A0)
            move.w  (A4)+,($1A,A0)
            clr.l   ($C,A0)
            clr.w   ($16,A0)
            movea.l (A3),A1
            move.w  (A1),($18,A0)
            _Control immed
            move.w  (A4)+,D0
            adda.w  D0,A4
.L7:
            dbra    D6,.L6
            dbra    D7,CheckDevices.L10
            movea.l CrsrDevice,A0
            movea.l (A0),A0
            move.l  ($22,A0),D0
            add.w   D0,($832).w
            swap    D0
            add.w   D0,Mouse
            move.l  Mouse,MTemp
            move.l  Mouse,RawMouse
            clr.b   CrsrBusy
            jsr     ([$F4C.w])
.L8:
            jsr     ([$148C.w])
.L9:
            movem.l (SP)+,D6-D7/A2-A4
            unlk    A6
            rts
            ds.b    10
GetGDevice:
            movea.l (SP)+,A0
            move.l  TheGDevice,(SP)
            jmp     (A0)
            ds.b    8
SetGDevice:
            movea.l (SP)+,A0
            move.l  (SP)+,TheGDevice
            jmp     (A0)
            ds.b    8
GetDeviceList:
            movea.l (SP)+,A0
            move.l  DeviceList,(SP)
            jmp     (A0)
            ds.b    8
GetMainDevice:
            movea.l (SP)+,A0
            move.l  MainDevice,(SP)
            jmp     (A0)
            ds.b    8
GetNextDevice:
            movea.l (SP)+,A0
            movea.l (SP)+,A1
            movea.l (A1),A1
            move.l  ($1E,A1),(SP)
            jmp     (A0)
            ds.b    4
TestDeviceAttribute:
            movea.l (SP)+,A1
            move.w  (SP)+,D0
            movea.l (SP)+,A0
            clr.b   (SP)
            movea.l (A0),A0
            move.w  ($14,A0),D1
            btst    D0,D1
            beq.b   .L1
            addq.b  #1,(SP)
.L1:
            jmp     (A1)
            ds.b    10
SetDeviceAttribute:
            movea.l (SP)+,A1
            move.b  (SP)+,D0
            move.w  (SP)+,D1
            movea.l (SP)+,A0
            movea.l (A0),A0
            move.w  ($14,A0),D2
            tst.b   D0
            bne.b   .L1
            bclr    D1,D2
            bra.b   .L2
.L1:
            bset    D1,D2
.L2:
            move.w  D2,($14,A0)
            jmp     (A1)
            dc.w    0
GetMaxDevice:
            link.w  A6,#-8
            movem.l D3/A3,-(SP)
            clr.l   ($C,A6)
            moveq   #0,D3
            movea.l DeviceList,A3
.L1:
            movea.l (A3),A0
            tst.w   ($14,A0)
            bpl.b   .L2
            clr.b   -(SP)
            move.l  (8,A6),-(SP)
            pea     ($22,A0)
            pea     (-8,A6)
            jsr     ([$10A8.w])
            tst.b   (SP)+
            beq.b   .L2
            movea.l (A3),A0
            movea.l ($16,A0),A0
            movea.l (A0),A0
            move.w  ($20,A0),D0
            cmp.w   D3,D0
            ble.b   .L2
            move.w  D0,D3
            move.l  A3,($C,A6)
.L2:
            movea.l (A3),A0
            move.l  ($1E,A0),D0
            movea.l D0,A3
            bne.b   .L1
            movem.l (SP)+,D3/A3
            unlk    A6
            rtd     #4
            ds.b    4
GetDevPix:
            movea.l TheGDevice,A0
            movea.l (A0),A0
            movea.l ($16,A0),A0
            movea.l (A0),A0
            rts
            dc.w    0
AllocCursor:
            lea     AllocCrsr,A0
            move.l  JAllocCrsr,D0
            beq.b   .L1
            movea.l D0,A0
.L1:
            jmp     (A0)
            dc.w    0
InitCursor:
            movea.l (A5),A0
            pea     (-$6C,A0)
            jsr     ([$F44.w])
            movea.l ($814).w,A0
            jmp     (A0)
            ds.b    14
SetCursor:
            movea.l (4,SP),A0
            move.l  ($40,A0),-(SP)
            move.w  #$10,-(SP)
            pea     (A0)
            pea     ($20,A0)
            movea.l ($818).w,A0
            jsr     (A0)
            move.l  (SP)+,(SP)
            rts
            ds.b    4
SetCCursor:
            move.l  (4,SP),-(SP)
            movea.l JSetCCrsr,A0
            jsr     (A0)
            move.l  (SP)+,(SP)
            rts
            dc.w    0
HideCursor:
            move.l  GrafBegin,-(SP)
            rts
            ds.b    10
ShowCursor:
            move.l  ($804).w,-(SP)
            rts
            ds.b    10
ShieldCursor:
            movem.l D0-D3/A0-A1,-(SP)
            movea.l ($20,SP),A0
            movem.w (A0)+,D0-D3
            lea     ($1C,SP),A1
            sub.w   (A1),D0
            sub.w   (A1)+,D2
            sub.w   (A1),D1
            sub.w   (A1),D3
            move.w  D1,-(SP)
            move.w  D0,-(SP)
            move.w  D3,-(SP)
            move.w  D2,-(SP)
            movea.l ($808).w,A0
            jsr     (A0)
            movem.l (SP)+,D0-D3/A0-A1
            move.l  (SP)+,(SP)
            move.l  (SP)+,(SP)
            rts
ObscureCursor:
            movea.l JCrsrObscure,A0
            jmp     (A0)
            ds.b    10
DrText:
            movea.l D0,A0
            move.l  SP,D0
            asr.w   #2,D0
            scs     D0
            bcc.b   .L1
            subq.w  #2,SP
.L1:
            link.w  A6,#-$1B8
            andi.w  #2,D0
            move.w  D0,(-$1A8,A6)
            move.l  A0,D0
            movem.l D0-D7/A1-A4,-(SP)
            move.l  SP,(-4,A6)
            move.l  A5,(-$8C,A6)
            movea.l (A5),A4
            movea.l (A4),A3
            move.w  (-$1A8,A6),D0
            move.l  ($C,A6,D0.w),(-$D0,A6)
            move.l  (8,A6,D0.w),(-$D4,A6)
            clr.w   (-$D6,A6)
            move.l  TheGDevice,LastTxGDevice
            lea     (2,A3),A1
            lea     (-$18E,A6),A2
            jsr     ([$1A08.w])
            move.l  D1,(-$A4,A6)
            move.b  D2,(-$1AB,A6)
.L2:
            move.w  (-$1A8,A6),D0
            clr.w   -(SP)
            move.w  ($14,A6,D0.w),D1
            move.w  D1,-(SP)
            ble.w   sub_40828A0E.L46
            move.w  D1,(-$1AA,A6)
            move.l  ($10,A6,D0.w),-(SP)
            pea     ($C,A6,D0.w)
            pea     (8,A6,D0.w)
            pea     (-$CC,A6)
            movea.l ($11B4).w,A0
            jsr     (A0)
            addq.w  #2,SP
            clr.b   (-$1B7,A6)
            move.l  (-$AC,A4),D1
            movea.l (-$B0,A4),A4
            movea.l (2,A4),A2
            movea.l (A2),A2
            move.w  (A2),D0
            btst    #9,D0
            sne     (-$1B5,A6)
            lsr.w   #2,D0
            andi.w  #7,D0
            sne     D2
            move.w  D0,(-$1B0,A6)
            moveq   #1,D3
            lsl.w   D0,D3
            move.w  D3,(-$19A,A6)
            move.w  ($E,A2),(-$194,A6)
            btst    #0,(1,A2)
            sne     (-$192,A6)
            move.w  (8,A2),(-$1A0,A6)
            clr.l   (-$94,A6)
            move.w  ($48,A3),D0
            andi.w  #$FFF7,D0
            tst.b   (-$1B5,A6)
            beq.b   .L3
            cmpi.w  #1,D0
            bne.b   .L3
            moveq   #$40,D0
.L3:
            move.w  D0,(-$1AE,A6)
            btst    #6,D0
            sne     D3
            beq.b   .L4
            lea     (-$132,A6),A0
            move.l  A0,(-$94,A6)
.L4:
            btst    #5,D0
            beq.b   .L5
            cmpi.w  #1,(-$16E,A6)
            bne.b   .L5
            lea     arithMode,A0
            andi.w  #7,D0
            move.b  (0,A0,D0.w),D0
            move.w  D0,(-$1AE,A6)
.L5:
            and.b   D2,D3
            beq.b   .L6
            movea.l WidthPtr,A0
            move.l  ([$400.w,A0]),D0
            sne     D3
            beq.b   .L6
            movea.l D0,A0
            moveq   #0,D0
            move.w  ($18,A0),D0
            add.l   D0,D0
            move.l  D0,(-$60,A6)
            lea     ($1A,A0),A0
            move.l  A0,(-$5C,A6)
            lea     (-$140,A6),A0
            move.l  A0,(-$94,A6)
.L6:
            move.b  D3,(-$190,A6)
            or.b    (-$1B5,A6),D3
            move.b  D3,(-$1B3,A6)
            move.l  ($30,A3),D2
            move.l  D2,(-$74,A6)
            move.w  D2,(-$A,A6)
            swap    D2
            move.w  #$8000,D2
            cmpi.w  #1,(-$1AE,A6)
            seq     (-$1B4,A6)
            bclr    #6,(-$1AD,A6)
            beq.b   .L7
            tst.w   (-$1AE,A6)
            seq     (-$1B4,A6)
.L7:
            clr.l   (-$90,A6)
            tst.w   (6,A3)
            bpl.b   .L10
            move.w  ($C,A3),D0
            beq.b   .L8
            bsr.w   CalcCharExtra
            move.l  D0,(-$90,A6)
.L8:
            move.w  ($E,A3),D2
            move.w  D2,(-$1A2,A6)
            move.l  ($50,A3),D0
            cmp.l   ($54,A3),D0
            beq.b   .L9
            addq.l  #1,D0
            move.w  (-$16E,A6),D3
            lsr.l   D3,D0
.L9:
            sne     D0
            tst.b   (-$1B5,A6)
            beq.b   .L12
            tst.l   ($54,A3)
            bra.b   .L11
.L10:
            btst    #5,($53,A3)
            sne     D0
            tst.b   (-$1B5,A6)
            beq.b   .L12
            btst    #0,($57,A3)
.L11:
            seq     D0
.L12:
            and.b   D0,(-$1B4,A6)
            add.l   D1,D2
            swap    D2
            clr.w   (-$19E,A6)
            tst.b   ($11,A4)
            beq.b   .L14
            moveq   #0,D0
            move.b  (7,A4),D0
            move.w  ($12,A2),D3
            subq.w  #1,D3
            mulu.w  D3,D0
            asr.w   #4,D0
            add.b   (6,A4),D0
            sub.b   ($C,A4),D0
            ext.w   D0
            moveq   #4,D3
            cmp.b   ($B,A4),D3
            ble.b   .L13
            move.b  ($B,A4),D3
            beq.b   .L13
            addq.w  #1,D3
.L13:
            add.w   D3,D0
            move.w  D0,(-$19E,A6)
            add.w   D0,D2
            moveq   #0,D0
            move.b  (7,A4),D0
            mulu.w  ($14,A2),D0
            asr.w   #4,D0
            sub.w   D0,(-$1A0,A6)
.L14:
            move.w  (-$1A0,A6),D0
            add.w   D0,(-$A,A6)
            move.w  D2,(-6,A6)
            move.w  (-$74,A6),D2
            sub.w   ($12,A2),D2
            move.w  D2,(-$C,A6)
            add.w   ($E,A2),D2
            move.w  D2,(-8,A6)
            move.l  (-$C,A6),(-$14,A6)
            move.l  (-8,A6),(-$10,A6)
            move.w  (-$1A8,A6),D3
            move.l  ($C,A6,D3.w),D0
            cmp.l   (8,A6,D3.w),D0
            sne     (-$191,A6)
            beq.b   .L15
            swap    D0
            clr.w   D0
            mulu.l  D0,D0:D1
            moveq   #0,D2
            move.w  ($A,A6,D3.w),D2
            swap    D2
            divu.l  D2,D0:D1
            move.l  (-$74,A6),D0
            move.l  D0,(-$70,A6)
            add.w   ($E,A6,D3.w),D0
            move.w  D0,(-$6A,A6)
            swap    D0
            add.w   ($C,A6,D3.w),D0
            move.w  D0,(-$6C,A6)
            move.l  (-$74,A6),D0
            move.l  D0,(-$68,A6)
            add.w   ($A,A6,D3.w),D0
            move.w  D0,(-$62,A6)
            swap    D0
            add.w   (8,A6,D3.w),D0
            move.w  D0,(-$64,A6)
            pea     (-$14,A6)
            pea     (-$68,A6)
            pea     (-$70,A6)
            jsr     ([$11E8.w])
.L15:
            andi.b  #$F,CCR
            tst.w   (6,A3)
            bpl.b   .L16
            add.w   D1,($E,A3)
.L16:
            swap    D1
            move.w  ($32,A3),D0
            addx.w  D1,D0
            move.w  D0,($32,A3)
            tst.w   ($42,A3)
            blt.w   sub_40828A0E.L46
            move.w  (-$E,A6),-(SP)
            move.w  #$7D00,(-$E,A6)
            pea     (-$14,A6)
            pea     (-$188,A6)
            movea.l ($1C,A3),A0
            movea.l (A0),A0
            pea     (2,A0)
            movea.l ($18,A3),A0
            movea.l (A0),A0
            pea     (2,A0)
            move.w  #4,-(SP)
            pea     (-$2C,A6)
            jsr     ([$1A84.w])
            beq.w   sub_40828A0E.L46
            move.w  (SP)+,(-$E,A6)
            lea     ($1A,A2),A0
            move.l  A0,(-$50,A6)
            moveq   #0,D1
            move.w  ($18,A2),D1
            move.w  (-$1B0,A6),D0
            lsl.l   D0,D1
            add.l   D1,D1
            move.l  D1,(-$54,A6)
            move.w  ($E,A2),(-$40,A6)
            tst.b   (7,A4)
            bne.w   .L21
            tst.b   (6,A4)
            bne.w   .L21
            tst.b   (-$1B4,A6)
            beq.w   .L21
            tst.w   ($A,A4)
            bne.w   .L21
            tst.b   (-$191,A6)
            bne.w   .L21
            movea.l ([$1C.w,A3]),A0
            moveq   #$A,D0
            cmp.w   (A0),D0
            bne.w   .L21
            moveq   #1,D0
            move.w  (-$1B0,A6),D1
            lsl.w   D1,D0
            cmp.w   (-$16E,A6),D0
            bne.w   .L21
            cmpi.w  #$10,(-$170,A6)
            bne.b   .L17
            seq     (-$1B3,A6)
            clr.w   (-$1AE,A6)
            bra.w   .L21
.L17:
            movea.l ($18,A3),A1
            movea.l (A1),A0
            cmpi.w  #$A,(A0)
            beq.b   .L18
            move.l  A1,-(SP)
            pea     (-$2C,A6)
            move.w  #$FFFF,-(SP)
            jsr     ([$1AA4.w])
            blt.w   sub_40828A0E.L46
            bgt.w   .L21
.L18:
            st      (-$18F,A6)
            clr.b   (-$190,A6)
            clr.l   (-$98,A6)
            move.w  (-$2C,A6),D0
            move.w  (-$28,A6),D1
            sub.w   (-$C,A6),D0
            bne.b   .L19
            cmp.w   (-8,A6),D1
            beq.b   .L20
.L19:
            clr.b   (-$192,A6)
            move.b  D0,(-$194,A6)
            sub.w   (-$2C,A6),D1
            move.b  D1,(-$193,A6)
.L20:
            move.w  (-$C,A6),D0
            sub.w   (-$188,A6),D0
            move.w  (-$18A,A6),D1
            andi.w  #$7FFF,D1
            muls.w  D1,D0
            add.l   (-$18E,A6),D0
            move.l  D0,(-$4C,A6)
            move.w  D1,(-$34,A6)
            move.w  (-$186,A6),(-$3E,A6)
            tst.b   (-$1AB,A6)
            beq.w   .L38
            pea     (-$2C,A6)
            move.l  (-$A4,A6),-(SP)
            jsr     ([$F54.w])
            move.l  (-$50,A6),D0
            jsr     ([$644.w])
            move.l  D0,(-$50,A6)
            move.l  A2,D0
            jsr     ([$644.w])
            movea.l D0,A2
            move.w  (-$1A8,A6),D1
            move.l  ($10,A6,D1.w),D0
            jsr     ([$644.w])
            move.l  D0,($10,A6,D1.w)
            moveq   #1,D0
            move.l  A2,-(SP)
            jsr     ([$574.w])
            movea.l (SP)+,A2
            move.b  D0,(-$1AC,A6)
            move.b  #1,(-$1B7,A6)
            bra.w   .L38
.L21:
            sf      (-$18F,A6)
            sf      (-$1AB,A6)
            move.w  (-$A,A6),D0
            sub.w   (-$186,A6),D0
            andi.w  #$FFE0,D0
            add.w   (-$186,A6),D0
            move.w  D0,(-$3E,A6)
            moveq   #0,D1
            move.w  (-6,A6),D1
            sub.w   D0,D1
            move.w  D1,D2
            move.w  (-$1B0,A6),D4
            lsl.l   D4,D1
            lsr.l   #5,D1
            addq.w  #2,D1
            move.w  (-$40,A6),D3
            mulu.w  D1,D3
            cmpi.l  #$1C00,D3
            bgt.b   .L24
            move.w  D3,(-$32,A6)
            add.w   D1,D3
            lsl.w   #2,D1
            move.w  D1,(-$34,A6)
            move.w  (-$E,A6),D5
            sub.w   (-$12,A6),D5
            lsr.w   #5,D5
            addq.w  #2,D5
            move.w  D5,D0
            add.w   D0,D3
            add.w   D0,D3
            lsl.w   D4,D0
            add.w   D0,D3
            mulu.w  (-$16E,A6),D5
            add.w   D5,D3
            add.w   D5,D3
            tst.b   (-$190,A6)
            beq.b   .L22
            lsr.w   #5,D2
            addq.w  #2,D2
            add.w   D2,D1
            move.w  (-$40,A6),D0
            mulu.w  D2,D0
            move.w  D0,(-$AE,A6)
            lsl.w   #2,D2
            move.w  D2,(-$B0,A6)
            add.w   D0,D3
            add.w   D2,D3
            move.w  (-$E,A6),D0
            sub.w   (-$12,A6),D0
            lsr.w   #5,D0
            add.w   D0,D3
.L22:
            tst.b   ($B,A4)
            beq.b   .L23
            add.w   (-$32,A6),D3
            add.w   D1,D3
.L23:
            lsl.l   #2,D3
            addi.l  #$800,D3
            movea.l ($594).w,A0
            jsr     (A0)
            cmp.l   D0,D3
            ble.b   .L31
.L24:
            move.w  (-$1A8,A6),D6
            move.w  ($14,A6,D6.w),D0
            move.w  D0,D7
            lsr.w   #1,D7
            bne.b   .L25
            subq.w  #1,(-$D6,A6)
            bra.w   sub_40828A0E.L46
.L25:
            tst.w   (-$D6,A6)
            bne.b   .L26
            move.b  HiliteMode,(-$1B6,A6)
            move.w  D0,(-$D6,A6)
.L26:
            move.l  (-$74,A6),($30,A3)
            tst.w   (6,A3)
            bpl.b   .L27
            move.w  (-$1A2,A6),($E,A3)
.L27:
            move.w  D7,($14,A6,D6.w)
.L28:
            movea.l (A5),A4
            move.l  (-$D0,A6),($C,A6,D6.w)
            move.l  (-$D4,A6),(8,A6,D6.w)
            move.b  (-$1B6,A6),HiliteMode
            jmp     .L2
.L29:
            moveq   #0,D7
            move.w  (-$1A8,A6),D6
            move.w  ($14,A6,D6.w),D7
            move.w  (-$D6,A6),D0
            cmp.w   D0,D7
            ble.b   .L30
            move.w  D0,($14,A6,D6.w)
.L30:
            add.l   D7,($10,A6,D6.w)
            bra.b   .L28
.L31:
            moveq   #0,D0
            tst.w   (-$1B0,A6)
            beq.b   .L34
            cmpi.w  #2,(-$1AE,A6)
            beq.b   .L34
            tst.b   (-$1B5,A6)
            bne.b   .L32
            cmpi.w  #$32,(-$1AE,A6)
            beq.b   .L34
            btst    #5,(-$1AD,A6)
            beq.b   .L34
.L32:
            subq.w  #6,SP
            move.l  SP,-(SP)
            jsr     ([$1668.w])
            clr.l   -(SP)
            pea     (4,SP)
            jsr     ([$16CC.w])
            moveq   #0,D0
            moveq   #$20,D1
            move.w  (-$19A,A6),D2
.L33:
            asl.l   D2,D0
            or.l    (SP),D0
            sub.w   D2,D1
            bgt.b   .L33
            lea     ($A,SP),SP
.L34:
            move.l  D0,(-$98,A6)
            move.w  (-$32,A6),D3
            subq.w  #1,D3
            move.l  D0,-(SP)
            move.l  SP,(-$30,A6)
.L35:
            move.l  D0,-(SP)
            dbra    D3,.L35
            move.l  SP,(-$4C,A6)
            move.l  D0,-(SP)
            tst.b   (-$190,A6)
            beq.b   .L37
            move.w  (-$AE,A6),D3
            subq.w  #1,D3
            clr.l   -(SP)
.L36:
            clr.l   -(SP)
            dbra    D3,.L36
            move.l  SP,(-$58,A6)
.L37:
            clr.l   -(SP)
.L38:
            lea     ($1A,A2),A0
            moveq   #0,D0
            move.w  ($E,A2),D0
            mulu.l  (-$54,A6),D0
            adda.l  D0,A0
            move.l  A0,(-$88,A6)
            move.w  ($A,A2),D0
            swap    D0
            bpl.b   .L39
            moveq   #0,D0
.L39:
            move.w  ($10,A2),D0
            lea     ($10,A2,D0.l*2),A1
            move.l  A1,(-$84,A6)
            move.w  (4,A2),D0
            move.w  (2,A2),D1
            move.w  D1,(-$198,A6)
            sub.w   D1,D0
            move.w  D0,(-$196,A6)
            addq.w  #3,D0
            btst    #1,(1,A2)
            beq.b   .L40
            add.w   D0,D0
.L40:
            lea     (0,A1,D0.w*2),A0
            move.l  A0,(-$80,A6)
            movea.l WidthTabHandle,A0
            movea.l (A0),A0
            move.l  ($80,A0),(-$78,A6)
            move.w  (-$3E,A6),D1
            move.w  (-$72,A6),D0
            add.w   (-$1A0,A6),D0
            sub.w   D1,D0
            move.w  D0,(-$7C,A6)
            tst.w   (6,A3)
            bpl.b   .L41
            move.w  (-$1A2,A6),(-$7A,A6)
            bra.b   .L42
.L41:
            move.w  #$8000,(-$7A,A6)
.L42:
            sub.w   D1,(-$2A,A6)
            sub.w   D1,(-$26,A6)
            move.w  (-$1A8,A6),D0
            movea.l ($10,A6,D0.w),A1
            bra.b   .L46
.L43:
            move.w  (-$196,A6),D0
            addq.w  #1,D0
            movea.l (-$84,A6),A0
            move.w  (0,A0,D0.w*2),D3
            cmpi.w  #$FFFF,D3
            bne.w   .L47
            bra.b   .L46
.L44:
            move.l  (-$78,A6),D1
            add.l   D1,(-$7C,A6)
.L45:
            subq.w  #1,(-$D6,A6)
            subq.w  #1,(-$1AA,A6)
            ble.w   sub_40828A0E.L19
.L46:
            clr.w   D0
            move.b  (A1)+,D0
            cmpi.b  #$20,D0
            beq.b   .L44
            movea.l WidthTabHandle,A0
            movea.l (A0),A0
            move.w  D0,D4
            move.l  (0,A0,D4.w*4),D4
            add.l   (-$90,A6),D4
            ble.b   .L45
            sub.w   (-$198,A6),D0
            cmp.w   (-$196,A6),D0
            bhi.b   .L43
            movea.l (-$84,A6),A0
            move.w  (0,A0,D0.w*2),D3
            cmpi.w  #$FFFF,D3
            beq.b   .L43
.L47:
            lsr.w   #8,D3
            add.w   (-$7C,A6),D3
            add.l   D4,(-$7C,A6)
            movea.l (-$88,A6),A0
            moveq   #0,D1
            move.w  (0,A0,D0.w*2),D1
            move.w  (2,A0,D0.w*2),D2
            sub.w   D1,D2
            ble.b   .L45
            move.w  D2,(-$1A6,A6)
            add.w   D3,D2
            tst.b   (-$192,A6)
            beq.b   .L48
            movea.l (-$80,A6),A0
            move.w  (0,A0,D0.w*2),(-$194,A6)
.L48:
            tst.b   (-$18F,A6)
            beq.b   .L52
            cmp.w   (-$2A,A6),D3
            bge.b   .L49
            cmp.w   (-$2A,A6),D2
            ble.w   .L45
            move.w  (-$2A,A6),D0
            sub.w   D3,D0
            add.w   D0,D1
            add.w   D0,D3
            cmp.w   (-$26,A6),D2
            ble.b   .L51
            bra.b   .L50
.L49:
            cmp.w   (-$26,A6),D2
            ble.b   .L52
            cmp.w   (-$26,A6),D3
            bge.w   sub_40828A0E.L19
.L50:
            move.w  (-$26,A6),D2
.L51:
            move.w  D2,D0
            sub.w   D3,D0
            move.w  D0,(-$1A6,A6)
.L52:
            movem.w D1-D3,(-$B6,A6)
            move.b  (-$1B3,A6),(-$1B1,A6)
            st      (-$1B2,A6)
            move.w  (-$1B0,A6),D0
            lsl.w   D0,D1
            lsl.w   D0,D2
            lsl.w   D0,D3
            movea.w (-$34,A6),A3
            movem.l (-$54,A6),A2/A4-A5
.L53:
            move.w  #$FF,D7
            add.b   (-$193,A6),D7
            bmi.w   .L45
            moveq   #0,D0
            move.b  (-$194,A6),D0
            move.l  A2,D4
            dc.w    $4C00,$4004,$D9C4,$380B,$C8C0,$DBC4,$701F,$2A01
            dc.w    $3C03,$EA46,$3806,$E54E,$DAC6,$3C02,$EA46,$9C44
            dc.w    $6700,$015E,$4443,$C640,$6602,$7620,$3806,$E54C
            dc.w    $94C4,$96C4,$5346,$D243,$7820,$9284,$4A2E,$FE4F
            dc.w    $663E,$C440,$7801,$E29C,$E4A4,$E384,$3406,$3046
            dc.w    $2C05,$DC43,$7020,$9C80,$E9D4,$0963,$6004,$E9D4
            dc.w    $0980,$819D,$584C,$51CA,$FFF6,$E9D4,$0840,$C084
            dc.w    $8195,$D9CA,$DBCB,$3408,$51CF,$FFDE,$6000,$01B8
            dc.w    $3802,$C840,$3D46,$FE5C,$3406,$2C2E,$FF68,$E9C6
            dc.w    $0023,$2D40,$FF64,$E9C6,$0024,$2D40,$FF60,$302E
            dc.w    $FE66,$E9C6,$0020,$3D40,$FE64,$7C20,$9C43,$2045
            dc.w    $D0C3,$90FC,$0020
.L54:
            bfextu  (A5){D6:D3},D0
            cmp.l   (-$9C,A6),D0
            bne.b   sub_40828A0E
            bfextu  (A4){D5:D3},D0
            bfins   D0,(A5){D6:D3}
.L55:
            exg     D5,A0
.L56:
            addq.w  #4,A5
            bra.b   .L58
.L57:
            move.l  (-$98,A6),D0
            cmp.l   (A5),D0
            bne.b   sub_40828A0E.L3
            bfextu  (A4){D5:0},D0
            move.l  D0,(A5)+
.L58:
            addq.w  #4,A4
            dbra    D2,.L57
            exg     D5,A0
            tst.w   D4
            beq.b   .L59
            bfextu  (A5){0:D4},D0
            cmp.l   (-$A0,A6),D0
            bne.b   sub_40828A0E.L6
            bfextu  (A4){D1:D4},D0
            bfins   D0,(A5){0:D4}
.L59:
            adda.l  A2,A4
            adda.l  A3,A5
            move.w  (-$1A4,A6),D2
            dbra    D7,.L54
            bra.w   sub_40828A0E.L17
sub_40828A0E:
            movem.l D1/D3-D6,-(SP)
            movem.w (-$19C,A6),D0-D1
.L1:
            bfextu  (A4){D5:D1},D4
            cmp.w   D4,D0
            beq.b   .L2
            bfins   D4,(A5){D6:D1}
.L2:
            add.l   D1,D5
            add.w   D1,D6
            sub.w   D1,D3
            bgt.b   .L1
            movem.l (SP)+,D1/D3-D6
            bra.b   DrText.L55
.L3:
            moveq   #$20,D0
            movem.l D1/D3-D6,-(SP)
            moveq   #0,D6
            movem.w (-$19C,A6),D1/D3
.L4:
            bfextu  (A4){D5:D3},D4
            cmp.w   D4,D1
            beq.b   .L5
            bfins   D4,(A5){D6:D3}
.L5:
            add.l   D3,D5
            add.w   D3,D6
            sub.w   D3,D0
            bgt.b   .L4
            movem.l (SP)+,D1/D3-D6
            bra.w   DrText.L56
.L6:
            movem.l D1/D3-D6,-(SP)
            moveq   #0,D6
            movem.w (-$19C,A6),D3/D5
.L7:
            bfextu  (A4){D1:D5},D0
            cmp.w   D0,D3
            beq.b   .L8
            bfins   D0,(A5){D6:D5}
.L8:
            add.l   D5,D1
            add.w   D5,D6
            sub.w   D5,D4
            bgt.b   .L7
            movem.l (SP)+,D1/D3-D6
            bra.w   DrText.L59
            move.w  (-$1A6,A6),D3
            tst.b   (-$1B2,A6)
            beq.b   .L9
            move.w  (-$1B0,A6),D4
            lsl.w   D4,D3
.L9:
            tst.b   (-$1B1,A6)
            bne.b   .L11
            move.w  D2,D1
            neg.w   D1
            and.w   D0,D1
            add.w   D1,D3
            and.w   D0,D2
            moveq   #1,D4
            ror.l   #1,D4
            asr.l   D2,D4
            asl.l   #1,D4
.L10:
            bfextu  (A4){D5:D3},D0
            and.l   D4,D0
            or.l    D0,(A5)
            adda.l  A2,A4
            adda.l  A3,A5
            dbra    D7,.L10
            bra.b   .L18
.L11:
            move.w  D2,D6
            and.l   D0,D6
            sub.w   D3,D6
            bfextu  (-$98,A6){0:D3},D2
            movem.l D5-D6,(-$AC,A6)
            move.w  D5,D0
            add.w   D3,D0
            move.w  D0,(-$1A4,A6)
            move.w  (-$19A,A6),D4
            bfextu  D2{0:D4},D1
.L12:
            bfextu  (A5){D6:D3},D0
            cmp.l   D2,D0
            beq.b   .L15
.L13:
            bfextu  (A4){D5:D4},D0
            cmp.w   D0,D1
            beq.b   .L14
            bfins   D0,(A5){D6:D4}
.L14:
            add.w   D4,D6
            add.w   D4,D5
            cmp.w   (-$1A4,A6),D5
            blt.b   .L13
            movem.l (-$AC,A6),D5-D6
            bra.b   .L16
.L15:
            bfextu  (A4){D5:D3},D0
            bfins   D0,(A5){D6:D3}
.L16:
            adda.l  A2,A4
            adda.l  A3,A5
            dbra    D7,.L12
.L17:
            tst.w   (-$1B0,A6)
            beq.b   .L18
            tst.b   (-$190,A6)
            beq.b   .L18
            sf      (-$1B1,A6)
            sf      (-$1B2,A6)
            movem.w (-$B6,A6),D1-D3/A3
            movem.l (-$60,A6),A2/A4-A5
            bra.w   DrText.L53
.L18:
            subq.w  #1,(-$D6,A6)
            subq.w  #1,(-$1AA,A6)
            bgt.w   DrText.L46
.L19:
            movea.l (-$8C,A6),A5
            tst.b   (-$18F,A6)
            beq.b   .L21
            tst.b   (-$1AB,A6)
            beq.b   .L20
            move.b  (-$1AC,A6),D0
            jsr     ([$574.w])
            jsr     ([$F4C.w])
.L20:
            bra.w   .L46
.L21:
            movea.l (A5),A0
            movea.l (A0),A3
            movea.l (-$B0,A0),A4
            movea.l (2,A4),A2
            movea.l (A2),A2
            move.w  (-$7C,A6),D7
            sub.w   (8,A2),D7
            clr.w   D2
            move.b  (6,A4),D2
            bra.b   .L24
.L22:
            movea.l (-$4C,A6),A0
            move.w  (-$32,A6),D1
            sub.w   D0,D0
.L23:
            move.l  (A0),D0
            roxr.l  #1,D0
            or.l    D0,(A0)+
            dbra    D1,.L23
.L24:
            dbra    D2,.L22
            moveq   #0,D2
            move.b  (7,A4),D2
            beq.b   .L28
            movea.l (-$30,A6),A1
            move.w  (-$34,A6),D3
            suba.w  D3,A1
            lsr.w   #2,D3
            subq.w  #1,D3
            move.w  (-$40,A6),D6
            moveq   #0,D4
            bra.b   .L27
.L25:
            add.l   D2,D4
            move.l  D4,D5
            lsr.l   #4,D5
            neg.l   D5
            movea.l A1,A0
            subq.w  #4,A0
            move.w  D3,D1
.L26:
            bfextu  (A0){D5:0},D0
            subq.w  #4,A0
            move.l  D0,-(A1)
            dbra    D1,.L26
.L27:
            dbra    D6,.L25
.L28:
            tst.b   ($A,A4)
            beq.b   .L32
            movea.l (-$4C,A6),A0
            move.w  (-$34,A6),D1
            move.w  ($12,A2),D0
            move.w  ($14,A2),D2
            mulu.w  D1,D0
            adda.l  D0,A0
            movea.l A0,A1
            movea.l A0,A2
            adda.w  D1,A1
            cmpi.w  #2,D2
            blt.b   .L32
            beq.b   .L29
            adda.w  D1,A2
            adda.w  D1,A2
.L29:
            suba.w  D1,SP
            move.l  A3,-(SP)
            lea     (4,SP),A3
            lsr.w   #2,D1
            subq.w  #1,D1
            move.w  D1,D2
            sub.w   D0,D0
.L30:
            move.l  (A0)+,D0
            or.l    (A1)+,D0
            or.l    (A2)+,D0
            move.l  D0,(A3)
            roxr.l  #1,D0
            or.l    D0,(A3)+
            dbra    D1,.L30
            movea.l A1,A0
            sub.w   D0,D0
.L31:
            move.l  -(A3),D0
            roxl.l  #1,D0
            or.l    (A3),D0
            not.l   D0
            or.l    D0,-(A1)
            dbra    D2,.L31
            movea.l (SP)+,A3
.L32:
            move.w  #$A,(-$C0,A6)
            move.l  (-$188,A6),(-$BE,A6)
            move.l  (-$184,A6),(-$BA,A6)
            lea     (-$C0,A6),A0
            move.l  A0,(-$C4,A6)
            lea     (-$E4,A6),A0
            movea.l A0,A1
            move.l  (-$4C,A6),(A0)+
            move.w  (-$34,A6),(A0)+
            move.w  (-$C,A6),(A0)+
            move.w  (-$3E,A6),(A0)+
            move.l  (-8,A6),(A0)+
            lea     (-$132,A6),A2
            jsr     ([$1A08.w])
            tst.b   (-$190,A6)
            beq.b   .L33
            lea     (-$140,A6),A0
            move.l  (-$58,A6),(A0)+
            move.w  (-$B0,A6),(A0)+
            move.w  (-$C,A6),(A0)+
            move.w  (-$3E,A6),(A0)+
            move.l  (-8,A6),(A0)+
.L33:
            tst.w   (-$1B0,A6)
            beq.b   .L34
            move.w  (-$19A,A6),(-$112,A6)
            move.l  (-$164,A6),(-$108,A6)
.L34:
            clr.w   D3
            move.b  ($B,A4),D3
            beq.w   .L45
            move.w  (-$34,A6),D0
            subq.w  #1,D0
            clr.l   -(SP)
            move.l  SP,(-$3C,A6)
.L35:
            clr.l   -(SP)
            dbra    D0,.L35
            move.w  (-$32,A6),D0
            subq.w  #1,D0
            movea.l (-$30,A6),A0
.L36:
            move.l  -(A0),-(SP)
            dbra    D0,.L36
            move.l  SP,(-$38,A6)
            clr.l   -(SP)
            andi.w  #3,D3
            move.w  D3,D2
.L37:
            movea.l (-$38,A6),A0
            move.w  (-$32,A6),D1
            sub.w   D0,D0
.L38:
            move.l  (A0),D0
            roxr.l  #1,D0
            or.l    D0,(A0)+
            dbra    D1,.L38
            dbra    D2,.L37
            movea.l (-$38,A6),A2
.L39:
            movea.l (-$3C,A6),A1
            movea.l A1,A0
            move.w  (-$E0,A6),D2
            suba.w  D2,A0
.L40:
            move.l  -(A0),D0
            or.l    D0,-(A1)
            cmpa.l  A2,A0
            bgt.b   .L40
            dbra    D3,.L39
            move.w  (-$32,A6),D1
            movea.l (-$4C,A6),A0
            movea.l A2,A1
            adda.w  D2,A1
            sub.w   D0,D0
.L41:
            move.l  (A0)+,D0
            roxr.l  #1,D0
            eor.l   D0,(A1)+
            dbra    D1,.L41
            move.l  A2,(-$E4,A6)
            addq.w  #4,(-$DA,A6)
            move.l  (-$C,A6),(-$1C,A6)
            move.l  (-8,A6),(-$18,A6)
            addq.w  #4,(-$18,A6)
            move.l  (-$1C,A6),(-$24,A6)
            move.l  (-$18,A6),(-$20,A6)
            lea     (-$24,A6),A0
            subq.w  #1,(A0)+
            subq.w  #1,(A0)+
            subq.w  #1,(A0)+
            subq.w  #1,(A0)+
            tst.b   (-$191,A6)
            beq.b   .L42
            pea     (-$24,A6)
            pea     (-$68,A6)
            pea     (-$70,A6)
            jsr     ([$11E8.w])
.L42:
            pea     (-$E4,A6)
            move.l  (-$94,A6),-(SP)
            beq.b   .L43
            move.l  (4,SP),(SP)
.L43:
            pea     (2,A3)
            pea     (-$1C,A6)
            pea     (-$1C,A6)
            pea     (-$24,A6)
            move.w  (-$1AE,A6),-(SP)
            clr.l   -(SP)
            move.l  ($1C,A3),-(SP)
            move.l  ($18,A3),-(SP)
            pea     (-$C4,A6)
            clr.w   -(SP)
            jsr     ([$1A9C.w])
            tst.w   (6,A3)
            bmi.b   .L46
            move.w  (-$1AE,A6),D0
            cmpi.w  #1,D0
            beq.b   .L44
            cmpi.w  #3,D0
            bne.b   .L46
.L44:
            move.l  (-$4C,A6),(-$E4,A6)
            subq.w  #4,(-$DA,A6)
            clr.l   (-$94,A6)
            eori.w  #2,D0
            move.w  D0,(-$1AE,A6)
.L45:
            pea     (-$132,A6)
            move.l  (-$94,A6),-(SP)
            pea     (2,A3)
            pea     (-$C,A6)
            pea     (-$C,A6)
            pea     (-$14,A6)
            move.w  (-$1AE,A6),-(SP)
            clr.l   -(SP)
            move.l  ($1C,A3),-(SP)
            move.l  ($18,A3),-(SP)
            pea     (-$C4,A6)
            move.b  (-$1B5,A6),-(SP)
            jsr     ([$1A9C.w])
.L46:
            movea.l (-4,A6),SP
            move.w  (-$D6,A6),D0
            sub.w   (-$1AA,A6),D0
            move.w  D0,(-$D6,A6)
            bgt.w   DrText.L29
            bset    #7,HiliteMode
            tst.w   (-$1A8,A6)
            movem.l (SP)+,D0-D7/A1-A4
            unlk    A6
            beq.b   .L47
            addq.w  #2,SP
.L47:
            rtd     #$E
            ds.b    6
StdText:
            link.w  A6,#-4
            movem.l D5-D7/A3-A4,-(SP)
.L1:
            move.w  ($14,A6),D6
            ble.w   .L22
            cmpi.w  #$FF,D6
            ble.b   .L2
            move.w  #$FF,D6
.L2:
            jsr     ([$1A3C.w])
            sle     -(SP)
            ble.w   .L20
            movea.l ($5C,A3),A4
            movea.l (A4),A4
            move.w  ($44,A3),D7
            cmp.w   ($18,A4),D7
            beq.b   .L3
            moveq   #3,D0
            bsr.l   DPutPicOp
            move.w  D7,-(SP)
            bsr.l   PutPicWord
            movea.l ($5C,A3),A4
            movea.l (A4),A4
            move.w  D7,($18,A4)
.L3:
            move.b  ($46,A3),D7
            cmp.b   ($1A,A4),D7
            beq.b   .L4
            moveq   #4,D0
            bsr.l   DPutPicOp
            move.b  D7,D0
            bsr.l   DPutPicByte
            movea.l ($5C,A3),A4
            movea.l (A4),A4
            move.b  D7,($1A,A4)
.L4:
            move.w  ($48,A3),D7
            cmp.w   ($1C,A4),D7
            beq.b   .L7
            cmpi.w  #1,($62,A4)
            bne.b   .L5
            btst    #5,D7
            beq.b   .L5
            andi.w  #7,D7
            move.b  .L6(PC,D7.w),D7
            cmp.w   ($1C,A4),D7
            beq.b   .L7
.L5:
            moveq   #5,D0
            bsr.l   DPutPicOp
            move.w  D7,-(SP)
            bsr.l   PutPicWord
            movea.l ($5C,A3),A4
            movea.l (A4),A4
            move.w  D7,($1C,A4)
            bra.b   .L7
.L6:
            dc.w    $0003,$0201,$0103,$0201
.L7:
            move.w  ($4A,A3),D7
            cmp.w   ($1E,A4),D7
            beq.b   .L8
            moveq   #$D,D0
            bsr.l   DPutPicOp
            move.w  D7,-(SP)
            bsr.l   PutPicWord
            movea.l ($5C,A3),A4
            movea.l (A4),A4
            move.w  D7,($1E,A4)
.L8:
            move.l  ($4C,A3),D7
            cmp.l   ($20,A4),D7
            beq.b   .L9
            moveq   #6,D0
            bsr.l   DPutPicOp
            move.l  D7,-(SP)
            bsr.l   PutPicLong
            movea.l ($5C,A3),A4
            movea.l (A4),A4
            move.l  D7,($20,A4)
.L9:
            move.l  ($C,A6),D7
            move.l  (8,A6),D5
            cmp.l   ($24,A4),D7
            bne.b   .L10
            cmp.l   ($28,A4),D5
            beq.b   .L11
.L10:
            moveq   #$10,D0
            bsr.l   DPutPicOp
            move.l  D7,-(SP)
            bsr.l   PutPicLong
            move.l  D5,-(SP)
            bsr.l   PutPicLong
            movea.l ($5C,A3),A4
            movea.l (A4),A4
            move.l  D7,($24,A4)
            move.l  D5,($28,A4)
.L11:
            cmpi.w  #1,($62,A4)
            beq.b   .L13
            move.w  ($E,A3),D7
            cmpi.w  #$8000,D7
            beq.b   .L12
            moveq   #$15,D0
            bsr.l   DPutPicOp
            move.w  D7,-(SP)
            bsr.l   PutPicWord
            movea.l ($5C,A3),A4
            movea.l (A4),A4
.L12:
            move.w  ($C,A3),D7
            cmp.w   ($70,A4),D7
            beq.b   .L13
            moveq   #$16,D0
            bsr.l   DPutPicOp
            move.w  D7,-(SP)
            bsr.l   PutPicWord
            movea.l ($5C,A3),A4
            movea.l (A4),A4
            move.w  D7,($70,A4)
.L13:
            move.l  ($30,A3),D5
            sub.w   ($2E,A4),D5
            swap    D5
            sub.w   ($2C,A4),D5
            swap    D5
            move.l  D5,D0
            andi.l  #$FF00FF00,D0
            beq.b   .L14
            moveq   #$28,D0
            bsr.l   DPutPicOp
            move.l  ($30,A3),-(SP)
            bsr.l   PutPicLong
            bra.b   .L19
.L14:
            move.l  D5,D0
            andi.l  #$FF0000,D0
            bne.b   .L15
            moveq   #$29,D0
            bsr.l   DPutPicOp
            bra.b   .L18
.L15:
            tst.b   D5
            bne.b   .L16
            moveq   #$2A,D0
            bsr.l   DPutPicOp
            bra.b   .L17
.L16:
            moveq   #$2B,D0
            bsr.l   DPutPicOp
            move.b  D5,D0
            bsr.l   DPutPicByte
.L17:
            swap    D5
.L18:
            move.b  D5,D0
            bsr.l   DPutPicByte
.L19:
            move.b  D6,D0
            bsr.l   DPutPicByte
            move.l  ($10,A6),-(SP)
            move.w  D6,-(SP)
            bsr.l   PutPicData
            movea.l ($5C,A3),A4
            movea.l (A4),A4
            move.l  ($30,A3),($2C,A4)
.L20:
            pea     StdDraw_Text
            pea     GetRect_Text
            jsr     ([$1AA0.w])
            tst.b   (SP)+
            bne.b   .L21
            movea.l ($5C,A3),A4
            movea.l (A4),A4
            move.w  ($E,A3),($72,A4)
.L21:
            sub.w   D6,($14,A6)
            ble.b   .L22
            movea.l ($10,A6),A0
            adda.w  D6,A0
            move.l  A0,($10,A6)
            bra.w   .L1
.L22:
            bset    #7,HiliteMode
            movem.l (SP)+,D5-D7/A3-A4
            unlk    A6
            rtd     #$E
GetRect_Text:
            move.l  (SP)+,D0
            movea.l (SP)+,A1
            move.l  D0,-(SP)
            move.l  TheGDevice,-(SP)
            move.l  LastTxGDevice,TheGDevice
            move.l  ($30,A3),D0
            move.l  D0,(A1)
            move.l  D0,(4,A1)
            move.l  ($C,A6),-(SP)
            move.l  (8,A6),-(SP)
            subq.w  #8,SP
            movea.l SP,A0
            move.l  A1,-(SP)
            clr.w   -(SP)
            move.w  D6,-(SP)
            move.l  ($10,A6),-(SP)
            pea     ($C,A0)
            pea     (8,A0)
            move.l  A0,-(SP)
            jsr     ([$11B4.w])
            move.w  (SP)+,D0
            movea.l (SP)+,A1
            add.w   D0,(6,A1)
            move.w  (SP)+,D0
            sub.w   D0,(A1)
            move.w  (SP)+,D0
            add.w   D0,(4,A1)
            lea     ($C,SP),SP
            move.l  (SP)+,TheGDevice
            rts
StdDraw_Text:
            move.w  D6,-(SP)
            move.l  ($10,A6),-(SP)
            move.l  ($C,A6),-(SP)
            move.l  (8,A6),-(SP)
            jsr     DrText
            rts
            ds.b    8
CallText:
            movea.l (SP)+,A0
            move.l  #$10001,-(SP)
            move.l  (SP),-(SP)
            move.l  A0,-(SP)
            movea.l (A5),A0
            movea.l (A0),A0
            move.l  ($68,A0),D0
            movea.l JStdTEXT,A0
            beq.b   .L1
            movea.l D0,A0
            movea.l (A0),A0
.L1:
            jmp     (A0)
TextFace:
            movea.l (A5),A0
            movea.l (A0),A0
            move.b  (5,SP),($46,A0)
            bra.b   CharWidth.L1
DrawChar:
            move.w  #1,-(SP)
            pea     (7,SP)
            jsr     CallText
            bra.b   CharWidth.L1
CharWidth:
            clr.w   -(SP)
            move.l  SP,-(SP)
            move.l  #$10007,-(SP)
            jsr     ([$1018.w])
            move.w  (SP)+,(6,SP)
.L1:
            movea.l (SP)+,A0
            addq.w  #2,SP
            jmp     (A0)
            ds.b    12
TextFont:
            moveq   #$44,D0
            bra.b   TextSize.L2
TextMode:
            moveq   #$48,D0
            bra.b   TextSize.L2
TextSize:
            movea.l ([A5]),A0
            tst.w   (6,A0)
            bpl.b   .L1
            clr.w   ($C,A0)
.L1:
            moveq   #$4A,D0
.L2:
            jmp     PortWord
            ds.b    4
SpaceExtra:
            movea.l (A5),A0
            movea.l (A0),A0
            move.l  (4,SP),($4C,A0)
            bra.b   DrawText2.L1
DrawString:
            movea.l (4,SP),A0
            clr.w   D0
            move.b  (A0)+,D0
            move.w  D0,-(SP)
            move.l  A0,-(SP)
            jsr     CallText
            bra.b   DrawText2.L1
DrawText2:
            movea.l (8,SP),A0
            adda.w  (6,SP),A0
            move.w  (4,SP),-(SP)
            move.l  A0,-(SP)
            jsr     CallText
            move.l  (SP)+,(SP)
.L1:
            move.l  (SP)+,(SP)
            rts
            ds.b    10
StringWidth:
            movea.l (SP)+,A1
            movea.l (SP)+,A0
            clr.w   D0
            move.b  (A0)+,D0
            move.l  A0,-(SP)
            clr.w   -(SP)
            move.w  D0,-(SP)
            move.l  A1,-(SP)
TextWidth:
            link.w  A6,#-$10
            clr.w   ($10,A6)
            clr.w   -(SP)
            move.w  (8,A6),-(SP)
            ble.b   .L3
            movea.l ($C,A6),A0
            adda.w  ($A,A6),A0
            move.l  A0,-(SP)
            move.l  #$10001,D0
            move.l  D0,(-$C,A6)
            move.l  D0,(-$10,A6)
            pea     (-$C,A6)
            pea     (-$10,A6)
            pea     (-8,A6)
            movea.l (A5),A0
            movea.l (A0),A0
            move.l  ($68,A0),D0
            movea.l ($11B4).w,A0
            beq.b   .L1
            movea.l D0,A0
            movea.l ($28,A0),A0
.L1:
            jsr     (A0)
            move.w  (SP)+,D1
            move.w  (-$A,A6),D0
            move.w  (-$E,A6),D2
            cmp.w   D2,D0
            beq.b   .L2
            mulu.w  D0,D1
            divu.w  D2,D1
.L2:
            move.w  D1,($10,A6)
.L3:
            unlk    A6
            rtd     #8
            ds.b    10
StdTxMeas:
            link.w  A6,#-$14
            move.l  A4,-(SP)
            movea.l (A5),A4
            clr.l   (-$14,A6)
            movea.l (A4),A0
            lea     (-$10,A6),A1
            move.w  ($44,A0),(A1)+
            move.w  ($4A,A0),(A1)+
            move.b  ($46,A0),(A1)+
            st      (A1)+
            move.w  (A0),(A1)+
            movea.l ($10,A6),A0
            move.l  (A0),(A1)+
            movea.l ($C,A6),A0
            move.l  (A0),(A1)+
            clr.l   -(SP)
            pea     (-$10,A6)
            movea.l JSwapFont,A0
            jsr     (A0)
            movea.l (SP)+,A1
            move.l  A1,(-$B0,A4)
            movea.l (A4),A0
            tst.w   (6,A0)
            bpl.b   .L1
            move.w  ($C,A0),D0
            beq.b   .L1
            bsr.w   CalcCharExtra
            move.l  D0,(-$14,A6)
.L1:
            movea.l (8,A6),A0
            clr.l   (A0)
            clr.l   (4,A0)
            move.b  ($D,A1),(1,A0)
            move.b  ($E,A1),(3,A0)
            move.b  ($F,A1),(5,A0)
            move.b  ($10,A1),D0
            ext.w   D0
            move.w  D0,(6,A0)
            movea.l ($10,A6),A0
            move.l  ($12,A1),(A0)
            movea.l ($C,A6),A0
            move.l  ($16,A1),(A0)
            movea.l ($14,A6),A0
            movea.l WidthTabHandle,A1
            movea.l (A1),A1
            moveq   #0,D1
            move.w  ($18,A6),D2
            bra.b   .L3
.L2:
            clr.w   D0
            move.b  (A0)+,D0
            lsl.w   #2,D0
            add.l   (0,A1,D0.w),D1
            cmpi.w  #$80,D0
            beq.b   .L3
            add.l   (-$14,A6),D1
.L3:
            dbra    D2,.L2
            move.l  D1,(-$AC,A4)
            swap    D1
            move.w  D1,($1A,A6)
            movea.l (SP)+,A4
            unlk    A6
            rtd     #$12
            ds.b    8
MeasureText:
            link.w  A6,#-$14
            movem.l D3-D6/A2-A4,-(SP)
            movea.l ($C,A6),A2
            movea.l (8,A6),A3
            move.w  ($10,A6),D3
            moveq   #0,D4
            movea.l (A5),A4
            movea.l (A4),A0
            clr.l   (-$14,A6)
            move.l  ($68,A0),D0
            beq.b   .L3
            movea.l D0,A1
            move.l  ($28,A1),D0
            cmp.l   ($11B4).w,D0
            beq.b   .L3
            moveq   #0,D6
            moveq   #0,D5
            subq.w  #2,SP
.L1:
            move.l  A2,-(SP)
            clr.w   -(SP)
            move.w  D4,-(SP)
            jsr     ([$1018.w])
            move.w  (SP),D0
            cmp.w   D6,D0
            bge.b   .L2
            add.w   D6,D5
.L2:
            add.w   D5,D0
            move.w  D0,(A3)+
            move.w  (SP),D6
            addq.w  #1,D4
            cmp.w   D3,D4
            ble.b   .L1
            addq.w  #2,SP
            bra.w   .L8
.L3:
            lea     (-$10,A6),A1
            move.w  ($44,A0),(A1)+
            move.w  ($4A,A0),(A1)+
            move.b  ($46,A0),(A1)+
            st      (A1)+
            move.w  (A0),(A1)+
            move.l  #$10001,(A1)+
            move.l  #$10001,(A1)+
            clr.l   -(SP)
            pea     (-$10,A6)
            jsr     ([$1204.w])
            movea.l (SP)+,A0
            move.w  ($14,A0),D3
            move.w  ($18,A0),D4
            movea.l (A4),A0
            tst.w   (6,A0)
            bpl.b   .L4
            move.w  ($C,A0),D0
            beq.b   .L4
            bsr.w   CalcCharExtra
            move.l  D0,(-$14,A6)
.L4:
            movea.l ($C,A6),A0
            movea.l WidthTabHandle,A1
            movea.l (A1),A1
            movea.l (8,A6),A2
            moveq   #0,D1
            move.w  ($10,A6),D2
.L5:
            swap    D1
            move.w  D1,(A2)+
            swap    D1
            clr.w   D0
            move.b  (A0)+,D0
            lsl.w   #2,D0
            add.l   (0,A1,D0.w),D1
            cmpi.w  #$80,D0
            beq.b   .L6
            add.l   (-$14,A6),D1
.L6:
            dbra    D2,.L5
            cmp.w   D3,D4
            beq.b   .L8
            movea.l (8,A6),A2
            move.w  ($10,A6),D2
.L7:
            move.w  (A2),D0
            mulu.w  D3,D0
            divu.w  D4,D0
            move.w  D0,(A2)+
            dbra    D2,.L7
.L8:
            movem.l (SP)+,D3-D6/A2-A4
            unlk    A6
            rtd     #$A
            ds.b    4
GetFontInfo:
            link.w  A6,#-8
            move.l  #$10001,(-4,A6)
            move.l  #$10001,(-8,A6)
            clr.l   -(SP)
            clr.l   -(SP)
            pea     (-4,A6)
            pea     (-8,A6)
            move.l  (8,A6),-(SP)
            movea.l (A5),A0
            movea.l (A0),A0
            move.l  ($68,A0),D0
            movea.l ($11B4).w,A0
            beq.b   .L1
            movea.l D0,A0
            movea.l ($28,A0),A0
.L1:
            jsr     (A0)
            tst.w   (SP)+
            movea.l (A5),A0
            movea.l (-$B0,A0),A0
            movea.l (8,A6),A1
            move.b  ($C,A0),D0
            ext.w   D0
            add.w   D0,(4,A1)
            clr.w   D0
            move.b  ($B,A0),D0
            beq.b   .L2
            addq.w  #1,(A1)
            add.w   D0,(2,A1)
.L2:
            move.l  (-4,A6),D0
            cmp.l   (-8,A6),D0
            beq.b   .L3
            bsr.b   SCALE
            bsr.b   SCALE
            move.w  (A1),D0
            mulu.w  (-2,A6),D0
            move.w  (-6,A6),D1
            lsr.w   #1,D1
            ext.l   D1
            add.l   D1,D0
            divu.w  (-6,A6),D0
            move.w  D0,(A1)+
            bsr.b   SCALE
.L3:
            unlk    A6
            rtd     #4
SCALE:
            move.w  (A1),D0
            mulu.w  (-4,A6),D0
            move.w  (-8,A6),D1
            lsr.w   #1,D1
            ext.l   D1
            add.l   D1,D0
            divu.w  (-8,A6),D0
            move.w  D0,(A1)+
            rts
            ds.b    14
CalcCharExtra:
            movem.l D1-D2/A0-A1,-(SP)
            subq.w  #8,SP
            ext.l   D0
            asl.l   #4,D0
            move.l  D0,-(SP)
            movea.l WidthPtr,A0
            moveq   #0,D0
            move.w  ($40E,A0),D0
            swap    D0
            move.l  D0,-(SP)
            jsr     ([$FA0.w])
            subq.w  #8,SP
            move.w  ($992).w,-(SP)
            move.w  ($996).w,-(SP)
            jsr     ([$FA4.w])
            subq.w  #4,SP
            move.w  ($9B0).w,-(SP)
            move.w  ($9AC).w,-(SP)
            jsr     ([$FA4.w])
            jsr     ([$FA0.w])
            jsr     ([$FA0.w])
            movem.l (SP)+,D0-D2/A0-A1
            rts
            ds.b    14
CharExtra:
            movea.l ([A5]),A0
            tst.w   (6,A0)
            bpl.b   .L3
            subq.w  #4,SP
            move.l  (8,SP),-(SP)
            move.w  ($4A,A0),D0
            bne.b   .L2
            tst.w   ($44,A0)
            bne.b   .L1
            move.w  SysFontSize,D0
            bne.b   .L2
.L1:
            move.b  FMDefaultSize,D0
            bne.b   .L2
            moveq   #$C,D0
.L2:
            swap    D0
            clr.w   D0
            move.l  D0,-(SP)
            dc.w    $A84D                           ; A-trap $A84D
            move.l  (SP)+,D0
            asr.l   #4,D0
            movea.l ([A5]),A0
            move.w  D0,($C,A0)
.L3:
            rtd     #4
            ds.b    14
StdLine:
            link.w  A6,#0
            movem.l D5-D7/A3-A4,-(SP)
            jsr     ([$1A3C.w])
            ble.b   .L6
            clr.b   -(SP)
            bsr.l   PutPicVerb
            moveq   #$20,D7
            movea.l ($5C,A3),A4
            movea.l (A4),A4
            move.l  ($30,A3),D0
            cmp.l   ($30,A4),D0
            bne.b   .L1
            addq.w  #1,D7
.L1:
            move.w  ($A,A6),D6
            sub.w   D0,D6
            move.w  D6,D0
            ext.w   D0
            cmp.w   D6,D0
            bne.b   .L2
            move.w  (8,A6),D5
            sub.w   ($30,A3),D5
            move.w  D5,D0
            ext.w   D0
            cmp.w   D5,D0
            bne.b   .L2
            addq.w  #2,D7
.L2:
            move.w  D7,-(SP)
            bsr.l   PutPicOp
            ror.w   #1,D7
            bcs.b   .L3
            move.l  ($30,A3),-(SP)
            bsr.l   PutPicLong
.L3:
            ror.w   #1,D7
            bcs.b   .L4
            move.l  (8,A6),-(SP)
            bsr.l   PutPicLong
            bra.b   .L5
.L4:
            move.b  D6,-(SP)
            bsr.l   PutPicByte
            move.b  D5,-(SP)
            bsr.l   PutPicByte
.L5:
            movea.l ($5C,A3),A4
            movea.l (A4),A4
            move.l  (8,A6),($30,A4)
.L6:
            pea     sub_4082965A
            pea     GetRect_Lines
            jsr     ([$1AA0.w])
            movem.l (SP)+,D5-D7/A3-A4
            unlk    A6
            rtd     #4
GetRect_Lines:
            movea.l (SP)+,A0
            movea.l (SP)+,A1
            move.l  (8,A6),D0
            move.l  ($30,A3),D1
            cmp.w   D0,D1
            bgt.b   .L1
            exg     D0,D1
.L1:
            move.w  D0,(2,A1)
            add.w   ($36,A3),D1
            move.w  D1,(6,A1)
            swap    D0
            swap    D1
            cmp.w   D0,D1
            bgt.b   .L2
            exg     D0,D1
.L2:
            move.w  D0,(A1)
            add.w   ($34,A3),D1
            move.w  D1,(4,A1)
            jmp     (A0)
sub_4082965A:
            move.l  (8,A6),-(SP)
            jsr     ([$1A40.w])
            rts
            ds.b    10
LineTo:
            movea.l (A5),A0
            movea.l (A0),A0
            move.l  ($68,A0),D0
            movea.l ($1040).w,A0
            beq.b   .L1
            movea.l D0,A0
            movea.l (4,A0),A0
.L1:
            jmp     (A0)
            ds.b    10
Line:
            movea.l (A5),A0
            movea.l (A0),A0
            move.w  ($32,A0),D0
            add.w   D0,(6,SP)
            move.w  ($30,A0),D0
            add.w   D0,(4,SP)
            jmp     LineTo
            ds.b    8
MoveTo:
            movea.l (SP)+,A0
            movea.l (A5),A1
            movea.l (A1),A1
            move.l  (SP)+,($30,A1)
CommonMoveEnd:
            tst.w   (6,A1)
            bpl.b   .L1
            move.w  #$8000,($E,A1)
.L1:
            jmp     (A0)
            ds.b    8
Move_:
MOOV:
            movea.l (SP)+,A0
            move.w  (SP)+,D0
            move.w  (SP)+,D1
            movea.l (A5),A1
            movea.l (A1),A1
            add.w   D0,($30,A1)
            add.w   D1,($32,A1)
            bra.b   CommonMoveEnd
            ds.b    12
DoLine:
            movem.l D6-D7/A3-A4,-(SP)
            movea.l (A5),A4
            movea.l (A4),A3
            move.l  ($14,SP),D7
            move.l  ($30,A3),D6
            tst.l   ($64,A3)
            beq.b   .L3
            movea.l (-$A2,A4),A1
            movea.l (A1),A0
            moveq   #0,D0
            move.w  (A0),D0
            cmpi.w  #$A,D0
            bne.b   .L1
            move.l  D6,(0,A0,D0.l)
            addq.w  #4,D0
            bcs.b   .L2
.L1:
            move.l  D7,(0,A0,D0.l)
            addq.w  #4,D0
            move.w  D0,(A0)
            cmp.w   (-$A4,A4),D0
            bcs.b   .L2
            addi.w  #$100,(-$A4,A4)
            move.l  A1,-(SP)
            move.w  (-$A4,A4),-(SP)
            jsr     SetHSize
.L2:
            bra.b   .L4
.L3:
            tst.l   ($60,A3)
            beq.b   .L4
            move.l  D6,-(SP)
            move.l  D7,-(SP)
            move.l  (-$94,A4),-(SP)
            pea     (-$96,A4)
            pea     (-$98,A4)
            jsr     ([$1A64.w])
.L4:
            move.l  D6,-(SP)
            move.l  D7,-(SP)
            jsr     ([$1A28.w])
            move.l  D7,($30,A3)
            tst.w   (6,A3)
            bpl.b   .L5
            move.w  #$8000,($E,A3)
.L5:
            movem.l (SP)+,D6-D7/A3-A4
            move.l  (SP)+,(SP)
            rts
            ds.b    4
HidePen:
            moveq   #-1,D0
            bra.b   ShowPen.L1
ShowPen:
            moveq   #1,D0
.L1:
            movea.l (A5),A0
            movea.l (A0),A0
            add.w   D0,($42,A0)
            rts
GetPenState:
            movea.l (A5),A0
            movea.l (A0),A0
            move.w  (6,A0),D1
            lea     ($30,A0),A0
            movea.l (4,SP),A1
            move.l  (A0)+,(A1)+
            move.l  (A0)+,(A1)+
            move.w  (A0)+,(A1)+
            tst.w   D1
            bmi.b   .L3
.L1:
            move.l  (A0)+,(A1)+
            move.l  (A0)+,(A1)+
.L2:
            move.l  (SP)+,(SP)
            rts
.L3:
            move.l  (A0),(A1)
            movea.l (A0),A0
            movea.l (A0),A0
            tst.w   (A0)
            beq.b   .L4
            ori.w   #$8000,(-2,A1)
            bra.b   .L2
.L4:
            movea.l (6,A0),A0
            movea.l (A0),A0
            bra.b   .L1
SetPenState:
            movea.l (A5),A0
            movea.l (A0),A0
            move.w  (6,A0),D1
            lea     ($30,A0),A1
            movea.l (4,SP),A0
            move.l  (A0)+,(A1)+
            move.l  (A0)+,(A1)+
            move.w  (A0)+,(A1)
            andi.w  #$7FFF,(A1)+
            tst.w   D1
            bpl.b   GetPenState.L1
            tst.w   (-2,A0)
            bpl.b   .L1
            move.l  (A0),-(SP)
            jsr     ([$1628.w])
            bra.b   GetPenState.L2
.L1:
            move.l  A0,-(SP)
            jsr     ([$1074.w])
            bra.b   GetPenState.L2
            ds.b    12
GetPen:
            movea.l (A5),A0
            movea.l (A0),A0
            movea.l (4,SP),A1
            move.l  ($30,A0),(A1)
            move.l  (SP)+,(SP)
            rts
PenSize:
            movea.l (A5),A0
            movea.l (A0),A0
            move.l  (4,SP),($34,A0)
            move.l  (SP)+,(SP)
            rts
            dc.w    0
PenMode:
            moveq   #$38,D0
            jmp     PortWord
            ds.b    10
PenPat:
            movea.l (4,SP),A1
            movea.l (A5),A0
            movea.l (A0),A0
.L1:
            tst.w   (6,A0)
            bmi.b   .L3
            lea     ($3A,A0),A0
            move.l  (A1)+,(A0)+
            move.l  (A1)+,(A0)+
.L2:
            move.l  (SP)+,(SP)
            rts
.L3:
            move.l  A1,-(SP)
            pea     ($3A,A0)
            jsr     ([$1A44.w])
            bra.b   .L2
PenNormal:
            movea.l (A5),A0
            lea     (-$10,A0),A1
            movea.l (A0),A0
            move.l  #$10001,($34,A0)
            move.w  #8,($38,A0)
            move.l  (SP),-(SP)
            bra.b   PenPat.L1
            ds.b    14
PutLine:
            movem.l D3-D7/A2-A4,-(SP)
            move.w  ($36,SP),D2
            move.w  ($32,SP),D4
            cmp.w   D2,D4
            beq.w   .L13
            move.w  D2,D0
            sub.w   D4,D0
            bpl.b   .L1
            neg.w   D0
.L1:
            move.w  ($34,SP),D1
            sub.w   ($30,SP),D1
            bpl.b   .L2
            neg.w   D1
.L2:
            cmp.w   D1,D0
            ble.b   .L3
            move.w  D1,D0
.L3:
            addq.w  #1,D0
            ext.l   D0
            lsl.l   #3,D0
            movea.l ($2C,SP),A3
            movea.l ($28,SP),A4
            moveq   #0,D1
            move.w  (A4),D1
            add.l   D1,D0
            cmpi.l  #$FE00,D0
            blt.b   .L4
            move.w  #$FF6D,QDErr
            bra.w   .L13
.L4:
            movea.l ($24,SP),A0
            cmp.w   (A0),D0
            bls.b   .L5
            addi.w  #$200,D0
            move.w  D0,(A0)
            move.l  A3,-(SP)
            move.w  D0,-(SP)
            jsr     SetHSize
            move.w  ($36,SP),D2
.L5:
            movea.l (A3),A3
            moveq   #0,D0
            move.w  (A4),D0
            adda.l  D0,A3
            move.w  ($34,SP),D1
            move.w  ($30,SP),D3
            cmp.w   D1,D3
            bne.b   .L6
            move.w  D1,(A3)+
            move.w  D2,(A3)+
            move.w  D3,(A3)+
            move.w  D4,(A3)+
            bra.b   .L12
.L6:
            bgt.b   .L7
            exg     D1,D3
            exg     D2,D4
.L7:
            move.w  D1,D6
            clr.l   -(SP)
            move.w  D4,-(SP)
            sub.w   D2,(SP)
            move.w  D3,-(SP)
            sub.w   D1,(SP)
            jsr     ([$FA4.w])
            move.l  (SP)+,D7
            move.w  D2,D1
            swap    D1
            move.w  #$8000,D1
            move.l  D7,D0
            asr.l   #1,D0
            add.l   D0,D1
            move.l  #$10000,D0
            tst.l   D7
            bmi.b   .L8
            cmp.l   D0,D7
            bge.b   .L9
            add.l   D7,D1
            bra.b   .L9
.L8:
            cmpi.l  #$FFFF0000,D7
            bge.b   .L9
            add.l   D0,D1
.L9:
            move.w  D2,D5
.L10:
            swap    D1
            cmp.w   D1,D5
            beq.b   .L11
            move.w  D6,(A3)+
            move.w  D5,(A3)+
            move.w  D1,D5
            move.w  D6,(A3)+
            move.w  D5,(A3)+
.L11:
            swap    D1
            addq.w  #1,D6
            add.l   D7,D1
            cmp.w   D6,D3
            bne.b   .L10
            cmp.w   D4,D5
            beq.b   .L12
            move.w  D6,(A3)+
            move.w  D5,(A3)+
            move.w  D6,(A3)+
            move.w  D4,(A3)+
.L12:
            movea.l ($2C,SP),A0
            suba.l  (A0),A3
            move.w  A3,(A4)
.L13:
            movem.l (SP)+,D3-D7/A2-A4
            movea.l (SP)+,A0
            lea     ($14,SP),SP
            jmp     (A0)
            ds.b    6
DrawLine:
            link.w  A6,#-$14C
            movem.l D0-D7/A1-A5,-(SP)
            move.l  SP,(-$124,A6)
            move.l  A5,(-$13C,A6)
            clr.l   (-$20,A6)
            movea.l (A5),A0
            move.l  (-$82,A0),(-$148,A6)
            movea.l (A0),A3
            tst.w   ($42,A3)
            blt.w   .L33
            move.l  A3,(-$140,A6)
            move.l  SP,D1
            andi.b  #$FC,D1
            movea.l D1,SP
            lea     (2,A3),A1
            lea     (-$F4,A6),A2
            jsr     ([$1A08.w])
            move.l  D1,(-$14C,A6)
            move.b  D2,(-$144,A6)
            lea     ShftTbl,A0
            move.w  (-$D4,A6),D0
            moveq   #0,D1
            move.b  (0,A0,D0.w),D1
            move.w  D1,(-$76,A6)
            lea     ($3A,A3),A0
            move.l  A0,(-$9C,A6)
            move.w  ($38,A3),D0
            bset    #3,D0
            moveq   #$10,D1
            btst    #5,D0
            beq.b   .L1
            cmpi.w  #$3A,D0
            beq.b   .L2
            moveq   #$30,D1
.L1:
            cmp.w   D1,D0
            bgt.w   .L33
.L2:
            move.w  D0,(-$98,A6)
            tst.w   (6,A3)
            smi     (-$A6,A6)
            move.b  HiliteMode,-(SP)
            clr.b   (-$101,A6)
            jsr     ([$1A10.w])
            move.b  (SP)+,HiliteMode
            movea.l A3,A5
            movea.l ($1C,A5),A2
            movea.l (A2),A2
            movea.l ($18,A5),A3
            movea.l (A3),A3
            movem.w (8,A6),D1-D4
            cmp.w   D3,D1
            ble.b   .L3
            exg     D1,D3
.L3:
            cmp.w   D4,D2
            ble.b   .L4
            exg     D2,D4
.L4:
            add.w   ($36,A5),D4
            add.w   ($34,A5),D3
            movem.w D1-D4,(-$120,A6)
            pea     (-$120,A6)
            pea     (-$EE,A6)
            pea     (2,A2)
            pea     (2,A3)
            move.w  #4,-(SP)
            pea     (-$74,A6)
            jsr     ([$1A84.w])
            beq.w   .L33
            movea.l (-$13C,A6),A5
            tst.b   (-$144,A6)
            beq.b   .L5
            pea     (-$74,A6)
            move.l  (-$14C,A6),-(SP)
            jsr     ([$F54.w])
.L5:
            movea.l (-$140,A6),A5
            clr.b   (-$142,A6)
            cmpi.w  #$A,(A2)
            bne.b   .L10
            cmpi.w  #$A,(A3)
            beq.b   .L6
            move.l  ($18,A5),-(SP)
            pea     (-$74,A6)
            move.w  #$FFFF,-(SP)
            jsr     ([$1AA4.w])
            blt.w   .L32
            bgt.b   .L10
.L6:
            btst    #5,(-$97,A6)
            bne.b   .L10
            movea.l (-$9C,A6),A0
            tst.b   (-$A6,A6)
            beq.b   .L7
            movea.l (A0),A0
            movea.l (A0),A0
            tst.w   (A0)
            bne.b   .L10
            movea.l (6,A0),A0
            movea.l (A0),A0
.L7:
            move.l  (A0)+,D0
            cmp.l   (A0)+,D0
            bne.b   .L10
            not.l   D0
            beq.b   .L8
            not.l   D0
            bne.b   .L10
            eori.w  #4,(-$98,A6)
.L8:
            st      (-$142,A6)
            moveq   #7,D0
            and.w   (-$98,A6),D0
            move.b  .L9(PC,D0.w),D0
            bmi.w   .L32
            move.w  D0,(-$98,A6)
            bra.b   .L10
.L9:
            dc.w    0,$0102,$02FF,$FFFF
.L10:
            movem.w (8,A6),D1-D4
            cmp.w   D2,D4
            beq.b   .L11
            cmp.w   D1,D3
            bgt.b   .L14
            blt.b   .L13
.L11:
            tst.b   (-$142,A6)
            beq.b   .L12
            cmpi.l  #$10001,($34,A5)
            bne.b   .L12
            jmp     ([$1C70.w])
.L12:
            pea     (2,A5)
            clr.l   -(SP)
            pea     (2,A5)
            pea     (-$74,A6)
            clr.l   -(SP)
            pea     (-$74,A6)
            move.w  ($38,A5),-(SP)
            ori.w   #8,(SP)
            pea     ($3A,A5)
            move.l  ($1C,A5),-(SP)
            move.l  ($18,A5),-(SP)
            move.l  (-$148,A6),-(SP)
            movea.l (-$13C,A6),A5
            clr.w   -(SP)
            jsr     ([$1A9C.w])
            bra.w   .L32
.L13:
            exg     D1,D3
            exg     D2,D4
.L14:
            move.w  D3,D0
            add.w   ($34,A5),D0
            cmp.w   (-$74,A6),D0
            ble.w   .L32
            cmp.w   (-$70,A6),D1
            bge.w   .L32
            move.w  D2,(-$12C,A6)
            move.w  #$8000,(-$12A,A6)
            move.l  (-$12C,A6),(-$130,A6)
            move.w  ($36,A5),D0
            ble.w   .L32
            add.w   D0,(-$130,A6)
            move.w  ($34,A5),D6
            ble.w   .L32
            sub.w   D2,D4
            sub.w   D1,D3
            ext.l   D3
            moveq   #0,D7
            move.w  D4,D7
            swap    D7
            divs.l  D3,D7
            move.l  D7,(-$134,A6)
            move.l  D7,D5
            cmpi.w  #1,D6
            beq.b   .L15
            ext.l   D6
            dc.w    $4C06,$5805
.L15:
            suba.l  A2,A2
            move.l  D7,D0
            asr.l   #1,D0
            add.l   D0,(-$12C,A6)
            add.l   D0,(-$130,A6)
            tst.l   D7
            bmi.b   .L18
            sub.l   D5,(-$12C,A6)
            cmpi.l  #$10000,D7
            bgt.b   .L17
            beq.b   .L16
            add.l   D7,(-$12C,A6)
            addq.w  #1,A2
            bra.b   .L20
.L16:
            addq.w  #1,A2
.L17:
            subq.w  #1,(-$130,A6)
            bra.b   .L20
.L18:
            sub.l   D5,(-$130,A6)
            cmpi.l  #$FFFF0000,D7
            blt.b   .L19
            add.l   D7,(-$130,A6)
            subq.w  #1,A2
            bra.b   .L20
.L19:
            addq.w  #1,(-$12C,A6)
.L20:
            movem.w (-$74,A6),D1-D4
            cmp.w   (-$120,A6),D1
            beq.b   .L21
            move.w  D1,D0
            sub.w   (-$120,A6),D0
            ext.l   D0
            move.l  D7,D5
            dc.w    $4C00,$5805,$DBAE,$FED4,$DBAE,$FED0
.L21:
            tst.b   (-$142,A6)
            beq.b   .L22
            cmp.w   (-$11E,A6),D2
            bgt.b   .L22
            cmp.w   (-$11A,A6),D4
            blt.b   .L22
            cmpi.l  #$10001,($34,A5)
            bne.b   .L22
            jmp     ([$1C74.w])
.L22:
            move.w  (-$76,A6),D5
            sub.w   (-$EC,A6),D2
            ext.l   D2
            lsl.l   D5,D2
            andi.l  #$FFFFFFE0,D2
            move.l  D2,D1
            lsr.l   #3,D1
            move.w  D1,(-$90,A6)
            lsr.l   D5,D2
            add.w   (-$EC,A6),D2
            move.w  D2,(-$E,A6)
            tst.b   (-$142,A6)
            bne.w   .L24
            sub.w   D2,D4
            move.w  D4,D0
            ext.l   D4
            lsl.l   D5,D4
            subq.l  #1,D4
            lsr.l   #5,D4
            move.w  D4,(-$10,A6)
            lsr.w   #5,D0
            addq.w  #1,D0
            lsl.w   D5,D0
            subq.w  #1,D0
.L23:
            clr.l   -(SP)
            dbra    D0,.L23
            move.l  SP,(-8,A6)
            lea     .L32,A0
            move.l  A0,(-$80,A6)
            move.l  Lo3Bytes,(-$84,A6)
            clr.l   (-$7C,A6)
            clr.l   (-$C,A6)
            move.l  ($18,A5),-(SP)
            move.l  ($1C,A5),-(SP)
            move.l  #1,-(SP)
            jsr     ([$1A34.w])
.L24:
            move.w  (-$74,A6),D1
            sub.w   (-$EE,A6),D1
            move.w  (-$F0,A6),D0
            andi.w  #$7FFF,D0
            move.w  D0,(-$7C,A6)
            muls.w  D0,D1
            add.l   (-$F4,A6),D1
            move.w  (-$E,A6),D2
            sub.w   (-$EC,A6),D2
            move.w  (-$76,A6),D7
            lsl.w   D7,D2
            lsr.w   #3,D2
            ext.l   D2
            add.l   D2,D1
            move.l  D1,(-$138,A6)
            move.w  (-$E,A6),D1
            sub.w   D1,(-$12C,A6)
            sub.w   D1,(-$130,A6)
            sub.w   D1,(-$72,A6)
            sub.w   D1,(-$6E,A6)
            tst.b   (-$142,A6)
            beq.b   .L26
            move.w  (-$98,A6),D2
            jsr     ([$1A30.w])
            lea     (-$74,A6),A3
            move.l  (-$134,A6),D7
            movea.l (-$138,A6),A5
            move.l  (-$A0,A6),D4
            move.l  (-$A4,A6),D5
            move.w  (-$70,A6),D6
            sub.w   (-$74,A6),D6
            subq.w  #1,D6
            moveq   #1,D0
            jsr     ([$574.w])
            move.b  D0,(-$102,A6)
.L25:
            move.w  (-$12C,A6),D1
            move.w  (-$130,A6),D2
            movea.l A5,A1
            move.w  (-$76,A6),D0
            jsr     ([$1A2C.w])
            adda.w  (-$7C,A6),A5
            add.l   D7,(-$12C,A6)
            add.l   D7,(-$130,A6)
            dbra    D6,.L25
            bra.w   .L31
.L26:
            moveq   #0,D7
            move.w  (-$98,A6),D2
            btst    #5,D2
            bne.b   .L27
            bclr    #2,D2
            beq.b   .L27
            not.l   D7
.L27:
            movea.l (-$13C,A6),A5
            jsr     ([$1A54.w])
            move.w  (-$8E,A6),D1
            bne.b   .L28
            moveq   #$F,D6
            moveq   #4,D1
            move.w  D1,(-$8E,A6)
            move.w  #3,(-$8C,A6)
            move.w  #$3F,(-$8A,A6)
            bra.b   .L29
.L28:
            moveq   #0,D6
            move.w  (-$8A,A6),D6
            addq.w  #1,D6
            divu.w  (-$8E,A6),D6
            subq.w  #1,D6
.L29:
            and.w   (-$74,A6),D6
            mulu.w  D1,D6
            move.l  D6,(-$96,A6)
            move.w  (-$98,A6),D2
            jsr     ([$1A94.w])
            moveq   #1,D0
            jsr     ([$574.w])
            move.b  D0,(-$102,A6)
            move.w  (-$74,A6),(-4,A6)
            movea.l (-$138,A6),A5
            move.l  (-$A0,A6),D4
            move.l  (-$A4,A6),D5
            move.l  (-$134,A6),D7
.L30:
            jsr     ([-$1C.w,A6])
            lea     (-$74,A6),A3
            lea     ([-$88.w,A6],D6.l),A0
            move.l  (A0),D6
            move.w  (-$12C,A6),D1
            move.w  (-$130,A6),D2
            movea.l A5,A1
            movea.l (-8,A6),A2
            move.w  (-$76,A6),D0
            jsr     ([$1A2C.w])
            move.l  (-$96,A6),D6
            add.w   (-$8E,A6),D6
            and.w   (-$8A,A6),D6
            move.l  D6,(-$96,A6)
            adda.w  (-$7C,A6),A5
            add.l   D7,(-$12C,A6)
            add.l   D7,(-$130,A6)
            addq.w  #1,(-4,A6)
            move.w  (-4,A6),D0
            cmp.w   (-$70,A6),D0
            blt.b   .L30
.L31:
            move.b  (-$102,A6),D0
            jsr     ([$574.w])
.L32:
            movea.l (-$13C,A6),A5
            tst.b   (-$144,A6)
            beq.b   .L33
            jsr     ([$F4C.w])
.L33:
            bset    #7,HiliteMode
            movea.l (-$124,A6),SP
            movem.l (SP)+,D0-D7/A1-A5
            unlk    A6
            rtd     #8
            ds.b    12
FASTLINE:
            moveq   #1,D0
            move.w  D1,-(SP)
            jsr     ([$574.w])
            move.w  (SP)+,D1
            move.b  D0,(-$102,A6)
            cmp.w   D1,D3
            bne.w   .L12
            bsr.w   HVSETUP
            moveq   #-1,D6
            lsr.l   D0,D6
            move.w  (-$6E,A6),D2
            sub.w   (-$EC,A6),D2
            ext.l   D2
            lsl.l   D3,D2
            moveq   #$1F,D0
            and.l   D2,D0
            moveq   #-1,D3
            lsr.l   D0,D3
            not.l   D3
            lsr.l   #5,D2
            cmpi.w  #1,(-$98,A6)
            blt.b   .L1
            beq.b   .L7
            move.l  (-$A4,A6),D5
            bra.b   .L2
.L1:
            move.l  (-$A0,A6),D5
.L2:
            sub.w   D1,D2
            beq.b   .L6
            move.l  D5,D1
            and.l   D6,D1
            not.l   D6
            and.l   (A4),D6
            or.l    D1,D6
            move.l  D6,(A4)+
            subq.w  #1,D2
            beq.b   .L5
            bra.b   .L4
.L3:
            move.l  D5,(A4)+
.L4:
            move.l  D5,(A4)+
            subq.w  #2,D2
            bgt.b   .L3
            beq.b   .L4
.L5:
            and.l   D3,D5
            not.l   D3
            and.l   (A4),D3
            or.l    D5,D3
            move.l  D3,(A4)
            bra.w   DrawLine.L31
            ds.b    8
.L6:
            and.l   D3,D6
            and.l   D6,D5
            not.l   D6
            and.l   (A4),D6
            or.l    D5,D6
            move.l  D6,(A4)
            bra.w   DrawLine.L31
.L7:
            sub.w   D1,D2
            beq.b   .L11
            eor.l   D6,(A4)+
            subq.w  #1,D2
            beq.b   .L10
            bra.b   .L9
.L8:
            not.l   (A4)+
.L9:
            not.l   (A4)+
            subq.w  #2,D2
            bgt.b   .L8
            beq.b   .L9
.L10:
            eor.l   D3,(A4)
            bra.w   DrawLine.L31
.L11:
            and.l   D3,D6
            eor.l   D6,(A4)
            bra.w   DrawLine.L31
            ds.b    12
.L12:
            bsr.b   HVSETUP
            moveq   #-1,D2
            lsr.l   D0,D2
            move.l  D2,D0
            move.w  (-$D4,A6),D1
            lsr.l   D1,D0
            not.l   D0
            and.l   D0,D2
            move.w  (-$70,A6),D1
            sub.w   (-$74,A6),D1
            subq.w  #1,D1
            cmpi.w  #1,(-$98,A6)
            blt.b   .L13
            beq.b   .L16
            move.l  (-$A4,A6),D5
            bra.b   .L14
.L13:
            move.l  (-$A0,A6),D5
.L14:
            beq.b   .L18
            move.l  D5,D0
            not.l   D0
            beq.b   .L17
            and.l   D2,D5
            not.l   D2
.L15:
            move.l  D2,D3
            and.l   (A4),D3
            or.l    D5,D3
            move.l  D3,(A4)
            adda.w  D7,A4
            dbra    D1,.L15
            bra.w   DrawLine.L31
            dc.w    0
.L16:
            eor.l   D2,(A4)
            adda.w  D7,A4
            dbra    D1,.L16
            bra.w   DrawLine.L31
            ds.b    4
.L17:
            or.l    D2,(A4)
            adda.w  D7,A4
            dbra    D1,.L17
            bra.w   DrawLine.L31
            ds.b    4
.L18:
            not.l   D2
.L19:
            and.l   D2,(A4)
            adda.w  D7,A4
            dbra    D1,.L19
            bra.w   DrawLine.L31
            dc.w    0
HVSETUP:
            movea.l (-$F4,A6),A4
            move.w  (-$74,A6),D0
            sub.w   (-$EE,A6),D0
            move.w  (-$F0,A6),D7
            andi.w  #$7FFF,D7
            muls.w  D7,D0
            adda.l  D0,A4
            move.w  (-$72,A6),D0
            sub.w   (-$EC,A6),D0
            ext.l   D0
            move.w  (-$76,A6),D3
            ext.l   D3
            lsl.l   D3,D0
            move.l  D0,D1
            lsr.l   #5,D1
            lea     (0,A4,D1.w*4),A4
            andi.w  #$1F,D0
            rts
STEEPBLITTAB:
            dc.w    0,$00F8,0,$0138,0,$0178,0,$01B8
            dc.w    0,$01F8,0,$0238,0,$0278,0,$02B8
            dc.w    0,$02F8,0,$0338,0,$0378,0,$03B8
SHALLOWBLITTAB:
            dc.w    0,$0478,0,$04C8,0,$0528,0,$0528
            dc.w    0,$0528,$FFFF,$FE1E,0,$0588,0,$05D8
            dc.w    0,$0638,0,$0638,0,$0638,$FFFF,$FE1E
            ds.b    8
FASTSLANT:
            movea.l (-$F4,A6),A4
            move.w  D1,D0
            sub.w   (-$EE,A6),D0
            move.w  (-$F0,A6),D6
            andi.w  #$7FFF,D6
            muls.w  D6,D0
            movea.w D6,A3
            adda.l  D0,A4
            tst.w   A2
            beq.w   .L6
            sub.w   D1,D3
            moveq   #-1,D6
            add.w   D3,D6
            move.l  (-$12C,A6),D5
            move.l  D5,D2
            swap    D2
            sub.w   (-$EC,A6),D2
            ext.l   D2
            move.w  (-$76,A6),D3
            lsl.l   D3,D2
            move.l  D2,D4
            lsr.l   #5,D2
            lsl.l   #2,D2
            adda.l  D2,A4
            andi.w  #$1F,D4
            moveq   #1,D0
            jsr     ([$574.w])
            move.b  D0,(-$102,A6)
            tst.l   D7
            bpl.b   .L1
            neg.w   D7
            not.w   D5
.L1:
            tst.w   D7
            bne.b   .L2
            not.w   D7
            move.w  D7,D5
.L2:
            move.w  (-$D4,A6),D2
            move.l  (-$A0,A6),D1
            moveq   #0,D0
            lea     STEEPBLITTAB,A0
            cmpi.w  #1,(-$98,A6)
            blt.b   .L3
            beq.b   .L4
            move.l  (-$A4,A6),D1
.L3:
            adda.l  (0,A0,D3.w*4),A0
            jmp     (A0)
.L4:
            moveq   #-1,D1
            adda.l  ($18,A0,D3.w*4),A0
            jmp     (A0)
            ds.b    6
            tst.l   D7
            bmi.b   .L17
.L18:
            bfins   D1,(A4){D4:D2}
            adda.l  A3,A4
            add.w   D7,D5
            addx.l  D0,D4
            dbra    D6,.L18
            bra.w   DrawLine.L31
            ds.b    10
.L17:
            bfins   D1,(A4){D4:D2}
            adda.l  A3,A4
            add.w   D7,D5
            subx.l  D0,D4
            dbra    D6,.L17
            bra.w   DrawLine.L31
            ds.b    14
            tst.l   D7
            bmi.b   .L19
.L20:
            bfins   D1,(A4){D4:2}
            adda.l  A3,A4
            move.l  D0,D2
            add.w   D7,D5
            addx.l  D0,D2
            add.l   D2,D4
            add.l   D2,D4
            dbra    D6,.L20
            bra.w   DrawLine.L31
            ds.b    4
.L19:
            bfins   D1,(A4){D4:2}
            adda.l  A3,A4
            move.l  D0,D2
            add.w   D7,D5
            addx.l  D0,D2
            sub.l   D2,D4
            sub.l   D2,D4
            dbra    D6,.L19
            bra.w   DrawLine.L31
            ds.b    8
            tst.l   D7
            bmi.b   .L21
.L22:
            bfins   D1,(A4){D4:4}
            adda.l  A3,A4
            move.l  D0,D2
            add.w   D7,D5
            addx.l  D0,D2
            lsl.l   #2,D2
            add.l   D2,D4
            dbra    D6,.L22
            bra.w   DrawLine.L31
            ds.b    4
.L21:
            bfins   D1,(A4){D4:4}
            adda.l  A3,A4
            move.l  D0,D2
            add.w   D7,D5
            addx.l  D0,D2
            lsl.l   #2,D2
            sub.l   D2,D4
            dbra    D6,.L21
            bra.w   DrawLine.L31
            ds.b    8
            lsr.l   #3,D4
            tst.l   D7
            bmi.b   .L23
.L24:
            move.b  D1,(0,A4,D4.w)
            adda.l  A3,A4
            add.w   D7,D5
            addx.l  D0,D4
            dbra    D6,.L24
            bra.w   DrawLine.L31
            ds.b    8
.L23:
            move.b  D1,(0,A4,D4.w)
            adda.l  A3,A4
            add.w   D7,D5
            subx.l  D0,D4
            dbra    D6,.L23
            bra.w   DrawLine.L31
            ds.b    14
            lsr.l   #4,D4
            tst.l   D7
            bmi.b   .L25
.L26:
            move.w  D1,(0,A4,D4.w*2)
            adda.l  A3,A4
            add.w   D7,D5
            addx.l  D0,D4
            dbra    D6,.L26
            bra.w   DrawLine.L31
            ds.b    8
.L25:
            move.w  D1,(0,A4,D4.w*2)
            adda.l  A3,A4
            add.w   D7,D5
            subx.l  D0,D4
            dbra    D6,.L25
            bra.w   DrawLine.L31
            ds.b    14
            lsr.l   #5,D4
            tst.l   D7
            bmi.b   .L27
            move.l  D1,(0,A4,D4.w*4)
            adda.l  A3,A4
            add.w   D7,D5
            addx.l  D0,D4
            dc.b    $51,$CE,$FF,$F4,$60,$00,$FC
            ds.b    9
.L27:
            move.l  D1,(0,A4,D4.w*4)
            adda.l  A3,A4
            add.w   D7,D5
            subx.l  D0,D4
            dbra    D6,.L27
            bra.w   DrawLine.L31
            ds.b    14
            tst.l   D7
            bmi.b   .L28
.L29:
            bfchg   (A4){D4:D2}
            adda.l  A3,A4
            add.w   D7,D5
            addx.l  D0,D4
            dbra    D6,.L29
            bra.w   DrawLine.L31
            ds.b    10
.L28:
            bfchg   (A4){D4:D2}
            adda.l  A3,A4
            add.w   D7,D5
            subx.l  D0,D4
            dbra    D6,.L28
            bra.w   DrawLine.L31
            ds.b    14
            tst.l   D7
            bmi.b   .L30
.L31:
            bfchg   (A4){D4:2}
            adda.l  A3,A4
            move.l  D0,D2
            add.w   D7,D5
            addx.l  D0,D2
            add.l   D2,D4
            add.l   D2,D4
            dbra    D6,.L31
            bra.w   DrawLine.L31
            ds.b    4
.L30:
            bfchg   (A4){D4:2}
            adda.l  A3,A4
            move.l  D0,D2
            add.w   D7,D5
            addx.l  D0,D2
            sub.l   D2,D4
            sub.l   D2,D4
            dbra    D6,.L30
            bra.w   DrawLine.L31
            ds.b    8
            tst.l   D7
            bmi.b   .L32
.L33:
            bfchg   (A4){D4:4}
            adda.l  A3,A4
            move.l  D0,D2
            add.w   D7,D5
            addx.l  D0,D2
            lsl.l   #2,D2
            add.l   D2,D4
            dbra    D6,.L33
            bra.w   DrawLine.L31
            ds.b    4
.L32:
            bfchg   (A4){D4:4}
            adda.l  A3,A4
            move.l  D0,D2
            add.w   D7,D5
            addx.l  D0,D2
            lsl.l   #2,D2
            sub.l   D2,D4
            dbra    D6,.L32
            bra.w   DrawLine.L31
            ds.b    8
            lsr.l   #3,D4
            tst.l   D7
            bmi.b   .L34
            eor.b   D1,(0,A4,D4.w)
            adda.l  A3,A4
            add.w   D7,D5
            addx.l  D0,D4
            dc.b    $51,$CE,$FF,$F4,$60,$00,$FB
            ds.b    9
.L34:
            eor.b   D1,(0,A4,D4.w)
            adda.l  A3,A4
            add.w   D7,D5
            subx.l  D0,D4
            dbra    D6,.L34
            bra.w   DrawLine.L31
            ds.b    14
            lsr.l   #4,D4
            tst.l   D7
            bmi.b   .L35
.L36:
            eor.w   D1,(0,A4,D4.w*2)
            adda.l  A3,A4
            add.w   D7,D5
            addx.l  D0,D4
            dbra    D6,.L36
            bra.w   DrawLine.L31
            ds.b    8
.L35:
            eor.w   D1,(0,A4,D4.w*2)
            adda.l  A3,A4
            add.w   D7,D5
            subx.l  D0,D4
            dbra    D6,.L35
            bra.w   DrawLine.L31
            ds.b    14
            lsr.l   #5,D4
            tst.l   D7
            bmi.b   .L37
.L38:
            eor.l   D1,(0,A4,D4.w*4)
            adda.l  A3,A4
            add.w   D7,D5
            addx.l  D0,D4
            dbra    D6,.L38
            bra.w   DrawLine.L31
            ds.b    8
.L37:
            eor.l   D1,(0,A4,D4.w*4)
            adda.l  A3,A4
            add.w   D7,D5
            subx.l  D0,D4
            dbra    D6,.L37
            bra.w   DrawLine.L31
            ds.b    14
.L5:
            bra.w   DrawLine.L22
.L6:
            cmp.w   (-$120,A6),D1
            bgt.b   .L5
            cmp.w   (-$11C,A6),D3
            blt.b   .L5
            sub.w   D1,D3
            moveq   #-2,D6
            add.w   D3,D6
            move.w  D2,D0
            tst.l   D7
            bpl.b   .L7
            move.w  D4,D0
.L7:
            sub.w   (-$EC,A6),D0
            ext.l   D0
            move.w  (-$76,A6),D3
            lsl.l   D3,D0
            move.l  D0,D1
            lsr.l   #5,D0
            lsl.l   #2,D0
            adda.l  D0,A4
            andi.w  #$1F,D1
            move.l  D7,D5
            bpl.b   .L8
            neg.l   D5
.L8:
            movea.l D5,A2
            cmpi.l  #$10800,D5
            blt.b   .L5
            clr.w   D5
            swap    D5
            lsl.l   D3,D5
            cmpi.w  #$20,D5
            bge.b   .L5
            sub.w   D2,D4
            move.w  (-$12E,A6),D7
            lsl.l   D3,D4
            add.w   D1,D4
            movea.w D4,A5
            move.l  D1,D4
            tst.l   D7
            bpl.b   .L9
            suba.w  D1,A5
            suba.w  D1,A5
.L9:
            moveq   #1,D0
            jsr     ([$574.w])
            move.b  D0,(-$102,A6)
            moveq   #0,D0
            move.w  (-$6E,A6),D0
            sub.w   (-$12C,A6),D0
            tst.l   D7
            bmi.b   .L10
            move.w  (-$130,A6),D0
            sub.w   (-$72,A6),D0
.L10:
            lsl.l   D3,D0
            moveq   #0,D2
            move.l  (-$A0,A6),D1
            lea     SHALLOWBLITTAB,A0
            cmpi.w  #1,(-$98,A6)
            blt.b   .L11
            beq.b   .L12
            move.l  (-$A4,A6),D1
.L11:
            adda.l  (0,A0,D3.w*4),A0
            jmp     (A0)
.L12:
            adda.l  ($18,A0,D3.w*4),A0
            jmp     (A0)
            tst.l   D7
            bmi.b   .L14
.L13:
            bfins   D1,(A4){D4:D0}
            adda.l  A3,A4
            add.l   D0,D4
            move.w  D5,D0
            add.w   A2,D7
            addx.l  D2,D0
            dbra    D6,.L13
            suba.w  D4,A5
            move.w  A5,D0
            bfins   D1,(A4){D4:D0}
            bra.w   DrawLine.L31
            ds.b    14
.L14:
            sub.l   D0,D4
            bfins   D1,(A4){D4:D0}
            adda.l  A3,A4
            move.w  D5,D0
            add.w   A2,D7
            addx.l  D2,D0
            dbra    D6,.L14
            adda.w  D4,A5
            move.w  A5,D0
            sub.l   D0,D4
            bfins   D1,(A4){D4:D0}
            bra.w   DrawLine.L31
            tst.l   D7
            bmi.b   .L16
.L15:
            bfins   D1,(A4){D4:D0}
            adda.l  A3,A4
            add.l   D0,D4
            move.l  D2,D0
            add.w   A2,D7
            addx.l  D2,D0
            add.l   D0,D0
            add.l   D5,D0
            dbra    D6,.L15
            suba.w  D4,A5
            move.w  A5,D0
            bfins   D1,(A4){D4:D0}
            bra.w   DrawLine.L31
            ds.b    10
.L16:
            sub.l   D0,D4
            bfins   D1,(A4){D4:D0}
            adda.l  A3,A4
            move.l  D2,D0
            add.w   A2,D7
            addx.l  D2,D0
            add.l   D0,D0
            add.l   D5,D0
            dbra    D6,.L16
            adda.w  D4,A5
            move.w  A5,D0
            sub.l   D0,D4
            bfins   D1,(A4){D4:D0}
            bra.w   DrawLine.L31
            ds.b    12
            tst.l   D7
            bmi.b   .L39
.L40:
            bfins   D1,(A4){D4:D0}
            adda.l  A3,A4
            add.l   D0,D4
            move.l  D2,D0
            add.w   A2,D7
            addx.l  D2,D0
            lsl.l   D3,D0
            add.l   D5,D0
            dbra    D6,.L40
            suba.w  D4,A5
            move.w  A5,D0
            bfins   D1,(A4){D4:D0}
            bra.w   DrawLine.L31
            ds.b    10
.L39:
            sub.l   D0,D4
            bfins   D1,(A4){D4:D0}
            adda.l  A3,A4
            move.l  D2,D0
            add.w   A2,D7
            addx.l  D2,D0
            lsl.l   D3,D0
            add.l   D5,D0
            dbra    D6,.L39
            adda.w  D4,A5
            move.w  A5,D0
            sub.l   D0,D4
            bfins   D1,(A4){D4:D0}
            bra.w   DrawLine.L31
            ds.b    12
            tst.l   D7
            bmi.b   .L41
.L42:
            bfchg   (A4){D4:D0}
            adda.l  A3,A4
            add.l   D0,D4
            move.w  D5,D0
            add.w   A2,D7
            addx.l  D2,D0
            dbra    D6,.L42
            suba.w  D4,A5
            move.w  A5,D0
            bfchg   (A4){D4:D0}
            bra.w   DrawLine.L31
            ds.b    14
.L41:
            sub.l   D0,D4
            bfchg   (A4){D4:D0}
            adda.l  A3,A4
            move.w  D5,D0
            add.w   A2,D7
            addx.l  D2,D0
            dbra    D6,.L41
            adda.w  D4,A5
            move.w  A5,D0
            sub.l   D0,D4
            bfchg   (A4){D4:D0}
            bra.w   DrawLine.L31
            tst.l   D7
            bmi.b   .L43
.L44:
            bfchg   (A4){D4:D0}
            adda.l  A3,A4
            add.l   D0,D4
            move.l  D2,D0
            add.w   A2,D7
            addx.l  D2,D0
            add.l   D0,D0
            add.l   D5,D0
            dbra    D6,.L44
            suba.w  D4,A5
            move.w  A5,D0
            bfchg   (A4){D4:D0}
            bra.w   DrawLine.L31
            ds.b    10
.L43:
            sub.l   D0,D4
            bfchg   (A4){D4:D0}
            adda.l  A3,A4
            move.l  D2,D0
            add.w   A2,D7
            addx.l  D2,D0
            add.l   D0,D0
            add.l   D5,D0
            dbra    D6,.L43
            adda.w  D4,A5
            move.w  A5,D0
            sub.l   D0,D4
            bfchg   (A4){D4:D0}
            bra.w   DrawLine.L31
            ds.b    12
            tst.l   D7
            bmi.b   .L45
.L46:
            bfchg   (A4){D4:D0}
            adda.l  A3,A4
            add.l   D0,D4
            move.l  D2,D0
            add.w   A2,D7
            addx.l  D2,D0
            lsl.l   D3,D0
            add.l   D5,D0
            dbra    D6,.L46
            suba.w  D4,A5
            move.w  A5,D0
            bfchg   (A4){D4:D0}
            bra.w   DrawLine.L31
            ds.b    10
.L45:
            sub.l   D0,D4
            bfchg   (A4){D4:D0}
            adda.l  A3,A4
            move.l  D2,D0
            add.w   A2,D7
            addx.l  D2,D0
            lsl.l   D3,D0
            add.l   D5,D0
            dbra    D6,.L45
            adda.w  D4,A5
            move.w  A5,D0
            sub.l   D0,D4
            bfchg   (A4){D4:D0}
            bra.w   DrawLine.L31
            ds.b    12
RgnBlt:
            move.l  SP,(-$258,A6)
            move.w  (-$72,A6),D1
            sub.w   (8,A5),D1
            ext.l   D1
            lsl.l   D4,D1
            andi.w  #$FFE0,D1
            lsr.l   D4,D1
            add.w   (8,A5),D1
            move.w  D1,(-$E,A6)
            move.w  (-$6E,A6),D0
            sub.w   D1,D0
            move.w  D0,D1
            ext.l   D1
            lsl.l   D4,D1
            subq.l  #1,D1
            lsr.l   #5,D1
            move.w  D1,(-$10,A6)
            lsr.w   #5,D0
            addq.w  #1,D0
            lsl.w   D4,D0
            subq.w  #1,D0
.L1:
            clr.l   -(SP)
            dbra    D0,.L1
            move.l  SP,(-8,A6)
            moveq   #-1,D0
            cmpi.w  #4,D4
            bge.b   .L2
            cmpi.w  #$20,(-$98,A6)
            blt.b   .L2
            cmpi.w  #$2F,(-$98,A6)
            bgt.b   .L2
            moveq   #0,D0
.L2:
            move.l  D0,(-$C,A6)
            move.l  ($A,A6),-(SP)
            move.l  ($E,A6),-(SP)
            move.l  ($12,A6),-(SP)
            move.l  #2,-(SP)
            jsr     ([$1A34.w])
            move.w  (-$76,A6),D4
            movea.l ($1C,A6),A3
            move.w  (-$74,A6),(-$246,A6)
            move.w  (-$70,A6),(-$248,A6)
            move.l  #$40001,(-$24C,A6)
            move.l  (-8,A6),(-$250,A6)
            move.w  (-$98,A6),D2
            move.w  D2,D1
            cmpi.w  #$20,D2
            bcs.w   .L10
            cmpi.w  #$40,D2
            bcc.w   .L37
            cmpi.w  #$30,D2
            blt.b   .L4
            cmpi.w  #$32,D2
            beq.b   .L4
            cmpi.w  #$3A,D2
            bne.w   .L37
            tst.w   (-$8E,A6)
            bne.b   .L4
            movea.l (-$88,A6),A0
            moveq   #-1,D0
            moveq   #$F,D3
.L3:
            cmp.l   (A0)+,D0
            dbne    D3,.L3
            bne.b   .L4
            movea.l ($1C88).w,A0
            adda.l  (-4,A0,D4.w*4),A0
            move.l  A0,(-$218,A6)
            move.w  #$10,(-$98,A6)
            move.w  (-$D4,A6),D7
            bfextu  (-$118,A6){0:D7},D3
            bfextu  (-$114,A6){0:D7},D6
            clr.w   (-$8E,A6)
            bra.w   .L18
.L4:
            andi.w  #$37,D2
            bclr    #4,D2
            bne.b   .L8
            cmpi.w  #4,D4
            blt.b   .L9
            movea.l ($1C84).w,A0
            bne.b   .L5
            movea.l ($1C80).w,A0
.L5:
            subi.w  #$20,D2
            beq.b   .L7
.L6:
            adda.l  (0,A0,D2.w*4),A0
            move.l  A0,(-$218,A6)
            bra.b   .L13
.L7:
            lea     (-$FA,A6),A1
            move.w  (A1)+,D0
            cmp.w   (A1)+,D0
            bne.b   .L6
            cmp.w   (A1),D0
            bne.b   .L6
            addq.w  #1,D0
            andi.w  #$FFFE,D0
            cmpi.w  #$8000,D0
            bne.b   .L6
            addq.w  #8,D2
            bra.b   .L6
.L8:
            addq.w  #8,D2
.L9:
            add.w   D2,D2
            subi.w  #$28,D2
            bra.b   .L12
.L10:
            andi.w  #$B,D2
            moveq   #3,D0
            and.w   D2,D0
            add.w   D0,D2
            cmpi.w  #8,D2
            bge.b   .L11
            cmpi.w  #4,D2
            beq.b   .L12
            tst.w   (-$104,A6)
            beq.b   .L12
            addi.w  #$28,D2
.L11:
            tst.w   (-$8E,A6)
            beq.b   .L12
            addq.w  #8,D2
.L12:
            lea     ($1B68).w,A0
            move.l  (0,A0,D2.w*2),(-$218,A6)
            move.l  (-$1C8,A6),D7
.L13:
            btst    #3,D1
            beq.b   .L15
            move.l  (-$88,A6),(-$1F8,A6)
            move.w  (-$8E,A6),D1
            beq.b   .L14
            moveq   #0,D6
            move.w  (-$8A,A6),D6
            addq.w  #1,D6
            divu.w  (-$8E,A6),D6
            subq.w  #1,D6
            and.w   (-$74,A6),D6
            mulu.w  D1,D6
            swap    D6
            move.w  (-$8C,A6),D7
            bra.w   .L18
.L14:
            moveq   #$F,D7
            and.w   (-$74,A6),D7
            move.l  ([-$88.w,A6],D7.w*4),D6
            bra.w   .L18
.L15:
            movea.l ($24,A6),A2
            lea     (-$168,A6),A4
            move.l  (A4),D0
            cmp.l   (A5),D0
            bne.b   .L17
            move.w  (A3),D0
            sub.w   (6,A5),D0
            move.w  (A2),D1
            sub.w   (6,A4),D1
            sub.w   D1,D0
            blt.b   .L17
            bgt.b   .L16
            move.w  (2,A3),D0
            sub.w   (8,A5),D0
            move.w  (2,A2),D1
            sub.w   (8,A4),D1
            cmp.w   D1,D0
            ble.b   .L17
            move.w  (6,A2),D1
            sub.w   (8,A4),D1
            cmp.w   D1,D0
            bge.b   .L17
            neg.w   (-$24C,A6)
            bra.b   .L17
.L16:
            neg.w   (-$24A,A6)
            neg.l   (-$1BC,A6)
            neg.l   (-$7C,A6)
            move.w  (-$70,A6),(-$246,A6)
            subq.w  #1,(-$246,A6)
            move.w  (-$74,A6),(-$248,A6)
            subq.w  #1,(-$248,A6)
.L17:
            move.w  (2,A3),D6
            sub.w   (8,A5),D6
            ext.l   D6
            lsl.l   D4,D6
            move.w  (2,A2),D1
            sub.w   (8,A4),D1
            ext.l   D1
            lsl.l   D4,D1
            sub.l   D1,D6
            moveq   #$1F,D0
            and.l   D0,D6
            neg.l   D6
            move.w  (-$246,A6),D0
            sub.w   (A3),D0
            add.w   (A2),D0
            sub.w   (6,A4),D0
            move.w  (4,A4),D1
            andi.w  #$7FFF,D1
            muls.w  D1,D0
            movea.l (A4),A0
            adda.l  D0,A0
            move.w  (-$72,A6),D0
            sub.w   (2,A3),D0
            add.w   (2,A2),D0
            sub.w   (8,A4),D0
            ext.l   D0
            lsl.l   D4,D0
            sub.l   D6,D0
            asr.l   #5,D0
            lsl.l   #2,D0
            adda.l  D0,A0
            move.l  A0,(-$1F8,A6)
.L18:
            move.w  (-$246,A6),D0
            sub.w   (6,A5),D0
            move.w  (4,A5),D1
            andi.w  #$7FFF,D1
            muls.w  D1,D0
            movea.l (A5),A0
            adda.l  D0,A0
            move.w  (-$72,A6),D0
            sub.w   (8,A5),D0
            ext.l   D0
            lsl.l   D4,D0
            lsr.l   #5,D0
            lsl.l   #2,D0
            move.w  D0,D1
            add.l   A0,D0
            move.l  D0,(-$200,A6)
            tst.w   (-$8E,A6)
            beq.b   .L19
            and.w   D7,D1
            move.w  D1,(-$90,A6)
            move.w  D1,D6
            swap    D6
.L19:
            move.w  (-$98,A6),D2
            move.l  (-$118,A6),D4
            cmpi.w  #$10,D2
            beq.b   .L21
            tst.l   (-$C,A6)
            bne.b   .L20
            tst.w   (-$24C,A6)
            bpl.b   .L20
            move.w  (-$10,A6),D0
            ext.l   D0
            lsl.l   #2,D0
            add.l   D0,(-$200,A6)
            add.l   D0,(-$250,A6)
            add.l   D0,(-$1F8,A6)
.L20:
            move.w  (-$24C,A6),D3
            move.l  (-$A0,A6),D4
            move.l  (-$A4,A6),D5
.L21:
            move.w  (-$246,A6),(-4,A6)
            btst    #5,D2
            beq.w   .L29
            move.l  (-$114,A6),D5
            moveq   #0,D1
            move.w  (-$D4,A6),D1
            btst    #3,D2
            beq.b   .L23
            tst.w   (-$8E,A6)
            beq.b   .L22
            move.b  #1,(-$270,A6)
            move.w  D6,(-$27E,A6)
            movea.l (-$1F8,A6),A0
            adda.w  D6,A0
            move.l  A0,(-$1F8,A6)
            clr.w   D6
            swap    D6
            asl.l   #3,D6
            move.l  D6,(-$27C,A6)
            move.w  D1,D3
            subq.w  #1,D3
            not.w   D3
            move.w  (-$8E,A6),D0
            asl.w   #3,D0
            subq.w  #1,D0
            and.w   D3,D0
            move.w  D0,(-$8C,A6)
            bra.b   .L24
.L22:
            clr.b   (-$270,A6)
            lea     ([-$88.w,A6],D7.w*4),A3
            move.l  A3,(-$1F8,A6)
            move.w  D7,(-$27E,A6)
            moveq   #0,D6
            move.l  D6,(-$27C,A6)
            move.w  #$1F,(-$8C,A6)
            bra.b   .L24
.L23:
            st      (-$270,A6)
            move.l  D6,(-$27C,A6)
            move.w  #$FFFF,(-$8C,A6)
.L24:
            cmpi.w  #$10,D1
            blt.b   .L25
            asr.l   #3,D6
            move.l  D6,(-$27C,A6)
            move.w  (-$8C,A6),D0
            asr.w   #3,D0
            move.w  D0,(-$8C,A6)
.L25:
            move.w  D1,D7
            andi.w  #$37,D2
            cmpi.w  #$24,D2
            beq.b   .L26
            move.w  (-$10E,A6),D5
.L26:
            cmpi.w  #$32,D2
            bne.b   .L27
            bfextu  (-$118,A6){0:D7},D5
.L27:
            moveq   #5,D4
            sub.w   (-$76,A6),D4
            moveq   #1,D0
            lsl.w   D4,D0
            move.w  D0,(-$286,A6)
            move.w  D0,D2
            moveq   #0,D4
            move.l  D7,D3
            moveq   #$20,D1
            tst.w   (-$24C,A6)
            bpl.b   .L28
            neg.l   D3
            neg.w   D1
            moveq   #$20,D4
            sub.w   D0,D4
            add.l   D4,D6
.L28:
            move.w  D4,(-$284,A6)
            move.w  D1,(-$288,A6)
            move.w  (-$10,A6),D0
            addq.w  #1,D0
            mulu.w  D2,D0
            subq.w  #1,D0
            move.w  D0,(-$10,A6)
.L29:
            moveq   #1,D0
            jsr     ([$574.w])
            move.b  D0,(-$102,A6)
            tst.l   (-$C,A6)
            bne.b   .L31
.L30:
            jsr     ([-$1C.w,A6])
            movea.l (-$1F8,A6),A3
            movea.l (-$200,A6),A5
            movea.l (-$250,A6),A4
            move.w  (-$10,A6),D2
            movea.l (-$218,A6),A2
            jmp     (A2)
.L31:
            movea.l (-$200,A6),A5
            movea.l (-$C,A6),A4
            move.w  (-$24C,A6),(-$78,A6)
            btst    #5,(-$97,A6)
            beq.b   .L32
            movea.w (-$24C,A6),A4
            move.w  (-$8C,A6),D4
.L32:
            tst.w   (-$7C,A6)
            bpl.b   .L34
            addq.w  #1,(-4,A6)
            jsr     ([-$1C.w,A6])
            subq.w  #1,(-4,A6)
            bra.b   .L34
.L33:
            move.w  D0,(-4,A6)
            move.l  A3,(-$1F8,A6)
.L34:
            jsr     ([-$1C.w,A6])
            move.w  D2,D1
            jsr     ([-$18.w,A6])
            move.w  (-4,A6),D0
            move.l  (-$7C,A6),D2
            movea.l (-$1F8,A6),A3
            movea.l (-$218,A6),A2
            jmp     (A2)
.L35:
            move.l  (-$1BC,A6),D0
            add.l   D0,(-$1F8,A6)
            bra.b   .L36
            move.w  (-$90,A6),D6
            swap    D6
            add.w   (-$8E,A6),D6
            and.w   (-$8A,A6),D6
            bra.b   .L36
            addq.w  #1,D7
            andi.w  #$F,D7
            move.l  ([-$88.w,A6],D7.w*4),D6
.L36:
            move.l  (-$7C,A6),D0
            add.l   D0,(-$200,A6)
            move.w  (-4,A6),D0
            add.w   (-$24A,A6),D0
            move.w  D0,(-4,A6)
            cmp.w   (-$248,A6),D0
            bne.w   .L30
.L37:
            movea.l (-$258,A6),SP
            rts
.L38:
            move.w  (-$284,A6),D4
            move.l  (-$27C,A6),D6
            tst.b   (-$270,A6)
            beq.b   .L39
            bmi.b   .L35
            moveq   #0,D0
            move.w  (-$27E,A6),D0
            suba.l  D0,A3
            add.w   (-$8E,A6),D0
            and.w   (-$8A,A6),D0
            adda.l  D0,A3
            move.w  D0,(-$27E,A6)
            bra.b   .L40
.L39:
            move.w  (-$27E,A6),D0
            addq.w  #1,D0
            andi.w  #$F,D0
            lea     ([-$88.w,A6],D0.w*4),A3
            move.w  D0,(-$27E,A6)
.L40:
            move.l  A3,(-$1F8,A6)
            bra.b   .L36
            dc.w    0
.L41:
            move.l  A2,D1
.L42:
            move.l  (-$27C,A6),D6
            tst.b   (-$270,A6)
            beq.b   .L43
            bmi.b   .L44
            moveq   #0,D0
            move.w  (-$27E,A6),D0
            suba.l  D0,A3
            add.w   (-$8E,A6),D0
            and.w   (-$8A,A6),D0
            adda.l  D0,A3
            move.w  D0,(-$27E,A6)
            bra.b   .L45
.L43:
            move.w  (-$27E,A6),D0
            addq.w  #1,D0
            andi.w  #$F,D0
            lea     ([-$88.w,A6],D0.w*4),A3
            move.w  D0,(-$27E,A6)
            bra.b   .L45
.L44:
            adda.l  (-$1BC,A6),A3
.L45:
            movea.l (-$200,A6),A5
            adda.l  (-$7C,A6),A5
            move.l  A5,(-$200,A6)
            move.w  (-4,A6),D0
            add.w   (-$24A,A6),D0
            cmp.w   (-$248,A6),D0
            beq.w   .L37
            subq.w  #1,D1
            ble.w   .L33
            move.w  D0,(-4,A6)
            movea.l (-$218,A6),A2
            jmp     (A2)
RARITH16TAB:
            dc.w    0,$1134,0,$0944,0,$07E4,0,$0C14
            dc.w    0,$1484,0,$0D84,0,$0AA4,0,$0EC4
            dc.w    0,$1014
RARITH32TAB:
            dc.w    0,$1076,0,$08A0,0,$0770,0,$0B70
            dc.w    0,$1430,0,$0D10,0,$0A30,0,$0E50
            dc.w    0,$0FA0
RHILITETAB:
            dc.w    0,$11EC,0,$11EC,0,$11EC,0,$11EC
            dc.w    0,$12CC
            ds.b    8
rMASK0:
            tst.l   D7
            bne.b   .L3
            tst.w   D3
            bmi.b   .L3
            neg.l   D6
            move.w  D6,D4
            andi.w  #7,D4
            bne.b   .L2
            asr.w   #3,D6
            suba.w  D6,A3
            lea     nxtScan0.L6,A2
.L1:
            move.l  A2,(-$218,A6)
            jmp     (A2)
.L2:
            moveq   #$20,D3
            sub.w   D6,D3
            lea     nxtScan0.L5,A2
            bra.b   .L1
.L3:
            lea     nxtScan0.L1,A2
            bra.b   .L1
nxtScan0:
            adda.l  (-$7C,A6),A5
            adda.l  (-$1BC,A6),A3
            add.w   (-$24A,A6),D0
            cmp.w   (-$248,A6),D0
            beq.w   RgnBlt.L37
            subq.w  #1,D1
            ble.w   RgnBlt.L33
.L1:
            movea.l A5,A2
            movea.l A4,A1
            movea.l A3,A0
.L2:
            move.l  (A1)+,D2
            bmi.b   nxtScan0
            adda.w  D2,A2
            adda.w  D2,A0
            swap    D2
            bclr    #$E,D2
            beq.b   .L4
.L3:
            bfextu  (A0){D6:0},D4
            adda.w  D3,A0
            eor.l   D7,D4
            move.l  (A1)+,D5
            and.l   D5,D4
            not.l   D5
            and.l   (A2),D5
            or.l    D5,D4
            move.l  D4,(A2)
            adda.w  D3,A2
            dbra    D2,.L3
            bra.b   .L2
.L4:
            bfextu  (A0){D6:0},D4
            adda.w  D3,A0
            eor.l   D7,D4
            move.l  D4,(A2)
            adda.w  D3,A2
            dbra    D2,.L4
            bra.b   .L2
            dc.w    0
.L8:
            adda.l  (-$7C,A6),A5
            adda.l  (-$1BC,A6),A3
            add.w   (-$24A,A6),D0
            cmp.w   (-$248,A6),D0
            beq.w   RgnBlt.L37
            subq.w  #1,D1
            ble.w   RgnBlt.L33
.L5:
            movea.l A5,A2
            movea.l A4,A1
            movea.l A3,A0
.L11:
            move.l  (A1)+,D2
            bmi.b   .L8
            adda.w  D2,A2
            adda.w  D2,A0
            swap    D2
            bclr    #$E,D2
            beq.b   .L9
            move.l  (-4,A0),D5
.L10:
            move.l  (A0)+,D4
            lsl.l   D3,D5
            move.l  D4,D7
            lsr.l   D6,D7
            or.l    D5,D7
            move.l  (A1)+,D5
            and.l   D5,D7
            not.l   D5
            and.l   (A2),D5
            or.l    D5,D7
            move.l  D7,(A2)+
            move.l  D4,D5
            dbra    D2,.L10
            bra.b   .L11
.L9:
            move.l  (-4,A0),D5
.L12:
            move.l  (A0)+,D4
            lsl.l   D3,D5
            move.l  D4,D7
            lsr.l   D6,D7
            or.l    D5,D7
            move.l  D7,(A2)+
            move.l  D4,D5
            dbra    D2,.L12
            bra.b   .L11
            ds.b    6
.L13:
            adda.l  D2,A5
            adda.l  (-$1BC,A6),A3
            add.w   (-$24A,A6),D0
            cmp.w   (-$248,A6),D0
            beq.w   RgnBlt.L37
            subq.w  #1,D1
            ble.w   RgnBlt.L33
.L6:
            movea.l A5,A2
            movea.l A4,A1
            movea.l A3,A0
.L16:
            move.l  (A1)+,D3
            bmi.b   .L13
            adda.w  D3,A2
            adda.w  D3,A0
            swap    D3
            bclr    #$E,D3
            beq.b   .L14
.L15:
            move.l  (A0)+,D4
            move.l  (A1)+,D5
            and.l   D5,D4
            not.l   D5
            and.l   (A2),D5
            or.l    D4,D5
            move.l  D5,(A2)+
            dbra    D3,.L15
            bra.b   .L16
.L14:
            moveq   #$F,D4
            and.w   D3,D4
            neg.w   D4
            lsr.w   #4,D3
            jmp     (.L17.w,PC,D4.w*2)
.L18:
            move.l  (A0)+,(A2)+
            move.l  (A0)+,(A2)+
            move.l  (A0)+,(A2)+
            move.l  (A0)+,(A2)+
            move.l  (A0)+,(A2)+
            move.l  (A0)+,(A2)+
            move.l  (A0)+,(A2)+
            move.l  (A0)+,(A2)+
            move.l  (A0)+,(A2)+
            move.l  (A0)+,(A2)+
            move.l  (A0)+,(A2)+
            move.l  (A0)+,(A2)+
            move.l  (A0)+,(A2)+
            move.l  (A0)+,(A2)+
            move.l  (A0)+,(A2)+
.L17:
            move.l  (A0)+,(A2)+
            dbra    D3,.L18
            bra.b   .L16
            ds.b    10
.L7:
            adda.l  (-$7C,A6),A5
            adda.l  (-$1BC,A6),A3
            add.w   (-$24A,A6),D0
            cmp.w   (-$248,A6),D0
            beq.w   RgnBlt.L37
            subq.w  #1,D1
            ble.w   RgnBlt.L33
rMASK1:
            movea.l A5,A2
            movea.l A4,A1
            movea.l A3,A0
.L1:
            move.l  (A1)+,D2
            bmi.b   nxtScan0.L7
            adda.w  D2,A2
            adda.w  D2,A0
            swap    D2
            bclr    #$E,D2
            beq.b   .L3
.L2:
            bfextu  (A0){D6:0},D4
            adda.w  D3,A0
            eor.l   D7,D4
            and.l   (A1)+,D4
            or.l    D4,(A2)
            adda.w  D3,A2
            dbra    D2,.L2
            bra.b   .L1
.L3:
            bfextu  (A0){D6:0},D4
            adda.w  D3,A0
            eor.l   D7,D4
            or.l    D4,(A2)
            adda.w  D3,A2
            dbra    D2,.L3
            bra.b   .L1
            ds.b    10
.L4:
            adda.l  (-$7C,A6),A5
            adda.l  (-$1BC,A6),A3
            add.w   (-$24A,A6),D0
            cmp.w   (-$248,A6),D0
            beq.w   RgnBlt.L37
            subq.w  #1,D1
            ble.w   RgnBlt.L33
rMASK2:
            movea.l A5,A2
            movea.l A4,A1
            movea.l A3,A0
.L1:
            move.l  (A1)+,D2
            bmi.b   rMASK1.L4
            adda.w  D2,A2
            adda.w  D2,A0
            swap    D2
            bclr    #$E,D2
            beq.b   .L3
.L2:
            bfextu  (A0){D6:0},D4
            adda.w  D3,A0
            eor.l   D7,D4
            and.l   (A1)+,D4
            eor.l   D4,(A2)
            adda.w  D3,A2
            dbra    D2,.L2
            bra.b   .L1
.L3:
            bfextu  (A0){D6:0},D4
            adda.w  D3,A0
            eor.l   D7,D4
            eor.l   D4,(A2)
            adda.w  D3,A2
            dbra    D2,.L3
            bra.b   .L1
            ds.b    10
.L4:
            adda.l  (-$7C,A6),A5
            adda.l  (-$1BC,A6),A3
            add.w   (-$24A,A6),D0
            cmp.w   (-$248,A6),D0
            beq.w   RgnBlt.L37
            subq.w  #1,D1
            ble.w   RgnBlt.L33
rMASK3:
            movea.l A5,A2
            movea.l A4,A1
            movea.l A3,A0
.L1:
            move.l  (A1)+,D2
            bmi.b   rMASK2.L4
            adda.w  D2,A2
            adda.w  D2,A0
            swap    D2
            bclr    #$E,D2
            beq.b   .L3
.L2:
            bfextu  (A0){D6:0},D4
            adda.w  D3,A0
            eor.l   D7,D4
            and.l   (A1)+,D4
            not.l   D4
            and.l   D4,(A2)
            adda.w  D3,A2
            dbra    D2,.L2
            bra.b   .L1
.L3:
            bfextu  (A0){D6:0},D4
            adda.w  D3,A0
            eor.l   D7,D4
            not.l   D4
            and.l   D4,(A2)
            adda.w  D3,A2
            dbra    D2,.L3
            bra.b   .L1
            ds.b    6
rcMask0:
            swap    D0
            move.w  D1,D0
            movea.w (-$24C,A6),A4
            bra.b   .L2
.L1:
            adda.l  (-$7C,A6),A5
            adda.l  (-$1BC,A6),A3
            add.w   (-$24A,A6),D0
            cmp.w   (-$248,A6),D0
            beq.w   RgnBlt.L37
            swap    D0
            subq.w  #1,D0
            bgt.b   .L2
            swap    D0
            bra.w   RgnBlt.L33
.L2:
            swap    D0
            movea.l A5,A2
            movea.l (-$C,A6),A1
            movea.l A3,A0
.L3:
            move.l  (A1)+,D2
            bmi.b   .L1
            adda.w  D2,A2
            adda.w  D2,A0
            swap    D2
            bclr    #$E,D2
            beq.b   .L5
.L4:
            bfextu  (A0){D6:0},D3
            adda.w  A4,A0
            eor.l   D7,D3
            move.l  D3,D1
            not.l   D3
            and.l   D5,D3
            and.l   D4,D1
            or.l    D1,D3
            move.l  (A1)+,D1
            and.l   D1,D3
            not.l   D1
            and.l   (A2),D1
            or.l    D1,D3
            move.l  D3,(A2)
            adda.w  A4,A2
            dbra    D2,.L4
            bra.b   .L3
.L5:
            bfextu  (A0){D6:0},D3
            adda.w  A4,A0
            eor.l   D7,D3
            move.l  D3,D1
            not.l   D3
            and.l   D5,D3
            and.l   D4,D1
            or.l    D1,D3
            move.l  D3,(A2)
            adda.w  A4,A2
            dbra    D2,.L5
            bra.b   .L3
            ds.b    10
.L6:
            adda.l  (-$7C,A6),A5
            adda.l  (-$1BC,A6),A3
            add.w   (-$24A,A6),D0
            cmp.w   (-$248,A6),D0
            beq.w   RgnBlt.L37
            subq.w  #1,D1
            ble.w   RgnBlt.L33
rcMask1:
            movea.l A5,A2
            movea.l A4,A1
            movea.l A3,A0
.L1:
            move.l  (A1)+,D2
            bmi.b   rcMask0.L6
            adda.w  D2,A2
            adda.w  D2,A0
            swap    D2
            bclr    #$E,D2
            beq.b   .L3
.L2:
            bfextu  (A0){D6:0},D5
            adda.w  D3,A0
            eor.l   D7,D5
            and.l   (A1)+,D5
            not.l   D5
            and.l   D5,(A2)
            not.l   D5
            and.l   D4,D5
            or.l    D5,(A2)
            adda.w  D3,A2
            dbra    D2,.L2
            bra.b   .L1
.L3:
            bfextu  (A0){D6:0},D5
            adda.w  D3,A0
            eor.l   D7,D5
            not.l   D5
            and.l   D5,(A2)
            not.l   D5
            and.l   D4,D5
            or.l    D5,(A2)
            adda.w  D3,A2
            dbra    D2,.L3
            bra.b   .L1
            ds.b    10
.L4:
            adda.l  (-$7C,A6),A5
            adda.l  (-$1BC,A6),A3
            add.w   (-$24A,A6),D0
            cmp.w   (-$248,A6),D0
            beq.w   RgnBlt.L37
            subq.w  #1,D1
            ble.w   RgnBlt.L33
rcMask3:
            movea.l A5,A2
            movea.l A4,A1
            movea.l A3,A0
.L1:
            move.l  (A1)+,D2
            bmi.b   rcMask1.L4
            adda.w  D2,A2
            adda.w  D2,A0
            swap    D2
            bclr    #$E,D2
            beq.b   .L3
.L2:
            bfextu  (A0){D6:0},D4
            adda.w  D3,A0
            eor.l   D7,D4
            and.l   (A1)+,D4
            not.l   D4
            and.l   D4,(A2)
            not.l   D4
            and.l   D5,D4
            or.l    D4,(A2)
            adda.w  D3,A2
            dbra    D2,.L2
            bra.b   .L1
.L3:
            bfextu  (A0){D6:0},D4
            adda.w  D3,A0
            eor.l   D7,D4
            not.l   D4
            and.l   D4,(A2)
            not.l   D4
            and.l   D5,D4
            or.l    D4,(A2)
            adda.w  D3,A2
            dbra    D2,.L3
            bra.b   .L1
            ds.b    10
.L4:
            addq.w  #1,D7
            andi.w  #$F,D7
            move.l  (0,A3,D7.w*4),D6
            adda.l  D2,A5
            addq.w  #1,D0
            cmp.w   (-$248,A6),D0
            bge.w   RgnBlt.L37
            subq.w  #1,D1
            ble.w   RgnBlt.L33
rMASK8:
            movea.l A5,A2
            movea.l A4,A1
.L1:
            move.l  (A1)+,D3
            bmi.b   rcMask3.L4
            adda.w  D3,A2
            swap    D3
            bclr    #$E,D3
            beq.b   .L3
.L2:
            move.l  D6,D5
            move.l  (A1)+,D4
            and.l   D4,D5
            not.l   D4
            and.l   (A2),D4
            or.l    D4,D5
            move.l  D5,(A2)+
            dbra    D3,.L2
            bra.b   .L1
.L3:
            moveq   #$F,D4
            and.w   D3,D4
            neg.w   D4
            lsr.w   #4,D3
            jmp     ($4082B13E.w,PC,D4.w*2)
sub_4082B120:
            move.l  D6,(A2)+
            move.l  D6,(A2)+
            move.l  D6,(A2)+
            move.l  D6,(A2)+
            move.l  D6,(A2)+
            move.l  D6,(A2)+
            move.l  D6,(A2)+
            move.l  D6,(A2)+
            move.l  D6,(A2)+
            move.l  D6,(A2)+
            move.l  D6,(A2)+
            move.l  D6,(A2)+
            move.l  D6,(A2)+
            move.l  D6,(A2)+
            move.l  D6,(A2)+
            move.l  D6,(A2)+
            dbra    D3,sub_4082B120
            bra.b   rMASK8.L1
            ds.b    10
.L1:
            addq.w  #1,D7
            andi.w  #$F,D7
            move.l  (0,A3,D7.w*4),D6
            adda.l  (-$7C,A6),A5
            addq.w  #1,D0
            cmp.w   (-$248,A6),D0
            bge.w   RgnBlt.L37
            subq.w  #1,D1
            ble.w   RgnBlt.L33
rMASK9:
            movea.l A5,A2
            movea.l A4,A1
            move.l  (-$A0,A6),D2
.L1:
            move.l  (A1)+,D3
            bmi.b   sub_4082B120.L1
            adda.w  D3,A2
            swap    D3
            bclr    #$E,D3
            beq.b   .L3
.L2:
            move.l  D6,D5
            and.l   (A1)+,D5
            move.l  D5,D4
            not.l   D4
            and.l   (A2),D4
            and.l   D2,D5
            or.l    D5,D4
            move.l  D4,(A2)+
            dbra    D3,.L2
            bra.b   .L1
.L3:
            move.l  D6,D5
            not.l   D5
            and.l   D2,D6
.L4:
            move.l  D5,D4
            and.l   (A2),D4
            or.l    D6,D4
            move.l  D4,(A2)+
            dbra    D3,.L4
            move.l  D5,D6
            not.l   D6
            bra.b   .L1
            ds.b    14
.L5:
            addq.w  #1,D7
            andi.w  #$F,D7
            move.l  (0,A3,D7.w*4),D6
            adda.l  D2,A5
            addq.w  #1,D0
            cmp.w   (-$248,A6),D0
            bge.w   RgnBlt.L37
            subq.w  #1,D1
            ble.w   RgnBlt.L33
rMASK10:
            movea.l A5,A2
            movea.l A4,A1
.L1:
            move.l  (A1)+,D3
            bmi.b   rMASK9.L5
            adda.w  D3,A2
            swap    D3
            bclr    #$E,D3
            beq.b   .L3
.L2:
            move.l  D6,D5
            and.l   (A1)+,D5
            eor.l   D5,(A2)+
            dbra    D3,.L2
            bra.b   .L1
.L3:
            moveq   #$F,D4
            and.w   D3,D4
            neg.w   D4
            lsr.w   #4,D3
            jmp     ($4082B226.w,PC,D4.w*2)
sub_4082B208:
            eor.l   D6,(A2)+
            eor.l   D6,(A2)+
            eor.l   D6,(A2)+
            eor.l   D6,(A2)+
            eor.l   D6,(A2)+
            eor.l   D6,(A2)+
            eor.l   D6,(A2)+
            eor.l   D6,(A2)+
            eor.l   D6,(A2)+
            eor.l   D6,(A2)+
            eor.l   D6,(A2)+
            eor.l   D6,(A2)+
            eor.l   D6,(A2)+
            eor.l   D6,(A2)+
            eor.l   D6,(A2)+
            eor.l   D6,(A2)+
            dbra    D3,sub_4082B208
            bra.b   rMASK10.L1
rMASK11:
            move.l  (-$A4,A6),(-$A0,A6)
            lea     rMASK9,A2
            move.l  A2,(-$218,A6)
            jmp     (A2)
            dc.w    0
.L1:
            move.w  (-$90,A6),D6
            swap    D6
            add.w   (-$8E,A6),D6
            and.w   (-$8A,A6),D6
            adda.l  D2,A5
            addq.w  #1,D0
            cmp.w   (-$248,A6),D0
            bge.w   RgnBlt.L37
            subq.w  #1,D1
            ble.w   RgnBlt.L33
rXMASK8:
            movea.l A5,A2
            movea.l A3,A0
            adda.w  D6,A0
            swap    D6
            movea.l A4,A1
.L1:
            move.l  (A1)+,D3
            bmi.b   rMASK11.L1
            adda.w  D3,A2
            add.w   D3,D6
            and.w   D7,D6
            swap    D3
            bclr    #$E,D3
            beq.b   .L3
.L2:
            move.l  (0,A0,D6.w),D5
            addq.w  #4,D6
            and.w   D7,D6
            move.l  (A1)+,D4
            and.l   D4,D5
            not.l   D4
            and.l   (A2),D4
            or.l    D4,D5
            move.l  D5,(A2)+
            dbra    D3,.L2
            bra.b   .L1
.L3:
            move.l  (0,A0,D6.w),(A2)+
            addq.w  #4,D6
            and.w   D7,D6
            dbra    D3,.L3
            bra.b   .L1
            ds.b    12
.L4:
            move.w  (-$90,A6),D6
            swap    D6
            add.w   (-$8E,A6),D6
            and.w   (-$8A,A6),D6
            adda.l  (-$7C,A6),A5
            addq.w  #1,D0
            cmp.w   (-$248,A6),D0
            bge.w   RgnBlt.L37
            subq.w  #1,D1
            ble.w   RgnBlt.L33
rXMASK9:
            move.l  (-$A0,A6),D2
            movea.l A5,A2
            movea.l A3,A0
            adda.w  D6,A0
            swap    D6
            movea.l A4,A1
.L1:
            move.l  (A1)+,D3
            bmi.b   rXMASK8.L4
            adda.w  D3,A2
            add.w   D3,D6
            and.w   D7,D6
            swap    D3
            bclr    #$E,D3
            beq.b   .L3
.L2:
            move.l  (0,A0,D6.w),D5
            addq.w  #4,D6
            and.w   D7,D6
            and.l   (A1)+,D5
            move.l  D5,D4
            not.l   D4
            and.l   (A2),D4
            and.l   D2,D5
            or.l    D4,D5
            move.l  D5,(A2)+
            dbra    D3,.L2
            bra.b   .L1
.L3:
            move.l  (0,A0,D6.w),D5
            move.l  D5,D4
            not.l   D4
            and.l   D2,D5
            and.l   (A2),D4
            addq.w  #4,D6
            and.w   D7,D6
            or.l    D4,D5
            move.l  D5,(A2)+
            dbra    D3,.L3
            bra.b   .L1
            ds.b    8
.L4:
            move.w  (-$90,A6),D6
            swap    D6
            add.w   (-$8E,A6),D6
            and.w   (-$8A,A6),D6
            adda.l  D2,A5
            addq.w  #1,D0
            cmp.w   (-$248,A6),D0
            bge.w   RgnBlt.L37
            subq.w  #1,D1
            ble.w   RgnBlt.L33
rXMASK10:
            movea.l A5,A2
            movea.l A3,A0
            adda.w  D6,A0
            swap    D6
            movea.l A4,A1
.L1:
            move.l  (A1)+,D3
            bmi.b   rXMASK9.L4
            adda.w  D3,A2
            add.w   D3,D6
            and.w   D7,D6
            swap    D3
            bclr    #$E,D3
            beq.b   .L3
.L2:
            move.l  (0,A0,D6.w),D5
            and.l   (A1)+,D5
            addq.w  #4,D6
            and.w   D7,D6
            eor.l   D5,(A2)+
            dbra    D3,.L2
            bra.b   .L1
.L3:
            move.l  (0,A0,D6.w),D5
            addq.w  #4,D6
            and.w   D7,D6
            eor.l   D5,(A2)+
            dbra    D3,.L3
            bra.b   .L1
            dc.w    0
rXMASK11:
            move.l  (-$A4,A6),(-$A0,A6)
            lea     rXMASK9,A2
            move.l  A2,(-$218,A6)
            jmp     (A2)
rAddOver:
            movea.l (-$108,A6),A0
            move.w  (-$8C,A6),D1
.L1:
            and.w   D1,D6
            bfextu  (A4){D4:D7},D0
            beq.b   .L2
            bfextu  (A3){D6:D7},D0
            lea     (0,A0,D0.w*8),A2
            bfextu  (A5){D4:D7},D0
            lea     (0,A0,D0.w*8),A1
            move.w  (A2)+,D0
            add.w   (A1)+,D0
            asl.l   D5,D0
            move.w  (A2)+,D0
            add.w   (A1)+,D0
            asl.l   D5,D0
            move.w  (A2)+,D0
            add.w   (A1)+,D0
            asl.l   D5,D0
            swap    D0
            move.b  ([-$10C.w,A6],D0.w,6.w),D0
            bfins   D0,(A5){D4:D7}
.L2:
            add.l   D3,D6
            add.l   D3,D4
            dbra    D2,.L1
            bra.w   RgnBlt.L38
            ds.b    4
            movea.l A3,A0
            movea.l (-$C,A6),A1
            move.l  #$7F7F7F,D0
            movea.l #$808080,A2
.L7:
            move.l  (A1)+,D2
            bmi.w   RgnBlt.L42
            adda.w  D2,A5
            add.w   D2,D6
            and.w   (-$8C,A6),D6
            swap    D2
.L6:
            move.l  (0,A0,D6.w),D7
            move.l  A2,D4
            and.l   D7,D4
            and.l   D0,D7
            move.l  (A5),D5
            move.l  A2,D3
            and.l   D5,D3
            and.l   D0,D5
            add.l   D7,D5
            eor.l   D4,D3
            eor.l   D3,D5
            move.l  D5,(A5)
            adda.w  A4,A5
            add.w   A4,D6
            and.w   (-$8C,A6),D6
            dbra    D2,.L6
            bra.b   .L7
            ds.b    6
            movea.l A3,A0
            movea.l (-$C,A6),A1
            move.w  #$3DEF,D0
            movea.w #$4210,A2
.L3:
            move.l  (A1)+,D2
            bmi.w   RgnBlt.L42
            adda.w  D2,A5
            add.w   D2,D6
            and.w   (-$8C,A6),D6
            swap    D2
            bclr    #$E,D2
            beq.b   sub_4082B4A8
.L4:
            tst.l   (A1)+
            bmi.b   .L5
            addq.w  #2,A5
            addq.w  #2,D6
            bsr.b   sub_4082B48C
            addq.w  #2,A5
            addq.w  #2,D6
            and.w   (-$8C,A6),D6
            dbra    D2,.L4
            bra.b   .L3
.L5:
            bsr.b   sub_4082B48C
            addq.w  #4,A5
            addq.w  #4,D6
            and.w   (-$8C,A6),D6
            dbra    D2,.L4
            bra.b   .L3
sub_4082B48C:
            move.w  (0,A0,D6.w),D7
            move.w  A2,D4
            and.w   D7,D4
            and.w   D0,D7
            move.w  (A5),D5
            move.w  A2,D3
            and.w   D5,D3
            and.w   D0,D5
            add.w   D7,D5
            eor.w   D4,D3
            eor.w   D3,D5
            move.w  D5,(A5)
            rts
sub_4082B4A8:
            bsr.b   sub_4082B48C
            addq.w  #2,A5
            addq.w  #2,D6
            bsr.b   sub_4082B48C
            addq.w  #2,A5
            addq.w  #2,D6
            and.w   (-$8C,A6),D6
            dbra    D2,sub_4082B4A8
            bra.b   rAddOver.L3
            dc.w    0
rAddPin:
            movea.l (-$108,A6),A0
.L1:
            and.w   (-$8C,A6),D6
            bfextu  (A4){D4:D7},D0
            beq.b   .L5
            bfextu  (A3){D6:D7},D0
            lea     (0,A0,D0.w*8),A2
            bfextu  (A5){D4:D7},D0
            lea     (0,A0,D0.w*8),A1
            moveq   #2,D1
.L2:
            move.w  (A2)+,D0
            add.w   (A1)+,D0
            bcs.b   .L3
            cmp.w   (-$FA.w,A6,D1.w*2),D0
            bls.b   .L4
.L3:
            move.w  (-$FA.w,A6,D1.w*2),D0
.L4:
            asl.l   D5,D0
            dbra    D1,.L2
            swap    D0
            move.b  ([-$10C.w,A6],D0.w,6.w),D0
            bfins   D0,(A5){D4:D7}
.L5:
            add.l   D3,D6
            add.l   D3,D4
            dbra    D2,.L1
            bra.w   RgnBlt.L38
            ds.b    12
            lea     .L9,A0
            move.l  A0,(-$218,A6)
            moveq   #0,D3
            move.b  (-$F6,A6),D3
            swap    D3
            move.w  (-$F8,A6),D3
            move.b  (-$FA,A6),D3
.L9:
            movea.l A3,A0
            movea.l (-$C,A6),A1
            movea.l D1,A2
            move.l  Lo3Bytes,D1
.L17:
            move.l  (A1)+,D2
            bmi.w   RgnBlt.L41
            adda.w  D2,A5
            add.w   D2,D6
            and.w   D4,D6
            swap    D2
.L16:
            move.l  (0,A0,D6.w),D7
            add.w   A4,D6
            and.w   D4,D6
            and.l   D1,D7
            move.l  D7,D0
            move.l  (A5),D5
            and.l   D1,D5
            clr.b   D0
            add.w   D5,D0
            bcs.b   .L11
            cmp.w   D3,D0
            bls.b   .L12
.L11:
            move.w  D3,D0
.L12:
            move.b  D7,D0
            add.b   D5,D0
            bcs.b   .L13
            cmp.b   D3,D0
            bls.b   .L14
.L13:
            move.b  D3,D0
.L14:
            clr.w   D5
            add.l   D5,D0
            cmp.l   D3,D0
            bls.b   .L15
            swap    D3
            swap    D0
            move.w  D3,D0
            swap    D0
            swap    D3
.L15:
            move.l  D0,(A5)
            adda.w  A4,A5
            dbra    D2,.L16
            bra.b   .L17
            ds.b    10
            lea     .L10,A0
            move.l  A0,(-$218,A6)
            moveq   #0,D3
            move.b  (-$F6,A6),D3
            lsr.b   #3,D3
            swap    D3
            move.w  (-$F8,A6),D3
            lsr.w   #3,D3
            move.b  (-$FA,A6),D3
            lsr.b   #3,D3
.L10:
            movea.l A3,A0
            movea.l (-$C,A6),A1
            move.w  #$3DEF,D0
            movea.w #$4210,A2
.L6:
            move.l  (A1)+,D2
            bmi.w   RgnBlt.L42
            adda.w  D2,A5
            add.w   D2,D6
            and.w   (-$8C,A6),D6
            swap    D2
            bclr    #$E,D2
            beq.b   sub_4082B644
.L7:
            tst.l   (A1)+
            bmi.b   .L8
            addq.w  #2,A5
            addq.w  #2,D6
            bsr.b   sub_4082B606
            addq.w  #2,A5
            addq.w  #2,D6
            and.w   D4,D6
            dbra    D2,.L7
            bra.b   .L6
.L8:
            bsr.b   sub_4082B606
            addq.w  #4,A5
            addq.w  #4,D6
            and.w   D4,D6
            dbra    D2,.L7
            bra.b   .L6
sub_4082B606:
            moveq   #0,D7
            move.w  (0,A0,D6.w),D7
            add.w   D7,D7
            lsl.l   #5,D7
            lsr.w   #3,D7
            lsr.b   #3,D7
            moveq   #0,D5
            move.w  (A5),D5
            add.w   D5,D5
            lsl.l   #5,D5
            lsr.w   #3,D5
            lsr.b   #3,D5
            add.l   D5,D7
            move.l  D7,D0
            cmp.l   D3,D0
            bls.b   .L1
            move.l  D3,D0
.L1:
            move.w  D7,D0
            cmp.w   D3,D0
            bls.b   .L2
            move.w  D3,D0
.L2:
            move.b  D7,D0
            cmp.b   D3,D0
            bls.b   .L3
            move.b  D3,D0
.L3:
            lsl.b   #3,D0
            lsl.w   #3,D0
            lsr.l   #6,D0
            move.w  D0,(A5)
            rts
sub_4082B644:
            bsr.b   sub_4082B606
            addq.w  #2,A5
            addq.w  #2,D6
            bsr.b   sub_4082B606
            addq.w  #2,A5
            addq.w  #2,D6
            and.w   D4,D6
            dbra    D2,sub_4082B644
            bra.w   rAddPin.L6
            ds.b    6
rSubOver:
            movea.l (-$108,A6),A0
            move.w  (-$8C,A6),D1
.L1:
            and.w   D1,D6
            bfextu  (A4){D4:D7},D0
            beq.b   .L2
            bfextu  (A3){D6:D7},D0
            lea     (0,A0,D0.w*8),A2
            bfextu  (A5){D4:D7},D0
            lea     (0,A0,D0.w*8),A1
            move.w  (A1)+,D0
            sub.w   (A2)+,D0
            asl.l   D5,D0
            move.w  (A1)+,D0
            sub.w   (A2)+,D0
            asl.l   D5,D0
            move.w  (A1)+,D0
            sub.w   (A2)+,D0
            asl.l   D5,D0
            swap    D0
            move.b  ([-$10C.w,A6],D0.w,6.w),D0
            bfins   D0,(A5){D4:D7}
.L2:
            add.l   D3,D6
            add.l   D3,D4
            dbra    D2,.L1
            bra.w   RgnBlt.L38
            ds.b    4
            movea.l A3,A0
            movea.l (-$C,A6),A1
            movea.l D1,A2
            move.l  #$7F7F7F,D0
            move.l  #$808080,D1
.L7:
            move.l  (A1)+,D2
            bmi.w   RgnBlt.L41
            adda.w  D2,A5
            add.w   D2,D6
            and.w   (-$8C,A6),D6
            swap    D2
.L6:
            move.l  (0,A0,D6.w),D7
            move.l  D1,D3
            and.l   D7,D3
            eor.l   D1,D3
            and.l   D0,D7
            move.l  (A5),D5
            move.l  D1,D4
            and.l   D5,D4
            and.l   D0,D5
            or.l    D1,D5
            sub.l   D7,D5
            eor.l   D3,D4
            eor.l   D4,D5
            move.l  D5,(A5)
            adda.w  A4,A5
            add.w   A4,D6
            and.w   (-$8C,A6),D6
            dbra    D2,.L6
            bra.b   .L7
            movea.l A3,A0
            movea.l (-$C,A6),A1
            movea.l D1,A2
            move.w  #$3DEF,D0
            move.w  #$4210,D1
.L3:
            move.l  (A1)+,D2
            bmi.w   RgnBlt.L41
            adda.w  D2,A5
            add.w   D2,D6
            and.w   (-$8C,A6),D6
            swap    D2
            bclr    #$E,D2
            beq.b   sub_4082B76E
.L4:
            tst.l   (A1)+
            bmi.b   .L5
            addq.w  #2,A5
            addq.w  #2,D6
            bsr.b   sub_4082B74E
            addq.w  #2,A5
            addq.w  #2,D6
            and.w   (-$8C,A6),D6
            dbra    D2,.L4
            bra.b   .L3
.L5:
            bsr.b   sub_4082B74E
            addq.w  #4,A5
            addq.w  #4,D6
            and.w   (-$8C,A6),D6
            dbra    D2,.L4
            bra.b   .L3
sub_4082B74E:
            move.w  D1,D3
            move.w  (0,A0,D6.w),D7
            and.w   D7,D3
            eor.w   D1,D3
            and.w   D0,D7
            move.w  (A5),D5
            move.w  D1,D4
            and.w   D5,D4
            and.w   D0,D5
            or.w    D1,D5
            sub.w   D7,D5
            eor.w   D3,D4
            eor.w   D4,D5
            move.w  D5,(A5)
            rts
sub_4082B76E:
            bsr.b   sub_4082B74E
            addq.w  #2,A5
            addq.w  #2,D6
            bsr.b   sub_4082B74E
            addq.w  #2,A5
            addq.w  #2,D6
            and.w   (-$8C,A6),D6
            dbra    D2,sub_4082B76E
            bra.b   rSubOver.L3
            ds.b    12
rSubPin:
            movea.l (-$108,A6),A0
.L1:
            and.w   (-$8C,A6),D6
            bfextu  (A4){D4:D7},D0
            beq.b   .L5
            bfextu  (A3){D6:D7},D0
            lea     (0,A0,D0.w*8),A2
            bfextu  (A5){D4:D7},D0
            lea     (0,A0,D0.w*8),A1
            moveq   #2,D1
.L2:
            move.w  (A1)+,D0
            sub.w   (A2)+,D0
            bcs.b   .L3
            cmp.w   (-$FA.w,A6,D1.w*2),D0
            bcc.b   .L4
.L3:
            move.w  (-$FA.w,A6,D1.w*2),D0
.L4:
            asl.l   D5,D0
            dbra    D1,.L2
            swap    D0
            move.b  ([-$10C.w,A6],D0.w,6.w),D0
            bfins   D0,(A5){D4:D7}
.L5:
            add.l   D3,D6
            add.l   D3,D4
            dbra    D2,.L1
            bra.w   RgnBlt.L38
            ds.b    12
            lea     .L9,A0
            move.l  A0,(-$218,A6)
            moveq   #0,D3
            move.b  (-$F6,A6),D3
            swap    D3
            move.w  (-$F8,A6),D3
            move.b  (-$FA,A6),D3
.L9:
            movea.l A3,A0
            movea.l (-$C,A6),A1
            movea.l D1,A2
            move.l  Lo3Bytes,D1
.L17:
            move.l  (A1)+,D2
            bmi.w   RgnBlt.L41
            adda.w  D2,A5
            add.w   D2,D6
            and.w   D4,D6
            swap    D2
.L16:
            move.l  (0,A0,D6.w),D5
            add.w   A4,D6
            and.w   D4,D6
            and.l   D1,D5
            move.l  (A5),D7
            and.l   D1,D7
            move.l  D7,D0
            st      D0
            sub.w   D5,D0
            bcs.b   .L11
            cmp.w   D3,D0
            bcc.b   .L12
.L11:
            move.w  D3,D0
.L12:
            move.b  D7,D0
            sub.b   D5,D0
            bcs.b   .L13
            cmp.b   D3,D0
            bcc.b   .L14
.L13:
            move.b  D3,D0
.L14:
            clr.w   D5
            sub.l   D5,D0
            cmp.l   D3,D0
            bge.b   .L15
            swap    D3
            swap    D0
            move.w  D3,D0
            swap    D0
            swap    D3
.L15:
            move.l  D0,(A5)
            adda.w  A4,A5
            dbra    D2,.L16
            bra.b   .L17
            ds.b    10
            lea     .L10,A0
            move.l  A0,(-$218,A6)
            moveq   #0,D3
            move.b  (-$F6,A6),D3
            lsr.b   #3,D3
            swap    D3
            move.w  (-$F8,A6),D3
            lsr.w   #3,D3
            move.b  (-$FA,A6),D3
            lsr.b   #3,D3
            addi.l  #$808080,D3
.L10:
            movea.l A3,A0
            movea.l (-$C,A6),A1
            movea.l D1,A2
            move.l  #$808080,D1
.L6:
            move.l  (A1)+,D2
            bmi.w   RgnBlt.L41
            adda.w  D2,A5
            add.w   D2,D6
            and.w   D4,D6
            swap    D2
            bclr    #$E,D2
            beq.b   sub_4082B91A
.L7:
            tst.l   (A1)+
            bmi.b   .L8
            addq.w  #2,A5
            addq.w  #2,D6
            bsr.b   sub_4082B8DA
            addq.w  #2,A5
            addq.w  #2,D6
            and.w   D4,D6
            dbra    D2,.L7
            bra.b   .L6
.L8:
            bsr.b   sub_4082B8DA
            addq.w  #4,A5
            addq.w  #4,D6
            and.w   D4,D6
            dbra    D2,.L7
            bra.b   .L6
sub_4082B8DA:
            moveq   #0,D5
            move.w  (0,A0,D6.w),D5
            add.w   D5,D5
            lsl.l   #5,D5
            lsr.w   #3,D5
            lsr.b   #3,D5
            moveq   #0,D7
            move.w  (A5),D7
            add.w   D7,D7
            lsl.l   #5,D7
            lsr.w   #3,D7
            lsr.b   #3,D7
            add.l   D1,D7
            sub.l   D5,D7
            move.l  D7,D0
            cmp.l   D3,D0
            bcc.b   .L1
            move.l  D3,D0
.L1:
            move.w  D7,D0
            cmp.w   D3,D0
            bcc.b   .L2
            move.w  D3,D0
.L2:
            move.b  D7,D0
            cmp.b   D3,D0
            bcc.b   .L3
            move.b  D3,D0
.L3:
            lsl.b   #3,D0
            lsl.w   #3,D0
            lsr.l   #6,D0
            move.w  D0,(A5)
            rts
sub_4082B91A:
            bsr.b   sub_4082B8DA
            addq.w  #2,A5
            addq.w  #2,D6
            bsr.b   sub_4082B8DA
            addq.w  #2,A5
            addq.w  #2,D6
            and.w   D4,D6
            dbra    D2,sub_4082B91A
            bra.w   rSubPin.L6
rMax:
            movea.l (-$108,A6),A0
            move.w  (-$8C,A6),D1
.L1:
            and.w   D1,D6
            bfextu  (A4){D4:D7},D0
            beq.b   .L5
            bfextu  (A3){D6:D7},D0
            lea     (0,A0,D0.w*8),A2
            bfextu  (A5){D4:D7},D0
            lea     (0,A0,D0.w*8),A1
            move.w  (A2)+,D0
            cmp.w   (A1),D0
            bcc.b   .L2
            move.w  (A1),D0
.L2:
            addq.w  #2,A1
            asl.l   D5,D0
            move.w  (A2)+,D0
            cmp.w   (A1),D0
            bcc.b   .L3
            move.w  (A1),D0
.L3:
            addq.w  #2,A1
            asl.l   D5,D0
            move.w  (A2)+,D0
            cmp.w   (A1),D0
            bcc.b   .L4
            move.w  (A1),D0
.L4:
            asl.l   D5,D0
            swap    D0
            move.b  ([-$10C.w,A6],D0.w,6.w),D0
            bfins   D0,(A5){D4:D7}
.L5:
            add.l   D3,D6
            add.l   D3,D4
            dbra    D2,.L1
            bra.w   RgnBlt.L38
            ds.b    4
            movea.l A3,A0
            movea.l (-$C,A6),A1
.L13:
            move.l  (A1)+,D2
            bmi.w   RgnBlt.L42
            adda.w  D2,A5
            add.w   D2,D6
            and.w   D4,D6
            swap    D2
.L12:
            move.l  (0,A0,D6.w),D7
            add.w   A4,D6
            and.w   D4,D6
            move.l  (A5),D5
            move.l  D5,D0
            cmp.w   D7,D0
            bhi.b   .L9
            move.w  D7,D0
            move.b  D5,D0
.L9:
            cmp.b   D7,D5
            bhi.b   .L10
            move.b  D7,D0
.L10:
            swap    D7
            swap    D0
            cmp.b   D7,D0
            bhi.b   .L11
            move.b  D7,D0
.L11:
            swap    D0
            move.l  D0,(A5)
            adda.w  A4,A5
            dbra    D2,.L12
            bra.b   .L13
            ds.b    12
            dc.w    $204B,$226E,$FFF4
.L6:
            move.l  (A1)+,D2
            bmi.w   RgnBlt.L42
            adda.w  D2,A5
            add.w   D2,D6
            and.w   D4,D6
            swap    D2
            bclr    #$E,D2
            beq.b   sub_4082BA5A
.L7:
            tst.l   (A1)+
            bmi.b   .L8
            addq.w  #2,A5
            addq.w  #2,D6
            bsr.b   sub_4082BA1E
            addq.w  #2,A5
            addq.w  #2,D6
            and.w   D4,D6
            dbra    D2,.L7
            bra.b   .L6
.L8:
            bsr.b   sub_4082BA1E
            addq.w  #4,A5
            addq.w  #4,D6
            and.w   D4,D6
            dbra    D2,.L7
            bra.b   .L6
sub_4082BA1E:
            moveq   #0,D7
            move.w  (0,A0,D6.w),D7
            add.w   D7,D7
            lsl.l   #5,D7
            lsr.w   #3,D7
            lsr.b   #3,D7
            moveq   #0,D5
            move.w  (A5),D5
            add.w   D5,D5
            lsl.l   #5,D5
            lsr.w   #3,D5
            lsr.b   #3,D5
            move.l  D7,D0
            cmp.l   D5,D0
            bcc.b   .L1
            move.l  D5,D0
.L1:
            move.w  D7,D0
            cmp.w   D5,D0
            bcc.b   .L2
            move.w  D5,D0
.L2:
            move.b  D7,D0
            cmp.b   D5,D0
            bcc.b   .L3
            move.b  D5,D0
.L3:
            lsl.b   #3,D0
            lsl.w   #3,D0
            lsr.l   #6,D0
            move.w  D0,(A5)
            rts
sub_4082BA5A:
            bsr.b   sub_4082BA1E
            addq.w  #2,A5
            addq.w  #2,D6
            bsr.b   sub_4082BA1E
            addq.w  #2,A5
            addq.w  #2,D6
            and.w   D4,D6
            dbra    D2,sub_4082BA5A
            bra.w   rMax.L6
rMin:
            movea.l (-$108,A6),A0
            move.w  (-$8C,A6),D1
.L1:
            and.w   D1,D6
            bfextu  (A4){D4:D7},D0
            beq.b   .L5
            bfextu  (A3){D6:D7},D0
            lea     (0,A0,D0.w*8),A2
            bfextu  (A5){D4:D7},D0
            lea     (0,A0,D0.w*8),A1
            move.w  (A2)+,D0
            cmp.w   (A1),D0
            bls.b   .L2
            move.w  (A1),D0
.L2:
            addq.w  #2,A1
            asl.l   D5,D0
            move.w  (A2)+,D0
            cmp.w   (A1),D0
            bls.b   .L3
            move.w  (A1),D0
.L3:
            addq.w  #2,A1
            asl.l   D5,D0
            move.w  (A2)+,D0
            cmp.w   (A1),D0
            bls.b   .L4
            move.w  (A1),D0
.L4:
            asl.l   D5,D0
            swap    D0
            move.b  ([-$10C.w,A6],D0.w,6.w),D0
            bfins   D0,(A5){D4:D7}
.L5:
            add.l   D3,D6
            add.l   D3,D4
            dbra    D2,.L1
            bra.w   RgnBlt.L38
            ds.b    4
            movea.l A3,A0
            movea.l (-$C,A6),A1
.L13:
            move.l  (A1)+,D2
            bmi.w   RgnBlt.L42
            adda.w  D2,A5
            add.w   D2,D6
            and.w   D4,D6
            swap    D2
.L12:
            move.l  (0,A0,D6.w),D7
            add.w   A4,D6
            and.w   D4,D6
            move.l  (A5),D5
            move.l  D5,D0
            cmp.w   D7,D0
            bls.b   .L9
            move.w  D7,D0
            move.b  D5,D0
.L9:
            cmp.b   D7,D5
            bls.b   .L10
            move.b  D7,D0
.L10:
            swap    D7
            swap    D0
            cmp.b   D7,D0
            bls.b   .L11
            move.b  D7,D0
.L11:
            swap    D0
            move.l  D0,(A5)
            adda.w  A4,A5
            dbra    D2,.L12
            bra.b   .L13
            ds.b    12
            dc.w    $204B,$226E,$FFF4
.L6:
            move.l  (A1)+,D2
            bmi.w   RgnBlt.L42
            adda.w  D2,A5
            add.w   D2,D6
            and.w   D4,D6
            swap    D2
            bclr    #$E,D2
            beq.b   sub_4082BB9A
.L7:
            tst.l   (A1)+
            bmi.b   .L8
            addq.w  #2,A5
            addq.w  #2,D6
            bsr.b   sub_4082BB5E
            addq.w  #2,A5
            addq.w  #2,D6
            and.w   D4,D6
            dbra    D2,.L7
            bra.b   .L6
.L8:
            bsr.b   sub_4082BB5E
            addq.w  #4,A5
            addq.w  #4,D6
            and.w   D4,D6
            dbra    D2,.L7
            bra.b   .L6
sub_4082BB5E:
            moveq   #0,D7
            move.w  (0,A0,D6.w),D7
            add.w   D7,D7
            lsl.l   #5,D7
            lsr.w   #3,D7
            lsr.b   #3,D7
            moveq   #0,D5
            move.w  (A5),D5
            add.w   D5,D5
            lsl.l   #5,D5
            lsr.w   #3,D5
            lsr.b   #3,D5
            move.l  D7,D0
            cmp.l   D5,D0
            bls.b   .L1
            move.l  D5,D0
.L1:
            move.w  D7,D0
            cmp.w   D5,D0
            bls.b   .L2
            move.w  D5,D0
.L2:
            move.b  D7,D0
            cmp.b   D5,D0
            bls.b   .L3
            move.b  D5,D0
.L3:
            lsl.b   #3,D0
            lsl.w   #3,D0
            lsr.l   #6,D0
            move.w  D0,(A5)
            rts
sub_4082BB9A:
            bsr.b   sub_4082BB5E
            addq.w  #2,A5
            addq.w  #2,D6
            bsr.b   sub_4082BB5E
            addq.w  #2,A5
            addq.w  #2,D6
            and.w   D4,D6
            dbra    D2,sub_4082BB9A
            bra.w   rMin.L6
rAvg:
            movea.l D3,A0
.L1:
            and.w   (-$8C,A6),D6
            bfextu  (A4){D4:D7},D0
            beq.b   .L3
            bfextu  (A3){D6:D7},D0
            lea     ([-$108.w,A6],D0.w*8),A2
            bfextu  (A5){D4:D7},D0
            lea     ([-$108.w,A6],D0.w*8),A1
            moveq   #2,D0
            move.w  (-$10E,A6),D3
            add.w   D3,D3
            clr.w   -(SP)
.L2:
            move.w  (A2)+,D1
            mulu.w  (-$FA.w,A6,D0.w*2),D1
            move.w  (A1)+,D5
            mulu.w  (-$100.w,A6,D0.w*2),D5
            add.l   D5,D1
            swap    D1
            move.w  (-$110,A6),D5
            lsr.w   D5,D1
            lsl.w   D3,D1
            or.w    D1,(SP)
            sub.w   (-$10E,A6),D3
            dbra    D0,.L2
            move.w  (SP)+,D0
            move.b  ([-$10C.w,A6],D0.w,6.w),D0
            bfins   D0,(A5){D4:D7}
.L3:
            add.l   A0,D6
            add.l   A0,D4
            dbra    D2,.L1
            move.l  A0,D3
            bra.w   RgnBlt.L38
            ds.b    4
            movea.l A3,A0
            movea.l (-$C,A6),A1
            move.l  #$7F7F7F,D0
            movea.l #$10101,A2
.L8:
            move.l  (A1)+,D2
            bmi.w   RgnBlt.L42
            adda.w  D2,A5
            add.w   D2,D6
            and.w   D4,D6
            swap    D2
.L7:
            move.l  (0,A0,D6.w),D7
            add.w   A4,D6
            and.w   D4,D6
            move.l  A2,D3
            and.l   D7,D3
            lsr.l   #1,D7
            and.l   D0,D7
            move.l  (A5),D5
            and.l   D5,D3
            lsr.l   #1,D5
            and.l   D0,D5
            add.l   D5,D7
            add.l   D3,D7
            move.l  D7,(A5)
            adda.w  A4,A5
            dbra    D2,.L7
            bra.b   .L8
            ds.b    10
            movea.l A3,A0
            movea.l (-$C,A6),A1
            move.w  #$3DEF,D0
            movea.w #$421,A2
.L4:
            move.l  (A1)+,D2
            bmi.w   RgnBlt.L42
            adda.w  D2,A5
            add.w   D2,D6
            and.w   D4,D6
            swap    D2
            bclr    #$E,D2
            beq.b   sub_4082BCD2
.L5:
            tst.l   (A1)+
            bmi.b   .L6
            addq.w  #2,A5
            addq.w  #2,D6
            bsr.b   sub_4082BCB6
            addq.w  #2,A5
            addq.w  #2,D6
            and.w   D4,D6
            dbra    D2,.L5
            bra.b   .L4
.L6:
            bsr.b   sub_4082BCB6
            addq.w  #4,A5
            addq.w  #4,D6
            and.w   D4,D6
            dbra    D2,.L5
            bra.b   .L4
sub_4082BCB6:
            move.l  A2,D3
            move.w  (0,A0,D6.w),D7
            and.w   D7,D3
            lsr.w   #1,D7
            and.w   D0,D7
            move.w  (A5),D5
            and.w   D5,D3
            lsr.w   #1,D5
            and.w   D0,D5
            add.w   D5,D7
            add.w   D3,D7
            move.w  D7,(A5)
            rts
sub_4082BCD2:
            bsr.b   sub_4082BCB6
            addq.w  #2,A5
            addq.w  #2,D6
            bsr.b   sub_4082BCB6
            addq.w  #2,A5
            addq.w  #2,D6
            and.w   D4,D6
            dbra    D2,sub_4082BCD2
            bra.b   rAvg.L4
            ds.b    10
.L1:
            move.w  (SP)+,D1
            bra.w   RgnBlt.L42
            movea.l A3,A0
            movea.l (-$C,A6),A1
            move.w  D1,-(SP)
            lea     (-$FA,A6),A2
            move.l  (A2)+,D1
            move.w  (A2),D0
            moveq   #0,D4
            move.l  D4,D3
            movea.l D4,A2
.L2:
            move.l  (A1)+,D2
            bmi.b   .L1
            adda.w  D2,A5
            add.w   D2,D6
            and.w   (-$8C,A6),D6
            swap    D2
.L3:
            move.l  (0,A0,D6.w),D7
            add.w   A4,D6
            and.w   (-$8C,A6),D6
            move.l  (A5),D5
            cmp.l   D3,D7
            bne.b   .L4
            cmp.l   A2,D5
            beq.b   .L5
.L4:
            moveq   #0,D3
            move.b  D7,D3
            swap    D1
            mulu.w  D1,D3
            moveq   #0,D4
            move.b  D5,D4
            neg.w   D1
            mulu.w  D1,D4
            neg.w   D1
            add.l   D3,D4
            swap    D4
            movea.w D4,A2
            move.w  D7,D3
            lsr.w   #8,D3
            swap    D1
            mulu.w  D1,D3
            move.w  D5,D4
            lsr.w   #8,D4
            neg.w   D1
            mulu.w  D1,D4
            neg.w   D1
            add.l   D3,D4
            swap    D4
            lsl.w   #8,D4
            adda.w  D4,A2
            moveq   #0,D3
            swap    D7
            move.b  D7,D3
            mulu.w  D0,D3
            moveq   #0,D4
            swap    D5
            move.b  D5,D4
            neg.w   D0
            mulu.w  D0,D4
            neg.w   D0
            add.l   D3,D4
            move.w  A2,D4
            swap    D5
            movea.l D5,A2
            swap    D7
            move.l  D7,D3
.L5:
            move.l  D4,(A5)
            adda.w  A4,A5
            dbra    D2,.L3
            bra.b   .L2
            ds.b    6
            movea.l A3,A0
            movea.l (-$C,A6),A1
            move.w  D1,-(SP)
            lea     (-$FA,A6),A2
            move.l  (A2)+,D1
            move.w  (A2),D0
            moveq   #0,D4
            move.l  D4,D3
            movea.l D4,A2
.L6:
            move.l  (A1)+,D2
            bmi.w   .L1
            adda.w  D2,A5
            add.w   D2,D6
            and.w   (-$8C,A6),D6
            swap    D2
            bclr    #$E,D2
            beq.w   sub_4082BE6E
.L7:
            tst.l   (A1)+
            bmi.b   .L8
            addq.w  #2,A5
            addq.w  #2,D6
            bsr.b   sub_4082BDE6
            addq.w  #2,A5
            addq.w  #2,D6
            and.w   (-$8C,A6),D6
            dbra    D2,.L7
            bra.b   .L6
.L8:
            bsr.b   sub_4082BDE6
            addq.w  #4,A5
            addq.w  #4,D6
            and.w   (-$8C,A6),D6
            dbra    D2,.L7
            bra.b   .L6
sub_4082BDE6:
            moveq   #0,D7
            move.w  (0,A0,D6.w),D7
            moveq   #0,D5
            move.w  (A5),D5
            cmp.w   D3,D7
            bne.b   .L1
            cmp.w   A2,D5
            beq.b   .L2
.L1:
            add.w   D7,D7
            lsl.l   #5,D7
            lsr.w   #3,D7
            lsr.b   #3,D7
            add.w   D5,D5
            lsl.l   #5,D5
            lsr.w   #3,D5
            lsr.b   #3,D5
            moveq   #0,D3
            move.b  D7,D3
            swap    D1
            mulu.w  D1,D3
            moveq   #0,D4
            move.b  D5,D4
            neg.w   D1
            mulu.w  D1,D4
            neg.w   D1
            add.l   D3,D4
            swap    D4
            movea.l D4,A2
            move.w  D7,D3
            lsr.w   #8,D3
            swap    D1
            mulu.w  D1,D3
            move.w  D5,D4
            lsr.w   #8,D4
            neg.w   D1
            mulu.w  D1,D4
            neg.w   D1
            add.l   D3,D4
            swap    D4
            lsl.w   #5,D4
            adda.w  D4,A2
            moveq   #0,D3
            swap    D7
            move.b  D7,D3
            mulu.w  D0,D3
            moveq   #0,D4
            swap    D5
            move.b  D5,D4
            neg.w   D0
            mulu.w  D0,D4
            neg.w   D0
            add.l   D3,D4
            clr.w   D4
            lsr.l   #6,D4
            add.w   A2,D4
            swap    D5
            lsl.b   #3,D5
            lsl.w   #3,D5
            lsr.l   #6,D5
            movea.l D5,A2
            swap    D7
            lsl.b   #3,D7
            lsl.w   #3,D7
            lsr.l   #6,D7
            move.l  D7,D3
.L2:
            move.w  D4,(A5)
            rts
sub_4082BE6E:
            bsr.w   sub_4082BDE6
            addq.w  #2,A5
            addq.w  #2,D6
            bsr.w   sub_4082BDE6
            addq.w  #2,A5
            addq.w  #2,D6
            and.w   (-$8C,A6),D6
            dbra    D2,sub_4082BE6E
            bra.w   sub_4082BCD2.L6
            ds.b    6
rHilite:
            lea     .L2,A0
            move.l  A0,(-$218,A6)
            movea.l (-$118,A6),A3
            move.l  (-$114,A6),D5
            bra.b   .L2
.L1:
            adda.l  (-$7C,A6),A5
            move.w  (-4,A6),D0
            addq.w  #1,D0
            cmp.w   (-$248,A6),D0
            bge.w   RgnBlt.L37
            subq.w  #1,A0
            move.w  A0,D1
            ble.w   RgnBlt.L33
.L2:
            movea.w D1,A0
            move.w  D0,(-4,A6)
            movea.l A5,A2
            movea.l (-$C,A6),A1
.L3:
            move.l  (A1)+,D2
            bmi.b   .L1
            adda.w  D2,A2
            swap    D2
            bclr    #$E,D2
            beq.b   .L11
.L4:
            move.l  (A2),D4
            cmp.l   D4,D5
            bne.b   .L6
.L5:
            move.l  (A1)+,D0
            move.l  A3,D1
            and.l   D0,D1
            not.l   D0
            and.l   (A2),D0
            or.l    D0,D1
            move.l  D1,(A2)+
            dbra    D2,.L4
            bra.b   .L3
.L6:
            cmp.l   A3,D4
            bne.b   .L7
            exg     D5,A3
            bra.b   .L5
.L7:
            moveq   #$20,D1
            sub.w   D7,D1
            movea.l D5,A4
            move.l  (A1)+,D5
.L8:
            bfextu  D5{D1:D7},D0
            beq.b   .L10
            bfextu  D4{D1:D7},D0
            cmp.l   D6,D0
            bne.b   .L9
            bfins   D3,D4{D1:D7}
            bra.b   .L10
.L9:
            cmp.l   D3,D0
            bne.b   .L10
            bfins   D6,D4{D1:D7}
.L10:
            sub.w   D7,D1
            bpl.b   .L8
            move.l  D4,(A2)+
            move.l  A4,D5
            dbra    D2,.L4
            bra.b   .L3
.L11:
            move.l  (A2),D4
            cmp.l   D4,D5
            bne.b   .L13
.L12:
            move.l  A3,(A2)+
            dbra    D2,.L11
            bra.b   .L3
.L13:
            cmp.l   A3,D4
            bne.b   .L14
            exg     D5,A3
            bra.b   .L12
.L14:
            moveq   #$20,D1
            sub.w   D7,D1
.L15:
            bfextu  D4{D1:D7},D0
            cmp.l   D6,D0
            bne.b   .L16
            bfins   D3,D4{D1:D7}
            bra.b   .L17
.L16:
            cmp.l   D3,D0
            bne.b   .L17
            bfins   D6,D4{D1:D7}
.L17:
            sub.w   D7,D1
            bpl.b   .L15
            move.l  D4,(A2)+
            dbra    D2,.L11
            bra.w   .L3
            ds.b    8
            lea     .L18,A0
            move.l  A0,(-$218,A6)
            moveq   #-1,D3
            lsr.l   #8,D3
            movea.l (-$118,A6),A3
            move.l  (-$114,A6),D5
            bra.b   .L18
.L19:
            adda.l  (-$7C,A6),A5
            move.w  (-4,A6),D0
            addq.w  #1,D0
            cmp.w   (-$248,A6),D0
            bge.w   RgnBlt.L37
            subq.w  #1,D1
            ble.w   RgnBlt.L33
.L18:
            move.w  D0,(-4,A6)
            movea.l A5,A2
            movea.l (-$C,A6),A1
.L22:
            move.l  (A1)+,D2
            bmi.b   .L19
            adda.w  D2,A2
            swap    D2
.L21:
            move.l  D3,D4
            and.l   (A2),D4
            cmp.l   D4,D5
            bne.b   .L20
.L24:
            move.l  A3,(A2)+
            dbra    D2,.L21
            bra.b   .L22
.L20:
            cmp.l   A3,D4
            bne.b   .L23
            exg     D5,A3
            bra.b   .L24
.L23:
            addq.l  #4,A2
            dbra    D2,.L21
            bra.b   .L22
rslowHilite:
            bra.w   RgnBlt.L37
            movea.w D1,A0
            bfextu  (-$114,A6){0:D7},D1
            movea.l D3,A0
            move.w  (-$8C,A6),D3
            bra.b   .L2
.L1:
            adda.l  (-$7C,A6),A5
            move.w  (-4,A6),D0
            addq.w  #1,D0
            cmp.w   (-$248,A6),D0
            bge.w   RgnBlt.L37
            subq.w  #1,A0
            move.w  A0,D1
            ble.w   RgnBlt.L33
.L2:
            move.w  D0,(-4,A6)
            movea.l A5,A2
            movea.l (-$C,A6),A1
.L3:
            move.l  (A1)+,D2
            bmi.b   .L1
            adda.w  D2,A2
            swap    D2
            bclr    #$E,D2
            beq.b   .L5
.L4:
            move.l  (A2),D4
            move.l  (A1)+,D0
            move.l  A3,D1
            and.l   D0,D1
            not.l   D0
            and.l   (A2),D0
            or.l    D0,D1
            move.l  D1,(A2)+
            dbra    D2,.L4
            bra.b   .L3
.L5:
            and.w   D3,D6
            bfextu  (A4){D4:D7},D0
            beq.b   .L7
            bfextu  (A3){D6:D7},D0
            beq.b   .L7
            bfextu  (A5){D4:D7},D0
            cmp.w   D5,D0
            bne.b   .L6
            bfins   D1,(A5){D4:D7}
            bra.b   .L7
.L6:
            cmp.w   D1,D0
            bne.b   .L7
            bfins   D5,(A5){D4:D7}
.L7:
            add.l   A0,D6
            add.l   A0,D4
            dbra    D2,.L5
            bra.b   .L3
            ds.b    6
rTransparent:
            move.w  (-$8C,A6),D1
            movea.w (-$286,A6),A0
            movea.w (-$288,A6),A2
            bfextu  D5{0:D7},D0
            movea.l D0,A1
.L1:
            and.w   D1,D6
            bfextu  (A3){D6:0},D0
            cmp.l   D0,D5
            beq.b   .L3
            bfextu  (A4){D4:D7},D0
            beq.b   .L2
            bfextu  (A3){D6:D7},D0
            cmpa.l  D0,A1
            beq.b   .L2
            bfins   D0,(A5){D4:D7}
.L2:
            add.l   D3,D6
            add.l   D3,D4
            dbra    D2,.L1
            bra.w   RgnBlt.L38
.L3:
            add.l   A2,D6
            add.l   A2,D4
            sub.w   A0,D2
            bge.b   .L1
            bra.w   RgnBlt.L38
            ds.b    10
            movea.l A3,A0
            movea.l (-$C,A6),A1
.L6:
            move.l  (A1)+,D2
            bmi.w   RgnBlt.L42
            adda.w  D2,A5
            add.w   D2,D6
            and.w   D4,D6
            swap    D2
.L5:
            move.l  (0,A0,D6.w),D7
            add.w   A4,D6
            and.w   D4,D6
            cmp.l   D7,D5
            beq.b   .L4
            move.l  D7,(A5)
.L4:
            adda.w  A4,A5
            dbra    D2,.L5
            bra.b   .L6
            ds.b    6
            movea.l A3,A0
            movea.l (-$C,A6),A1
.L11:
            move.l  (A1)+,D2
            bmi.w   RgnBlt.L42
            adda.w  D2,A5
            add.w   D2,D6
            and.w   D4,D6
            swap    D2
            bclr    #$E,D2
            beq.b   .L7
.L10:
            tst.l   (A1)+
            bmi.b   .L8
            move.w  (2,A0,D6.w),D7
            cmp.w   D7,D5
            beq.b   .L9
            move.w  D7,(2,A5)
.L9:
            adda.w  A4,A5
            add.w   A4,D6
            and.w   D4,D6
            dbra    D2,.L10
            bra.b   .L11
.L8:
            move.w  (0,A0,D6.w),D7
            cmp.w   D7,D5
            beq.b   .L12
            move.w  D7,(A5)
.L12:
            adda.w  A4,A5
            add.w   A4,D6
            and.w   D4,D6
            dbra    D2,.L10
            bra.b   .L11
.L7:
            move.l  (0,A0,D6.w),D7
            cmp.l   D7,D5
            beq.b   .L13
            cmp.w   D7,D5
            beq.b   .L14
            move.w  D7,(2,A5)
.L14:
            swap    D7
            cmp.w   D7,D5
            beq.b   .L13
            move.w  D7,(A5)
.L13:
            adda.w  A4,A5
            add.w   A4,D6
            and.w   D4,D6
            dbra    D2,.L7
            bra.b   .L11
StdRect:
            link.w  A6,#0
            movem.l D7/A3-A4,-(SP)
            move.b  ($C,A6),D7
            jsr     ([$1A3C.w])
            ble.b   .L1
            move.b  D7,-(SP)
            jsr     PutPicVerb
            moveq   #$30,D0
            add.w   D7,D0
            move.b  D0,-(SP)
            move.l  (8,A6),-(SP)
            jsr     PutPicRect
.L1:
            pea     StdDraw_Rects
            pea     GetRect_Rects
            jsr     ([$1AA0.w])
            movem.l (SP)+,D7/A3-A4
            unlk    A6
            rtd     #6
GetRect_Rects:
            move.l  (SP)+,D0
            movea.l (SP)+,A1
            movea.l (8,A6),A0
            move.l  (A0)+,(A1)+
            move.l  (A0),(A1)
            movea.l D0,A0
            jmp     (A0)
StdDraw_Rects:
            move.l  (8,A6),-(SP)
            tst.b   D7
            bne.b   .L2
            tst.l   ($60,A3)
            beq.b   .L1
            move.l  (8,A6),-(SP)
            move.l  (-$94,A4),-(SP)
            pea     (-$96,A4)
            pea     (-$98,A4)
            jsr     PUTRECT
.L1:
            jsr     FrmRect
            bra.b   .L3
.L2:
            jsr     ([$1A60.w])
            jsr     DrawRect
.L3:
            rts
            ds.b    12
STDDEVLOOP:
            link.w  A6,#-$26
            clr.l   (-$C,A6)
            movea.l DeviceList,A0
            movea.l (A0),A0
            tst.l   ($1E,A0)
            beq.w   .L10
            clr.w   (-$E,A6)
            movea.l A3,A0
            jsr     ([$1A5C.w])
            move.l  A0,(-$22,A6)
            move.l  (A0),D0
            movea.l MainDevice,A0
            movea.l (A0),A1
            movea.l ($16,A1),A1
            movea.l (A1),A1
            cmp.l   (A1),D0
            bne.w   .L10
            move.b  HiliteMode,(-$24,A6)
            move.l  ($30,A3),(-$12,A6)
            move.w  ($E,A3),(-$26,A6)
            move.l  SrcDevice,-(SP)
            move.l  TheGDevice,-(SP)
            move.l  ($64,A3),-(SP)
            move.l  ($60,A3),-(SP)
            movea.l ($2A,A1),A0
            movea.l (A0),A0
            move.l  (A0),(-$16,A6)
            move.l  ($50,A3),(-$1A,A6)
            move.l  ($54,A3),(-$1E,A6)
            move.l  A6,-(SP)
            movea.l (8,A6),A0
            pea     (-8,A6)
            movea.l (A6),A6
            jsr     (A0)
            movea.l (SP)+,A6
            lea     (-8,A6),A0
            movea.l (-$22,A6),A1
            move.l  (6,A1),D0
            move.l  D0,D1
            swap    D1
            sub.w   D1,(A0)+
            bvc.b   .L1
            jsr     ([$1A58.w])
.L1:
            sub.w   D0,(A0)+
            bvc.b   .L2
            jsr     ([$1A58.w])
.L2:
            sub.w   D1,(A0)+
            bvc.b   .L3
            jsr     ([$1A58.w])
.L3:
            sub.w   D0,(A0)+
            bvc.b   .L4
            jsr     ([$1A58.w])
.L4:
            movea.l DeviceList,A0
.L5:
            movea.l (A0),A1
            tst.w   ($14,A1)
            bpl.w   .L12
            move.l  A0,TheGDevice
            move.l  A0,SrcDevice
            move.l  A0,(-$C,A6)
            lea     ($22,A1),A0
            lea     (-8,A6),A1
            move.l  (A1)+,D0
            move.l  (A1)+,D1
            swap    D1
            cmp.w   (A0)+,D1
            ble.w   .L11
            swap    D1
            cmp.w   (A0)+,D1
            ble.w   .L11
            swap    D0
            cmp.w   (A0)+,D0
            bge.w   .L11
            swap    D0
            cmp.w   (A0)+,D0
            bge.w   .L11
            move.b  (-$24,A6),HiliteMode
            move.l  (-$12,A6),($30,A3)
            tst.w   (6,A3)
            bpl.w   .L10
            move.w  (-$26,A6),($E,A3)
            movea.l TheGDevice,A0
            movea.l (A0),A0
            movea.l ($16,A0),A0
            movea.l (A0),A0
            movea.l ($2A,A0),A0
            movea.l (A0),A0
            move.l  (A0),D0
            cmp.l   (-$16,A6),D0
            beq.b   .L10
            move.l  D0,(-$16,A6)
            subq.w  #6,SP
            clr.l   -(SP)
            move.l  (8,A3),D0
            beq.b   .L6
            movea.l D0,A0
            movea.l (A0),A0
            tst.l   ($C,A0)
            beq.b   .L6
            move.w  ($18,A0),D2
            move.w  ($16,A0),(2,SP)
            btst    #1,D2
            sne     (SP)
            btst    #0,D2
            beq.b   .L6
            move.w  ($10,A0),-(SP)
            jsr     ([$185C.w])
            bra.b   .L7
.L6:
            pea     (4,SP)
            move.l  (SP),-(SP)
            jsr     ([$1664.w])
            jsr     ([$1650.w])
.L7:
            tst.b   (SP)
            beq.b   .L8
            move.w  (2,SP),-(SP)
            jsr     ([$1860.w])
            bra.b   .L9
.L8:
            pea     (4,SP)
            move.l  (SP),-(SP)
            jsr     ([$1668.w])
            jsr     ([$1654.w])
.L9:
            lea     ($A,SP),SP
.L10:
            movea.l ($C,A6),A0
            move.l  A6,-(SP)
            movea.l (A6),A6
            jsr     (A0)
            movea.l (SP)+,A6
            st      (-$E,A6)
            move.l  (-$C,A6),D0
            beq.b   .L13
            clr.l   ($60,A3)
            clr.l   ($64,A3)
.L11:
            movea.l (-$C,A6),A0
            movea.l (A0),A1
.L12:
            move.l  ($1E,A1),D0
            movea.l D0,A0
            bne.w   .L5
            clr.l   (-$C,A6)
            move.l  (SP)+,($60,A3)
            move.l  (SP)+,($64,A3)
            move.l  (SP)+,TheGDevice
            move.l  (SP)+,SrcDevice
            move.l  (-$1A,A6),($50,A3)
            move.l  (-$1E,A6),($54,A3)
            tst.w   (-$E,A6)
            beq.b   .L10
.L13:
            bset    #7,HiliteMode
            unlk    A6
            rtd     #8
            ds.b    10
PINIT:
            tst.w   (-2,A0)
            bpl.b   .L1
            move.w  #$7FFE,(-2,A0)
            rts
.L1:
            move.w  #$8002,(-2,A0)
            rts
            ds.b    10
PUSHVERB:
            movea.l (SP)+,A0
            move.w  #8,-(SP)
            cmpi.b  #1,D7
            ble.b   .L5
            cmpi.b  #3,D7
            blt.b   .L3
            beq.b   .L4
            lea     ($28,A3),A1
            tst.w   (6,A3)
            bpl.b   .L2
.L1:
            lea     ($3E,A3),A1
.L2:
            move.l  A1,-(SP)
            bra.b   .L6
.L3:
            pea     ($20,A3)
            bra.b   .L6
.L4:
            addq.w  #2,(SP)
            lea     (-$10,A4),A1
            tst.w   (6,A3)
            bpl.b   .L2
            move.l  A0,-(SP)
            move.l  A1,-(SP)
            moveq   #0,D0
            jsr     ([$1A8C.w])
            movea.l (SP)+,A0
            bra.b   .L1
.L5:
            move.w  ($38,A3),D0
            or.w    D0,(SP)
            pea     ($3A,A3)
.L6:
            jmp     (A0)
            ds.b    12
FillRect:
            moveq   #0,D0
            bra.b   FillCRect.L1
FillCRect:
            moveq   #1,D0
.L1:
            movea.l (SP)+,A0
            movea.l (SP)+,A1
            move.l  A0,-(SP)
            move.l  A1,-(SP)
            jsr     ([$1A8C.w])
            moveq   #4,D0
            bra.b   CallRect
FrameRect:
            moveq   #0,D0
            bra.b   CallRect
PaintRect:
            moveq   #1,D0
            bra.b   CallRect
EraseRect:
            moveq   #2,D0
            bra.b   CallRect
InvertRect:
            moveq   #3,D0
CallRect:
            movea.l (SP)+,A0
            movea.l (SP)+,A1
            move.b  D0,-(SP)
            move.l  A1,-(SP)
            move.l  A0,-(SP)
            movea.l (A5),A0
            movea.l (A0),A0
            move.l  ($68,A0),D0
            movea.l ($1080).w,A0
            beq.b   .L1
            movea.l D0,A0
            movea.l (8,A0),A0
.L1:
            jmp     (A0)
            ds.b    10
DrawRect:
            link.w  A6,#0
            movea.l (A5),A0
            movea.l (A0),A1
            tst.w   ($42,A1)
            blt.b   .L1
            pea     (2,A1)
            clr.l   -(SP)
            pea     (2,A1)
            move.l  ($E,A6),-(SP)
            clr.l   -(SP)
            move.l  ($E,A6),-(SP)
            move.w  ($C,A6),-(SP)
            ori.w   #8,(SP)
            move.l  (8,A6),-(SP)
            move.l  ($1C,A1),-(SP)
            move.l  ($18,A1),-(SP)
            move.l  (-$82,A0),-(SP)
            clr.w   -(SP)
            jsr     ([$1A9C.w])
.L1:
            unlk    A6
            rtd     #$A
            ds.b    8
FrmRect:
            link.w  A6,#-$1C
            movea.l (A5),A0
            movea.l (A0),A0
            tst.w   ($42,A0)
            blt.w   DORECT.L2
            movea.l (8,A6),A1
            move.l  (A1)+,(-$1C,A6)
            move.l  (A1)+,(-$18,A6)
            lea     (-$1C,A6),A1
            move.w  ($36,A0),D2
            move.w  (2,A1),D0
            move.w  D0,(-2,A6)
            add.w   D2,D0
            move.w  D0,(-4,A6)
            move.w  (6,A1),D1
            move.w  D1,(-$A,A6)
            sub.w   D2,D1
            move.w  D1,(-6,A6)
            cmp.w   D1,D0
            bge.b   .L1
            move.w  ($34,A0),D2
            move.w  (A1),D0
            move.w  D0,(-$C,A6)
            add.w   D2,D0
            move.w  D0,(-$E,A6)
            move.w  (4,A1),D1
            move.w  D1,(-$14,A6)
            sub.w   D2,D1
            move.w  D1,(-$10,A6)
            cmp.w   D1,D0
            bge.b   .L1
            move.w  (-2,A6),(-$1A,A6)
            move.w  (-6,A6),(-$16,A6)
            move.w  (-$C,A6),(-$1C,A6)
            move.w  (-$E,A6),(-$18,A6)
            bsr.b   DORECT
            move.w  (-6,A6),(-$1A,A6)
            move.w  (-$A,A6),(-$16,A6)
            move.w  (-$10,A6),(-$18,A6)
            bsr.b   DORECT
            move.w  (-4,A6),(-$1A,A6)
            move.w  (-$10,A6),(-$1C,A6)
            move.w  (-$14,A6),(-$18,A6)
            bsr.b   DORECT
            move.w  (-2,A6),(-$1A,A6)
            move.w  (-4,A6),(-$16,A6)
            move.w  (-$E,A6),(-$1C,A6)
.L1:
            bra.b   DORECT.L1
DORECT:
            move.b  HiliteMode,-(SP)
            movea.l (A5),A0
            movea.l (A0),A1
            pea     (2,A1)
            clr.l   -(SP)
            pea     (2,A1)
            pea     (-$1C,A6)
            clr.l   -(SP)
            pea     (-$1C,A6)
            move.w  ($38,A1),-(SP)
            ori.w   #8,(SP)
            pea     ($3A,A1)
            move.l  ($1C,A1),-(SP)
            move.l  ($18,A1),-(SP)
            move.l  (-$82,A0),-(SP)
            clr.w   -(SP)
            jsr     ([$1A9C.w])
            move.b  (SP)+,HiliteMode
            rts
.L1:
            bsr.b   DORECT
            bset    #7,HiliteMode
.L2:
            unlk    A6
            rtd     #4
            ds.b    4
SetRect:
            movea.l (SP)+,A0
            move.l  (SP)+,D1
            move.l  (SP)+,D0
            movea.l (SP)+,A1
            move.l  D0,(A1)+
            move.l  D1,(A1)+
            jmp     (A0)
            dc.w    0
EqualRect:
            move.l  (SP)+,D0
            movea.l (SP)+,A1
            movea.l (SP)+,A0
            cmpm.l  (A0)+,(A1)+
            bne.b   .L1
            cmpm.l  (A0)+,(A1)+
            bne.b   .L1
            move.b  #1,(SP)
            bra.b   .L2
.L1:
            clr.b   (SP)
.L2:
            move.l  D0,-(SP)
            rts
            ds.b    6
EmptyRect:
            movea.l (SP)+,A1
            movea.l (SP)+,A0
            move.w  (A0)+,D0
            move.w  (A0)+,D1
            cmp.w   (A0)+,D0
            bge.b   .L1
            cmp.w   (A0)+,D1
            bge.b   .L1
            clr.b   (SP)
            bra.b   .L2
.L1:
            move.b  #1,(SP)
.L2:
            jmp     (A1)
            ds.b    6
OffsetRect:
            movea.l (SP)+,A0
            move.w  (SP)+,D1
            move.w  (SP)+,D0
            movea.l (SP)+,A1
            add.w   D1,(A1)+
            add.w   D0,(A1)+
            add.w   D1,(A1)+
            add.w   D0,(A1)+
            jmp     (A0)
            ds.b    14
InsetRect:
            movea.l (SP)+,A0
            move.w  (SP)+,D1
            move.w  (SP)+,D0
            movea.l (SP)+,A1
            add.w   D1,(A1)+
            add.w   D0,(A1)+
            sub.w   D1,(A1)+
            sub.w   D0,(A1)+
            jmp     (A0)
            ds.b    14
SectRect:
            link.w  A6,#0
            move.l  ($10,A6),-(SP)
            move.l  ($C,A6),-(SP)
            move.w  #2,-(SP)
            move.l  (8,A6),-(SP)
            bsr.b   RSECT
            sne     ($14,A6)
            neg.b   ($14,A6)
            unlk    A6
            rtd     #$C
RSECT:
            link.w  A6,#0
            movem.l D1-D4/A1,-(SP)
            lea     ($C,A6),A1
            move.w  (A1)+,D0
            ble.b   .L6
            movea.l (A1)+,A0
            movem.w (A0)+,D1-D4
            subq.w  #1,D0
            bra.b   .L5
.L1:
            movea.l (A1)+,A0
            cmp.w   (A0)+,D1
            bge.b   .L2
            move.w  (-2,A0),D1
.L2:
            cmp.w   (A0)+,D2
            bge.b   .L3
            move.w  (-2,A0),D2
.L3:
            cmp.w   (A0)+,D3
            ble.b   .L4
            move.w  (-2,A0),D3
.L4:
            cmp.w   (A0)+,D4
            ble.b   .L5
            move.w  (-2,A0),D4
.L5:
            cmp.w   D1,D3
            ble.b   .L6
            cmp.w   D2,D4
            ble.b   .L6
            dbra    D0,.L1
            bra.b   .L7
.L6:
            clr.w   D1
            clr.w   D2
            clr.w   D3
            clr.w   D4
.L7:
            movea.l (8,A6),A0
            move.w  D1,(A0)+
            move.w  D2,(A0)+
            move.w  D3,(A0)+
            move.w  D4,(A0)+
            move.w  ($C,A6),D0
            lsl.w   #2,D0
            addq.w  #6,D0
            cmp.w   D1,D3
            movem.l (SP)+,D1-D4/A1
            unlk    A6
            movea.l (SP)+,A0
            adda.w  D0,SP
            jmp     (A0)
            ds.b    8
UnionRect:
            movea.l ($C,SP),A0
            movea.l (8,SP),A1
            move.w  (A0)+,D0
            cmp.w   (A1)+,D0
            ble.b   .L1
            move.w  (-2,A1),D0
.L1:
            swap    D0
            move.w  (A0)+,D0
            cmp.w   (A1)+,D0
            ble.b   .L2
            move.w  (-2,A1),D0
.L2:
            move.w  (A0)+,D1
            cmp.w   (A1)+,D1
            bge.b   .L3
            move.w  (-2,A1),D1
.L3:
            swap    D1
            move.w  (A0)+,D1
            cmp.w   (A1)+,D1
            bge.b   .L4
            move.w  (-2,A1),D1
.L4:
            movea.l (4,SP),A0
            move.l  D0,(A0)+
            move.l  D1,(A0)+
            bra.b   Pt2Rect.L3
Pt2Rect:
            movea.l (4,SP),A0
            move.w  ($E,SP),D0
            move.w  ($A,SP),D1
            cmp.w   D0,D1
            bge.b   .L1
            exg     D0,D1
.L1:
            move.w  D0,(2,A0)
            move.w  D1,(6,A0)
            move.w  ($C,SP),D0
            move.w  (8,SP),D1
            cmp.w   D0,D1
            bge.b   .L2
            exg     D0,D1
.L2:
            move.w  D0,(A0)
            move.w  D1,(4,A0)
.L3:
            movea.l (SP)+,A0
            lea     ($C,SP),SP
            jmp     (A0)
            ds.b    12
PtInRect:
            link.w  A6,#0
            movea.l (8,A6),A0
            move.w  ($E,A6),D0
            move.w  ($C,A6),D1
            clr.b   ($10,A6)
            cmp.w   (A0)+,D1
            blt.b   .L1
            cmp.w   (A0)+,D0
            blt.b   .L1
            cmp.w   (A0)+,D1
            bge.b   .L1
            cmp.w   (A0)+,D0
            bge.b   .L1
            addq.b  #1,($10,A6)
.L1:
            unlk    A6
            rtd     #8
            dc.w    0
PUTRECT:
            link.w  A6,#0
            movea.l ($C,A6),A0
            cmpi.w  #$FBEF,(A0)
            bls.b   .L1
            move.w  #$FF6D,QDErr
            bra.b   .L3
.L1:
            movea.l (8,A6),A1
            moveq   #$10,D0
            add.w   (A0),D0
            cmp.w   (A1),D0
            bls.b   .L2
            addi.w  #$400,(A1)
            movem.l D3/A2,-(SP)
            move.l  ($10,A6),-(SP)
            move.w  (A1),-(SP)
            jsr     SetHSize
            movem.l (SP)+,D3/A2
            movea.l ($C,A6),A0
.L2:
            movea.l ($10,A6),A1
            movea.l (A1),A1
            moveq   #0,D0
            move.w  (A0),D0
            adda.l  D0,A1
            addi.w  #$10,(A0)
            movea.l ($14,A6),A0
            move.l  (A0),(A1)+
            move.w  (A0),(A1)+
            move.w  (6,A0),(A1)+
            move.w  (4,A0),(A1)+
            move.w  (2,A0),(A1)+
            move.l  (4,A0),(A1)+
.L3:
            unlk    A6
            rtd     #$10
            ds.b    6
BITBLT:
            lea     (-$268,A6),A0
            move.w  (-$74,A6),D0
            sub.w   (A3),D0
            add.w   (A2),D0
            move.w  D0,(A0)
            move.w  (-$72,A6),D0
            sub.w   (2,A3),D0
            add.w   (2,A2),D0
            move.w  D0,(2,A0)
            movea.l A0,A2
            lea     (-$74,A6),A3
            move.w  (4,A3),D0
            sub.w   (A3),D0
            ble.w   .L32
            move.w  D0,(-$260,A6)
            move.w  #4,D3
            move.w  (A2),D0
            sub.w   (6,A4),D0
            move.w  D0,(-$25A,A6)
            move.w  (A3),D0
            sub.w   (6,A5),D0
            move.w  D0,(-$25C,A6)
            move.w  (-$98,A6),D2
            btst    #3,D2
            beq.b   .L2
            move.w  (-$8E,A6),D1
            bne.b   .L1
            moveq   #$F,D7
            and.w   (A3),D7
            move.l  ([-$88.w,A6],D7.w*4),D6
            bra.w   .L5
.L1:
            moveq   #0,D6
            move.w  (-$8A,A6),D6
            addq.w  #1,D6
            divu.w  (-$8E,A6),D6
            subq.w  #1,D6
            and.w   (A3),D6
            mulu.w  D1,D6
            move.w  (-$8C,A6),D7
            bra.w   .L5
.L2:
            move.l  (A4),D0
            cmp.l   (A5),D0
            bne.b   .L4
            move.w  (-$25A,A6),D0
            cmp.w   (-$25C,A6),D0
            bgt.b   .L4
            blt.b   .L3
            move.w  (2,A2),D0
            sub.w   (8,A4),D0
            move.w  (2,A3),D1
            sub.w   (8,A5),D1
            cmp.w   D1,D0
            bge.b   .L4
            move.w  (-$6E,A6),D2
            sub.w   (-$72,A6),D2
            add.w   D0,D2
            cmp.w   D1,D2
            ble.b   .L4
            neg.w   D3
            bra.b   .L4
.L3:
            move.w  (-$260,A6),D0
            subq.w  #1,D0
            add.w   D0,(-$25A,A6)
            add.w   D0,(-$25C,A6)
            neg.l   (-$1BC,A6)
            neg.l   (-$7C,A6)
.L4:
            move.w  (2,A3),D6
            sub.w   (8,A5),D6
            ext.l   D6
            lsl.l   D4,D6
            move.w  (2,A2),D1
            sub.w   (8,A4),D1
            ext.l   D1
            move.w  (-$1C2,A6),D0
            lsl.l   D0,D1
            sub.l   D1,D6
            moveq   #$1F,D0
            and.l   D0,D6
            neg.l   D6
            move.w  (4,A4),D0
            andi.w  #$7FFF,D0
            muls.w  (-$25A,A6),D0
            movea.l (A4),A4
            adda.l  D0,A4
            sub.l   D6,D1
            asr.l   #5,D1
            add.l   D1,D1
            add.l   D1,D1
            adda.l  D1,A4
.L5:
            move.w  (2,A3),D1
            sub.w   (8,A5),D1
            ext.l   D1
            lsl.l   D4,D1
            move.w  (4,A5),D0
            andi.w  #$7FFF,D0
            muls.w  (-$25C,A6),D0
            movea.l (A5),A5
            adda.l  D0,A5
            move.l  D1,D0
            asr.l   #5,D1
            lsl.l   #2,D1
            adda.l  D1,A5
            tst.w   (-$8E,A6)
            beq.b   .L6
            movea.l (-$88,A6),A4
            adda.w  D6,A4
            swap    D6
            move.w  D1,D6
            and.w   D7,D6
            move.w  D6,(-$90,A6)
.L6:
            move.l  D4,D5
            moveq   #$1F,D2
            and.l   D2,D0
            moveq   #-1,D4
            lsr.l   D0,D4
            move.w  (6,A3),D1
            sub.w   (2,A3),D1
            ble.w   .L32
            move.w  D1,(-$280,A6)
            ext.l   D1
            lsl.l   D5,D1
            add.l   D0,D1
            moveq   #-1,D5
            and.l   D1,D2
            beq.b   .L7
            lsr.l   D2,D5
            not.l   D5
.L7:
            subq.l  #1,D1
            asr.l   #5,D1
            move.w  D1,(-$26E,A6)
            move.l  D1,D2
            add.l   D1,D1
            add.l   D1,D1
            move.l  D1,D0
            addq.l  #4,D0
            movea.w D3,A0
            tst.w   D3
            bpl.b   .L8
            neg.l   D0
            adda.l  D1,A5
            adda.l  D1,A4
            exg     D4,D5
.L8:
            move.w  (-$1BA,A6),(-$25E,A6)
            sub.w   D0,(-$25E,A6)
            movea.w (-$7A,A6),A3
            suba.w  D0,A3
            move.w  (-$98,A6),D0
            bne.b   .L10
            tst.w   (-$104,A6)
            bne.b   .L10
            move.w  D6,D1
            andi.w  #7,D1
            bne.b   .L10
            tst.w   D2
            ble.b   .L10
            move.w  D6,D1
            asr.w   #3,D1
            adda.w  D1,A4
            movea.l ($1B60).w,A1
            tst.w   D3
            bpl.b   .L9
            movea.l ($1B64).w,A1
.L9:
            jmp     (A1)
.L10:
            cmpi.w  #$20,D0
            bcs.w   .L24
            move.l  (-$114,A6),(-$A4,A6)
            cmpi.w  #$40,D0
            bcc.w   .L32
            cmpi.w  #$30,D0
            blt.b   .L12
            cmpi.w  #$32,D0
            beq.b   .L12
            cmpi.w  #$3A,D0
            bne.w   .L32
            tst.w   (-$8E,A6)
            bne.b   .L12
            moveq   #-1,D2
            moveq   #$F,D3
            movea.l (-$88,A6),A1
.L11:
            cmp.l   (A1)+,D2
            dbne    D3,.L11
            beq.w   .L19
.L12:
            btst    #3,D0
            beq.b   .L14
            move.w  (-$8E,A6),D2
            beq.b   .L13
            move.b  #1,(-$270,A6)
            swap    D6
            move.w  D6,(-$27E,A6)
            clr.w   D6
            swap    D6
            asl.l   #3,D6
            move.l  D6,(-$27C,A6)
            move.w  (-$D4,A6),D3
            subq.w  #1,D3
            not.w   D3
            asl.w   #3,D2
            subq.w  #1,D2
            and.w   D3,D2
            move.w  D2,(-$8C,A6)
            bra.b   .L15
.L13:
            clr.b   (-$270,A6)
            lea     ([-$88.w,A6],D7.w*4),A4
            move.w  D7,(-$27E,A6)
            moveq   #0,D6
            move.l  D6,(-$27C,A6)
            move.w  #$1F,(-$8C,A6)
            bra.b   .L15
.L14:
            st      (-$270,A6)
            move.w  #$FFFF,(-$8C,A6)
.L15:
            andi.w  #$37,D0
            moveq   #$20,D2
            moveq   #0,D7
            move.w  (-$D4,A6),D7
            divu.w  D7,D2
            move.w  D2,(-$278,A6)
            move.w  D2,(-$286,A6)
            moveq   #0,D3
            move.l  D7,-(SP)
            moveq   #$20,D1
            move.w  A0,(-$24C,A6)
            cmpa.w  #0,A0
            bpl.b   .L16
            neg.l   (SP)
            neg.l   D1
            moveq   #$20,D3
            sub.w   D2,D3
            add.l   D3,D6
.L16:
            movea.l D1,A2
            move.l  D5,(-$274,A6)
            movea.l (-$10C,A6),A0
            move.w  (-$10E,A6),D5
            clr.b   (-$26F,A6)
            move.w  (-$26E,A6),D1
            subq.w  #1,D1
            move.w  D1,(-$26E,A6)
            bmi.b   .L17
            mulu.w  (-$278,A6),D1
            subq.w  #1,D1
            move.w  D1,(-$276,A6)
            subq.w  #1,D2
            move.w  D2,(-$26E,A6)
.L17:
            subq.w  #1,(-$278,A6)
            move.l  D3,(-$284,A6)
            cmpi.w  #$30,D0
            bgt.b   .L18
            cmpi.w  #$10,D7
            bge.b   .L20
            add.w   D0,D0
            move.w  D0,D1
            bfextu  (-$114,A6){0:D7},D0
            movea.l D0,A3
            move.l  D3,D0
            bra.w   .L27
.L18:
            move.l  D3,D0
            moveq   #$3C,D1
            bfextu  (-$118,A6){0:D7},D5
            bra.w   .L27
.L19:
            move.w  (-$D4,A6),D7
            move.l  D5,(-$274,A6)
            movea.l (-$118,A6),A0
            bfextu  (-$118,A6){0:D7},D5
            lea     PrivlgVector,A2
            suba.w  D7,A2
            bfextu  (-$114,A6){0:D7},D0
            move.w  (-$76,A6),D1
            movea.l ($1CE8).w,A1
            adda.l  (-4,A1,D1.w*4),A1
            bra.w   .L28
.L20:
            andi.w  #7,D0
            beq.b   .L23
.L21:
            cmpi.w  #$10,D7
            beq.b   .L22
            movea.l ($1CE4).w,A1
            adda.l  (0,A1,D0.w*4),A1
            jmp     ([$1CF0.w])
.L22:
            movea.l ($1CE0).w,A1
            adda.l  (0,A1,D0.w*4),A1
            move.l  D4,D1
            jmp     ([$1CEC.w])
.L23:
            lea     (-$FA,A6),A1
            move.w  (A1)+,D1
            cmp.w   (A1)+,D1
            bne.b   .L21
            cmp.w   (A1),D1
            bne.b   .L21
            addq.w  #1,D1
            andi.w  #$FFFE,D1
            cmpi.w  #$8000,D1
            bne.b   .L21
            addq.w  #8,D0
            bra.b   .L21
.L24:
            andi.w  #$B,D0
            move.w  D0,D1
            andi.w  #3,D0
            add.w   D0,D1
            cmpi.w  #8,D1
            bge.b   .L25
            cmpi.w  #4,D1
            beq.b   .L26
            tst.w   (-$104,A6)
            beq.b   .L26
            addi.w  #$18,D1
.L25:
            tst.w   (-$8E,A6)
            beq.b   .L26
            addq.w  #8,D1
.L26:
            tst.w   D2
            bne.b   .L27
            addi.w  #$20,D1
.L27:
            lea     ($1AC0).w,A1
            movea.l (0,A1,D1.w*2),A1
.L28:
            move.l  D4,(-$26C,A6)
            move.l  (-$A0,A6),D3
            move.l  (-$A4,A6),D4
.L29:
            move.l  (-$26C,A6),D1
            move.w  (-$26E,A6),D2
            jmp     (A1)
.L30:
            adda.w  (-$25E,A6),A4
            adda.w  A3,A5
            subq.w  #1,(-$260,A6)
            bne.b   .L29
            bra.b   .L32
.L31:
            clr.w   D6
            swap    D6
            suba.l  D6,A4
            add.w   (-$8E,A6),D6
            and.w   (-$8A,A6),D6
            adda.l  D6,A4
            swap    D6
            move.w  (-$90,A6),D6
            adda.w  A3,A5
            subq.w  #1,(-$260,A6)
            bne.b   .L29
.L32:
            rts
.L33:
            addq.w  #1,D7
            andi.w  #$F,D7
            move.l  ([-$88.w,A6],D7.w*4),D6
            adda.w  A3,A5
            subq.w  #1,(-$260,A6)
            bne.b   .L29
            rts
.L39:
            tst.b   (-$270,A6)
            beq.b   .L36
            bpl.b   .L35
            adda.w  (-$25E,A6),A4
            move.l  (-$27C,A6),D6
            bra.b   .L38
.L34:
            tst.b   (-$270,A6)
            beq.b   .L36
            bpl.b   .L35
            adda.w  (-$25E,A6),A4
            bra.b   .L38
.L35:
            moveq   #0,D0
            move.w  (-$27E,A6),D6
            suba.l  D6,A4
            add.w   (-$8E,A6),D6
            and.w   (-$8A,A6),D6
            adda.l  D6,A4
            move.w  D6,(-$27E,A6)
            bra.b   .L37
.L36:
            move.w  (-$27E,A6),D1
            addq.w  #1,D1
            andi.w  #$F,D1
            move.w  D1,(-$27E,A6)
            lea     ([-$88.w,A6],D1.w*4),A4
.L37:
            move.l  (-$27C,A6),D6
.L38:
            clr.b   (-$26F,A6)
            move.l  (-$284,A6),D0
            adda.w  (-$7A,A6),A5
            subq.w  #1,(-$260,A6)
            bne.w   .L29
            addq.w  #4,SP
            rts
bArith16Tab:
            dc.w    0,$0FA0,0,$0880,0,$0730,0,$0B10
            dc.w    0,$1250,0,$0C60,0,$09C0,0,$0D90
            dc.w    0,$0ED0
bArith32Tab:
            dc.w    0,$0EEC,0,$07EC,0,$06BC,0,$0A7C
            dc.w    0,$11FC,0,$0BFC,0,$094C,0,$0D2C
            dc.w    0,$0E6C
bHiliteTab:
            dc.w    0,$1018,0,$1018,0,$1018,0,$1018
            dc.w    0,$10A8
            ds.b    4
bLeft0:
            move.l  D4,D1
            move.w  (-$26E,A6),D2
            move.l  (A4),D0
            adda.w  A0,A4
            and.l   D1,D0
            not.l   D1
            and.l   (A5),D1
            or.l    D1,D0
            move.l  D0,(A5)
            adda.w  A0,A5
            subq.w  #1,D2
            beq.b   .L3
            suba.w  A0,A4
            suba.w  A0,A5
            bra.b   .L2
.L1:
            move.l  -(A4),-(A5)
.L2:
            move.l  -(A4),-(A5)
            subq.w  #2,D2
            bgt.b   .L1
            beq.b   .L2
            adda.w  A0,A4
            adda.w  A0,A5
.L3:
            move.l  D5,D1
            move.l  (A4),D0
            adda.w  A0,A4
            and.l   D1,D0
            not.l   D1
            and.l   (A5),D1
            or.l    D1,D0
            move.l  D0,(A5)
            adda.w  A0,A5
            adda.w  (-$25E,A6),A4
            adda.w  A3,A5
            subq.w  #1,(-$260,A6)
            bne.b   bLeft0
            bra.w   BITBLT.L32
bSetup0:
            move.w  D2,D6
            move.l  D4,D2
            not.l   D2
            bne.b   .L1
            addq.w  #1,D6
.L1:
            move.l  D5,D3
            not.l   D3
            bne.b   .L2
            addq.w  #1,D6
.L2:
            move.w  (-$260,A6),D7
            subq.w  #1,D7
            movea.w (-$25E,A6),A2
            lea     sub_4082CDD2.L1,A0
            subq.w  #1,D6
            beq.b   .L3
            moveq   #$F,D0
            and.w   D6,D0
            neg.w   D0
            lea     (-4,A0,D0.w*2),A0
            lsr.w   #4,D6
.L3:
            move.l  D2,D1
            beq.b   .L4
            move.l  (A4)+,D0
            and.l   D4,D0
            and.l   (A5),D1
            or.l    D1,D0
            move.l  D0,(A5)+
.L4:
            move.w  D6,D0
            jmp     (A0)
sub_4082CDD2:
            move.l  (A4)+,(A5)+
            move.l  (A4)+,(A5)+
            move.l  (A4)+,(A5)+
            move.l  (A4)+,(A5)+
            move.l  (A4)+,(A5)+
            move.l  (A4)+,(A5)+
            move.l  (A4)+,(A5)+
            move.l  (A4)+,(A5)+
            move.l  (A4)+,(A5)+
            move.l  (A4)+,(A5)+
            move.l  (A4)+,(A5)+
            move.l  (A4)+,(A5)+
            move.l  (A4)+,(A5)+
            move.l  (A4)+,(A5)+
            move.l  (A4)+,(A5)+
            move.l  (A4)+,(A5)+
            dbra    D0,sub_4082CDD2
.L1:
            move.l  D3,D1
            beq.b   .L2
            move.l  (A4)+,D0
            and.l   D5,D0
            and.l   (A5),D1
            or.l    D1,D0
            move.l  D0,(A5)+
.L2:
            adda.w  A2,A4
            adda.w  A3,A5
            dbra    D7,bSetup0.L3
            bra.w   BITBLT.L32
bEND0:
            and.l   D5,D1
bMAIN0:
            bfextu  (A4){D6:0},D0
            adda.w  A0,A4
            eor.l   D7,D0
            and.l   D1,D0
            not.l   D1
            and.l   (A5),D1
            or.l    D1,D0
            move.l  D0,(A5)
            adda.w  A0,A5
            moveq   #-1,D1
            subq.w  #1,D2
            bgt.b   bMAIN0
            beq.b   bEND0
            bra.w   BITBLT.L30
            ds.b    14
bEND1:
            and.l   D5,D1
bMAIN1:
            bfextu  (A4){D6:0},D0
            adda.w  A0,A4
            eor.l   D7,D0
            and.l   D1,D0
            or.l    D0,(A5)
            adda.w  A0,A5
            moveq   #-1,D1
            subq.w  #1,D2
            bgt.b   bMAIN1
            beq.b   bEND1
            bra.w   BITBLT.L30
            ds.b    4
bEND2:
            and.l   D5,D1
bMAIN2:
            bfextu  (A4){D6:0},D0
            adda.w  A0,A4
            eor.l   D7,D0
            and.l   D1,D0
            eor.l   D0,(A5)
            adda.w  A0,A5
            moveq   #-1,D1
            subq.w  #1,D2
            bgt.b   bMAIN2
            beq.b   bEND2
            bra.w   BITBLT.L30
            ds.b    4
bEND3:
            and.l   D5,D1
bMAIN3:
            bfextu  (A4){D6:0},D0
            adda.w  A0,A4
            eor.l   D7,D0
            and.l   D1,D0
            not.l   D0
            and.l   D0,(A5)
            adda.w  A0,A5
            moveq   #-1,D1
            subq.w  #1,D2
            bgt.b   bMAIN3
            beq.b   bEND3
            bra.w   BITBLT.L30
            dc.w    0
bcEnd0:
            and.l   D5,D1
bcMain0:
            bfextu  (A4){D6:0},D0
            adda.w  A0,A4
            eor.l   D7,D0
            move.l  D0,-(SP)
            not.l   D0
            and.l   D4,D0
            and.l   D3,(SP)
            or.l    (SP)+,D0
            and.l   D1,D0
            not.l   D1
            and.l   (A5),D1
            or.l    D1,D0
            move.l  D0,(A5)
            adda.w  A0,A5
            moveq   #-1,D1
            subq.w  #1,D2
            bgt.b   bcMain0
            beq.b   bcEnd0
            bra.w   BITBLT.L30
            ds.b    4
bcEnd1:
            and.l   D5,D1
bcMain1:
            bfextu  (A4){D6:0},D0
            adda.w  A0,A4
            eor.l   D7,D0
            and.l   D1,D0
            not.l   D0
            and.l   D0,(A5)
            not.l   D0
            and.l   D3,D0
            or.l    D0,(A5)
            adda.w  A0,A5
            moveq   #-1,D1
            subq.w  #1,D2
            bgt.b   bcMain1
            beq.b   bcEnd1
            bra.w   BITBLT.L30
            ds.b    12
bcEnd3:
            and.l   D5,D1
bcMain3:
            bfextu  (A4){D6:0},D0
            adda.w  A0,A4
            eor.l   D7,D0
            and.l   D1,D0
            not.l   D0
            and.l   D0,(A5)
            not.l   D0
            and.l   D4,D0
            or.l    D0,(A5)
            adda.w  A0,A5
            moveq   #-1,D1
            subq.w  #1,D2
            bgt.b   bcMain3
            beq.b   bcEnd3
            bra.w   BITBLT.L30
            ds.b    12
bLONG8:
            move.w  (-$260,A6),D3
            movea.l (-$88,A6),A4
            lea     (0,A4,D7.w*4),A2
            addq.w  #4,A3
            subq.w  #1,D3
            and.l   D5,D1
            move.l  D1,D5
            movea.l A4,A1
            move.l  (A1)+,D0
            moveq   #$E,D2
.L1:
            cmp.l   (A1)+,D0
            dbne    D2,.L1
            beq.b   .L5
            not.l   D5
            beq.b   .L3
.L2:
            and.l   D1,D6
            move.l  (A5),D0
            and.l   D5,D0
            or.l    D6,D0
            move.l  D0,(A5)
            adda.w  A3,A5
            addq.w  #1,D7
            andi.w  #$F,D7
            move.l  (0,A4,D7.w*4),D6
            dbra    D3,.L2
            bra.w   BITBLT.L32
.L3:
            move.l  (A2)+,(A5)
            adda.w  A3,A5
            addq.w  #1,D7
            andi.w  #$F,D7
            bne.b   .L4
            movea.l A4,A2
.L4:
            dbra    D3,.L3
            bra.w   BITBLT.L32
            ds.b    6
.L5:
            not.l   D5
            beq.b   .L7
            and.l   D1,D0
.L6:
            move.l  (A5),D2
            and.l   D5,D2
            or.l    D0,D2
            move.l  D2,(A5)
            adda.w  A3,A5
            dbra    D3,.L6
            bra.w   BITBLT.L32
.L7:
            move.l  D0,(A5)
            adda.w  A3,A5
            dbra    D3,.L7
            bra.w   BITBLT.L32
            ds.b    12
bSETUP8:
            move.w  D2,D3
            move.l  D1,D4
            not.l   D1
            movea.l D1,A1
            bne.b   .L1
            addq.w  #1,D3
.L1:
            move.l  D5,D0
            not.l   D0
            movea.l D0,A2
            bne.b   .L2
            addq.w  #1,D3
.L2:
            movea.l (-$88,A6),A4
            lea     (4,A4,D7.w*4),A4
            move.w  D7,D0
            moveq   #1,D7
            lsl.w   D0,D7
            move.w  (-$260,A6),D2
            subq.w  #1,D2
            lea     sub_4082D01A.L1,A0
            subq.w  #1,D3
            beq.b   sub_4082D000.L2
            moveq   #$F,D0
            and.w   D3,D0
            neg.w   D0
            lea     (-4,A0,D0.w*2),A0
            lsr.w   #4,D3
            bra.b   sub_4082D000.L2
sub_4082D000:
            moveq   #1,D7
            suba.w  #$40,A4
.L1:
            move.l  (A4)+,D6
.L2:
            move.l  A1,D1
            beq.b   .L3
            move.l  D6,D0
            and.l   D4,D0
            and.l   (A5),D1
            or.l    D1,D0
            move.l  D0,(A5)+
.L3:
            move.w  D3,D0
            jmp     (A0)
sub_4082D01A:
            move.l  D6,(A5)+
            move.l  D6,(A5)+
            move.l  D6,(A5)+
            move.l  D6,(A5)+
            move.l  D6,(A5)+
            move.l  D6,(A5)+
            move.l  D6,(A5)+
            move.l  D6,(A5)+
            move.l  D6,(A5)+
            move.l  D6,(A5)+
            move.l  D6,(A5)+
            move.l  D6,(A5)+
            move.l  D6,(A5)+
            move.l  D6,(A5)+
            move.l  D6,(A5)+
            move.l  D6,(A5)+
            dbra    D0,sub_4082D01A
.L1:
            move.l  A2,D0
            beq.b   .L2
            and.l   (A5),D0
            and.l   D5,D6
            or.l    D6,D0
            move.l  D0,(A5)+
.L2:
            adda.w  A3,A5
            add.w   D7,D7
            dbeq    D2,sub_4082D000.L1
            dbne    D2,sub_4082D000
            bra.w   BITBLT.L32
            ds.b    6
bEND9:
            and.l   D5,D1
bMAIN9:
            and.l   D6,D1
            move.l  D1,D0
            and.l   D3,D0
            not.l   D1
            and.l   (A5),D1
            or.l    D1,D0
            move.l  D0,(A5)+
            moveq   #-1,D1
            subq.w  #1,D2
            bgt.b   bMAIN9
            beq.b   bEND9
            bra.w   BITBLT.L33
            ds.b    4
bEND10:
            move.w  (-$260,A6),D3
            movea.l (-$88,A6),A4
            lea     (0,A4,D7.w*4),A2
            addq.w  #4,A3
            subq.w  #1,D3
            and.l   D5,D1
.L1:
            move.l  (A2)+,D6
            and.l   D1,D6
            eor.l   D6,(A5)
            adda.w  A3,A5
            addq.w  #1,D7
            andi.w  #$F,D7
            bne.b   .L2
            movea.l A4,A2
.L2:
            dbra    D3,.L1
            bra.w   BITBLT.L32
            ds.b    4
bSETUP10:
            move.w  D2,D3
            move.l  D1,D4
            movea.l (-$88,A6),A2
            lea     (4,A2,D7.w*4),A4
            move.w  D7,D0
            moveq   #1,D7
            lsl.w   D0,D7
            move.w  (-$260,A6),D2
            subq.w  #1,D2
            lea     sub_4082D0EE.L1,A0
            subq.w  #1,D3
            beq.b   sub_4082D0DE.L2
            moveq   #$F,D0
            and.w   D3,D0
            neg.w   D0
            lea     (-4,A0,D0.w*2),A0
            lsr.w   #4,D3
            bra.b   sub_4082D0DE.L2
sub_4082D0DE:
            moveq   #1,D7
            movea.l A2,A4
.L1:
            move.l  (A4)+,D6
.L2:
            move.l  D6,D0
            and.l   D4,D0
            eor.l   D0,(A5)+
            move.w  D3,D0
            jmp     (A0)
sub_4082D0EE:
            eor.l   D6,(A5)+
            eor.l   D6,(A5)+
            eor.l   D6,(A5)+
            eor.l   D6,(A5)+
            eor.l   D6,(A5)+
            eor.l   D6,(A5)+
            eor.l   D6,(A5)+
            eor.l   D6,(A5)+
            eor.l   D6,(A5)+
            eor.l   D6,(A5)+
            eor.l   D6,(A5)+
            eor.l   D6,(A5)+
            eor.l   D6,(A5)+
            eor.l   D6,(A5)+
            eor.l   D6,(A5)+
            eor.l   D6,(A5)+
            dbra    D0,sub_4082D0EE
.L1:
            and.l   D5,D6
            eor.l   D6,(A5)+
            adda.w  A3,A5
            add.w   D7,D7
            dbeq    D2,sub_4082D0DE.L1
            dbne    D2,sub_4082D0DE
            bra.w   BITBLT.L32
            ds.b    10
bEND11:
            and.l   D5,D1
bMAIN11:
            and.l   D6,D1
            move.l  D1,D0
            and.l   D4,D0
            not.l   D1
            and.l   (A5),D1
            or.l    D1,D0
            move.l  D0,(A5)+
            moveq   #-1,D1
            subq.w  #1,D2
            bgt.b   bMAIN11
            beq.b   bEND11
            bra.w   BITBLT.L33
            ds.b    4
bXLONG8:
            movea.w (-$8E,A6),A0
            move.w  (-$8A,A6),D2
            move.w  (-$260,A6),D3
            subq.w  #1,D3
            addq.w  #4,A3
            and.l   D5,D1
            move.l  D1,D5
            adda.w  D6,A4
            clr.w   D6
            swap    D6
            suba.l  D6,A4
            not.l   D5
            beq.b   .L2
.L1:
            move.l  (0,A4,D6.w),D7
            and.l   D1,D7
            move.l  (A5),D0
            and.l   D5,D0
            or.l    D7,D0
            move.l  D0,(A5)
            adda.w  A3,A5
            add.w   A0,D6
            and.w   D2,D6
            dbra    D3,.L1
            bra.w   BITBLT.L32
.L2:
            move.l  (0,A4,D6.w),(A5)
            adda.w  A3,A5
            add.w   A0,D6
            and.w   D2,D6
            dbra    D3,.L2
            bra.w   BITBLT.L32
            dc.w    0
.L3:
            subq.w  #1,D2
.L4:
            move.l  (0,A4,D6.w),(A5)+
            addq.w  #4,D6
            and.w   D7,D6
            dbra    D2,.L4
.L5:
            and.l   D5,D1
bXMAIN8:
            move.l  D1,D0
            and.l   (0,A4,D6.w),D0
            addq.w  #4,D6
            and.w   D7,D6
            not.l   D1
            and.l   (A5),D1
            or.l    D1,D0
            move.l  D0,(A5)+
            moveq   #-1,D1
            subq.w  #1,D2
            bgt.b   bXLONG8.L3
            beq.b   bXLONG8.L5
            clr.w   D6
            swap    D6
            suba.l  D6,A4
            add.w   (-$8E,A6),D6
            and.w   (-$8A,A6),D6
            adda.l  D6,A4
            swap    D6
            move.w  (-$90,A6),D6
            adda.w  A3,A5
            subq.w  #1,(-$260,A6)
            beq.w   BITBLT.L32
            move.l  (-$26C,A6),D1
            move.w  (-$26E,A6),D2
            bra.b   bXMAIN8
            ds.b    12
bXEND9:
            and.l   D5,D1
bXMAIN9:
            and.l   (0,A4,D6.w),D1
            addq.w  #4,D6
            and.w   D7,D6
            move.l  D1,D0
            and.l   D3,D0
            not.l   D1
            and.l   (A5),D1
            or.l    D1,D0
            move.l  D0,(A5)+
            moveq   #-1,D1
            subq.w  #1,D2
            bgt.b   bXMAIN9
            beq.b   bXEND9
            bra.w   BITBLT.L31
            ds.b    14
bXEND10:
            movea.w (-$8E,A6),A0
            move.w  (-$8A,A6),D2
            move.w  (-$260,A6),D3
            subq.w  #1,D3
            addq.w  #4,A3
            and.l   D5,D1
            adda.w  D6,A4
            clr.w   D6
            swap    D6
            suba.l  D6,A4
.L1:
            move.l  (0,A4,D6.w),D0
            and.l   D1,D0
            eor.l   D0,(A5)
            adda.w  A3,A5
            add.w   A0,D6
            and.w   D2,D6
            dbra    D3,.L1
            bra.w   BITBLT.L32
.L2:
            and.l   D5,D1
bXMAIN10:
            and.l   (0,A4,D6.w),D1
            addq.w  #4,D6
            and.w   D7,D6
            eor.l   D1,(A5)+
            moveq   #-1,D1
            subq.w  #1,D2
            bgt.b   bXMAIN10
            beq.b   bXEND10.L2
            bra.w   BITBLT.L31
            ds.b    8
bXEND11:
            and.l   D5,D1
bXMAIN11:
            and.l   (0,A4,D6.w),D1
            addq.w  #4,D6
            and.w   D7,D6
            move.l  D1,D0
            and.l   D4,D0
            not.l   D1
            and.l   (A5),D1
            or.l    D1,D0
            move.l  D0,(A5)+
            moveq   #-1,D1
            subq.w  #1,D2
            bgt.b   bXMAIN11
            beq.b   bXEND11
            bra.w   BITBLT.L31
            ds.b    14
BARITH32SETUP:
            move.w  (-$280,A6),D2
            subq.w  #1,D2
            move.w  D2,(-$26E,A6)
            moveq   #0,D4
            move.w  (-$8C,A6),D4
            lsr.l   #3,D4
            move.w  D4,(-$8C,A6)
            tst.b   (-$270,A6)
            bpl.b   .L1
            moveq   #0,D6
.L1:
            lsr.l   #3,D6
            move.l  D6,(-$27C,A6)
            move.w  (-$1BA,A6),(-$25E,A6)
            movea.w (-$24C,A6),A3
            move.w  A3,D7
            bpl.b   .L2
            addq.w  #1,D2
            move.w  D2,(-$26E,A6)
.L2:
            jmp     (A1)
            ds.b    6
BARITH16SETUP:
            move.w  (-$280,A6),D2
            subq.w  #1,D2
            move.w  D2,(-$26E,A6)
            asr.l   #3,D6
            move.l  D6,(-$27C,A6)
            move.w  (-$1BA,A6),(-$25E,A6)
            move.w  (-$24C,A6),D7
            asr.w   #1,D7
            movea.w D7,A3
            bpl.b   .L1
            addq.w  #1,D2
            move.w  D2,(-$26E,A6)
.L1:
            tst.l   D1
            bmi.b   .L2
            addq.w  #2,A5
            addq.l  #2,D6
            move.l  D6,(-$27C,A6)
.L2:
            moveq   #0,D4
            move.w  (-$8C,A6),D4
            lsr.l   #3,D4
            bset    #1,D4
            move.w  D4,(-$8C,A6)
            jmp     (A1)
            ds.b    12
bAddOver:
            movea.l (-$108,A6),A1
            tst.w   D2
            bgt.b   .L3
.L1:
            ori.b   #3,(-$26F,A6)
.L2:
            move.w  (-$278,A6),D2
            and.l   (-$274,A6),D1
.L3:
            and.w   (-$8C,A6),D6
            bfextu  D1{D0:D7},D3
            beq.b   .L4
            bfextu  (A4){D6:D7},D3
            lea     (0,A1,D3.w*8),A2
            bfextu  (A5){D0:D7},D3
            lea     (0,A1,D3.w*8),A3
            move.w  (A2)+,D3
            add.w   (A3)+,D3
            asl.l   D5,D3
            move.w  (A2)+,D3
            add.w   (A3)+,D3
            asl.l   D5,D3
            move.w  (A2)+,D3
            add.w   (A3)+,D3
            asl.l   D5,D3
            swap    D3
            move.b  (6,A0,D3.w),D3
            bfins   D3,(A5){D0:D7}
.L4:
            add.l   (SP),D6
            add.l   (SP),D0
            dbra    D2,.L3
            moveq   #-1,D1
            bset    #0,(-$26F,A6)
            bne.b   .L5
            move.w  (-$276,A6),D2
            bmi.b   .L1
            bra.b   .L3
.L5:
            bset    #1,(-$26F,A6)
            beq.b   .L2
            lea     bAddOver,A1
            bra.w   BITBLT.L34
            ds.b    10
.L8:
            movea.l A4,A0
            adda.w  D6,A0
            movea.l A5,A2
            move.l  #$7F7F7F,D0
            movea.l #$808080,A1
.L7:
            move.l  A1,D3
            move.l  (A0),D7
            and.l   D7,D3
            adda.w  A3,A0
            and.l   D0,D7
            move.l  (A2),D5
            move.l  A1,D1
            and.l   D5,D1
            and.l   D0,D5
            add.l   D5,D7
            eor.l   D3,D1
            eor.l   D1,D7
            move.l  D7,(A2)
            adda.w  A3,A2
            addq.l  #4,D6
            and.l   D4,D6
            bne.b   .L6
            movea.l A4,A0
.L6:
            dbra    D2,.L7
            lea     .L8,A1
            bra.w   BITBLT.L39
            ds.b    14
.L11:
            movea.l A4,A0
            adda.w  D6,A0
            movea.l A5,A2
            move.w  #$3DEF,D0
            movea.w #$4210,A1
.L10:
            move.w  A1,D3
            move.w  (A0),D7
            and.w   D7,D3
            adda.w  A3,A0
            and.w   D0,D7
            move.w  (A2),D5
            move.w  A1,D1
            and.w   D5,D1
            and.w   D0,D5
            add.w   D5,D7
            eor.w   D3,D1
            eor.w   D1,D7
            move.w  D7,(A2)
            adda.w  A3,A2
            addq.l  #2,D6
            and.l   D4,D6
            bne.b   .L9
            movea.l A4,A0
.L9:
            dbra    D2,.L10
            lea     .L11,A1
            bra.w   BITBLT.L39
            dc.w    0
bAddPin:
            movea.l (-$108,A6),A1
            tst.w   D2
            bgt.b   .L3
.L1:
            ori.b   #3,(-$26F,A6)
.L2:
            move.w  (-$278,A6),D2
            and.l   (-$274,A6),D1
.L3:
            and.w   (-$8C,A6),D6
            bfextu  D1{D0:D7},D3
            beq.b   .L10
            bfextu  (A4){D6:D7},D3
            lea     (0,A1,D3.w*8),A2
            bfextu  (A5){D0:D7},D3
            lea     (0,A1,D3.w*8),A3
            move.w  (A2)+,D3
            add.w   (A3)+,D3
            bcs.b   .L4
            cmp.w   (-$F6,A6),D3
            bls.b   .L5
.L4:
            move.w  (-$F6,A6),D3
.L5:
            asl.l   D5,D3
            move.w  (A2)+,D3
            add.w   (A3)+,D3
            bcs.b   .L6
            cmp.w   (-$F8,A6),D3
            bls.b   .L7
.L6:
            move.w  (-$F8,A6),D3
.L7:
            asl.l   D5,D3
            move.w  (A2)+,D3
            add.w   (A3)+,D3
            bcs.b   .L8
            cmp.w   (-$FA,A6),D3
            bls.b   .L9
.L8:
            move.w  (-$FA,A6),D3
.L9:
            asl.l   D5,D3
            swap    D3
            move.b  (6,A0,D3.w),D3
            bfins   D3,(A5){D0:D7}
.L10:
            add.l   (SP),D6
            add.l   (SP),D0
            dbra    D2,.L3
            moveq   #-1,D1
            bset    #0,(-$26F,A6)
            bne.b   .L11
            move.w  (-$276,A6),D2
            bmi.b   .L1
            bra.b   .L3
.L11:
            bset    #1,(-$26F,A6)
            beq.w   .L2
            lea     bAddPin,A1
            bra.w   BITBLT.L34
            ds.b    4
            lea     .L12,A1
            moveq   #0,D3
            move.b  (-$F6,A6),D3
            swap    D3
            move.w  (-$F8,A6),D3
            move.b  (-$FA,A6),D3
.L12:
            movea.l A4,A0
            adda.w  D6,A0
            movea.l A5,A2
            move.l  Lo3Bytes,D1
.L19:
            move.l  (A0),D7
            and.l   D1,D7
            move.l  D7,D0
            adda.w  A3,A0
            move.l  (A2),D5
            and.l   D1,D5
            clr.b   D0
            add.w   D5,D0
            bcs.b   .L13
            cmp.w   D3,D0
            bls.b   .L14
.L13:
            move.w  D3,D0
.L14:
            move.b  D7,D0
            add.b   D5,D0
            bcs.b   .L15
            cmp.b   D3,D0
            bls.b   .L16
.L15:
            move.b  D3,D0
.L16:
            clr.w   D5
            add.l   D5,D0
            cmp.l   D3,D0
            bls.b   .L17
            swap    D3
            swap    D0
            move.w  D3,D0
            swap    D0
            swap    D3
.L17:
            move.l  D0,(A2)
            adda.w  A3,A2
            addq.l  #4,D6
            and.l   D4,D6
            bne.b   .L18
            movea.l A4,A0
.L18:
            dbra    D2,.L19
            bra.w   BITBLT.L39
            ds.b    8
            lea     .L20,A1
            moveq   #0,D3
            move.b  (-$F6,A6),D3
            lsr.b   #3,D3
            swap    D3
            move.w  (-$F8,A6),D3
            lsr.w   #3,D3
            move.b  (-$FA,A6),D3
            lsr.b   #3,D3
.L20:
            movea.l A4,A0
            adda.w  D6,A0
            movea.l A5,A2
.L25:
            moveq   #0,D7
            move.w  (A0),D7
            adda.w  A3,A0
            add.w   D7,D7
            lsl.l   #5,D7
            lsr.w   #3,D7
            lsr.b   #3,D7
            moveq   #0,D5
            move.w  (A2),D5
            add.w   D5,D5
            lsl.l   #5,D5
            lsr.w   #3,D5
            lsr.b   #3,D5
            add.l   D5,D7
            move.l  D7,D0
            cmp.l   D3,D0
            bls.b   .L21
            move.l  D3,D0
.L21:
            move.w  D7,D0
            cmp.w   D3,D0
            bls.b   .L22
            move.w  D3,D0
.L22:
            move.b  D7,D0
            cmp.b   D3,D0
            bls.b   .L23
            move.b  D3,D0
.L23:
            lsl.b   #3,D0
            lsl.w   #3,D0
            lsr.l   #6,D0
            move.w  D0,(A2)
            adda.w  A3,A2
            addq.l  #2,D6
            and.l   D4,D6
            bne.b   .L24
            movea.l A4,A0
.L24:
            dbra    D2,.L25
            bra.w   BITBLT.L39
            dc.w    0
bSubOver:
            movea.l (-$108,A6),A1
            tst.w   D2
            bgt.b   .L3
.L1:
            ori.b   #3,(-$26F,A6)
.L2:
            move.w  (-$278,A6),D2
            and.l   (-$274,A6),D1
.L3:
            and.w   (-$8C,A6),D6
            bfextu  D1{D0:D7},D3
            beq.b   .L4
            bfextu  (A4){D6:D7},D3
            lea     (0,A1,D3.w*8),A2
            bfextu  (A5){D0:D7},D3
            lea     (0,A1,D3.w*8),A3
            move.w  (A3)+,D3
            sub.w   (A2)+,D3
            asl.l   D5,D3
            move.w  (A3)+,D3
            sub.w   (A2)+,D3
            asl.l   D5,D3
            move.w  (A3)+,D3
            sub.w   (A2)+,D3
            asl.l   D5,D3
            swap    D3
            move.b  (6,A0,D3.w),D3
            bfins   D3,(A5){D0:D7}
.L4:
            add.l   (SP),D6
            add.l   (SP),D0
            dbra    D2,.L3
            moveq   #-1,D1
            bset    #0,(-$26F,A6)
            bne.b   .L5
            move.w  (-$276,A6),D2
            bmi.b   .L1
            bra.b   .L3
.L5:
            bset    #1,(-$26F,A6)
            beq.b   .L2
            lea     bSubOver,A1
            bra.w   BITBLT.L34
            ds.b    10
            movea.l A4,A0
            adda.w  D6,A0
            movea.l A5,A2
            move.l  #$7F7F7F,D0
            move.l  #$808080,D1
.L7:
            move.l  D1,D3
            move.l  (A0),D7
            and.l   D7,D3
            eor.l   D1,D3
            adda.w  A3,A0
            and.l   D0,D7
            move.l  (A2),D5
            move.l  D1,D4
            and.l   D5,D4
            and.l   D0,D5
            or.l    D1,D5
            sub.l   D7,D5
            eor.l   D3,D4
            eor.l   D4,D5
            move.l  D5,(A2)
            adda.w  A3,A2
            addq.l  #4,D6
            and.w   (-$8C,A6),D6
            bne.b   .L6
            movea.l A4,A0
.L6:
            dbra    D2,.L7
            bra.w   BITBLT.L39
            ds.b    12
            movea.l A4,A0
            adda.w  D6,A0
            movea.l A5,A2
            move.w  #$3DEF,D0
            move.w  #$4210,D1
.L9:
            move.w  D1,D3
            move.w  (A0),D7
            adda.w  A3,A0
            and.w   D7,D3
            eor.w   D1,D3
            and.w   D0,D7
            move.l  (A2),D5
            move.w  D1,D4
            and.w   D5,D4
            and.w   D0,D5
            or.w    D1,D5
            sub.w   D7,D5
            eor.w   D3,D4
            eor.w   D4,D5
            move.w  D5,(A2)
            adda.w  A3,A2
            addq.l  #2,D6
            and.w   (-$8C,A6),D6
            bne.b   .L8
            movea.l A4,A0
.L8:
            dbra    D2,.L9
            bra.w   BITBLT.L39
bSubPin:
            movea.l (-$108,A6),A1
            tst.w   D2
            bgt.b   .L3
.L1:
            ori.b   #3,(-$26F,A6)
.L2:
            move.w  (-$278,A6),D2
            and.l   (-$274,A6),D1
.L3:
            and.w   (-$8C,A6),D6
            bfextu  D1{D0:D7},D3
            beq.b   .L10
            bfextu  (A4){D6:D7},D3
            lea     (0,A1,D3.w*8),A2
            bfextu  (A5){D0:D7},D3
            lea     (0,A1,D3.w*8),A3
            move.w  (A3)+,D3
            sub.w   (A2)+,D3
            bcs.b   .L4
            cmp.w   (-$F6,A6),D3
            bcc.b   .L5
.L4:
            move.w  (-$F6,A6),D3
.L5:
            asl.l   D5,D3
            move.w  (A3)+,D3
            sub.w   (A2)+,D3
            bcs.b   .L6
            cmp.w   (-$F8,A6),D3
            bcc.b   .L7
.L6:
            move.w  (-$F8,A6),D3
.L7:
            asl.l   D5,D3
            move.w  (A3)+,D3
            sub.w   (A2)+,D3
            bcs.b   .L8
            cmp.w   (-$FA,A6),D3
            bcc.b   .L9
.L8:
            move.w  (-$FA,A6),D3
.L9:
            asl.l   D5,D3
            swap    D3
            move.b  (6,A0,D3.w),D3
            bfins   D3,(A5){D0:D7}
.L10:
            add.l   (SP),D6
            add.l   (SP),D0
            dbra    D2,.L3
            moveq   #-1,D1
            bset    #0,(-$26F,A6)
            bne.b   .L11
            move.w  (-$276,A6),D2
            bmi.b   .L1
            bra.b   .L3
.L11:
            bset    #1,(-$26F,A6)
            beq.w   .L2
            lea     bSubPin,A1
            bra.w   BITBLT.L34
            ds.b    4
            lea     .L12,A1
            moveq   #0,D3
            move.b  (-$F6,A6),D3
            swap    D3
            move.w  (-$F8,A6),D3
            move.b  (-$FA,A6),D3
.L12:
            movea.l A4,A0
            adda.w  D6,A0
            movea.l A5,A2
            move.l  Lo3Bytes,D1
.L19:
            move.l  (A0),D5
            and.l   D1,D5
            adda.w  A3,A0
            move.l  (A2),D7
            and.l   D1,D7
            move.l  D7,D0
            st      D0
            sub.w   D5,D0
            bcs.b   .L13
            cmp.w   D3,D0
            bcc.b   .L14
.L13:
            move.w  D3,D0
.L14:
            move.b  D7,D0
            sub.b   D5,D0
            bcs.b   .L15
            cmp.b   D3,D0
            bcc.b   .L16
.L15:
            move.b  D3,D0
.L16:
            clr.w   D5
            sub.l   D5,D0
            cmp.l   D3,D0
            bge.b   .L17
            swap    D3
            swap    D0
            move.w  D3,D0
            swap    D0
            swap    D3
.L17:
            move.l  D0,(A2)
            adda.w  A3,A2
            addq.l  #4,D6
            and.l   D4,D6
            bne.b   .L18
            movea.l A4,A0
.L18:
            dbra    D2,.L19
            bra.w   BITBLT.L39
            ds.b    8
            lea     .L20,A1
            moveq   #0,D3
            move.b  (-$F6,A6),D3
            lsr.b   #3,D3
            swap    D3
            move.w  (-$F8,A6),D3
            lsr.w   #3,D3
            move.b  (-$FA,A6),D3
            lsr.b   #3,D3
            addi.l  #$808080,D3
.L20:
            movea.l A4,A0
            adda.w  D6,A0
            movea.l A5,A2
            move.l  #$808080,D1
.L25:
            moveq   #0,D5
            move.w  (A0),D5
            adda.w  A3,A0
            add.w   D5,D5
            lsl.l   #5,D5
            lsr.w   #3,D5
            lsr.b   #3,D5
            moveq   #0,D7
            move.w  (A2),D7
            add.w   D7,D7
            lsl.l   #5,D7
            lsr.w   #3,D7
            lsr.b   #3,D7
            add.l   D1,D7
            sub.l   D5,D7
            move.l  D7,D0
            cmp.l   D3,D0
            bcc.b   .L21
            move.l  D3,D0
.L21:
            move.w  D7,D0
            cmp.w   D3,D0
            bcc.b   .L22
            move.w  D3,D0
.L22:
            move.b  D7,D0
            cmp.b   D3,D0
            bcc.b   .L23
            move.b  D3,D0
.L23:
            lsl.b   #3,D0
            lsl.w   #3,D0
            lsr.l   #6,D0
            move.w  D0,(A2)
            adda.w  A3,A2
            addq.l  #2,D6
            and.l   D4,D6
            bne.b   .L24
            movea.l A4,A0
.L24:
            dbra    D2,.L25
            bra.w   BITBLT.L39
            ds.b    4
bMax:
            movea.l (-$108,A6),A1
            tst.w   D2
            bgt.b   .L3
.L1:
            ori.b   #3,(-$26F,A6)
.L2:
            move.w  (-$278,A6),D2
            and.l   (-$274,A6),D1
.L3:
            and.w   (-$8C,A6),D6
            bfextu  D1{D0:D7},D3
            beq.b   .L7
            bfextu  (A4){D6:D7},D3
            lea     (0,A1,D3.w*8),A2
            bfextu  (A5){D0:D7},D3
            lea     (0,A1,D3.w*8),A3
            move.w  (A2)+,D3
            cmp.w   (A3),D3
            bcc.b   .L4
            move.w  (A3),D3
.L4:
            addq.w  #2,A3
            asl.l   D5,D3
            move.w  (A2)+,D3
            cmp.w   (A3),D3
            bcc.b   .L5
            move.w  (A3),D3
.L5:
            addq.w  #2,A3
            asl.l   D5,D3
            move.w  (A2)+,D3
            cmp.w   (A3),D3
            bcc.b   .L6
            move.w  (A3),D3
.L6:
            asl.l   D5,D3
            swap    D3
            move.b  (6,A0,D3.w),D3
            bfins   D3,(A5){D0:D7}
.L7:
            add.l   (SP),D6
            add.l   (SP),D0
            dbra    D2,.L3
            moveq   #-1,D1
            bset    #0,(-$26F,A6)
            bne.b   .L8
            move.w  (-$276,A6),D2
            bmi.b   .L1
            bra.b   .L3
.L8:
            bset    #1,(-$26F,A6)
            beq.b   .L2
            lea     bMax,A1
            bra.w   BITBLT.L34
            ds.b    10
            movea.l A4,A0
            adda.w  D6,A0
            movea.l A5,A2
.L13:
            move.l  (A0),D7
            adda.w  A3,A0
            move.l  (A2),D5
            move.l  D5,D0
            cmp.w   D7,D0
            bhi.b   .L9
            move.w  D7,D0
            move.b  D5,D0
.L9:
            cmp.b   D7,D5
            bhi.b   .L10
            move.b  D7,D0
.L10:
            swap    D7
            swap    D0
            cmp.b   D7,D0
            bhi.b   .L11
            move.b  D7,D0
.L11:
            swap    D0
            move.l  D0,(A2)
            adda.w  A3,A2
            addq.l  #4,D6
            and.l   D4,D6
            bne.b   .L12
            movea.l A4,A0
.L12:
            dbra    D2,.L13
            bra.w   BITBLT.L39
            ds.b    4
            movea.l A4,A0
            adda.w  D6,A0
            movea.l A5,A2
.L18:
            moveq   #0,D7
            move.w  (A0),D7
            adda.w  A3,A0
            add.w   D7,D7
            lsl.l   #5,D7
            lsr.w   #3,D7
            lsr.b   #3,D7
            moveq   #0,D5
            move.w  (A2),D5
            add.w   D5,D5
            lsl.l   #5,D5
            lsr.w   #3,D5
            lsr.b   #3,D5
            move.l  D7,D0
            cmp.l   D5,D0
            bcc.b   .L14
            move.l  D5,D0
.L14:
            move.w  D7,D0
            cmp.w   D5,D0
            bcc.b   .L15
            move.w  D5,D0
.L15:
            move.b  D7,D0
            cmp.b   D5,D0
            bcc.b   .L16
            move.b  D5,D0
.L16:
            lsl.b   #3,D0
            lsl.w   #3,D0
            lsr.l   #6,D0
            move.w  D0,(A2)
            adda.w  A3,A2
            addq.l  #2,D6
            and.l   D4,D6
            bne.b   .L17
            movea.l A4,A0
.L17:
            dbra    D2,.L18
            bra.w   BITBLT.L39
            ds.b    14
bMin:
            movea.l (-$108,A6),A1
            tst.w   D2
            bgt.b   .L3
.L1:
            ori.b   #3,(-$26F,A6)
.L2:
            move.w  (-$278,A6),D2
            and.l   (-$274,A6),D1
.L3:
            and.w   (-$8C,A6),D6
            bfextu  D1{D0:D7},D3
            beq.b   .L7
            bfextu  (A4){D6:D7},D3
            lea     (0,A1,D3.w*8),A2
            bfextu  (A5){D0:D7},D3
            lea     (0,A1,D3.w*8),A3
            move.w  (A2)+,D3
            cmp.w   (A3),D3
            bls.b   .L4
            move.w  (A3),D3
.L4:
            addq.w  #2,A3
            asl.l   D5,D3
            move.w  (A2)+,D3
            cmp.w   (A3),D3
            bls.b   .L5
            move.w  (A3),D3
.L5:
            addq.w  #2,A3
            asl.l   D5,D3
            move.w  (A2)+,D3
            cmp.w   (A3),D3
            bls.b   .L6
            move.w  (A3),D3
.L6:
            asl.l   D5,D3
            swap    D3
            move.b  (6,A0,D3.w),D3
            bfins   D3,(A5){D0:D7}
.L7:
            add.l   (SP),D6
            add.l   (SP),D0
            dbra    D2,.L3
            moveq   #-1,D1
            bset    #0,(-$26F,A6)
            bne.b   .L8
            move.w  (-$276,A6),D2
            bmi.b   .L1
            bra.b   .L3
.L8:
            bset    #1,(-$26F,A6)
            beq.b   .L2
            lea     bMin,A1
            bra.w   BITBLT.L34
            ds.b    10
            movea.l A4,A0
            adda.w  D6,A0
            movea.l A5,A2
.L13:
            move.l  (A0),D7
            adda.w  A3,A0
            move.l  (A2),D5
            move.l  D5,D0
            cmp.w   D7,D0
            bls.b   .L9
            move.w  D7,D0
            move.b  D5,D0
.L9:
            cmp.b   D7,D5
            bls.b   .L10
            move.b  D7,D0
.L10:
            swap    D7
            swap    D0
            cmp.b   D7,D0
            bls.b   .L11
            move.b  D7,D0
.L11:
            swap    D0
            move.l  D0,(A2)
            adda.w  A3,A2
            addq.l  #4,D6
            and.l   D4,D6
            bne.b   .L12
            movea.l A4,A0
.L12:
            dbra    D2,.L13
            bra.w   BITBLT.L39
            ds.b    4
            movea.l A4,A0
            adda.w  D6,A0
            movea.l A5,A2
.L18:
            moveq   #0,D7
            move.w  (A0),D7
            adda.w  A3,A0
            add.w   D7,D7
            lsl.l   #5,D7
            lsr.w   #3,D7
            lsr.b   #3,D7
            moveq   #0,D5
            move.w  (A2),D5
            add.w   D5,D5
            lsl.l   #5,D5
            lsr.w   #3,D5
            lsr.b   #3,D5
            move.l  D7,D0
            cmp.l   D5,D0
            bls.b   .L14
            move.l  D5,D0
.L14:
            move.w  D7,D0
            cmp.w   D5,D0
            bls.b   .L15
            move.w  D5,D0
.L15:
            move.b  D7,D0
            cmp.b   D5,D0
            bls.b   .L16
            move.b  D5,D0
.L16:
            lsl.b   #3,D0
            lsl.w   #3,D0
            lsr.l   #6,D0
            move.w  D0,(A2)
            adda.w  A3,A2
            addq.l  #2,D6
            and.l   D4,D6
            bne.b   .L17
            movea.l A4,A0
.L17:
            dbra    D2,.L18
            bra.w   BITBLT.L39
            ds.b    14
bAvg:
            movea.l (-$108,A6),A1
            tst.w   D2
            bgt.b   .L3
.L1:
            ori.b   #3,(-$26F,A6)
.L2:
            move.w  (-$278,A6),D2
            and.l   (-$274,A6),D1
.L3:
            and.w   (-$8C,A6),D6
            bfextu  D1{D0:D7},D3
            beq.b   .L5
            bfextu  (A4){D6:D7},D3
            lea     (0,A1,D3.w*8),A2
            bfextu  (A5){D0:D7},D3
            lea     (0,A1,D3.w*8),A3
            move.w  D0,-(SP)
            moveq   #2,D0
            move.w  (-$10E,A6),D4
            add.w   D4,D4
            clr.w   -(SP)
.L4:
            move.w  (A2)+,D3
            mulu.w  (-$FA.w,A6,D0.w*2),D3
            move.w  (A3)+,D5
            mulu.w  (-$100.w,A6,D0.w*2),D5
            add.l   D5,D3
            swap    D3
            move.w  (-$110,A6),D5
            lsr.w   D5,D3
            lsl.w   D4,D3
            or.w    D3,(SP)
            sub.w   (-$10E,A6),D4
            dbra    D0,.L4
            move.w  (SP)+,D3
            move.w  (SP)+,D0
            move.b  (6,A0,D3.w),D3
            bfins   D3,(A5){D0:D7}
.L5:
            add.l   (SP),D6
            add.l   (SP),D0
            dbra    D2,.L3
            moveq   #-1,D1
            bset    #0,(-$26F,A6)
            bne.b   .L6
            move.w  (-$276,A6),D2
            bmi.b   .L1
            bra.b   .L3
.L6:
            bset    #1,(-$26F,A6)
            beq.w   .L2
            movea.l ($1B40).w,A1
            bra.w   BITBLT.L34
            ds.b    6
            movea.l A4,A0
            adda.w  D6,A0
            movea.l A5,A2
            move.l  #$7F7F7F,D0
            move.l  #$10101,D1
.L8:
            move.l  D1,D3
            move.l  (A0),D7
            and.l   D7,D3
            adda.w  A3,A0
            lsr.l   #1,D7
            and.l   D0,D7
            move.l  (A2),D5
            and.l   D5,D3
            lsr.l   #1,D5
            and.l   D0,D5
            add.l   D5,D7
            add.l   D3,D7
            move.l  D7,(A2)
            adda.w  A3,A2
            addq.l  #4,D6
            and.l   D4,D6
            bne.b   .L7
            movea.l A4,A0
.L7:
            dbra    D2,.L8
            bra.w   BITBLT.L39
            dc.w    0
            movea.l A4,A0
            adda.w  D6,A0
            movea.l A5,A2
            move.w  #$3DEF,D0
            move.w  #$421,D1
.L10:
            move.l  D1,D3
            move.w  (A0),D7
            and.w   D7,D3
            adda.w  A3,A0
            lsr.w   #1,D7
            and.w   D0,D7
            move.w  (A2),D5
            and.w   D5,D3
            lsr.w   #1,D5
            and.w   D0,D5
            add.w   D5,D7
            add.w   D3,D7
            move.w  D7,(A2)
            adda.w  A3,A2
            addq.l  #2,D6
            and.l   D4,D6
            bne.b   .L9
            movea.l A4,A0
.L9:
            dbra    D2,.L10
            bra.w   BITBLT.L39
            ds.b    6
.L15:
            lea     (-$FA,A6),A0
            move.l  (A0)+,D1
            move.w  (A0),D0
            movea.l A4,A0
            adda.w  D6,A0
            movea.l A5,A2
            moveq   #0,D4
            move.l  D4,D3
            movea.l D4,A1
.L14:
            move.l  (A0),D7
            adda.w  A3,A0
            move.l  (A2),D5
            cmp.l   D3,D7
            bne.b   .L11
            cmp.l   A1,D5
            beq.b   .L12
.L11:
            moveq   #0,D3
            move.b  D7,D3
            swap    D1
            mulu.w  D1,D3
            moveq   #0,D4
            move.b  D5,D4
            neg.w   D1
            mulu.w  D1,D4
            neg.w   D1
            add.l   D3,D4
            swap    D4
            movea.w D4,A1
            move.w  D7,D3
            lsr.w   #8,D3
            swap    D1
            mulu.w  D1,D3
            move.w  D5,D4
            lsr.w   #8,D4
            neg.w   D1
            mulu.w  D1,D4
            neg.w   D1
            add.l   D3,D4
            swap    D4
            lsl.w   #8,D4
            adda.w  D4,A1
            moveq   #0,D3
            swap    D7
            move.b  D7,D3
            mulu.w  D0,D3
            moveq   #0,D4
            swap    D5
            move.b  D5,D4
            neg.w   D0
            mulu.w  D0,D4
            neg.w   D0
            add.l   D3,D4
            move.w  A1,D4
            swap    D5
            movea.l D5,A1
            swap    D7
            move.l  D7,D3
.L12:
            move.l  D4,(A2)
            adda.w  A3,A2
            addq.w  #4,D6
            and.w   (-$8C,A6),D6
            bne.b   .L13
            movea.l A4,A0
.L13:
            dbra    D2,.L14
            lea     .L15,A1
            bra.w   BITBLT.L39
            dc.w    0
.L20:
            lea     (-$FA,A6),A0
            move.l  (A0)+,D1
            move.w  (A0),D0
            movea.l A4,A0
            adda.w  D6,A0
            movea.l A5,A2
            moveq   #0,D4
            move.l  D4,D3
            movea.l D4,A1
.L19:
            moveq   #0,D7
            move.w  (A0),D7
            adda.w  A3,A0
            moveq   #0,D5
            move.w  (A2),D5
            cmp.w   D3,D7
            bne.b   .L16
            cmp.w   A1,D5
            beq.b   .L17
.L16:
            add.w   D7,D7
            lsl.l   #5,D7
            lsr.w   #3,D7
            lsr.b   #3,D7
            add.w   D5,D5
            lsl.l   #5,D5
            lsr.w   #3,D5
            lsr.b   #3,D5
            moveq   #0,D3
            move.b  D7,D3
            swap    D1
            mulu.w  D1,D3
            moveq   #0,D4
            move.b  D5,D4
            neg.w   D1
            mulu.w  D1,D4
            neg.w   D1
            add.l   D3,D4
            swap    D4
            movea.l D4,A1
            move.w  D7,D3
            lsr.w   #8,D3
            swap    D1
            mulu.w  D1,D3
            move.w  D5,D4
            lsr.w   #8,D4
            neg.w   D1
            mulu.w  D1,D4
            neg.w   D1
            add.l   D3,D4
            swap    D4
            lsl.w   #5,D4
            adda.w  D4,A1
            moveq   #0,D3
            swap    D7
            move.b  D7,D3
            mulu.w  D0,D3
            moveq   #0,D4
            swap    D5
            move.b  D5,D4
            neg.w   D0
            mulu.w  D0,D4
            neg.w   D0
            add.l   D3,D4
            clr.w   D4
            lsr.l   #6,D4
            add.w   A1,D4
            swap    D5
            lsl.b   #3,D5
            lsl.w   #3,D5
            lsr.l   #6,D5
            movea.l D5,A1
            swap    D7
            lsl.b   #3,D7
            lsl.w   #3,D7
            lsr.l   #6,D7
            move.l  D7,D3
.L17:
            move.w  D4,(A2)
            adda.w  A3,A2
            addq.w  #2,D6
            and.w   (-$8C,A6),D6
            bne.b   .L18
            movea.l A4,A0
.L18:
            dbra    D2,.L19
            lea     .L20,A1
            bra.w   BITBLT.L39
            ds.b    14
bHilite:
            subq.w  #1,D2
            bmi.b   .L5
            bsr.b   hiliteMask
            subq.w  #1,D2
            bmi.b   .L4
.L1:
            cmp.l   (A5),D4
            bne.b   .L6
.L2:
            move.l  A0,(A5)+
.L3:
            dbra    D2,.L1
.L4:
            moveq   #-1,D1
.L5:
            and.l   (-$274,A6),D1
            bsr.b   hiliteMask
            bra.w   BITBLT.L30
.L6:
            cmpa.l  (A5),A0
            beq.b   .L10
            move.l  A2,D6
.L7:
            bfextu  (A5){D6:D7},D3
            cmp.l   D3,D0
            bne.b   .L8
            bfins   D5,(A5){D6:D7}
            bra.b   .L9
.L8:
            cmp.l   D5,D3
            bne.b   .L9
            bfins   D0,(A5){D6:D7}
.L9:
            sub.w   D7,D6
            bpl.b   .L7
            addq.w  #4,A5
            bra.b   .L3
.L10:
            bfextu  D4{0:D7},D5
            exg     D4,A0
            bfextu  D4{0:D7},D0
            bra.b   .L2
hiliteMask:
            move.l  D4,D3
            and.l   D1,D3
            move.l  (A5),D6
            and.l   D1,D6
            cmp.l   D3,D6
            bne.b   .L1
            move.l  A0,D3
            and.l   D1,D3
            not.l   D1
            and.l   (A5),D1
            or.l    D3,D1
            move.l  D1,(A5)+
            rts
.L1:
            move.l  A2,D6
.L2:
            bfextu  D1{D6:D7},D3
            beq.b   .L4
            bfextu  (A5){D6:D7},D3
            cmp.l   D3,D0
            bne.b   .L3
            bfins   D5,(A5){D6:D7}
            bra.b   .L4
.L3:
            cmp.l   D5,D3
            bne.b   .L4
            bfins   D0,(A5){D6:D7}
.L4:
            sub.w   D7,D6
            bpl.b   .L2
            addq.w  #4,A5
            rts
            moveq   #-1,D0
            lsr.l   #8,D0
            move.w  D2,D3
.L5:
            move.w  D3,D2
.L6:
            move.l  D0,D1
            and.l   (A5),D1
            cmp.l   D1,D4
            bne.b   .L8
.L7:
            move.l  A0,(A5)+
            dbra    D2,.L6
            bra.b   .L10
.L8:
            cmpa.l  D1,A0
            bne.b   .L9
            exg     D4,A0
            bra.b   .L7
.L9:
            addq.w  #4,A5
            dbra    D2,.L6
.L10:
            adda.w  A3,A5
            subq.w  #1,(-$260,A6)
            bne.b   .L5
            bra.w   BITBLT.L32
            ds.b    14
bSloHilite:
            bfextu  D4{0:D7},D4
            cmpi.w  #$20,D7
            beq.b   .L3
            tst.w   D2
            bgt.b   .L3
.L1:
            ori.b   #3,(-$26F,A6)
.L2:
            move.w  (-$278,A6),D2
            and.l   (-$274,A6),D1
.L3:
            and.w   (-$8C,A6),D6
            bfextu  D1{D0:D7},D3
            beq.b   .L5
            bfextu  (A4){D6:D7},D3
            cmp.l   D3,D4
            beq.b   .L5
            bfextu  (A5){D0:D7},D3
            cmp.l   D3,D4
            bne.b   .L4
            bfins   D5,(A5){D0:D7}
            bra.b   .L5
.L4:
            cmp.l   D5,D3
            bne.b   .L5
            bfins   D4,(A5){D0:D7}
.L5:
            add.l   (SP),D6
            add.l   (SP),D0
            dbra    D2,.L3
            moveq   #-1,D1
            bset    #0,(-$26F,A6)
            bne.b   .L6
            move.w  (-$276,A6),D2
            bmi.b   .L1
            bra.b   .L3
.L6:
            bset    #1,(-$26F,A6)
            beq.b   .L2
            bra.w   BITBLT.L34
            ds.b    6
bTransparent:
            cmpi.w  #$20,D7
            beq.b   .L3
            tst.w   D2
            bgt.b   .L3
.L1:
            ori.b   #3,(-$26F,A6)
.L2:
            move.w  (-$278,A6),D2
            and.l   (-$274,A6),D1
.L3:
            and.w   (-$8C,A6),D6
            bfextu  (A4){D6:0},D3
            cmp.l   D3,D4
            beq.b   .L5
            bfextu  D1{D0:D7},D3
            beq.b   .L4
            bfextu  (A4){D6:D7},D3
            cmpa.l  D3,A3
            beq.b   .L4
            bfins   D3,(A5){D0:D7}
.L4:
            add.l   (SP),D6
            add.l   (SP),D0
            dbra    D2,.L3
            bra.b   .L6
.L5:
            add.l   A2,D6
            add.l   A2,D0
            sub.w   (-$286,A6),D2
            bge.b   .L3
.L6:
            addq.w  #1,D2
            beq.b   .L7
            sub.l   (SP),D6
            sub.l   (SP),D0
            bra.b   .L6
.L7:
            moveq   #-1,D1
            bset    #0,(-$26F,A6)
            bne.b   .L8
            move.w  (-$276,A6),D2
            bmi.b   .L1
            bra.b   .L3
.L8:
            bset    #1,(-$26F,A6)
            beq.b   .L2
            bra.w   BITBLT.L34
            ds.b    14
            move.l  (-$A4,A6),D3
            movea.l A4,A0
            adda.w  D6,A0
            movea.l A5,A2
            move.l  Lo3Bytes,D0
.L11:
            move.l  (A0),D7
            adda.w  A3,A0
            and.l   D0,D7
            cmp.l   D3,D7
            beq.b   .L9
            move.l  D7,(A2)
.L9:
            adda.w  A3,A2
            addq.l  #4,D6
            and.l   D4,D6
            bne.b   .L10
            movea.l A4,A0
.L10:
            dbra    D2,.L11
            bra.w   BITBLT.L39
            ds.b    4
            move.l  (-$A4,A6),D3
            movea.l A4,A0
            adda.w  D6,A0
            movea.l A5,A2
            moveq   #-1,D0
            lsr.w   #1,D0
.L14:
            move.w  (A0),D7
            adda.w  A3,A0
            and.w   D0,D7
            cmp.w   D3,D7
            beq.b   .L12
            move.w  D7,(A2)
.L12:
            adda.w  A3,A2
            addq.l  #2,D6
            and.l   D4,D6
            bne.b   .L13
            movea.l A4,A0
.L13:
            dbra    D2,.L14
            bra.w   BITBLT.L39
            dc.b    '(c) Apple Computer Inc., 1983-1989'
            dc.w    0
CrsrCore:
InitCrTable:
            dc.w    $02F0,$0322,$0362,$0AC0,$0AD0,$0310,$052A,$02E2
            dc.w    $05F0,$03C4
CrsrVBLTask:
            tst.b   CrsrNew
            beq.w   .L19
            tst.b   CrsrBusy
            bne.w   .L19
            tst.b   CrsrCouple
            beq.w   .L20
            move.w  ($82A).w,D0
            sub.w   ($82E).w,D0
            move.w  MTemp,D1
            sub.w   RawMouse,D1
            move.w  D0,D2
            bge.b   .L1
            neg.w   D2
.L1:
            move.w  D1,D3
            bge.b   .L2
            neg.w   D3
.L2:
            movea.l MickeyBytes,A0
            cmp.w   D2,D3
            bls.b   .L3
            exg     D2,D3
.L3:
            asr.w   #1,D3
            add.w   D2,D3
            bne.b   .L4
            move.w  #1,(A0)
            clr.w   ($12,A0)
            bra.w   .L15
.L4:
            movem.l D4-D5,-(SP)
            move.w  (A0),D4
            cmp.w   (2,A0),D4
            bge.b   .L5
            addq.w  #1,(A0)
.L5:
            move.w  D3,D5
            move.w  D4,D2
            subq.w  #1,D2
            asl.w   #1,D2
            jmp     .L6(PC,D2.w)
.L6:
            bra.b   .L7
            bra.b   .L21
            bra.b   .L22
            bra.b   .L23
            bra.b   .L24
            bra.b   .L25
            bra.b   .L26
            add.w   (4,A0),D5
.L26:
            add.w   (6,A0),D5
            move.w  (6,A0),(4,A0)
.L25:
            add.w   (8,A0),D5
            move.w  (8,A0),(6,A0)
.L24:
            add.w   ($A,A0),D5
            move.w  ($A,A0),(8,A0)
.L23:
            add.w   ($C,A0),D5
            move.w  ($C,A0),($A,A0)
.L22:
            add.w   ($E,A0),D5
            move.w  ($E,A0),($C,A0)
.L21:
            add.w   ($10,A0),D5
            move.w  ($10,A0),($E,A0)
.L7:
            move.w  D3,($10,A0)
            move.w  D4,D2
            asr.w   #1,D2
            add.w   D2,D5
            ext.l   D5
            divu.w  D4,D5
            move.w  D3,D4
            sub.w   D5,D3
            add.w   ($12,A0),D3
            cmpi.w  #$FFFF,D3
            bne.b   .L8
            clr.w   D3
.L8:
            asr.w   #1,D3
            move.w  D3,($12,A0)
            add.w   D5,D3
            cmpi.w  #$FF,D5
            bls.b   .L9
            move.b  #$FF,D5
.L9:
            movea.l MickeyBytes,A0
            lea     ($14,A0),A0
            clr.w   D2
.L10:
            addq.b  #1,D2
            cmp.b   (A0)+,D5
            bhi.b   .L10
            muls.w  D2,D3
            muls.w  D3,D0
            divs.w  D4,D0
            bmi.b   .L11
            andi.w  #$7F,D0
            bra.b   .L12
.L11:
            ori.w   #$FF80,D0
.L12:
            muls.w  D3,D1
            divs.w  D4,D1
            bmi.b   .L13
            andi.w  #$7F,D1
            bra.b   .L14
.L13:
            ori.w   #$FF80,D1
.L14:
            movem.l (SP)+,D4-D5
            add.w   D0,($82E).w
            add.w   D1,RawMouse
.L15:
            lea     CrsrPin,A0
            move.l  RawMouse,D0
            bsr.b   ScrnPin
            move.l  D0,RawMouse
            move.l  D0,MTemp
            and.l   MouseMask,D0
            move.l  MouseOffset,D1
            beq.b   .L16
            add.l   D1,D0
            bsr.b   ScrnPin
.L16:
            move.l  D0,Mouse
.L17:
            bsr.w   ERASECURSOR
.L18:
            clr.b   CrsrNew
            clr.b   CrsrObscure
            bsr.w   DRAWCURSOR
            rts
.L19:
            movea.l MickeyBytes,A0
            move.w  #1,(A0)
            clr.w   ($12,A0)
            rts
.L20:
            movea.l MickeyBytes,A0
            move.w  #1,(A0)
            clr.w   ($12,A0)
            bra.b   .L17
ScrnPin:
            cmp.w   (2,A0),D0
            bge.b   .L1
            bsr.b   FindScreen
            move.w  (2,A0),D0
.L1:
            cmp.w   (6,A0),D0
            blt.b   .L2
            bsr.b   FindScreen
            move.w  (6,A0),D0
            subq.w  #1,D0
.L2:
            swap    D0
            cmp.w   (A0),D0
            bge.b   .L3
            swap    D0
            bsr.b   FindScreen
            swap    D0
            move.w  (A0),D0
.L3:
            cmp.w   (4,A0),D0
            blt.b   .L4
            swap    D0
            bsr.b   FindScreen
            swap    D0
            move.w  (4,A0),D0
            subq.w  #1,D0
.L4:
            swap    D0
            rts
FindScreen:
            move.w  D0,D3
            move.l  D0,D1
            swap    D1
            move.l  DeviceList,D2
            bmi.b   .L3
.L1:
            movea.l D2,A3
            movea.l (A3),A3
            tst.w   ($14,A3)
            bpl.b   .L2
            lea     ($22,A3),A1
            cmp.w   (A1)+,D1
            blt.b   .L2
            cmp.w   (A1)+,D3
            blt.b   .L2
            cmp.w   (A1)+,D1
            bge.b   .L2
            cmp.w   (A1)+,D3
            blt.b   .L4
.L2:
            move.l  ($1E,A3),D2
            bne.b   .L1
.L3:
            rts
.L4:
            movea.l CrsrPtr,A0
            movea.l (A0),A0
            movea.l CrsrDevice,A1
            movea.l (A1),A1
            move.w  ($3A,A0),($30,A1)
            move.w  ($4C,A0),($2E,A1)
            bsr.w   ERASECURSOR
            swap    D3
            move.w  D1,D3
            swap    D3
            move.l  D3,MTemp
            move.l  D3,RawMouse
            move.l  D3,Mouse
            move.l  D2,CrsrDevice
            movea.l A3,A1
            jsr     SetCrsrData
            move.w  (A3),D0
            not.w   D0
            asl.w   #2,D0
            movea.l UTableBase,A0
            movea.l (0,A0,D0.w),A3
            movea.l (A3),A0
            moveq   #0,D0
            move.b  ($28,A0),D0
            _AttachVBL
            addq.w  #8,SP
            bra.w   CrsrVBLTask.L18
PinGuts:
            cmp.w   (2,A0),D0
            bge.b   .L1
            move.w  (2,A0),D0
.L1:
            cmp.w   (6,A0),D0
            blt.b   .L2
            move.w  (6,A0),D0
            subq.w  #1,D0
.L2:
            swap    D0
            cmp.w   (A0),D0
            bge.b   .L3
            move.w  (A0),D0
.L3:
            cmp.w   (4,A0),D0
            blt.b   .L4
            move.w  (4,A0),D0
            subq.w  #1,D0
.L4:
            swap    D0
            rts
PinRect:
            move.l  (4,SP),D0
            movea.l (8,SP),A0
            bsr.b   PinGuts
            movea.l (SP)+,A0
            addq.w  #8,SP
            move.l  D0,(SP)
            jmp     (A0)
CURSORSECT:
            movem.l D0/A0-A1,-(SP)
            tst.w   ($D4C).w
            beq.b   .L1
            lea     CrsrRect,A0
            movea.l CrsrDevice,A1
            movea.l (A1),A1
            lea     ($22,A1),A1
            move.w  ($D48).w,D0
            sub.w   (A1),D0
            cmp.w   (A0)+,D0
            blt.b   .L1
            move.w  ($D4A).w,D0
            sub.w   (2,A1),D0
            cmp.w   (A0)+,D0
            ble.b   .L1
            move.w  ($D44).w,D0
            sub.w   (A1),D0
            cmp.w   (A0)+,D0
            bge.b   .L1
            move.w  ($D46).w,D0
            sub.w   (2,A1),D0
            cmp.w   (A0),D0
            bge.b   .L1
            moveq   #1,D0
            bra.b   .L2
.L1:
            clr.w   D0
.L2:
            movem.l (SP)+,D0/A0-A1
            rts
            move.b  #1,CrsrBusy
            move.b  #1,CrsrObscure
            bra.b   ERASECURSOR
            move.b  #1,CrsrBusy
            subq.w  #1,CrsrState
ERASECURSOR:
            move.b  #1,CrsrBusy
            tst.b   CrsrVis
            beq.b   .L1
            bsr.w   UNBLITCURSOR
.L1:
            clr.b   CrsrBusy
            rts
            move.b  #1,CrsrBusy
            clr.b   CrsrObscure
            clr.w   CrsrState
            clr.w   ($D4C).w
            move.b  #1,CrsrBusy
            tst.w   ($D4C).w
            beq.b   .L2
            subq.w  #1,($D4C).w
            bra.b   DRAWCURSOR
.L2:
            addq.w  #1,CrsrState
            clr.b   CrsrObscure
DRAWCURSOR:
            move.b  #1,CrsrBusy
            tst.w   CrsrState
            bmi.b   .L1
            clr.w   CrsrState
            tst.b   CrsrVis
            bne.b   .L1
            tst.b   CrsrObscure
            bne.b   .L1
            bsr.w   BLITCURSOR
.L1:
            clr.b   CrsrBusy
            rts
            tst.w   ($D4C).w
            beq.b   .L6
            movem.l D0/A0,-(SP)
            lea     ($D4A).w,A0
            move.l  ($C,SP),D0
            cmp.w   (A0),D0
            ble.b   .L2
            move.w  D0,(A0)
.L2:
            swap    D0
            cmp.w   -(A0),D0
            ble.b   .L3
            move.w  D0,(A0)
.L3:
            move.l  ($10,SP),D0
            cmp.w   -(A0),D0
            bge.b   .L4
            move.w  D0,(A0)
.L4:
            swap    D0
            cmp.w   -(A0),D0
            bge.b   .L5
            move.w  D0,(A0)
.L5:
            movem.l (SP)+,D0/A0
            bra.b   .L7
.L6:
            move.l  (4,SP),($D48).w
            move.l  (8,SP),($D44).w
.L7:
            addq.w  #1,($D4C).w
            move.b  #1,CrsrBusy
            bsr.w   CURSORSECT
            beq.b   .L8
            bsr.w   ERASECURSOR
.L8:
            clr.b   CrsrBusy
            move.l  (SP)+,(SP)
            move.l  (SP)+,(SP)
            rts
            movem.l D3-D4/A2-A4,-(SP)
            movea.l ($18,SP),A2
            movea.l A2,A0
            _HGetState
            move.w  D0,-(SP)
            movea.l A2,A0
            _HLock
            movea.l (A2),A2
            movea.l ([CrsrPtr.w]),A3
            move.l  ($5C,A2),D0
            cmpi.w  #$8001,(A3)
            bne.b   .L9
            cmp.l   ($36,A3),D0
            beq.w   .L18
.L9:
            move.b  #1,CrsrBusy
            move.l  D0,($36,A3)
            lea     ($14,A2),A0
            lea     TheCrsr,A1
            moveq   #$10,D0
.L10:
            move.l  (A0)+,(A1)+
            dbra    D0,.L10
            lea     ($14,A2),A0
            lea     ($16,A3),A1
            moveq   #7,D0
.L11:
            move.l  (A0)+,(A1)+
            dbra    D0,.L11
            move.w  (A2),(A3)
            move.l  (2,A2),-(SP)
            move.l  (2,A3),-(SP)
            jsr     ([$1614.w])
            move.l  (6,A2),-(SP)
            move.l  (6,A3),-(SP)
            jsr     ([$1A14.w])
            move.l  DeviceList,D4
            movea.l D4,A4
.L12:
            movea.l (A4),A4
            tst.w   ($14,A4)
            bpl.w   .L17
            movea.l ($16,A4),A0
            movea.l (A0),A0
            move.w  ($20,A0),D3
            clr.w   ($30,A4)
            move.w  ($E,A2),D0
            beq.b   .L13
            cmp.w   D3,D0
            bne.b   .L13
            move.w  D0,($30,A4)
            move.l  ($A,A2),-(SP)
            move.l  ($A,A3),-(SP)
            jsr     ([$1A14.w])
            bra.b   .L17
.L13:
            cmpi.w  #$8001,(A3)
            bne.b   .L16
            cmpi.w  #2,D3
            ble.b   .L16
            move.w  D3,($30,A4)
            move.l  ($32,A4),($A,A3)
            move.l  TheGDevice,-(SP)
            move.l  D4,TheGDevice
            move.l  CrsrPtr,-(SP)
            jsr     ([$1A4C.w])
            move.l  (SP)+,TheGDevice
            move.w  D3,D0
            moveq   #0,D1
.L14:
            lsr.w   #1,D0
            bcs.b   .L15
            addq.w  #1,D1
            bra.b   .L14
.L15:
            lea     ($864).w,A0
            movea.l ([$36.w,A4]),A1
            movea.l A1,A2
            move.w  #$20,D0
            lsl.w   D1,D0
            adda.w  D0,A2
            movea.l ($1AAC).w,A3
            adda.l  (0,A3,D1.w*4),A3
            moveq   #0,D0
            jsr     (A3)
            movea.l ([CrsrPtr.w]),A3
.L16:
            move.w  ($30,A4),D0
            add.w   D0,D0
            move.w  D0,($2E,A4)
.L17:
            move.l  ($1E,A4),D4
            movea.l D4,A4
            bne.w   .L12
            bsr.b   GetMainCrsr
            bsr.w   ERASECURSOR
            bsr.w   DRAWCURSOR
.L18:
            clr.b   CrsrBusy
            move.w  (SP)+,D0
            movea.l ($18,SP),A0
            _HSetState
            movem.l (SP)+,D3-D4/A2-A4
            move.l  (SP)+,(SP)
            rts
GetMainCrsr:
            movea.l CrsrDevice,A0
            movea.l (A0),A0
            movea.l CrsrPtr,A1
            movea.l (A1),A1
            move.l  ($32,A0),($A,A1)
            move.l  ($36,A0),($E,A1)
            move.w  ($30,A0),($3A,A1)
            move.w  ($2E,A0),($4C,A1)
            rts
            movea.l ([CrsrPtr.w]),A0
            move.b  #1,CrsrBusy
            move.w  #$8000,(A0)
            movea.l (8,SP),A0
            lea     TheCrsr,A1
            moveq   #$F,D2
            moveq   #0,D1
.L1:
            move.l  (A0)+,D0
            cmp.l   (A1),D0
            beq.b   .L2
            addq.w  #1,D1
.L2:
            move.l  D0,(A1)+
            dbra    D2,.L1
            move.l  ($E,SP),D0
            moveq   #$10,D2
            cmp.w   D2,D0
            bls.b   .L3
            move.w  D2,D0
.L3:
            swap    D0
            cmp.w   D2,D0
            bls.b   .L4
            move.w  D2,D0
.L4:
            swap    D0
            cmp.l   ($884).w,D0
            beq.b   .L5
            addq.w  #1,D1
            move.l  D0,($884).w
.L5:
            clr.b   CrsrBusy
            tst.w   D1
            beq.b   .L6
            bsr.w   ERASECURSOR
            bsr.w   DRAWCURSOR
.L6:
            movea.l (SP)+,A0
            lea     ($E,SP),SP
            jmp     (A0)
            dc.w    0
SetCrsrData:
            movea.l CrsrPtr,A0
            movea.l (A0),A0
            move.l  ($32,A1),($A,A0)
            move.l  ($36,A1),($E,A0)
            move.w  ($30,A1),($3A,A0)
            move.w  ($2E,A1),($4C,A0)
            lea     ($22,A1),A0
            move.l  (A0)+,CrsrPin
            move.l  (A0),($838).w
            movea.l ($16,A1),A0
            movea.l (A0),A0
            move.w  ($20,A0),ChunkyDepth
            move.l  (A0)+,CRSRBASE
            move.w  (A0)+,D0
            andi.w  #$7FFF,D0
            move.w  D0,CRSRROW
            move.w  (4,A0),D0
            sub.w   (A0),D0
            move.w  D0,ColLines
            move.w  (6,A0),D0
            sub.w   (2,A0),D0
            move.w  D0,RowBits
            rts
            ds.b    4
AllocCrsr:
            movem.l D0-D6/A0-A4/A6,-(SP)
            move.l  TheZone,-(SP)
            move.l  SysZone,TheZone
            bsr.w   ERASECURSOR
            move.b  #1,CrsrBusy
            move.l  CrsrPtr,D0
            cmp.l   MinusOne,D0
            bne.b   .L2
            clr.b   CrsrObscure
            clr.w   CrsrState
            clr.w   ($D4C).w
            moveq   #$50,D1
            bsr.w   GETLOWHANDLE
            move.l  A0,CrsrPtr
            movea.l (A0),A4
            moveq   #$32,D0
            _ResrvMem
            clr.l   -(SP)
            jsr     ([$160C.w])
            movea.l (SP)+,A0
            move.l  A0,(2,A4)
            _HLock
            moveq   #2,D0
            jsr     RNewHandle
            move.l  A0,(6,A4)
            move.l  #$400,D1
            bsr.w   GETLOWHANDLE
            move.l  A0,($12,A4)
            move.w  #$8000,(A4)
            clr.w   ($3A,A4)
            movea.l (A5),A0
            lea     (-$6C,A0),A0
            lea     TheCrsr,A1
            moveq   #$10,D0
.L1:
            move.l  (A0)+,(A1)+
            dbra    D0,.L1
.L2:
            movea.l CrsrPtr,A4
            movea.l (A4),A4
            move.l  DeviceList,D4
            movea.l D4,A6
.L3:
            movea.l (A6),A6
            tst.w   ($14,A6)
            bpl.w   .L7
            tst.w   ($30,A6)
            bne.b   .L4
            movea.l ($32,A6),A0
            _DisposHandle
            move.l  #$400,D1
            bsr.w   GETLOWHANDLE
            move.l  A0,($32,A6)
            movea.l ($36,A6),A0
            _DisposHandle
            bsr.w   GETLOWHANDLE
            move.l  A0,($36,A6)
.L4:
            movea.l ($16,A6),A0
            movea.l (A0),A0
            move.w  ($20,A0),D3
            cmp.w   ($30,A6),D3
            beq.b   .L7
            move.w  D3,D0
            moveq   #0,D6
.L5:
            lsr.w   #1,D0
            bcs.b   .L6
            addq.w  #1,D6
            bra.b   .L5
.L6:
            cmpi.w  #$8001,(A4)
            bne.b   .L7
            cmpi.w  #2,D3
            ble.b   .L7
            move.l  ($32,A6),($A,A4)
            move.l  TheGDevice,-(SP)
            move.l  D4,TheGDevice
            move.l  CrsrPtr,-(SP)
            jsr     ([$1A4C.w])
            move.l  (SP)+,TheGDevice
            lea     ($864).w,A0
            movea.l ([$36.w,A6]),A1
            movea.l A1,A2
            move.w  #$20,D0
            lsl.w   D6,D0
            adda.w  D0,A2
            movea.l ($1AAC).w,A3
            adda.l  (0,A3,D6.w*4),A3
            moveq   #0,D0
            jsr     (A3)
            move.w  D3,($30,A6)
            add.w   D3,D3
            move.w  D3,($2E,A6)
.L7:
            move.l  ($1E,A6),D4
            movea.l D4,A6
            bne.w   .L3
            bsr.w   GetMainCrsr
            movea.l CrsrDevice,A1
            movea.l (A1),A1
            jsr     SetCrsrData
            move.l  (SP)+,TheZone
            clr.b   CrsrBusy
            bsr.w   DRAWCURSOR
            movem.l (SP)+,D0-D6/A0-A4/A6
            rts
GETLOWHANDLE:
            move.l  D1,D0
            _ResrvMem
            bne.b   .L1
            move.l  D1,D0
            _NewHandleClear
            _HLock
            rts
.L1:
            moveq   #$19,D0
            jsr     ([$1524.w])
            _Debugger
            dc.w    0
BLITCURSOR:
            tst.l   CrsrPtr
            bmi.w   .L35
            movem.l D0-D7/A0-A6,-(SP)
            lea     TheCrsr,A2
            lea     ShftTbl,A0
            move.w  ChunkyDepth,D1
            moveq   #0,D7
            move.b  (0,A0,D1.w),D7
            movea.l ([CrsrPtr.w]),A4
            cmpi.w  #$8001,(A4)
            bne.b   .L1
            cmp.w   ($3A,A4),D1
            beq.w   .L10
            cmpi.w  #2,D1
            bgt.w   .L9
            bra.b   .L6
.L1:
            lea     ($16,A4),A0
            movea.l A2,A1
            moveq   #7,D0
.L2:
            cmpm.l  (A0)+,(A1)+
            bne.b   .L3
            dbra    D0,.L2
            cmp.w   ($3A,A4),D1
            beq.w   .L10
.L3:
            movea.l DeviceList,A0
.L4:
            movea.l (A0),A0
            tst.w   ($14,A0)
            bpl.b   .L5
            clr.w   ($30,A0)
.L5:
            move.l  ($1E,A0),D0
            movea.l D0,A0
            bne.b   .L4
.L6:
            lea     ($16,A4),A0
            movea.l A2,A1
            moveq   #7,D0
.L7:
            move.l  (A1)+,(A0)+
            dbra    D0,.L7
            move.w  D1,($3A,A4)
            add.w   D1,D1
            move.w  D1,($4C,A4)
            movea.l A2,A0
            movea.l ([$A.w,A4]),A1
            movea.l A1,A2
            move.w  #$20,D5
            lsl.w   D7,D5
            adda.w  D5,A2
            move.w  D7,D0
            cmpi.w  #4,D0
            blt.b   .L8
            addq.w  #2,D0
.L8:
            movea.l ($1AAC).w,A3
            adda.l  (0,A3,D0.w*4),A3
            moveq   #0,D0
            jsr     (A3)
.L9:
            lea     ($864).w,A0
            movea.l ([$E.w,A4]),A1
            movea.l A1,A2
            move.w  #$20,D5
            lsl.w   D7,D5
            adda.w  D5,A2
            movea.l ($1AAC).w,A3
            adda.l  (0,A3,D7.w*4),A3
            moveq   #0,D0
            jsr     (A3)
.L10:
            move.l  ([$A.w,A4]),D0
            jsr     ([$644.w])
            movea.l D0,A2
            move.l  ([$E.w,A4]),D0
            jsr     ([$644.w])
            movea.l D0,A3
            moveq   #$10,D5
            move.w  Mouse,D2
            sub.w   CrsrPin,D2
            sub.w   ($884).w,D2
            move.w  D2,D3
            add.w   D5,D3
            cmp.w   D5,D3
            bge.b   .L11
            neg.w   D2
            cmp.w   D5,D2
            beq.w   .L34
            mulu.w  ($4C,A4),D2
            adda.l  D2,A2
            adda.l  D2,A3
            moveq   #0,D2
.L11:
            move.w  ColLines,D4
            cmp.w   D4,D3
            ble.b   .L12
            move.w  D4,D3
.L12:
            moveq   #0,D6
            move.w  ($832).w,D0
            sub.w   ($836).w,D0
            sub.w   ($886).w,D0
            move.w  D0,D1
            add.w   D5,D1
            cmp.w   D5,D1
            bge.b   .L13
            sub.w   D0,D6
            moveq   #0,D0
.L13:
            move.w  RowBits,D4
            cmp.w   D4,D1
            ble.b   .L14
            move.w  D4,D1
.L14:
            movea.l CRSRBASE,A5
            movea.w CRSRROW,A0
            move.w  A0,D4
            mulu.w  D2,D4
            adda.l  D4,A5
            ext.l   D0
            lsl.l   D7,D0
            move.l  D0,D4
            andi.l  #$FFFFFFE0,D4
            move.l  D4,D5
            asr.l   #3,D5
            adda.l  D5,A5
            lea     CrsrRect,A1
            move.w  D2,(A1)+
            move.l  D4,D5
            lsr.l   D7,D5
            move.w  D5,(A1)+
            move.w  D3,(A1)+
            move.w  D5,(A1)
            andi.w  #$1F,D0
            lsl.w   D7,D6
            sub.w   D0,D6
            ext.l   D1
            lsl.l   D7,D1
            move.l  D1,D5
            sub.l   D4,D5
            ble.w   .L34
            subq.w  #1,D5
            lsr.l   #5,D5
            sub.w   D2,D3
            subq.w  #1,D3
            move.l  D5,D2
            addq.l  #1,D2
            lsl.l   #2,D2
            suba.l  D2,A0
            lsl.l   #3,D2
            lsr.l   D7,D2
            add.w   D2,(A1)
            bsr.w   CURSORSECT
            bne.w   .L34
            moveq   #-1,D4
            lsr.l   D0,D4
            moveq   #-1,D2
            andi.w  #$1F,D1
            beq.b   .L15
            lsr.l   D1,D2
            not.l   D2
.L15:
            lea     ($4C,A4),A6
            movea.w (A6),A1
            move.l  ([$12.w,A4]),D0
            jsr     ([$644.w])
            movea.l D0,A4
            movem.l D3/D5/A0/A5,-(A6)
            moveq   #1,D0
            movem.l A0-A2,-(SP)
            jsr     ([$574.w])
            movem.l (SP)+,A0-A2
            move.b  D0,-(SP)
            movea.l D5,A6
            ext.l   D6
            move.l  D6,-(SP)
            move.l  D4,-(SP)
            cmpi.w  #4,D7
            bge.w   .L19
            tst.w   D5
            bra.b   .L18
.L16:
            and.l   D2,D4
.L17:
            bfextu  (A2){D6:0},D0
            bfextu  (A3){D6:0},D1
            addi.l  #$20,D6
            and.l   D4,D0
            and.l   D4,D1
            move.l  D0,D7
            and.l   D1,D7
            not.l   D1
            move.l  (A5),D4
            move.l  D4,(A4)+
            and.l   D1,D0
            and.l   D4,D1
            or.l    D7,D1
            eor.l   D0,D1
            move.l  D1,(A5)+
            moveq   #-1,D4
            subq.w  #1,D5
.L18:
            bgt.b   .L17
            beq.b   .L16
            move.l  (4,SP),D6
            move.l  (SP),D4
            adda.l  A1,A3
            adda.l  A1,A2
            adda.l  A0,A5
            move.l  A6,D5
            dbra    D3,.L18
            bra.w   .L33
.L19:
            bgt.b   .L29
            swap    D4
            addq.w  #1,D5
            add.w   D5,D5
            move.w  D5,D0
            subq.w  #2,D5
            movea.w D5,A6
            moveq   #-1,D7
            lsr.w   #1,D7
            add.w   D0,D0
            suba.w  D0,A1
            asr.w   #3,D6
            adda.w  D6,A2
            adda.w  D6,A3
.L20:
            tst.w   D4
            bne.b   .L21
            move.w  (A5)+,(A4)+
            addq.w  #2,A2
            addq.w  #2,A3
            bra.b   .L24
.L21:
            move.w  (A2)+,D0
            move.w  (A5),D1
            move.w  D1,(A4)+
            tst.w   (A3)+
            bne.b   .L22
            not.w   D0
            and.w   D7,D0
            beq.b   .L23
            eor.w   D1,D0
.L22:
            move.w  D0,(A5)
.L23:
            addq.w  #2,A5
.L24:
            dbra    D5,.L21
            tst.w   D2
            bne.b   .L25
            move.w  (A5)+,(A4)+
            addq.w  #2,A2
            addq.w  #2,A3
            bra.b   .L28
.L25:
            move.w  (A2)+,D0
            move.w  (A5),D1
            move.w  D1,(A4)+
            tst.w   (A3)+
            bne.b   .L26
            not.w   D0
            and.w   D7,D0
            beq.b   .L27
            eor.w   D1,D0
.L26:
            move.w  D0,(A5)
.L27:
            addq.w  #2,A5
.L28:
            adda.l  A1,A3
            adda.l  A1,A2
            adda.l  A0,A5
            move.l  A6,D5
            dbra    D3,.L20
            bra.b   .L33
.L29:
            moveq   #-1,D4
            lsr.l   #8,D4
            move.w  D5,D0
            addq.w  #1,D0
            lsl.w   #2,D0
            suba.w  D0,A1
            asr.w   #3,D6
            adda.w  D6,A2
            adda.w  D6,A3
.L30:
            move.l  (A2)+,D0
            move.l  (A5),D1
            move.l  D1,(A4)+
            tst.l   (A3)+
            bne.b   .L31
            not.l   D0
            and.l   D4,D0
            beq.b   .L32
            eor.l   D1,D0
.L31:
            move.l  D0,(A5)
.L32:
            addq.w  #4,A5
            dbra    D5,.L30
            adda.l  A1,A3
            adda.l  A1,A2
            adda.l  A0,A5
            move.l  A6,D5
            dbra    D3,.L30
.L33:
            addq.w  #8,SP
            move.b  #1,CrsrVis
            moveq   #0,D0
            move.b  (SP)+,D0
            jsr     ([$574.w])
.L34:
            movem.l (SP)+,D0-D7/A0-A6
.L35:
            rts
            ds.b    10
UNBLITCURSOR:
            tst.l   CrsrPtr
            bmi.b   .L2
            movem.l D1-D4/A0-A2,-(SP)
            movea.l ([CrsrPtr.w]),A0
            movea.l ($12,A0),A1
            move.l  (A1),D0
            jsr     ([$644.w])
            movea.l D0,A1
            lea     ($3C,A0),A0
            movem.l (A0)+,D2-D4/A2
            moveq   #1,D0
            movem.l D2/A1-A2,-(SP)
            jsr     ([$574.w])
            movem.l (SP)+,D2/A1-A2
            movea.l D3,A0
.L1:
            move.l  (A1)+,(A2)+
            dbra    D3,.L1
            move.l  A0,D3
            adda.w  D4,A2
            dbra    D2,.L1
            jsr     ([$574.w])
            clr.b   CrsrVis
            movem.l (SP)+,D1-D4/A0-A2
.L2:
            rts
            ds.b    10
ScrnAddress:
            move.l  ScrnBase,(4,SP)
            rts
            ds.b    8
ScrnSize:
            move.l  (SP)+,D0
            movea.l MainDevice,A0
            movea.l (A0),A0
            movea.l (SP)+,A1
            move.w  ($26,A0),D1
            sub.w   ($22,A0),D1
            move.w  D1,(A1)
            movea.l (SP)+,A1
            move.w  ($28,A0),D1
            sub.w   ($24,A0),D1
            move.w  D1,(A1)
            movea.l D0,A0
            jmp     (A0)
            ds.b    12
ScrnBitMap:
            move.l  (SP)+,D0
            movea.l MainDevice,A0
            movea.l (A0),A0
            movea.l ($16,A0),A0
            movea.l (A0),A0
            movea.l (SP)+,A1
            move.l  (A0)+,(A1)+
            move.w  (A0)+,D1
            andi.w  #$7FFF,D1
            move.w  D1,(A1)+
            move.l  (A0)+,(A1)+
            move.l  (A0)+,(A1)+
            movea.l D0,A0
            jmp     (A0)
            ds.b    14
BitNot:
            movea.l (SP)+,A0
            not.l   (SP)
            move.l  (SP)+,(SP)
            jmp     (A0)
            ds.b    8
BitAnd:
            movea.l (SP)+,A0
            move.l  (SP)+,D0
            and.l   (SP)+,D0
            bra.b   BitShift.L2
BitXOr:
            movea.l (SP)+,A0
            move.l  (SP)+,D0
            move.l  (SP)+,D1
            eor.l   D1,D0
            bra.b   BitShift.L2
BitOr:
            movea.l (SP)+,A0
            move.l  (SP)+,D0
            or.l    (SP)+,D0
            bra.b   BitShift.L2
BitShift:
            movea.l (SP)+,A0
            move.w  (SP)+,D1
            bpl.b   .L1
            neg.w   D1
            move.l  (SP)+,D0
            lsr.l   D1,D0
            bra.b   .L2
.L1:
            move.l  (SP)+,D0
            lsl.l   D1,D0
.L2:
            move.l  D0,(SP)
            jmp     (A0)
BitTst:
            bsr.b   SHARE
            movea.l (SP)+,A1
            btst    D0,(0,A1,D1.l)
            sne     (SP)
            neg.b   (SP)
            jmp     (A0)
BitSet:
            bsr.b   SHARE
            movea.l (SP)+,A1
            bset    D0,(0,A1,D1.l)
            jmp     (A0)
BitClr:
            bsr.b   SHARE
            movea.l (SP)+,A1
            bclr    D0,(0,A1,D1.l)
            jmp     (A0)
SHARE:
            movea.l (SP)+,A1
            movea.l (SP)+,A0
            move.l  (SP)+,D1
            move.w  D1,D0
            asr.l   #3,D1
            not.w   D0
            jmp     (A1)
Random:
            movea.l (A5),A0
            move.w  #$41A7,D0
            move.w  D0,D2
            mulu.w  (-$7C,A0),D0
            move.l  D0,D1
            clr.w   D1
            swap    D1
            mulu.w  (-$7E,A0),D2
            add.l   D1,D2
            move.l  D2,D1
            add.l   D1,D1
            clr.w   D1
            swap    D1
            andi.l  #$FFFF,D0
            subi.l  #$7FFFFFFF,D0
            andi.l  #$7FFF,D2
            swap    D2
            add.l   D1,D2
            add.l   D2,D0
            bpl.b   .L1
            addi.l  #$7FFFFFFF,D0
.L1:
            move.l  D0,(-$7E,A0)
            cmpi.w  #$8000,D0
            bne.b   .L2
            clr.w   D0
.L2:
            move.w  D0,(4,SP)
            rts
            ds.b    14
ForeColor:
            moveq   #$50,D0
.L1:
            movea.l (A5),A0
            movea.l (A0),A0
            tst.w   (6,A0)
            bpl.b   PortLong
            move.w  D0,-(SP)
            move.l  (6,SP),D0
            movea.l (2,A0),A0
            movea.l (A0),A0
            lsr.l   #1,D0
            bcs.b   .L2
            ori.w   #$E0,D0
.L2:
            lsr.w   #5,D0
            andi.w  #7,D0
            movea.l QDColors,A0
            pea     (2,A0,D0.w*8)
            cmpi.w  #$50,(4,SP)
            bne.b   .L3
            jsr     ([$1650.w])
            bra.b   .L4
.L3:
            jsr     ([$1654.w])
.L4:
            move.w  (SP)+,D0
            movea.l (SP)+,A1
            addq.w  #4,SP
            jmp     (A1)
BackColor:
            moveq   #$54,D0
            bra.b   ForeColor.L1
PortLong:
            movea.l (SP)+,A1
            movea.l (A5),A0
            movea.l (A0),A0
            move.l  (SP)+,(0,A0,D0.w)
            jmp     (A1)
ColorBit:
            moveq   #$58,D0
PortWord:
            movea.l (SP)+,A1
            movea.l (A5),A0
            movea.l (A0),A0
            move.w  (SP)+,(0,A0,D0.w)
            jmp     (A1)
            ds.b    6
GetMaskTab:
            lea     MaskTab,A0
            rts
LeftMask:
            andi.w  #$F,D0
            add.w   D0,D0
            move.w  MaskTab.L1(PC,D0.w),D0
            rts
RightMask:
            andi.w  #$F,D0
            add.w   D0,D0
            move.w  MaskTab(PC,D0.w),D0
            rts
BitMask:
            andi.w  #$F,D0
            add.w   D0,D0
            move.w  MaskTab.L2(PC,D0.w),D0
            rts
MaskTab:
            dc.w    0,$8000,$C000,$E000,$F000,$F800,$FC00,$FE00
            dc.w    $FF00,$FF80,$FFC0,$FFE0,$FFF0,$FFF8,$FFFC,$FFFE
.L1:
            dc.w    $FFFF,$7FFF,$3FFF,$1FFF,$0FFF,$07FF,$03FF,$01FF
            dc.w    $00FF,$007F,$003F,$001F,$000F,$0007,$0003,$0001
.L2:
            dc.w    $8000,$4000,$2000,$1000,$0800,$0400,$0200,$0100
            dc.w    $0080,$0040,$0020,$0010,$0008,$0004,$0002,$0001
            ds.b    6
arithMode:
            dc.w    $0003,$0201,$0103,$0201
            ds.b    8
ColorMap:
            movem.l D3-D7/A2-A3,-(SP)
            moveq   #-1,D4
            moveq   #0,D5
            movea.l (A5),A2
            movea.l (A2),A2
            move.w  ($58,A2),D2
            move.w  (-$98,A6),D3
            move.l  ($50,A2),D6
            move.l  ($54,A2),D7
            clr.w   (-$104,A6)
            move.w  D3,D1
            andi.w  #$FFF7,D3
            eor.w   D3,D1
            cmpi.w  #2,D3
            bne.b   .L1
            bset    #7,HiliteMode
            bne.b   .L1
            move.w  #$32,D3
.L1:
            btst    #5,D3
            beq.b   .L2
            cmpi.w  #1,(-$D4,A6)
            bne.b   .L2
            andi.w  #7,D3
            move.b  arithMode(PC,D3.w),D3
.L2:
            or.w    D1,D3
            move.w  D3,(-$98,A6)
            move.w  D3,D0
            bclr    #3,D0
            cmpi.w  #$32,D0
            beq.w   .L17
            cmpi.w  #2,D0
            beq.w   .L17
            cmpi.w  #6,D0
            beq.w   .L17
            tst.b   D1
            bne.b   .L3
            tst.b   (-$101,A6)
            bne.w   .L17
            bra.b   .L4
.L3:
            tst.b   (-$A6,A6)
            beq.b   .L4
            movea.l (-$9C,A6),A0
            movea.l (A0),A0
            movea.l (A0),A0
            tst.w   (A0)
            bne.w   .L17
.L4:
            tst.w   (6,A2)
            bpl.b   .L6
            lea     ($24,A2),A0
            move.l  (A0)+,D0
            or.w    (A0)+,D0
            tst.l   D0
            sne     (-$103,A6)
            move.w  (A0)+,D1
            and.w   (A0)+,D1
            and.w   (A0)+,D1
            lsr.w   #8,D1
            addq.b  #1,D1
            sne     (-$104,A6)
            cmpi.w  #2,(-$D4,A6)
            bgt.b   .L7
            cmp.l   D6,D7
            bne.b   .L7
            lea     ($24,A2),A0
            lea     ($2A,A2),A1
            cmpm.l  (A0)+,(A1)+
            bne.b   .L5
            cmpm.w  (A0)+,(A1)+
            beq.b   .L7
.L5:
            tst.w   D2
            bne.b   .L7
            lea     ($24,A2),A0
            subq.w  #6,SP
            movea.l SP,A1
            move.l  (A0)+,(A1)+
            move.w  (A0)+,(A1)+
            move.l  SP,-(SP)
            jsr     ([$16D4.w])
            subq.w  #4,SP
            pea     (4,SP)
            jsr     ([$16CC.w])
            move.l  (SP)+,D6
            addq.w  #6,SP
            bra.b   .L7
.L6:
            tst.w   D2
            bmi.w   .L17
            bne.b   .L9
            cmpi.w  #1,(-$D4,A6)
            beq.b   .L9
            cmpi.w  #$21,D6
            sne     (-$103,A6)
            cmpi.w  #$1E,D7
            sne     (-$104,A6)
            move.l  D7,D0
            bsr.w   mapToColor
            move.l  D0,D7
            move.l  D6,D0
            bsr.w   mapToColor
            move.l  D0,D6
.L7:
            move.w  (-$D4,A6),D0
            move.l  D6,D4
            move.l  D7,D5
            moveq   #$20,D1
.L8:
            sub.w   D0,D1
            ble.b   .L17
            lsl.l   D0,D4
            lsl.l   D0,D5
            or.l    D6,D4
            or.l    D7,D5
            bra.b   .L8
.L9:
            moveq   #3,D0
            and.w   D3,D0
            beq.b   .L12
            cmpi.w  #2,D0
            beq.b   .L17
            bgt.b   .L11
            move.l  D6,D1
.L10:
            btst    D2,D1
            bne.b   .L17
            eori.w  #2,D3
            bra.b   .L16
.L11:
            move.l  D7,D1
            not.l   D1
            bra.b   .L10
.L12:
            move.l  D6,D0
            move.l  D7,D1
            btst    D2,D0
            beq.b   .L14
            btst    D2,D1
            beq.b   .L17
            moveq   #8,D3
.L13:
            movea.l (A5),A0
            lea     (-$10,A0),A0
            move.l  A0,(-$9C,A6)
            sf      (-$A6,A6)
            bra.b   .L16
.L14:
            btst    D2,D1
            bne.b   .L15
            moveq   #$C,D3
            bra.b   .L13
.L15:
            eori.w  #4,D3
.L16:
            move.w  D3,(-$98,A6)
.L17:
            move.l  D4,(-$A0,A6)
            move.l  D5,(-$A4,A6)
            btst    #5,D3
            beq.w   .L27
            move.w  (-$D4,A6),D7
            move.l  ($54,A2),D5
            tst.w   (6,A2)
            bmi.b   .L20
            move.l  D5,D0
            bsr.w   mapToColor
            move.l  D0,D5
            lea     ($DA0).w,A2
            moveq   #7,D0
            and.w   D3,D0
            subq.w  #1,D0
            beq.b   .L18
            bmi.b   .L19
            lea     mapToColor.L2,A0
            bra.b   .L21
.L18:
            lea     mapToColor.L3,A0
            bra.b   .L21
.L19:
            lea     mapToColor.L4,A0
            bra.b   .L21
.L20:
            movea.l ([8.w,A2]),A0
            lea     (6,A0),A2
.L21:
            moveq   #2,D1
            lea     (-$F4,A6),A1
            lea     (-$FA,A6),A3
.L22:
            move.w  (A0)+,D0
            bne.b   .L23
            moveq   #1,D0
.L23:
            move.w  D0,-(A1)
            neg.w   D0
            move.w  D0,-(A3)
            dbra    D1,.L22
            subq.w  #6,SP
            subq.w  #4,SP
            move.l  A2,-(SP)
            jsr     ([$16CC.w])
            cmp.l   (SP),D5
            bne.b   .L24
            lea     (4,SP),A1
            movea.l A2,A0
            move.l  (A0)+,(A1)+
            move.w  (A0)+,(A1)+
            pea     (4,SP)
            jsr     ([$16D4.w])
            pea     (4,SP)
            jsr     ([$16CC.w])
.L24:
            movea.l ([TheGDevice.w]),A0
            movea.l ([$16.w,A0]),A1
            movea.l ([6.w,A0]),A0
            move.w  (4,A0),D0
            move.w  D0,(-$10E,A6)
            moveq   #$10,D1
            sub.w   D0,D1
            move.w  D1,(-$110,A6)
            move.l  A0,D0
            jsr     ([$644.w])
            move.l  D0,(-$10C,A6)
            movea.l ([$2A.w,A1]),A1
            lea     ($A,A1),A1
            move.l  A1,D0
            jsr     ([$644.w])
            move.l  D0,(-$108,A6)
            move.l  D5,D2
            move.l  (SP),D4
            moveq   #$20,D1
.L25:
            sub.w   D7,D1
            ble.b   .L26
            lsl.l   D7,D2
            or.l    D5,D2
            lsl.l   D7,D4
            or.l    (SP),D4
            bra.b   .L25
.L26:
            move.l  D2,(-$114,A6)
            move.l  D4,(-$118,A6)
            lea     ($A,SP),SP
            cmpi.w  #$24,(-$98,A6)
            bne.b   .L27
            clr.w   (-$104,A6)
.L27:
            movem.l (SP)+,D3-D7/A2-A3
            rts
mapToColor:
            lsr.w   #1,D0
            bcs.b   .L1
            ori.w   #$E0,D0
.L1:
            lsr.w   #5,D0
            andi.w  #7,D0
            movea.l QDColors,A0
            move.l  (4,A0,D0.w*8),-(SP)
            move.w  (2,A0,D0.w*8),-(SP)
            clr.l   -(SP)
            pea     (4,SP)
            jsr     ([$16CC.w])
            move.l  (SP)+,D0
            addq.w  #6,SP
            rts
.L2:
            ds.b    6
.L3:
            dc.w    $FFFF,$FFFF,$FFFF
.L4:
            dc.w    $7FFF,$7FFF,$7FFF
GetCPixel:
            move.l  (8,SP),-(SP)
            moveq   #1,D2
            bsr.b   sub_4082EF7E
            rtd     #8
GetPixel:
            moveq   #0,D2
sub_4082EF7E:
            link.w  A6,#0
            movem.l D4-D5/A2-A3,-(SP)
            move.l  TheGDevice,-(SP)
            movea.l (A5),A0
            movea.l (A0),A0
            jsr     ([$1A5C.w])
            move.w  (8,A6),D4
            sub.w   (6,A0),D4
            move.w  ($A,A6),D5
            sub.w   (8,A0),D5
            movea.l MainDevice,A2
            movea.l (A2),A2
            movea.l ($16,A2),A2
            movea.l (A2),A2
            move.l  (A0),D1
            cmp.l   (A2),D1
            seq     -(SP)
            movea.l A0,A3
            bne.b   .L4
            move.w  D5,-(SP)
            move.w  D4,-(SP)
            move.w  D5,-(SP)
            move.w  D4,-(SP)
            movea.l ($808).w,A1
            jsr     (A1)
            movea.l DeviceList,A3
.L1:
            movea.l (A3),A2
            tst.w   ($14,A2)
            bpl.b   .L2
            lea     ($22,A2),A1
            cmp.w   (A1)+,D4
            ble.b   .L2
            cmp.w   (A1)+,D5
            ble.b   .L2
            cmp.w   (A1)+,D4
            bge.b   .L2
            cmp.w   (A1)+,D5
            blt.b   .L3
.L2:
            move.l  ($1E,A2),D0
            movea.l D0,A3
            bne.b   .L1
            bra.b   .L10
.L3:
            move.l  A3,TheGDevice
            lea     ($22,A2),A1
            sub.w   (A1)+,D4
            sub.w   (A1)+,D5
            movea.l ($16,A2),A3
            move.l  (A3),D0
            jsr     ([$644.w])
            movea.l D0,A3
            moveq   #1,D0
            move.w  D2,-(SP)
            jsr     ([$574.w])
            move.w  (SP)+,D2
.L4:
            move.w  (4,A3),D1
            andi.w  #$7FFF,D1
            mulu.w  D4,D1
            movea.l (A3),A1
            adda.l  D1,A1
            moveq   #1,D1
            tst.w   (4,A3)
            bpl.b   .L5
            move.w  ($20,A3),D1
.L5:
            mulu.w  D1,D5
            bfextu  (A1){D5:D1},D4
            tst.b   (SP)
            beq.b   .L6
            move.l  D2,D5
            jsr     ([$574.w])
            move.l  D5,D2
.L6:
            tst.w   D2
            beq.b   .L7
            move.l  D4,-(SP)
            move.l  ($10,A6),-(SP)
            jsr     ([$16D0.w])
            bra.b   .L10
.L7:
            cmpi.w  #$10,($1E,A3)
            bne.b   .L8
            tst.l   D4
            seq     D4
            bra.b   .L9
.L8:
            tst.w   D4
            sne     D4
.L9:
            neg.w   D4
            move.b  D4,($C,A6)
.L10:
            tst.b   (SP)+
            beq.b   .L11
            jsr     ([$F4C.w])
.L11:
            move.l  (SP)+,TheGDevice
            movem.l (SP)+,D4-D5/A2-A3
            unlk    A6
            rtd     #4
            ds.b    8
Translate24To32:
            and.l   Lo3Bytes,D0
            bclr    #$17,D0
            bne.b   .L1
            rts
.L1:
            move.w  D1,-(SP)
            move.w  #$C,D1
            rol.l   D1,D0
            move.b  D0,D1
            beq.b   .L2
            lsr.l   #4,D0
            move.b  ($4082F0C2.w,PC,D1.w),D0
            move.w  (SP)+,D1
            ror.l   #8,D0
            rts
.L2:
            ori.w   #$408,D0
            ror.l   #4,D0
            ror.l   #8,D0
            move.w  (SP)+,D1
            rts
            dc.w    $40F9,$FAFB,$FCFD,$FE50
            ds.b    6
StuffHex:
            movea.l (4,SP),A0
            movea.l (8,SP),A1
            move.l  (SP),(8,SP)
            addq.w  #8,SP
            move.b  (A0)+,D2
            andi.w  #$FE,D2
            beq.b   .L2
.L1:
            bsr.b   NEXTHEX
            move.b  D0,D1
            bsr.b   NEXTHEX
            lsl.b   #4,D1
            add.b   D0,D1
            move.b  D1,(A1)+
            subq.w  #2,D2
            bne.b   .L1
.L2:
            rts
NEXTHEX:
            move.b  (A0)+,D0
            cmpi.b  #$39,D0
            ble.b   .L1
            addi.b  #9,D0
.L1:
            andi.b  #$F,D0
            rts
            ds.b    6
XorSlab:
            ext.l   D4
            ext.l   D3
            lsl.l   D0,D4
            lsl.l   D0,D3
            move.l  D4,D0
            sub.l   D3,D0
            ble.b   .L1
            cmpi.l  #$20,D0
            bgt.b   .L2
            bfchg   (A0){D3:D0}
.L1:
            rts
.L2:
            moveq   #$1F,D1
            move.w  D3,D0
            and.w   D1,D0
            moveq   #-1,D5
            lsr.l   D0,D5
            move.w  D4,D0
            and.w   D1,D0
            moveq   #-1,D6
            lsr.l   D0,D6
            not.l   D6
            asr.l   #5,D3
            asr.l   #5,D4
            sub.w   D3,D4
            subq.w  #1,D4
            lsl.w   #2,D3
            adda.w  D3,A0
            eor.l   D5,(A0)+
            bra.b   .L4
.L3:
            not.l   (A0)+
.L4:
            dbra    D4,.L3
            eor.l   D6,(A0)
            rts
            ds.b    6
DrawSlab:
            cmp.w   (2,A3),D1
            bge.b   .L1
            move.w  (2,A3),D1
.L1:
            cmp.w   (6,A3),D2
            ble.b   .L2
            move.w  (6,A3),D2
.L2:
            cmp.w   D2,D1
            bge.b   .L3
            ext.l   D1
            ext.l   D2
            lsl.l   D0,D1
            move.l  D1,(-$11C,A6)
            lsl.l   D0,D2
            moveq   #$1F,D0
            and.w   D0,D1
            moveq   #-1,D3
            lsr.l   D1,D3
            and.w   D2,D0
            moveq   #-1,D1
            lsr.l   D0,D1
            not.l   D1
            move.l  (-$11C,A6),D0
            asr.l   #5,D2
            asr.l   #5,D0
            sub.w   D0,D2
            add.w   D0,D0
            add.w   D0,D0
            adda.w  D0,A1
            adda.w  D0,A2
            tst.w   D2
            jmp     (A4)
.L3:
            rts
            ds.b    4
.L4:
            and.l   D1,D3
.L5:
            move.l  D6,D0
            and.l   (A2)+,D3
            and.l   D3,D0
            not.l   D3
            and.l   (A1),D3
            or.l    D0,D3
            move.l  D3,(A1)+
            moveq   #-1,D3
            subq.w  #1,D2
SLMASK8:
            bgt.b   DrawSlab.L5
            beq.b   DrawSlab.L4
            rts
            ds.b    6
.L1:
            and.l   D1,D3
.L2:
            and.l   D6,D3
            and.l   (A2)+,D3
            move.l  D3,D0
            and.l   D4,D0
            not.l   D3
            and.l   (A1),D3
            or.l    D3,D0
            move.l  D0,(A1)+
            moveq   #-1,D3
            subq.w  #1,D2
SLMASK9:
            bgt.b   SLMASK8.L2
            beq.b   SLMASK8.L1
            rts
            ds.b    4
.L1:
            and.l   D1,D3
.L2:
            and.l   D6,D3
            and.l   (A2)+,D3
            eor.l   D3,(A1)+
            moveq   #-1,D3
            subq.w  #1,D2
SLMASK10:
            bgt.b   SLMASK9.L2
            beq.b   SLMASK9.L1
            rts
            ds.b    14
.L1:
            and.l   D1,D3
.L2:
            and.l   D6,D3
            and.l   (A2)+,D3
            move.l  D3,D0
            and.l   D5,D0
            not.l   D3
            and.l   (A1),D3
            or.l    D3,D0
            move.l  D0,(A1)+
            moveq   #-1,D3
            subq.w  #1,D2
SLMASK11:
            bgt.b   SLMASK10.L2
            beq.b   SLMASK10.L1
            rts
            ds.b    4
SLXMASK8:
            move.w  D7,-(SP)
            move.w  (-$8C,A6),D7
            move.w  D0,D6
            add.w   (-$90,A6),D6
            and.w   D7,D6
            movea.l (-$88,A6),A3
            adda.l  (-$96,A6),A3
            tst.w   D2
            bra.b   .L3
.L1:
            and.l   D1,D3
.L2:
            move.l  (0,A3,D6.w),D0
            addq.w  #4,D6
            and.w   D7,D6
            and.l   (A2)+,D3
            and.l   D3,D0
            not.l   D3
            and.l   (A1),D3
            or.l    D0,D3
            move.l  D3,(A1)+
            moveq   #-1,D3
            subq.w  #1,D2
.L3:
            bgt.b   .L2
            beq.b   .L1
            move.w  (SP)+,D7
            rts
            ds.b    4
SLXMASK9:
            move.w  D7,-(SP)
            move.w  (-$8C,A6),D7
            move.w  D0,D6
            add.w   (-$90,A6),D6
            and.w   D7,D6
            movea.l (-$88,A6),A3
            adda.l  (-$96,A6),A3
            tst.w   D2
            bra.b   .L3
.L1:
            and.l   D1,D3
.L2:
            and.l   (0,A3,D6.w),D3
            addq.w  #4,D6
            and.w   D7,D6
            and.l   (A2)+,D3
            move.l  D3,D0
            and.l   D4,D0
            not.l   D3
            and.l   (A1),D3
            or.l    D3,D0
            move.l  D0,(A1)+
            moveq   #-1,D3
            subq.w  #1,D2
.L3:
            bgt.b   .L2
            beq.b   .L1
            move.w  (SP)+,D7
            rts
            dc.w    0
SLXMASK10:
            move.w  D7,-(SP)
            move.w  (-$8C,A6),D7
            move.w  D0,D6
            add.w   (-$90,A6),D6
            and.w   D7,D6
            movea.l (-$88,A6),A3
            adda.l  (-$96,A6),A3
            tst.w   D2
            bra.b   .L3
.L1:
            and.l   D1,D3
.L2:
            and.l   (0,A3,D6.w),D3
            addq.w  #4,D6
            and.w   D7,D6
            and.l   (A2)+,D3
            eor.l   D3,(A1)+
            moveq   #-1,D3
            subq.w  #1,D2
.L3:
            bgt.b   .L2
            beq.b   .L1
            move.w  (SP)+,D7
            rts
            ds.b    12
SLXMASK11:
            move.w  D7,-(SP)
            move.w  (-$8C,A6),D7
            move.w  D0,D6
            add.w   (-$90,A6),D6
            and.w   D7,D6
            movea.l (-$88,A6),A3
            adda.l  (-$96,A6),A3
            tst.w   D2
            bra.b   .L3
.L1:
            and.l   D1,D3
.L2:
            and.l   (0,A3,D6.w),D3
            addq.w  #4,D6
            and.w   D7,D6
            and.l   (A2)+,D3
            move.l  D3,D0
            and.l   D5,D0
            not.l   D3
            and.l   (A1),D3
            or.l    D3,D0
            move.l  D0,(A1)+
            moveq   #-1,D3
            subq.w  #1,D2
.L3:
            bgt.b   .L2
            beq.b   .L1
            move.w  (SP)+,D7
            rts
            dc.w    0
SLADDOVER:
            movem.l D7/A4-A5,-(SP)
            bsr.b   arithSetup
            tst.w   D2
            bra.b   .L4
.L1:
            and.l   D1,D3
.L2:
            add.l   D7,D6
            and.w   (-$8C,A6),D6
            bfextu  D3{D4:D7},D0
            beq.b   .L3
            bfextu  (A2){D4:D7},D0
            beq.b   .L3
            bfextu  (A3){D6:D7},D0
            lea     (0,A0,D0.w*8),A4
            bfextu  (A1){D4:D7},D0
            lea     (0,A0,D0.w*8),A5
            move.w  (A4)+,D0
            add.w   (A5)+,D0
            asl.l   D5,D0
            move.w  (A4)+,D0
            add.w   (A5)+,D0
            asl.l   D5,D0
            move.w  (A4)+,D0
            add.w   (A5)+,D0
            asl.l   D5,D0
            swap    D0
            move.b  ([-$10C.w,A6],D0.w,6.w),D0
            bfins   D0,(A1){D4:D7}
.L3:
            add.l   D7,D4
            move.w  D4,D0
            andi.w  #$1F,D0
            bne.b   .L2
            moveq   #-1,D3
            subq.w  #1,D2
.L4:
            bgt.b   .L2
            beq.b   .L1
            movem.l (SP)+,D7/A4-A5
            rts
            ds.b    10
arithSetup:
            moveq   #0,D4
            move.w  (-$10E,A6),D5
            moveq   #0,D6
            moveq   #0,D7
            move.w  (-$D4,A6),D7
            movea.l A0,A3
            cmpi.w  #4,(-$8E,A6)
            ble.b   .L1
            move.l  (-$11C,A6),D6
            andi.l  #$FFFFFFE0,D6
            movea.w (-$90,A6),A0
            add.l   A0,D6
            movea.l (-$88,A6),A3
            adda.l  (-$96,A6),A3
.L1:
            sub.l   D7,D6
            movea.l (-$108,A6),A0
            rts
            ds.b    8
SLADDPIN:
            movem.l D7/A4-A5,-(SP)
            bsr.b   arithSetup
            tst.w   D2
            bra.b   .L10
.L1:
            and.l   D1,D3
.L2:
            add.l   D7,D6
            and.w   (-$8C,A6),D6
            bfextu  D3{D4:D7},D0
            beq.b   .L9
            bfextu  (A2){D4:D7},D0
            beq.b   .L9
            bfextu  (A3){D6:D7},D0
            lea     (0,A0,D0.w*8),A4
            bfextu  (A1){D4:D7},D0
            lea     (0,A0,D0.w*8),A5
            move.w  (A4)+,D0
            add.w   (A5)+,D0
            bcs.b   .L3
            cmp.w   (-$F6,A6),D0
            bls.b   .L4
.L3:
            move.w  (-$F6,A6),D0
.L4:
            asl.l   D5,D0
            move.w  (A4)+,D0
            add.w   (A5)+,D0
            bcs.b   .L5
            cmp.w   (-$F8,A6),D0
            bls.b   .L6
.L5:
            move.w  (-$F8,A6),D0
.L6:
            asl.l   D5,D0
            move.w  (A4)+,D0
            add.w   (A5)+,D0
            bcs.b   .L7
            cmp.w   (-$FA,A6),D0
            bls.b   .L8
.L7:
            move.w  (-$FA,A6),D0
.L8:
            asl.l   D5,D0
            swap    D0
            move.b  ([-$10C.w,A6],D0.w,6.w),D0
            bfins   D0,(A1){D4:D7}
.L9:
            add.l   D7,D4
            move.w  D4,D0
            andi.w  #$1F,D0
            bne.b   .L2
            moveq   #-1,D3
            subq.w  #1,D2
.L10:
            bgt.b   .L2
            beq.b   .L1
            movem.l (SP)+,D7/A4-A5
            rts
            ds.b    6
SLSUBOVER:
            movem.l D7/A4-A5,-(SP)
            bsr.w   arithSetup
            tst.w   D2
            bra.b   .L4
.L1:
            and.l   D1,D3
.L2:
            add.l   D7,D6
            and.w   (-$8C,A6),D6
            bfextu  D3{D4:D7},D0
            beq.b   .L3
            bfextu  (A2){D4:D7},D0
            beq.b   .L3
            bfextu  (A3){D6:D7},D0
            lea     (0,A0,D0.w*8),A4
            bfextu  (A1){D4:D7},D0
            lea     (0,A0,D0.w*8),A5
            move.w  (A5)+,D0
            sub.w   (A4)+,D0
            asl.l   D5,D0
            move.w  (A5)+,D0
            sub.w   (A4)+,D0
            asl.l   D5,D0
            move.w  (A5)+,D0
            sub.w   (A4)+,D0
            asl.l   D5,D0
            swap    D0
            move.b  ([-$10C.w,A6],D0.w,6.w),D0
            bfins   D0,(A1){D4:D7}
.L3:
            add.l   D7,D4
            move.w  D4,D0
            andi.w  #$1F,D0
            bne.b   .L2
            moveq   #-1,D3
            subq.w  #1,D2
.L4:
            bgt.b   .L2
            beq.b   .L1
            movem.l (SP)+,D7/A4-A5
            rts
            ds.b    8
SLSUBPIN:
            movem.l D7/A4-A5,-(SP)
            bsr.w   arithSetup
            tst.w   D2
            bra.b   .L10
.L1:
            and.l   D1,D3
.L2:
            add.l   D7,D6
            and.w   (-$8C,A6),D6
            bfextu  D3{D4:D7},D0
            beq.b   .L9
            bfextu  (A2){D4:D7},D0
            beq.b   .L9
            bfextu  (A3){D6:D7},D0
            lea     (0,A0,D0.w*8),A4
            bfextu  (A1){D4:D7},D0
            lea     (0,A0,D0.w*8),A5
            move.w  (A5)+,D0
            sub.w   (A4)+,D0
            bcs.b   .L3
            cmp.w   (-$F6,A6),D0
            bcc.b   .L4
.L3:
            move.w  (-$F6,A6),D0
.L4:
            asl.l   D5,D0
            move.w  (A5)+,D0
            sub.w   (A4)+,D0
            bcs.b   .L5
            cmp.w   (-$F8,A6),D0
            bcc.b   .L6
.L5:
            move.w  (-$F8,A6),D0
.L6:
            asl.l   D5,D0
            move.w  (A5)+,D0
            sub.w   (A4)+,D0
            bcs.b   .L7
            cmp.w   (-$FA,A6),D0
            bcc.b   .L8
.L7:
            move.w  (-$FA,A6),D0
.L8:
            asl.l   D5,D0
            swap    D0
            move.b  ([-$10C.w,A6],D0.w,6.w),D0
            bfins   D0,(A1){D4:D7}
.L9:
            add.l   D7,D4
            move.w  D4,D0
            andi.w  #$1F,D0
            bne.b   .L2
            moveq   #-1,D3
            subq.w  #1,D2
.L10:
            bgt.b   .L2
            beq.b   .L1
            movem.l (SP)+,D7/A4-A5
            rts
            ds.b    4
SLMAX:
            movem.l D7/A4-A5,-(SP)
            bsr.w   arithSetup
            tst.w   D2
            bra.b   .L7
.L1:
            and.l   D1,D3
.L2:
            add.l   D7,D6
            and.w   (-$8C,A6),D6
            bfextu  D3{D4:D7},D0
            beq.b   .L6
            bfextu  (A2){D4:D7},D0
            beq.b   .L6
            bfextu  (A3){D6:D7},D0
            lea     (0,A0,D0.w*8),A4
            bfextu  (A1){D4:D7},D0
            lea     (0,A0,D0.w*8),A5
            move.w  (A4)+,D0
            cmp.w   (A5),D0
            bcc.b   .L3
            move.w  (A5),D0
.L3:
            addq.w  #2,A5
            asl.l   D5,D0
            move.w  (A4)+,D0
            cmp.w   (A5),D0
            bcc.b   .L4
            move.w  (A5),D0
.L4:
            addq.w  #2,A5
            asl.l   D5,D0
            move.w  (A4)+,D0
            cmp.w   (A5),D0
            bcc.b   .L5
            move.w  (A5),D0
.L5:
            asl.l   D5,D0
            swap    D0
            move.b  ([-$10C.w,A6],D0.w,6.w),D0
            bfins   D0,(A1){D4:D7}
.L6:
            add.l   D7,D4
            move.w  D4,D0
            andi.w  #$1F,D0
            bne.b   .L2
            moveq   #-1,D3
            subq.w  #1,D2
.L7:
            bgt.b   .L2
            beq.b   .L1
            movem.l (SP)+,D7/A4-A5
            rts
            ds.b    8
SLMIN:
            movem.l D7/A4-A5,-(SP)
            bsr.w   arithSetup
            tst.w   D2
            bra.b   .L7
.L1:
            and.l   D1,D3
.L2:
            add.l   D7,D6
            and.w   (-$8C,A6),D6
            bfextu  D3{D4:D7},D0
            beq.b   .L6
            bfextu  (A2){D4:D7},D0
            beq.b   .L6
            bfextu  (A3){D6:D7},D0
            lea     (0,A0,D0.w*8),A4
            bfextu  (A1){D4:D7},D0
            lea     (0,A0,D0.w*8),A5
            move.w  (A4)+,D0
            cmp.w   (A5),D0
            bls.b   .L3
            move.w  (A5),D0
.L3:
            addq.w  #2,A5
            asl.l   D5,D0
            move.w  (A4)+,D0
            cmp.w   (A5),D0
            bls.b   .L4
            move.w  (A5),D0
.L4:
            addq.w  #2,A5
            asl.l   D5,D0
            move.w  (A4)+,D0
            cmp.w   (A5),D0
            bls.b   .L5
            move.w  (A5),D0
.L5:
            asl.l   D5,D0
            swap    D0
            move.b  ([-$10C.w,A6],D0.w,6.w),D0
            bfins   D0,(A1){D4:D7}
.L6:
            add.l   D7,D4
            move.w  D4,D0
            andi.w  #$1F,D0
            bne.b   .L2
            moveq   #-1,D3
            subq.w  #1,D2
.L7:
            bgt.b   .L2
            beq.b   .L1
            movem.l (SP)+,D7/A4-A5
            rts
            ds.b    8
SLAVG:
            movem.l D7/A4-A5,-(SP)
            move.l  D1,-(SP)
            bsr.w   arithSetup
            tst.w   D2
            bra.w   .L4
.L1:
            and.l   (SP)+,D3
.L2:
            add.l   D7,D6
            and.w   (-$8C,A6),D6
            bfextu  D3{D4:D7},D0
            beq.b   .L3
            bfextu  (A2){D4:D7},D0
            beq.b   .L3
            bfextu  (A3){D6:D7},D0
            lea     (0,A0,D0.w*8),A4
            bfextu  (A1){D4:D7},D0
            lea     (0,A0,D0.w*8),A5
            move.w  (A4)+,D0
            mulu.w  (-$F6,A6),D0
            move.w  (A5)+,D1
            mulu.w  (-$FC,A6),D1
            add.l   D1,D0
            clr.w   D0
            swap    D0
            asl.l   D5,D0
            swap    D0
            asl.w   D5,D0
            asl.w   D5,D0
            move.w  D0,-(SP)
            move.w  (A4)+,D0
            mulu.w  (-$F8,A6),D0
            move.w  (A5)+,D1
            mulu.w  (-$FE,A6),D1
            add.l   D1,D0
            clr.w   D0
            swap    D0
            asl.l   D5,D0
            swap    D0
            asl.w   D5,D0
            or.w    D0,(SP)
            move.w  (A4)+,D0
            mulu.w  (-$FA,A6),D0
            move.w  (A5)+,D1
            mulu.w  (-$100,A6),D1
            add.l   D1,D0
            clr.w   D0
            swap    D0
            asl.l   D5,D0
            swap    D0
            or.w    (SP)+,D0
            move.b  ([-$10C.w,A6],D0.w,6.w),D0
            bfins   D0,(A1){D4:D7}
.L3:
            add.l   D7,D4
            move.w  D4,D0
            andi.w  #$1F,D0
            bne.w   .L2
            moveq   #-1,D3
            subq.w  #1,D2
.L4:
            bgt.w   .L2
            beq.w   .L1
            movem.l (SP)+,D7/A4-A5
            rts
            ds.b    4
SLHILITE:
            movem.l D7/A4-A5,-(SP)
            bsr.w   arithSetup
            bfextu  (-$114,A6){0:D7},D5
            bfextu  (-$118,A6){0:D7},D0
            movea.l D0,A0
            tst.w   D2
            bra.b   .L5
.L1:
            and.l   D1,D3
.L2:
            add.l   D7,D6
            and.w   (-$8C,A6),D6
            bfextu  D3{D4:D7},D0
            beq.b   .L4
            bfextu  (A2){D4:D7},D0
            beq.b   .L4
            bfextu  (A3){D6:D7},D0
            beq.b   .L4
            bfextu  (A1){D4:D7},D0
            cmp.l   D5,D0
            bne.b   .L3
            move.l  A0,D0
            bfins   D0,(A1){D4:D7}
            bra.b   .L4
.L3:
            cmp.l   A0,D0
            bne.b   .L4
            bfins   D5,(A1){D4:D7}
.L4:
            add.l   D7,D4
            move.w  D4,D0
            andi.w  #$1F,D0
            bne.b   .L2
            moveq   #-1,D3
            subq.w  #1,D2
.L5:
            bgt.b   .L2
            beq.b   .L1
            movem.l (SP)+,D7/A4-A5
            rts
            ds.b    12
SLTRANSPARENT:
            movem.l D7/A4-A5,-(SP)
            bsr.w   arithSetup
            bfextu  (-$114,A6){0:D7},D5
            tst.w   D2
            bra.b   .L4
.L1:
            and.l   D1,D3
.L2:
            add.l   D7,D6
            and.w   (-$8C,A6),D6
            bfextu  D3{D4:D7},D0
            beq.b   .L3
            bfextu  (A2){D4:D7},D0
            beq.b   .L3
            bfextu  (A3){D6:D7},D0
            cmp.l   D5,D0
            beq.b   .L3
            bfins   D0,(A1){D4:D7}
.L3:
            add.l   D7,D4
            move.w  D4,D0
            andi.w  #$1F,D0
            bne.b   .L2
            moveq   #-1,D3
            subq.w  #1,D2
.L4:
            bgt.b   .L2
            beq.b   .L1
            movem.l (SP)+,D7/A4-A5
            rts
            ds.b    6
            move.l  D7,-(SP)
            bsr.w   .L40
            move.l  #$7F7F7F,D0
            movea.l #$808080,A0
.L42:
            tst.l   (A2)+
            beq.b   .L41
            move.l  (0,A3,D6.w),D1
            move.l  A0,D7
            and.l   D1,D7
            and.l   D0,D1
            move.l  (A1),D5
            move.l  A0,D3
            and.l   D5,D3
            and.l   D0,D5
            add.l   D1,D5
            eor.l   D7,D3
            eor.l   D3,D5
            move.l  D5,(A1)
.L41:
            addq.l  #4,A1
            addq.l  #4,D6
            and.w   D4,D6
            dbra    D2,.L42
            move.l  (SP)+,D7
            rts
            dc.w    0
.L40:
            subq.w  #1,D2
            move.w  (-$8C,A6),D4
            move.w  D0,D6
            add.w   (-$90,A6),D6
            and.w   D4,D6
            movea.l (-$88,A6),A3
            adda.l  (-$96,A6),A3
            rts
            ds.b    8
            movea.l D7,A0
            bsr.b   .L40
            moveq   #0,D3
            move.b  (-$F6,A6),D3
            swap    D3
            move.w  (-$F8,A6),D3
            move.b  (-$FA,A6),D3
            move.l  Lo3Bytes,D1
.L11:
            tst.l   (A2)+
            beq.b   .L5
            move.l  (0,A3,D6.w),D7
            and.l   D1,D7
            move.l  D7,D0
            move.l  (A1),D5
            and.l   D1,D5
            clr.b   D0
            add.w   D5,D0
            bcs.b   .L6
            cmp.w   D3,D0
            bls.b   .L7
.L6:
            move.w  D3,D0
.L7:
            move.b  D7,D0
            add.b   D5,D0
            bcs.b   .L8
            cmp.b   D3,D0
            bls.b   .L9
.L8:
            move.b  D3,D0
.L9:
            clr.w   D5
            add.l   D5,D0
            cmp.l   D3,D0
            bls.b   .L10
            swap    D3
            swap    D0
            move.w  D3,D0
            swap    D0
            swap    D3
.L10:
            move.l  D0,(A1)
.L5:
            addq.l  #4,A1
            addq.l  #4,D6
            and.w   D4,D6
            dbra    D2,.L11
            move.l  A0,D7
            rts
            ds.b    14
            movea.l D7,A0
            bsr.w   .L40
            move.l  #$7F7F7F,D0
            move.l  #$808080,D1
.L13:
            tst.l   (A2)+
            beq.b   .L12
            move.l  (0,A3,D6.w),D7
            move.l  D1,D3
            and.l   D7,D3
            eor.l   D1,D3
            and.l   D0,D7
            move.l  (A1),D5
            move.l  D1,D4
            and.l   D5,D4
            and.l   D0,D5
            or.l    D1,D5
            sub.l   D7,D5
            eor.l   D3,D4
            eor.l   D4,D5
            move.l  D5,(A1)
.L12:
            addq.l  #4,A1
            addq.l  #4,D6
            and.w   (-$8C,A6),D6
            dbra    D2,.L13
            move.l  A0,D7
            rts
            ds.b    12
            movea.l D7,A0
            bsr.w   .L40
            moveq   #0,D3
            move.b  (-$F6,A6),D3
            swap    D3
            move.w  (-$F8,A6),D3
            move.b  (-$FA,A6),D3
            move.l  Lo3Bytes,D1
.L20:
            tst.l   (A2)+
            beq.b   .L14
            move.l  (0,A3,D6.w),D5
            and.l   D1,D5
            move.l  (A1),D7
            and.l   D1,D7
            move.l  D7,D0
            st      D0
            sub.w   D5,D0
            bcs.b   .L15
            cmp.w   D3,D0
            bcc.b   .L16
.L15:
            move.w  D3,D0
.L16:
            move.b  D7,D0
            sub.b   D5,D0
            bcs.b   .L17
            cmp.b   D3,D0
            bcc.b   .L18
.L17:
            move.b  D3,D0
.L18:
            clr.w   D5
            sub.l   D5,D0
            cmp.l   D3,D0
            bge.b   .L19
            swap    D3
            swap    D0
            move.w  D3,D0
            swap    D0
            swap    D3
.L19:
            move.l  D0,(A1)
.L14:
            addq.l  #4,A1
            addq.l  #4,D6
            and.w   D4,D6
            dbra    D2,.L20
            move.l  A0,D7
            rts
            ds.b    12
            bsr.w   .L40
.L25:
            tst.l   (A2)+
            beq.b   .L21
            move.l  (0,A3,D6.w),D1
            move.l  (A1),D5
            move.l  D5,D0
            cmp.w   D1,D0
            bhi.b   .L22
            move.w  D1,D0
            move.b  D5,D0
.L22:
            cmp.b   D1,D5
            bhi.b   .L23
            move.b  D1,D0
.L23:
            swap    D1
            swap    D0
            cmp.b   D1,D0
            bhi.b   .L24
            move.b  D1,D0
.L24:
            swap    D0
            move.l  D0,(A1)
.L21:
            addq.l  #4,A1
            addq.l  #4,D6
            and.w   D4,D6
            dbra    D2,.L25
            rts
            ds.b    8
            bsr.w   .L40
.L30:
            tst.l   (A2)+
            beq.b   .L26
            move.l  (0,A3,D6.w),D1
            move.l  (A1),D5
            move.l  D5,D0
            cmp.w   D1,D0
            bls.b   .L27
            move.w  D1,D0
            move.b  D5,D0
.L27:
            cmp.b   D1,D5
            bls.b   .L28
            move.b  D1,D0
.L28:
            swap    D1
            swap    D0
            cmp.b   D1,D0
            bls.b   .L29
            move.b  D1,D0
.L29:
            swap    D0
            move.l  D0,(A1)
.L26:
            addq.l  #4,A1
            addq.l  #4,D6
            and.w   D4,D6
            dbra    D2,.L30
            rts
            ds.b    8
            lea     .L31,A4
            lea     (-$FA,A6),A0
            move.w  (A0)+,D3
            cmp.w   (A0)+,D3
            bne.b   .L31
            cmp.w   (A0),D3
            bne.b   .L31
            addq.w  #1,D3
            andi.w  #$FFFE,D3
            cmpi.w  #$8000,D3
            bne.b   .L31
            lea     .L32,A4
            bra.w   .L32
            ds.b    10
.L31:
            move.l  D7,-(SP)
            bsr.w   .L40
            lea     (-$FA,A6),A0
            move.l  (A0)+,D1
            move.w  (A0),D0
            moveq   #0,D4
            move.l  D4,D3
            movea.l D4,A0
.L43:
            tst.l   (A2)+
            beq.b   .L44
            move.l  (0,A3,D6.w),D7
            move.l  (A1),D5
            cmp.l   D3,D7
            bne.b   .L33
            cmp.l   A0,D5
            beq.b   .L45
.L33:
            moveq   #0,D3
            move.b  D7,D3
            swap    D1
            mulu.w  D1,D3
            moveq   #0,D4
            move.b  D5,D4
            neg.w   D1
            mulu.w  D1,D4
            neg.w   D1
            add.l   D3,D4
            swap    D4
            movea.w D4,A0
            move.w  D7,D3
            lsr.w   #8,D3
            swap    D1
            mulu.w  D1,D3
            move.w  D5,D4
            lsr.w   #8,D4
            neg.w   D1
            mulu.w  D1,D4
            neg.w   D1
            add.l   D3,D4
            swap    D4
            lsl.w   #8,D4
            adda.w  D4,A0
            moveq   #0,D3
            swap    D7
            move.b  D7,D3
            mulu.w  D0,D3
            moveq   #0,D4
            swap    D5
            move.b  D5,D4
            neg.w   D0
            mulu.w  D0,D4
            neg.w   D0
            add.l   D3,D4
            move.w  A0,D4
            swap    D5
            movea.l D5,A0
            swap    D7
            move.l  D7,D3
.L45:
            move.l  D4,(A1)
.L44:
            addq.l  #4,A1
            addq.l  #4,D6
            and.w   (-$8C,A6),D6
            dbra    D2,.L43
            move.l  (SP)+,D7
            rts
            ds.b    6
.L32:
            bsr.w   .L40
            move.l  #$7F7F7F,D0
            movea.l #$10101,A0
.L35:
            tst.l   (A2)+
            beq.b   .L34
            move.l  (0,A3,D6.w),D1
            move.l  A0,D3
            and.l   D1,D3
            lsr.l   #1,D1
            and.l   D0,D1
            move.l  (A1),D5
            and.l   D5,D3
            lsr.l   #1,D5
            and.l   D0,D5
            add.l   D5,D1
            add.l   D3,D1
            move.l  D1,(A1)
.L34:
            addq.l  #4,A1
            addq.l  #4,D6
            and.w   D4,D6
            dbra    D2,.L35
            rts
            ds.b    6
            bsr.w   .L40
            move.l  (-$114,A6),D5
.L37:
            tst.l   (A2)+
            beq.b   .L36
            move.l  (0,A3,D6.w),D1
            cmp.l   D1,D5
            beq.b   .L36
            move.l  D1,(A1)
.L36:
            addq.l  #4,A1
            addq.l  #4,D6
            and.w   D4,D6
            dbra    D2,.L37
            rts
            ds.b    14
            move.l  D7,-(SP)
            bsr.b   arithSetup16
            move.w  #$3DEF,D0
            movea.w #$4210,A0
.L39:
            tst.w   (A2)+
            beq.b   .L38
            move.w  (0,A3,D6.w),D1
            move.w  A0,D7
            and.w   D1,D7
            and.w   D0,D1
            move.w  (A1),D5
            move.w  A0,D3
            and.w   D5,D3
            and.w   D0,D5
            add.w   D1,D5
            eor.w   D7,D3
            eor.w   D3,D5
            move.w  D5,(A1)
.L38:
            addq.l  #2,A1
            addq.l  #2,D6
            and.w   D4,D6
            dbra    D2,.L39
            move.l  (SP)+,D7
            rts
            ds.b    8
arithSetup16:
            asl.w   #1,D2
            beq.b   sub_4082FB94
            subq.w  #1,D2
            neg.w   D1
            add.w   D1,D2
            swap    D1
            neg.w   D1
            add.w   D1,D2
            tst.l   D3
            bmi.b   .L2
            subq.w  #1,D2
.L1:
            addq.w  #2,A2
            addq.w  #2,A3
            addq.w  #2,A1
            addq.w  #2,D0
.L2:
            move.w  (-$8C,A6),D4
            move.w  D0,D6
            add.w   (-$90,A6),D6
            and.w   D4,D6
            movea.l (-$88,A6),A3
            adda.l  (-$96,A6),A3
            rts
sub_4082FB94:
            and.l   D1,D3
            bpl.b   arithSetup16.L1
            neg.w   D3
            add.w   D3,D2
            bra.b   arithSetup16.L2
            dc.w    0
            move.l  D7,-(SP)
            bsr.b   arithSetup16
            moveq   #0,D3
            move.b  (-$F6,A6),D3
            lsr.b   #3,D3
            swap    D3
            move.w  (-$F8,A6),D3
            lsr.w   #3,D3
            move.b  (-$FA,A6),D3
            lsr.b   #3,D3
.L12:
            tst.w   (A2)+
            beq.b   .L8
            moveq   #0,D7
            move.w  (0,A3,D6.w),D7
            add.w   D7,D7
            lsl.l   #5,D7
            lsr.w   #3,D7
            lsr.b   #3,D7
            moveq   #0,D5
            move.w  (A1),D5
            add.w   D5,D5
            lsl.l   #5,D5
            lsr.w   #3,D5
            lsr.b   #3,D5
            add.l   D5,D7
            move.l  D7,D0
            cmp.l   D3,D0
            bls.b   .L9
            move.l  D3,D0
.L9:
            move.w  D7,D0
            cmp.w   D3,D0
            bls.b   .L10
            move.w  D3,D0
.L10:
            move.b  D7,D0
            cmp.b   D3,D0
            bls.b   .L11
            move.b  D3,D0
.L11:
            lsl.b   #3,D0
            lsl.w   #3,D0
            lsr.l   #6,D0
            move.w  D0,(A1)
.L8:
            addq.l  #2,A1
            addq.l  #2,D6
            and.w   D4,D6
            dbra    D2,.L12
            move.l  (SP)+,D7
            rts
            ds.b    8
            move.l  D7,-(SP)
            bsr.w   arithSetup16
            move.w  #$3DEF,D0
            move.w  #$4210,D1
.L14:
            tst.w   (A2)+
            beq.b   .L13
            move.w  (0,A3,D6.w),D7
            move.w  D1,D3
            and.w   D7,D3
            eor.w   D1,D3
            and.w   D0,D7
            move.w  (A1),D5
            move.w  D1,D4
            and.w   D5,D4
            and.w   D0,D5
            or.w    D1,D5
            sub.w   D7,D5
            eor.w   D3,D4
            eor.w   D4,D5
            move.w  D5,(A1)
.L13:
            addq.l  #2,A1
            addq.l  #2,D6
            and.w   (-$8C,A6),D6
            dbra    D2,.L14
            move.l  (SP)+,D7
            rts
            move.l  D7,-(SP)
            bsr.w   arithSetup16
            moveq   #0,D3
            move.b  (-$F6,A6),D3
            lsr.b   #3,D3
            swap    D3
            move.w  (-$F8,A6),D3
            lsr.w   #3,D3
            move.b  (-$FA,A6),D3
            lsr.b   #3,D3
            move.l  #$808080,D1
            add.l   D1,D3
.L1:
            tst.w   (A2)+
            beq.b   .L5
            moveq   #0,D7
            move.w  (0,A3,D6.w),D7
            add.w   D7,D7
            lsl.l   #5,D7
            lsr.w   #3,D7
            lsr.b   #3,D7
            moveq   #0,D5
            move.w  (A1),D5
            add.w   D5,D5
            lsl.l   #5,D5
            lsr.w   #3,D5
            lsr.b   #3,D5
            add.l   D1,D5
            sub.l   D7,D5
            move.l  D5,D0
            cmp.l   D3,D0
            bcc.b   .L2
            move.l  D3,D0
.L2:
            move.w  D5,D0
            cmp.w   D3,D0
            bcc.b   .L3
            move.w  D3,D0
.L3:
            move.b  D5,D0
            cmp.b   D3,D0
            bcc.b   .L4
            move.b  D3,D0
.L4:
            lsl.b   #3,D0
            lsl.w   #3,D0
            lsr.l   #6,D0
            move.w  D0,(A1)
.L5:
            addq.l  #2,A1
            addq.l  #2,D6
            and.w   D4,D6
            dbra    D2,.L1
            move.l  (SP)+,D7
            rts
            ds.b    12
            move.l  D7,-(SP)
            bsr.w   arithSetup16
.L19:
            tst.w   (A2)+
            beq.b   .L15
            moveq   #0,D7
            move.w  (0,A3,D6.w),D7
            add.w   D7,D7
            lsl.l   #5,D7
            lsr.w   #3,D7
            lsr.b   #3,D7
            moveq   #0,D5
            move.w  (A1),D5
            add.w   D5,D5
            lsl.l   #5,D5
            lsr.w   #3,D5
            lsr.b   #3,D5
            move.l  D7,D0
            cmp.l   D5,D0
            bcc.b   .L16
            move.l  D5,D0
.L16:
            move.w  D7,D0
            cmp.w   D5,D0
            bcc.b   .L17
            move.w  D5,D0
.L17:
            move.b  D7,D0
            cmp.b   D5,D0
            bcc.b   .L18
            move.b  D5,D0
.L18:
            lsl.b   #3,D0
            lsl.w   #3,D0
            lsr.l   #6,D0
            move.w  D0,(A1)
.L15:
            addq.l  #2,A1
            addq.l  #2,D6
            and.w   D4,D6
            dbra    D2,.L19
            move.l  (SP)+,D7
            rts
            ds.b    14
            move.l  D7,-(SP)
            bsr.w   arithSetup16
.L32:
            tst.w   (A2)+
            beq.b   .L28
            moveq   #0,D7
            move.w  (0,A3,D6.w),D7
            add.w   D7,D7
            lsl.l   #5,D7
            lsr.w   #3,D7
            lsr.b   #3,D7
            moveq   #0,D5
            move.w  (A1),D5
            add.w   D5,D5
            lsl.l   #5,D5
            lsr.w   #3,D5
            lsr.b   #3,D5
            move.l  D7,D0
            cmp.l   D5,D0
            bls.b   .L29
            move.l  D5,D0
.L29:
            move.w  D7,D0
            cmp.w   D5,D0
            bls.b   .L30
            move.w  D5,D0
.L30:
            move.b  D7,D0
            cmp.b   D5,D0
            bls.b   .L31
            move.b  D5,D0
.L31:
            lsl.b   #3,D0
            lsl.w   #3,D0
            lsr.l   #6,D0
            move.w  D0,(A1)
.L28:
            addq.l  #2,A1
            addq.l  #2,D6
            and.w   D4,D6
            dbra    D2,.L32
            move.l  (SP)+,D7
            rts
            ds.b    14
            lea     .L20,A4
            lea     (-$FA,A6),A0
            move.w  (A0)+,D5
            cmp.w   (A0)+,D5
            bne.b   .L20
            cmp.w   (A0),D5
            bne.b   .L20
            addq.w  #1,D5
            andi.w  #$FFFE,D5
            cmpi.w  #$8000,D5
            bne.b   .L20
            lea     .L21,A4
            bra.w   .L21
            ds.b    10
.L20:
            move.l  D7,-(SP)
            bsr.w   arithSetup16
            lea     (-$FA,A6),A0
            move.l  (A0)+,D1
            move.w  (A0),D0
            moveq   #0,D4
            move.l  D4,D3
            movea.l D4,A0
.L25:
            tst.w   (A2)+
            beq.w   .L22
            moveq   #0,D7
            move.w  (0,A3,D6.w),D7
            moveq   #0,D5
            move.w  (A1),D5
            cmp.w   D3,D7
            bne.b   .L23
            cmp.w   A0,D5
            beq.b   .L24
.L23:
            add.w   D7,D7
            lsl.l   #5,D7
            lsr.w   #3,D7
            lsr.b   #3,D7
            add.w   D5,D5
            lsl.l   #5,D5
            lsr.w   #3,D5
            lsr.b   #3,D5
            moveq   #0,D3
            move.b  D7,D3
            swap    D1
            mulu.w  D1,D3
            moveq   #0,D4
            move.b  D5,D4
            neg.w   D1
            mulu.w  D1,D4
            neg.w   D1
            add.l   D3,D4
            swap    D4
            movea.l D4,A0
            move.w  D7,D3
            lsr.w   #8,D3
            swap    D1
            mulu.w  D1,D3
            move.w  D5,D4
            lsr.w   #8,D4
            neg.w   D1
            mulu.w  D1,D4
            neg.w   D1
            add.l   D3,D4
            swap    D4
            lsl.w   #5,D4
            adda.w  D4,A0
            moveq   #0,D3
            swap    D7
            move.b  D7,D3
            mulu.w  D0,D3
            moveq   #0,D4
            swap    D5
            move.b  D5,D4
            neg.w   D0
            mulu.w  D0,D4
            neg.w   D0
            add.l   D3,D4
            clr.w   D4
            lsr.l   #6,D4
            add.w   A0,D4
            swap    D5
            lsl.b   #3,D5
            lsl.w   #3,D5
            lsr.l   #6,D5
            movea.l D5,A0
            swap    D7
            lsl.b   #3,D7
            lsl.w   #3,D7
            lsr.l   #6,D7
            move.l  D7,D3
.L24:
            move.w  D4,(A1)
.L22:
            addq.l  #2,A1
            addq.l  #2,D6
            and.w   (-$8C,A6),D6
            dbra    D2,.L25
            move.l  (SP)+,D7
            rts
.L21:
            bsr.w   arithSetup16
            move.w  #$3DEF,D0
            movea.w #$421,A0
.L6:
            tst.w   (A2)+
            beq.b   .L7
            move.w  (0,A3,D6.w),D1
            move.w  A0,D3
            and.w   D1,D3
            lsr.w   #1,D1
            and.w   D0,D1
            move.w  (A1),D5
            and.w   D5,D3
            lsr.w   #1,D5
            and.w   D0,D5
            add.w   D5,D1
            add.w   D3,D1
            move.w  D1,(A1)
.L7:
            addq.l  #2,A1
            addq.l  #2,D6
            and.w   D4,D6
            dbra    D2,.L6
            rts
            ds.b    10
            bsr.w   arithSetup16
            move.l  (-$114,A6),D5
.L27:
            tst.w   (A2)+
            beq.b   .L26
            move.w  (0,A3,D6.w),D1
            cmp.w   D1,D5
            beq.b   .L26
            move.w  D1,(A1)
.L26:
            addq.l  #2,A1
            addq.l  #2,D6
            and.w   D4,D6
            dbra    D2,.L27
            rts
            ds.b    14
SLABMODE:
            andi.w  #$37,D2
            bclr    #5,D2
            beq.b   .L2
            bclr    #4,D2
            beq.b   .L1
            moveq   #8,D2
.L1:
            cmpi.w  #$10,(-$D4,A6)
            bge.b   .L4
            addq.w  #8,D2
            move.w  #$1F,(-$8C,A6)
            cmpi.w  #4,(-$8E,A6)
            ble.b   .L3
            movem.l D2-D3,-(SP)
            move.w  (-$D4,A6),D3
            subq.w  #1,D3
            not.w   D3
            move.w  (-$8E,A6),D2
            asl.w   #3,D2
            subq.w  #1,D2
            and.w   D3,D2
            move.w  D2,(-$8C,A6)
            move.w  (-$90,A6),D2
            asl.w   #3,D2
            move.w  D2,(-$90,A6)
            movem.l (SP)+,D2-D3
            bra.b   .L3
.L2:
            andi.w  #3,D2
            cmpi.w  #4,(-$8E,A6)
            ble.b   .L3
            addq.w  #4,D2
.L3:
            lea     ($1C00).w,A4
            movea.l (0,A4,D2.w*4),A4
            rts
.L4:
            beq.b   .L5
            movea.l ($1CF8).w,A4
            adda.l  (0,A4,D2.w*4),A4
            rts
.L5:
            movea.l ($1CF4).w,A4
            adda.l  (0,A4,D2.w*4),A4
            move.w  (-$8C,A6),D2
            bset    #1,D2
            move.w  D2,(-$8C,A6)
            rts
            dc.w    0
SLARITH16TAB:
            dc.w    $FFFF,$FE20,$FFFF,$FC30,$FFFF,$FBB0,$FFFF,$FCE0
            dc.w    $FFFF,$FF40,$FFFF,$FD60,$FFFF,$FCA0,$FFFF,$FDC0
            dc.w    $FFFF,$F7B0
SLARITH32TAB:
            dc.w    $FFFF,$FA5C,$FFFF,$F8AC,$FFFF,$F84C,$FFFF,$F96C
            dc.w    $FFFF,$FB5C,$FFFF,$F9DC,$FFFF,$F91C,$FFFF,$FA1C
            dc.w    $FFFF,$F78C
            ds.b    8
            beq.b   .L1
            move.l  D3,D0
            not.l   D0
            and.l   (A1),D0
            and.l   D4,D3
            or.l    D3,D0
            move.l  D0,(A1)+
            subq.w  #2,D2
            blt.b   .L2
.L3:
            move.l  D4,(A1)+
            dbra    D2,.L3
            bra.b   .L2
.L1:
            and.l   D3,D1
.L2:
            move.l  D1,D0
            and.l   D4,D0
            not.l   D1
            and.l   (A1),D1
            or.l    D1,D0
            move.l  D0,(A1)+
            rts
            ds.b    6
            beq.b   .L4
            eor.l   D3,(A1)+
            subq.w  #2,D2
            blt.b   .L5
.L6:
            not.l   (A1)+
            dbra    D2,.L6
            bra.b   .L5
.L4:
            and.l   D3,D1
.L5:
            eor.l   D1,(A1)+
            rts
            ds.b    10
            beq.b   .L7
            move.l  D3,D0
            not.l   D0
            and.l   (A1),D0
            and.l   D5,D3
            or.l    D3,D0
            move.l  D0,(A1)+
            subq.w  #2,D2
            blt.b   .L8
.L9:
            move.l  D5,(A1)+
            dbra    D2,.L9
            bra.b   .L8
.L7:
            and.l   D3,D1
.L8:
            move.l  D1,D0
            and.l   D5,D0
            not.l   D1
            and.l   (A1),D1
            or.l    D1,D0
            move.l  D0,(A1)+
            rts
            ds.b    6
FASTSLABMODE:
            andi.w  #3,D2
            lea     .L1,A4
            move.b  (0,A4,D2.w),D2
            suba.w  D2,A4
            rts
.L1:
            dc.b    $90,$60,$40
            ds.b    13
CopyHandle:
            move.l  (8,SP),D0
            beq.b   .L1
            movea.l D0,A0
            move.l  (4,SP),D0
            beq.b   .L1
            movea.l D0,A1
            _HGetState
            move.b  D0,-(SP)
            _HNoPurge
            _GetHandleSize
            move.l  D0,D1
            exg     A0,A1
            jsr     RSetHSize
            exg     A0,A1
            move.b  (SP)+,D0
            _HSetState
            movea.l (A0),A0
            movea.l (A1),A1
            move.l  D1,D0
            _BlockMove
.L1:
            movea.l (SP)+,A0
            addq.w  #8,SP
            jmp     (A0)
            ds.b    12
OneBitCTable:
            movea.l (SP)+,A1
            movea.l (SP)+,A0
            moveq   #$18,D0
            jsr     RSetHSize
            movea.l (A0),A0
FillOneBit:
            moveq   #1,D1
            move.l  D1,(A0)+
            move.l  D1,(A0)+
            clr.w   (A0)+
            moveq   #-1,D0
            move.l  D0,(A0)+
            move.w  D0,(A0)+
            swap    D1
            move.l  D1,(A0)+
            clr.l   (A0)+
            jmp     (A1)
            ds.b    14
PortToMap:
            addq.w  #2,A0
BitsToMap:
            tst.w   (4,A0)
            bpl.b   .L1
            btst    #$E,(4,A0)
            beq.b   .L1
            movea.l (A0),A0
            movea.l (A0),A0
.L1:
            rts
            ds.b    10
OpenCPort:
            move.l  (4,SP),-(SP)
            move.l  (SP),-(SP)
            jsr     NewPort
            jsr     InsPortList
            clr.l   -(SP)
            move.w  #$32,-(SP)
            jsr     NewHandle
            movea.l (8,SP),A0
            move.l  (SP)+,(2,A0)
            clr.l   ($20,A0)
            clr.l   ($3A,A0)
            clr.l   ($3E,A0)
            clr.l   (8,A0)
            move.w  #$C000,(6,A0)
InitCPort:
            move.l  A2,-(SP)
            movea.l (8,SP),A2
            tst.w   (6,A2)
            bpl.w   .L2
            jsr     InitShared
            movea.l TheGDevice,A0
            movea.l (A0),A0
            movea.l ($16,A0),A0
            movea.l (A0),A0
            movea.l (2,A2),A1
            movea.l (A1),A1
            move.w  #$18,D0
.L1:
            move.w  (A0)+,(A1)+
            dbra    D0,.L1
            move.l  A2,-(SP)
            jsr     INITCOLORSTUFF
.L2:
            movea.l (SP)+,A2
            move.l  (SP)+,(SP)
            rts
INITCOLORSTUFF:
            move.l  A2,-(SP)
            movea.l (8,SP),A2
            clr.l   -(SP)
            clr.l   -(SP)
            move.l  SP,-(SP)
            pea     ($20,A2)
            jsr     ([$1A44.w])
            not.l   (SP)
            not.l   (4,SP)
            move.l  SP,-(SP)
            pea     ($3A,A2)
            jsr     ([$1A44.w])
            move.l  SP,-(SP)
            pea     ($3E,A2)
            jsr     ([$1A44.w])
            addq.w  #8,SP
            move.l  #$21,-(SP)
            jsr     ([$F88.w])
            move.l  #$1E,-(SP)
            jsr     ([$F8C.w])
            move.l  #$8000,($C,A2)
            tst.l   (8,A2)
            bne.b   .L1
            moveq   #$1A,D0
            jsr     RNewHandle
            move.l  A0,(8,A2)
.L1:
            movea.l ([8.w,A2]),A0
            clr.l   (A0)+
            clr.w   (A0)+
            move.l  ($DA0).w,(A0)+
            move.w  ($DA4).w,(A0)+
            movea.l (SP)+,A2
            move.l  (SP)+,(SP)
            rts
            dc.w    0
CloseCPort:
ClosePort:
            move.l  (4,SP),-(SP)
            jsr     DelPortList
            movea.l (4,SP),A0
            movea.l ($1C,A0),A0
            _DisposHandle
            movea.l (4,SP),A0
            movea.l ($18,A0),A0
            _DisposHandle
            movea.l (4,SP),A0
            tst.w   (6,A0)
            bpl.b   .L7
            moveq   #-1,D0
            tst.l   ($20,A0)
            beq.b   .L1
            addq.w  #1,D0
            move.l  ($20,A0),-(SP)
.L1:
            tst.l   ($3A,A0)
            beq.b   .L2
            addq.w  #1,D0
            move.l  ($3A,A0),-(SP)
.L2:
            tst.l   ($3E,A0)
            beq.b   .L3
            addq.w  #1,D0
            move.l  ($3E,A0),-(SP)
.L3:
            tst.w   D0
            bmi.b   .L6
.L4:
            movea.l (SP)+,A0
            tst.w   ([A0])
            bne.b   .L5
            move.w  D0,-(SP)
            move.l  A0,-(SP)
            jsr     ([$1620.w])
            move.w  (SP)+,D0
.L5:
            dbra    D0,.L4
.L6:
            movea.l (4,SP),A0
            movea.l (2,A0),A0
            _DisposHandle
            movea.l (4,SP),A0
            movea.l (8,A0),A0
            _DisposHandle
.L7:
            rtd     #4
SETCPORTPIX:
            movea.l (A5),A0
            movea.l (A0),A0
            tst.w   (6,A0)
            bpl.b   .L1
            move.l  (4,SP),(2,A0)
.L1:
            rtd     #4
            ds.b    12
NEWCTAB:
            clr.l   -(SP)
            move.w  #$18,-(SP)
            jsr     NewHandle
            move.l  (SP)+,(4,SP)
            rts
DisposCTable:
            movea.l (SP)+,A1
            move.l  (SP)+,D0
            beq.b   .L1
            movea.l D0,A0
            _DisposHandle
.L1:
            jmp     (A1)
            ds.b    4
GETCTSEED:
            move.l  D0,-(SP)
            move.l  TableSeed,D0
            addq.l  #1,D0
            bmi.b   .L1
            cmpi.l  #$3FF,D0
            bgt.b   .L1
            move.l  #$3FF,D0
.L1:
            move.l  D0,TableSeed
            move.l  (SP)+,D0
            move.l  TableSeed,(4,SP)
            rts
            ds.b    10
OpenPixMap:
            clr.l   -(SP)
            move.w  #$32,-(SP)
            jsr     NewHandle
            clr.l   -(SP)
            jsr     NEWCTAB
            move.l  (SP)+,D0
            movea.l (SP)+,A0
            move.l  A0,(4,SP)
            movea.l (A0),A0
            move.l  D0,($2A,A0)
            rts
NewPixMap:
            clr.l   -(SP)
            jsr     OpenPixMap
            move.l  (SP),(8,SP)
            jsr     InitPixMap
            rts
DisposPixMap:
            move.l  (4,SP),D0
            beq.b   .L2
            movea.l D0,A1
            movea.l (A1),A1
            move.l  ($2A,A1),D0
            beq.b   .L1
            move.l  D0,-(SP)
            jsr     ([$1690.w])
.L1:
            movea.l (4,SP),A0
            _DisposHandle
.L2:
            move.l  (SP)+,(SP)
            rts
            ds.b    14
InitPixMap:
            movea.l TheGDevice,A0
            movea.l (A0),A0
            movea.l ($16,A0),A0
            movea.l (A0),A0
            movea.l (4,SP),A1
            movea.l (A1),A1
            move.l  ($2A,A1),-(SP)
            move.l  A1,-(SP)
            moveq   #$18,D0
.L1:
            move.w  (A0)+,(A1)+
            dbra    D0,.L1
            movea.l (SP)+,A1
            move.l  (SP)+,($2A,A1)
            ori.w   #$8000,(4,A1)
            move.l  (SP)+,(SP)
            rts
CopyPixMap:
            movea.l (8,SP),A0
            movea.l (A0),A0
            movea.l (4,SP),A1
            movea.l (A1),A1
            moveq   #$14,D0
.L1:
            move.w  (A0)+,(A1)+
            dbra    D0,.L1
            move.l  (4,A0),(4,A1)
            move.l  (A0),-(SP)
            move.l  (A1),-(SP)
            jsr     ([$1A14.w])
            movea.l (SP)+,A0
            addq.w  #8,SP
            jmp     (A0)
            ds.b    6
BitsToPix:
            moveq   #0,D2
            move.w  (4,A1),D0
            bpl.b   .L2
            btst    #$E,D0
            beq.b   .L1
            movea.l (A1),A1
            movea.l (A1),A1
.L1:
            move.l  (6,A1),D1
            movea.l (A5),A0
            lea     (-$7A,A0),A0
            move.l  (A0),D0
            cmp.l   (A1),D0
            bne.w   COPYPMAP
            bra.b   .L3
.L2:
            move.l  (6,A1),D1
            movea.l (A5),A0
            lea     (-$7A,A0),A0
            move.l  (A0),D0
            cmp.l   (A1),D0
            bne.b   .L6
.L3:
            moveq   #1,D2
            movea.l TheGDevice,A0
            movea.l (A0),A0
            movea.l ($16,A0),A0
            movea.l (A0),A0
            move.l  (A0)+,(A2)+
            move.w  (A0)+,(A2)+
            cmp.l   ($A,A1),D1
            bne.b   .L4
            move.l  D1,(A2)+
            move.l  D1,(A2)+
            addq.l  #8,A0
            bra.b   .L5
.L4:
            move.l  (A0)+,D0
            add.w   D1,D0
            swap    D0
            swap    D1
            add.w   D1,D0
            swap    D0
            move.l  D0,(A2)+
            move.l  (A0)+,D0
            swap    D0
            add.w   D1,D0
            swap    D0
            swap    D1
            add.w   D1,D0
            move.l  D0,(A2)+
.L5:
            movea.l A0,A1
            bra.b   COPYPMAP.L3
.L6:
            lea     OneBitData,A0
            pea     PUTONETABLE
            move.l  (A1),D0
            jsr     ([$644.w])
            move.l  D0,(A2)+
            exg     A0,A1
            lea     ($E,A1),A1
            addq.w  #4,A0
            move.w  (A0)+,D0
            andi.w  #$7FFF,D0
            mulu.w  ($12,A1),D0
            ori.w   #$8000,D0
            move.w  D0,(A2)+
            move.l  (A0)+,(A2)+
            move.l  (A0)+,(A2)+
            bra.b   COPYPMAP.L3
PUTONETABLE:
            move.l  A2,(-8,A2)
            lea     (4,A2),A0
            move.l  A0,(A2)
            movea.l (SP)+,A1
            jmp     FillOneBit
.L1:
            movea.l (A1)+,A0
            btst    #1,D0
            beq.b   .L2
            movea.l (A0),A0
.L2:
            btst    #2,D0
            exg     D0,A0
            beq.b   COPYPMAP.L1
            bra.b   COPYPMAP.L2
COPYPMAP:
            move.w  ($E,A1),D0
            bne.b   PUTONETABLE.L1
            move.l  (A1)+,D0
.L1:
            jsr     ([$644.w])
.L2:
            move.l  D0,(A2)+
            move.w  (A1)+,(A2)+
            move.l  (A1)+,(A2)+
            move.l  (A1)+,(A2)+
.L3:
            move.l  (A1)+,(A2)+
            move.l  (A1)+,(A2)+
            move.l  (A1)+,(A2)+
            move.l  (A1)+,(A2)+
            move.l  (A1)+,(A2)+
            move.l  (A1)+,(A2)+
            move.l  (A1)+,(A2)+
            move.l  (A1)+,(A2)+
            move.l  (A1)+,(A2)+
            rts
OneBitData:
            ds.b    23
            dc.b    $48,$00,$00,$00,$48
            ds.b    5
            dc.b    $01,$00,$01,$00,$01
            ds.b    12
ShftTbl:
            dc.b    $00,$00,$01,$00,$02,$00,$00,$00,$03
            ds.b    7
            dc.b    $04
            ds.b    15
            dc.b    $05
            ds.b    9
SetCPixel:
            link.w  A6,#-$18
            pea     (-$12,A6)
            jsr     ([$1060.w])
            pea     (-$18,A6)
            jsr     ([$1664.w])
            move.l  (8,A6),-(SP)
            jsr     ([$1650.w])
            jsr     ([$1078.w])
            move.l  ($C,A6),-(SP)
            jsr     ([$104C.w])
            clr.l   -(SP)
            jsr     ([$1048.w])
            pea     (-$18,A6)
            jsr     ([$1650.w])
            pea     (-$12,A6)
            jsr     ([$1064.w])
            unlk    A6
            rtd     #8
            ds.b    12
HiliteColor:
            moveq   #6,D0
            bra.b   SETGRAFVARSCOMMON
            ds.b    12
OPCOLOR:
            moveq   #0,D0
SETGRAFVARSCOMMON:
            move.l  (SP)+,D2
            movea.l (SP)+,A1
            movea.l ([A5]),A0
            tst.w   (6,A0)
            bpl.b   .L1
            movea.l ([8.w,A0]),A0
            adda.w  D0,A0
            move.l  (A1)+,(A0)+
            move.w  (A1),(A0)
.L1:
            movea.l D2,A0
            jmp     (A0)
GETCCURSOR:
            move.w  (4,SP),D0
            move.l  #'crsr',D1
            moveq   #$60,D2
            bra.b   PATSHARE
            dc.w    0
GETPIXPAT:
            move.w  (4,SP),D0
            move.l  #'ppat',D1
            moveq   #$1C,D2
PATSHARE:
            link.w  A6,#0
            movem.l D3/A2-A4,-(SP)
            move.l  D2,D3
            clr.l   ($A,A6)
            subq.w  #4,SP
            move.l  D1,-(SP)
            move.w  D0,-(SP)
            jsr     ([$1480.w])
            movea.l (SP)+,A0
            move.l  A0,D0
            beq.w   .L5
            jsr     ([$1584.w])
            bne.w   .L5
            movea.l A0,A3
            _HLock
            movea.l (A3),A2
            movea.l A2,A0
            adda.l  (2,A2),A0
            moveq   #$32,D0
            jsr     ([$158C.w])
            bne.w   .L5
            movea.l A0,A4
            movea.l (A4),A1
            clr.l   ($2A,A1)
            movea.l A2,A0
            movea.l A2,A1
            adda.l  (2,A2),A1
            cmpi.w  #$10,($1E,A1)
            beq.b   .L1
            adda.l  ($2A,A1),A0
            move.w  (6,A0),D0
            addq.w  #1,D0
            mulu.w  #8,D0
            addq.w  #8,D0
            ext.l   D0
            jsr     ([$158C.w])
            bne.w   .L5
            movea.l (A4),A1
            move.l  A0,($2A,A1)
            clr.l   -(SP)
            jsr     ([$16A0.w])
            movea.l (A0),A0
            move.l  (SP)+,(A0)
.L1:
            movea.l A2,A0
            movea.l A2,A1
            adda.l  (2,A2),A1
            move.l  ($2A,A1),D0
            sub.l   (6,A2),D0
            adda.l  (6,A2),A0
            jsr     ([$158C.w])
            bne.w   .L5
            move.l  A0,(6,A2)
            moveq   #2,D0
            _NewHandle
            bne.w   .L5
            move.l  A0,($A,A2)
            cmpi.w  #$60,D3
            beq.b   .L2
            moveq   #$16,D0
            _NewHandle
            bne.w   .L5
            move.l  A0,($10,A2)
.L2:
            move.l  A4,(2,A2)
            movea.l A3,A0
            _HUnlock
            move.l  D3,D0
            jsr     RSetHSize
            cmpi.w  #$60,D3
            bne.b   .L3
            clr.l   -(SP)
            jsr     ([$16A0.w])
            movea.l (A3),A0
            move.l  (SP)+,($5C,A0)
            bra.b   .L4
.L3:
            move.w  #$FFFF,($E,A2)
.L4:
            move.l  A3,($A,A6)
.L5:
            movem.l (SP)+,D3/A2-A4
            unlk    A6
            rtd     #2
            dc.w    0
NewPixPat:
            clr.l   -(SP)
            move.w  #$16,-(SP)
            jsr     NewHandle
            clr.l   -(SP)
            move.w  #$1C,-(SP)
            jsr     NewHandle
            clr.l   -(SP)
            jsr     ([$160C.w])
            movea.l (SP),A0
            clr.l   -(SP)
            move.w  #8,-(SP)
            jsr     NewHandle
            clr.l   -(SP)
            clr.w   -(SP)
            jsr     NewHandle
            move.l  (SP)+,D2
            move.l  (SP)+,D1
            move.l  (SP)+,D0
            movea.l (SP)+,A1
            move.l  A1,(8,SP)
            movea.l (A1),A0
            move.l  D0,(2,A0)
            move.l  D1,(6,A0)
            move.l  D2,($A,A0)
            move.l  (SP)+,($10,A0)
            move.l  #$AA55AA55,D0
            move.l  D0,($14,A0)
            move.l  D0,($18,A0)
            move.w  #1,(A0)
            move.w  #$FFFF,($E,A0)
            rts
            ds.b    8
DisposCCursor:
DisposPixPat:
            move.l  (4,SP),D0
            beq.b   .L6
            movea.l D0,A1
            move.l  (A1),D0
            beq.b   .L6
            movea.l D0,A1
            move.w  (A1),-(SP)
            bmi.b   .L1
            movea.l ($10,A1),A0
            _DisposHandle
.L1:
            movea.l (6,A1),A0
            _DisposHandle
            movea.l ($A,A1),A0
            _DisposHandle
            move.l  (2,A1),-(SP)
            jsr     ([$1610.w])
            movea.l (6,SP),A0
            move.l  A0,D2
            _DisposHandle
            tst.w   (SP)+
            bmi.b   .L6
            movea.l PortList,A1
            movea.l (A1),A1
            move.w  (A1)+,D0
            bra.b   .L5
.L2:
            movea.l (A1)+,A0
            tst.w   (6,A0)
            bpl.b   .L5
            cmp.l   ($3A,A0),D2
            bne.b   .L3
            clr.l   ($3A,A0)
.L3:
            cmp.l   ($20,A0),D2
            bne.b   .L4
            clr.l   ($20,A0)
.L4:
            cmp.l   ($3E,A0),D2
            bne.b   .L5
            clr.l   ($3E,A0)
.L5:
            dbra    D0,.L2
.L6:
            move.l  (SP)+,(SP)
            rts
            ds.b    14
SetFillPat:
            movea.l (4,SP),A1
            movea.l (A5),A0
            movea.l (A0),A0
            tst.w   D0
            beq.b   .L1
            move.l  A1,-(SP)
            jsr     PHILPIXPAT
            bra.b   .L3
.L1:
            tst.w   (6,A0)
            bpl.b   .L2
            move.l  A1,-(SP)
            pea     ($3E,A0)
            jsr     ([$1A44.w])
            bra.b   .L3
.L2:
            lea     ($28,A0),A0
            move.l  (A1)+,(A0)+
            move.l  (A1)+,(A0)+
.L3:
            rtd     #4
            ds.b    12
PenPixPat:
            moveq   #$3A,D0
            moveq   #$3A,D1
            bra.b   BackPixPat.L1
PHILPIXPAT:
            moveq   #$3E,D0
            moveq   #$28,D1
            bra.b   BackPixPat.L1
BackPixPat:
            moveq   #$20,D0
            moveq   #$20,D1
.L1:
            movea.l (A5),A0
            movea.l (A0),A0
            tst.w   (6,A0)
            bmi.b   .L3
            movea.l (4,SP),A1
            movea.l (A1),A1
            cmpi.w  #2,(A1)
            beq.b   .L2
            lea     ($14,A1),A1
            lea     (0,A0,D1.w),A0
            move.l  (A1)+,(A0)+
            move.l  (A1)+,(A0)+
            bra.b   .L5
.L2:
            movea.l (2,A1),A1
            movea.l (A1),A1
            movea.l ($2A,A1),A1
            movea.l (A1),A1
            pea     ($2A,A1)
            pea     (0,A0,D1.w)
            jsr     PutGray
            bra.b   .L5
.L3:
            move.l  (0,A0,D0.w),D1
            beq.b   .L4
            movea.l D1,A0
            movea.l (A0),A0
            tst.w   (A0)
            bne.b   .L4
            move.w  D0,-(SP)
            move.l  D1,-(SP)
            jsr     ([$1620.w])
            move.w  (SP)+,D0
.L4:
            movea.l (A5),A0
            movea.l (A0),A0
            move.l  (4,SP),(0,A0,D0.w)
.L5:
            move.l  (SP)+,(SP)
            rts
            ds.b    10
CopyPixPat:
            moveq   #4,D0
            movea.l (8,SP),A0
            movea.l (A0),A0
            movea.l (4,SP),A1
            movea.l (A1),A1
            move.w  (A0)+,(A1)+
            move.l  (A0)+,-(SP)
            move.l  (A1)+,-(SP)
            move.l  (A0)+,-(SP)
            move.l  (A1)+,-(SP)
            move.l  (A0)+,-(SP)
            move.l  (A1)+,-(SP)
            move.w  (A0)+,(A1)+
            move.l  (A0)+,-(SP)
            move.l  (A1)+,-(SP)
            move.l  (A0)+,(A1)+
            move.l  (A0)+,(A1)+
            jsr     ([$1A14.w])
            jsr     ([$1A14.w])
            jsr     ([$1A14.w])
            jsr     ([$1614.w])
            movea.l (SP)+,A0
            addq.w  #8,SP
            jmp     (A0)
            ds.b    12
OLDPATTONEW:
            link.w  A6,#0
            movem.l A2-A3,-(SP)
            movea.l (8,A6),A0
            move.l  (A0),D0
            beq.b   .L1
            movea.l D0,A3
            movea.l (A3),A1
            tst.w   (A1)
            beq.b   .L2
.L1:
            clr.l   -(SP)
            jsr     ([$161C.w])
            movea.l (8,A6),A0
            move.l  (SP)+,(A0)
            movea.l (A0),A3
            movea.l (A3),A1
            clr.w   (A1)
            movea.l (2,A1),A1
            movea.l (A1),A1
            move.l  ($2A,A1),-(SP)
            jsr     OneBitCTable
            movea.l (A3),A1
.L2:
            move.w  #$FFFF,($E,A1)
            movea.l (6,A1),A0
            movea.l (A0),A0
            movea.l ($C,A6),A1
            move.l  (A1)+,(A0)+
            move.l  (A1)+,(A0)+
            movea.l (A3),A2
            movea.l (2,A2),A2
            movea.l (A2),A2
            movea.l A2,A3
            move.l  ($2A,A3),-(SP)
            lea     OneBitData,A1
            jsr     COPYPMAP
            move.w  #1,(4,A3)
            clr.l   (6,A3)
            move.l  #$80008,($A,A3)
            move.l  (SP)+,($2A,A3)
            movem.l (SP)+,A2-A3
            unlk    A6
            rtd     #8
            ds.b    10
PATEXPAND:
            tst.b   (-$A6,A6)
            bne.w   sub_4083093E.L11
            movea.l (SP)+,A0
            moveq   #$40,D0
            move.w  (-$76,A6),D1
            subq.w  #3,D1
            ble.b   .L1
            lsl.w   D1,D0
.L1:
            suba.w  D0,SP
            move.l  SP,(-$88,A6)
            move.l  A0,-(SP)
sub_4083093E:
            link.w  A4,#-$20
            movem.l D3-D6/A2-A3/A5,-(SP)
            move.w  (-$98,A6),D0
            move.w  (-$EC,A6),D2
            move.l  (-$A0,A6),D3
            move.l  (-$A4,A6),D4
            move.w  (-$76,A6),D5
            movea.l (-$9C,A6),A0
            lea     (-$8E,A6),A1
            andi.w  #$F3,D0
            beq.b   .L1
            btst    #5,D0
            bne.b   .L1
            moveq   #-1,D3
            moveq   #0,D4
.L1:
            movea.l (A5),A3
            moveq   #7,D0
            and.w   (-$A8,A3),D0
            beq.b   .L2
            move.l  (A0),(-$10,A4)
            move.l  (A0)+,(-8,A4)
            move.l  (A0),(-$C,A4)
            move.l  (A0),(-4,A4)
            lea     (-$10,A4),A0
            adda.w  D0,A0
.L2:
            add.w   (-$A6,A3),D2
            moveq   #7,D6
            and.w   D6,D2
            tst.w   D5
            bne.b   .L3
            movea.l (A3),A3
            move.w  ($5A,A3),D0
            cmpi.w  #$FFFE,D0
            beq.b   .L6
            cmpi.w  #2,D0
            beq.b   .L4
.L3:
            movea.l ($1AB8).w,A2
            adda.l  (0,A2,D5.w*4),A2
            jsr     (A2)
            bra.b   .L8
.L4:
            clr.w   (A1)+
            clr.l   (A1)+
            movea.l (A1),A1
            clr.w   D0
.L5:
            move.b  (A0)+,D0
            eor.b   D7,D0
            rol.b   D2,D0
            move.b  D0,-(SP)
            lsr.b   #4,D0
            move.b  .L9(PC,D0.w),(A1)+
            moveq   #$F,D0
            and.b   (SP)+,D0
            move.b  .L9(PC,D0.w),(A1)+
            move.w  (-2,A1),(A1)+
            move.l  (-4,A1),(A1)+
            dbra    D6,.L5
            bra.b   .L8
.L6:
            clr.w   (A1)+
            clr.l   (A1)+
            movea.l (A1),A1
            clr.w   D0
.L7:
            move.b  (A0)+,D0
            eor.b   D7,D0
            rol.b   D2,D0
            move.b  D0,-(SP)
            lsr.b   #4,D0
            move.b  .L10(PC,D0.w),(A1)+
            moveq   #$F,D0
            and.b   (SP)+,D0
            move.b  .L10(PC,D0.w),(A1)+
            move.w  (-2,A1),(A1)+
            clr.l   (A1)+
            dbra    D6,.L7
.L8:
            movem.l (SP)+,D3-D6/A2-A3/A5
            unlk    A4
            rts
.L9:
            dc.w    $0003,$0C0F,$3033,$3C3F,$C0C3,$CCCF,$F0F3,$FCFF
.L10:
            dc.w    $0001,$0405,$1011,$1415
            dc.b    '@ADEPQTU'
.L11:
            link.w  A4,#-$20
            movem.l D3-D6/A2-A3/A5,-(SP)
            move.l  SP,(-$14,A4)
            movea.l (A5),A3
            move.l  A3,(-$1C,A4)
            move.l  A5,(-$20,A4)
            movea.l (-$9C,A6),A0
            movea.l (A0),A0
            movea.l (A0),A0
            tst.w   (A0)
            bne.b   .L14
            movea.l ($A,A0),A0
            moveq   #$40,D0
            move.w  (-$76,A6),D1
            subq.w  #3,D1
            ble.b   .L12
            lsl.l   D1,D0
.L12:
            jsr     RSetHSize
            move.l  (A0),D0
            jsr     ([$644.w])
            move.l  D0,(-$88,A6)
            movea.l (-$9C,A6),A0
            move.l  A0,-(SP)
            movea.l (A0),A0
            movea.l (A0),A0
            movea.l (6,A0),A0
            movea.l (A0),A0
            move.l  A0,(-$9C,A6)
            jsr     sub_4083093E
            move.l  (SP)+,(-$9C,A6)
.L13:
            movea.l (-$14,A4),SP
            bra.w   .L8
.L14:
            movea.l (-$9C,A6),A0
            movea.l (A0),A0
            movea.l (A0),A2
            movea.l TheGDevice,A1
            movea.l (A1),A1
            movea.l ($16,A1),A1
            movea.l (A1),A1
            move.w  ($20,A1),D1
            movea.l ($10,A2),A5
            movea.l (A5),A5
            cmp.w   ($E,A2),D1
            bne.b   .L15
            cmpi.w  #8,D1
            bgt.b   .L16
            movea.l ($2A,A1),A1
            movea.l (A1),A1
            move.l  (A1),D0
            cmp.l   (6,A5),D0
            beq.b   .L16
.L15:
            move.l  D0,(6,A5)
            move.w  D1,($E,A2)
            move.l  A0,-(SP)
            movea.l (-$20,A4),A5
            jsr     ([$1A4C.w])
.L16:
            movea.l (-$9C,A6),A0
            movea.l (A0),A0
            movea.l (A0),A0
            movea.l ($10,A0),A5
            movea.l (A5),A5
            move.l  ([$A.w,A0]),D0
            jsr     ([$644.w])
            move.l  D0,(-$88,A6)
            move.w  (A5),(-$8E,A6)
            move.w  (2,A5),(-$8C,A6)
            move.w  (4,A5),(-$8A,A6)
            lea     ($A,A5),A2
            movea.l (A3),A1
            move.w  (A2)+,D0
            cmp.w   (-$EC,A6),D0
            bne.b   .L18
            cmp.l   (A2)+,D7
            bne.b   .L18
            move.w  (-$A8,A3),D0
            cmp.w   (A2)+,D0
            bne.b   .L18
            move.w  (-$A6,A3),D0
            cmp.w   (A2)+,D0
            bne.b   .L18
            move.w  ($5A,A1),D0
            cmp.w   (A2)+,D0
            beq.w   .L8
.L17:
            lea     ($C,A5),A2
            move.l  D7,(A2)+
            movea.l (-$1C,A4),A3
            move.l  (-$A8,A3),(A2)+
            movea.l (A3),A1
            move.w  ($5A,A1),(A2)+
            bra.w   .L13
.L18:
            move.w  (A5),D0
            bne.b   .L19
            moveq   #4,D0
.L19:
            movea.l (2,A0),A1
            movea.l (A1),A1
            move.w  (-$76,A6),D1
            lsl.w   #3,D0
            move.w  D0,D3
            move.w  D0,D4
            lsr.w   D1,D4
            lsr.w   #5,D0
.L20:
            clr.l   -(SP)
            dbra    D0,.L20
            move.w  (-$EC,A6),D2
            add.w   (-$A6,A3),D2
            move.w  D2,D0
            sub.w   ($A,A5),D2
            move.w  D0,($A,A5)
            subq.w  #1,D4
            and.w   D4,D2
            beq.b   .L17
            lsl.w   D1,D2
            move.w  D2,(-$18,A4)
            move.w  D3,(-$16,A4)
            movea.l ($A,A0),A3
            movea.l (A3),A3
            moveq   #$20,D6
            moveq   #$10,D5
            tst.w   (A5)
            beq.b   .L27
            move.w  ($A,A1),D5
            sub.w   (6,A1),D5
            moveq   #0,D3
            bra.b   .L27
.L21:
            movea.l SP,A2
            move.w  (-$16,A4),D3
            move.w  (-$18,A4),D2
            move.w  D2,D7
            ext.l   D7
            sub.w   D7,D3
.L22:
            bfextu  (A3){D7:0},D0
            add.l   D6,D7
            sub.w   D6,D3
            bmi.b   .L23
            move.l  D0,(A2)+
            bra.b   .L22
.L23:
            move.l  D6,D1
            add.w   D3,D1
            rol.l   D1,D0
            bfins   D0,(A2){0:D1}
            neg.w   D3
            bfextu  (A3){0:D3},D0
            bfins   D0,(A2){D1:D3}
            addq.w  #4,A2
            sub.w   D3,D2
            ble.b   .L25
.L24:
            bfextu  (A3){D3:0},D0
            add.l   D6,D3
            sub.w   D6,D2
            bmi.b   .L25
            move.l  D0,(A2)+
            bra.b   .L24
.L25:
            movea.l SP,A2
            move.w  (-$16,A4),D0
            subq.w  #1,D0
            lsr.w   #5,D0
.L26:
            move.l  (A2)+,(A3)+
            dbra    D0,.L26
.L27:
            dbra    D5,.L21
            bra.w   .L17
            ds.b    10
PATCONVERT:
            link.w  A6,#-$40
            movem.l D3-D7/A0/A2-A4,-(SP)
            move.l  SP,(-4,A6)
            bsr.l   GetDevPix
            move.w  ($20,A0),D6
            ext.l   D6
            movea.l (8,A6),A4
            movea.l (A4),A1
            move.w  (A1),D0
            bmi.b   .L1
            movea.l ($10,A1),A0
            movea.l (A0),A0
            clr.w   ($A,A0)
            cmpi.w  #2,D0
            bne.b   .L1
            move.l  A4,-(SP)
            jsr     ([$1A50.w])
            movea.l (A4),A1
.L1:
            movea.l (2,A1),A3
            movea.l (A3),A0
            move.w  ($20,A0),D7
            ext.l   D7
            move.w  (4,A0),D0
            andi.w  #$7FFF,D0
            move.w  D0,(-$E,A6)
            clr.w   (-$A,A6)
            clr.w   (-$C,A6)
            lea     ($C,A0),A2
            move.w  (A2),D4
            move.w  -(A2),D3
            sub.w   -(A2),D4
            sub.w   -(A2),D3
            move.w  D4,D0
            subq.w  #1,D0
            move.w  D0,(-6,A6)
            move.w  D3,D0
            subq.w  #1,D0
            move.w  D0,(-8,A6)
            move.w  (A1),D0
            bpl.b   .L2
            lsr.w   #3,D4
            mulu.w  D6,D4
            bra.b   .L6
.L2:
            movea.l ($10,A1),A2
            movea.l (A2),A2
            mulu.w  D6,D4
            moveq   #$20,D0
            divu.w  D4,D0
            subq.w  #1,D0
            bmi.b   .L3
            move.w  D0,(-$A,A6)
            clr.w   (A2)
            moveq   #4,D4
            moveq   #$10,D0
            divu.w  D3,D0
            cmpi.w  #1,D0
            blt.b   .L4
            mulu.w  D0,D3
            subq.w  #1,D0
            move.w  D0,(-$C,A6)
            bra.b   .L5
.L3:
            lsr.w   #3,D4
.L4:
            move.w  D4,(A2)
.L5:
            move.w  D4,D0
            subq.w  #1,D0
            andi.w  #$FFFC,D0
            move.w  D0,(2,A2)
            move.w  D4,D0
            mulu.w  D3,D0
            subq.w  #1,D0
            move.w  D0,(4,A2)
.L6:
            move.w  D4,D0
            mulu.w  D3,D0
            movea.l (A4),A0
            movea.l ($A,A0),A0
            jsr     RSetHSize
            cmpi.w  #8,D7
            bgt.b   .L12
            move.l  (A3),-(SP)
            move.w  #$20,-(SP)
            jsr     ([$1A38.w])
            movea.l (A4),A1
            movea.l ([$A.w,A1]),A2
            moveq   #0,D5
.L7:
            movea.l (A4),A1
            movea.l ([6.w,A1]),A3
            move.w  (-8,A6),D3
.L8:
            move.w  (-$A,A6),D2
.L9:
            moveq   #0,D4
            move.w  (-6,A6),D1
.L10:
            bfextu  (A3){D4:D7},D0
            move.l  (0,SP,D0.w*4),D0
            bfins   D0,(A2){D5:D6}
            add.l   D7,D4
            add.l   D6,D5
            dbra    D1,.L10
            dbra    D2,.L9
            adda.w  (-$E,A6),A3
            dbra    D3,.L8
            subq.w  #1,(-$C,A6)
            bpl.b   .L7
.L11:
            movea.l (-4,A6),SP
            movem.l (SP)+,D3-D7/A0/A2-A4
            unlk    A6
            rtd     #4
.L12:
            movea.l (A4),A0
            movea.l (6,A0),A0
            movea.l (A0),A0
            movea.l (A3),A1
            move.l  A0,(A1)
            bsr.l   GetDevPix
            lea     (-$40,A6),A1
            moveq   #$18,D0
.L13:
            move.w  (A0)+,(A1)+
            dbra    D0,.L13
            lea     (-$3A,A6),A0
            clr.l   (A0)+
            move.w  (-8,A6),(A0)
            addq.w  #1,(A0)+
            move.w  (-6,A6),(A0)
            addq.w  #1,(A0)
            movea.l (A4),A1
            movea.l ($A,A1),A0
            movea.l (A0),A0
            move.l  A0,(-$40,A6)
            ori.w   #$8000,D4
            move.w  D4,(-$3C,A6)
            movea.l (A3),A0
            move.l  (A3),-(SP)
            clr.l   -(SP)
            pea     (-$40,A6)
            pea     (6,A0)
            pea     (-$3A,A6)
            pea     (-$3A,A6)
            clr.w   -(SP)
            btst    #1,(1,A1)
            beq.b   .L14
            addi.w  #$40,(SP)
.L14:
            clr.l   -(SP)
            movea.l (A5),A0
            move.l  (-$82,A0),-(SP)
            move.l  (SP),-(SP)
            move.l  (SP),-(SP)
            st      -(SP)
            jsr     ([$1A9C.w])
            movea.l (A4),A1
            movea.l ([$A.w,A1]),A2
            move.w  (-6,A6),D7
            addq.w  #1,D7
            mulu.w  D6,D7
            andi.w  #$7FFF,(-$3C,A6)
            move.w  (-8,A6),D3
.L15:
            moveq   #0,D5
            move.l  D7,D4
            move.w  (-$A,A6),D2
            bra.b   .L18
.L16:
            move.w  (-6,A6),D1
.L17:
            bfextu  (A2){D5:D6},D0
            bfins   D0,(A2){D4:D6}
            add.l   D6,D4
            add.l   D6,D5
            dbra    D1,.L17
.L18:
            dbra    D2,.L16
            adda.w  (-$3C,A6),A2
            dbra    D3,.L15
            movea.l ([$A.w,A1]),A0
            move.w  (-$3C,A6),D1
            move.w  (-8,A6),D2
            addq.w  #1,D2
            mulu.w  D2,D1
            lsr.l   #2,D1
            subq.w  #1,D1
            move.w  (-$C,A6),D2
            bra.b   .L21
.L19:
            move.w  D1,D0
.L20:
            move.l  (A0)+,(A2)+
            dbra    D0,.L20
.L21:
            dbra    D2,.L19
            bra.w   .L11
            ds.b    8
MAKESCALETBL:
            movea.l (SP)+,A0
            move.w  (SP)+,D2
            movea.l (SP)+,A1
            move.w  ($20,A1),D1
            moveq   #1,D0
            lsl.w   D1,D0
            move.w  D0,D1
            subq.w  #1,D0
.L1:
            move.l  #$7FFFFFFF,-(SP)
            dbra    D0,.L1
            move.l  A0,-(SP)
            movem.l D3-D7/A2,-(SP)
            move.w  D2,D7
            moveq   #0,D5
            move.w  D1,D5
            subq.w  #6,SP
            clr.w   -(SP)
            moveq   #-1,D6
            move.l  ($2A,A1),D0
            beq.b   .L6
            movea.l D0,A2
            move.w  ([A2],6.w),D4
            move.w  ([A2],4.w),D3
            btst    #$E,D3
            bne.b   .L4
            moveq   #0,D6
            move.w  D4,D6
.L2:
            movea.l (A2),A0
            move.w  D4,D3
            tst.w   (4,A0)
            bmi.b   .L3
            move.w  (8,A0,D4.w*8),D3
.L3:
            move.w  ($A,A0,D4.w*8),(2,SP)
            move.l  ($C,A0,D4.w*8),(4,SP)
            clr.l   -(SP)
            pea     (6,SP)
            jsr     ([$16CC.w])
            move.l  (SP)+,D0
            move.l  D0,($24,SP,D3.w*4)
            dbra    D4,.L2
            bra.b   .L6
.L4:
            moveq   #0,D6
            move.w  D4,D6
.L5:
            movea.l (A2),A0
            move.w  D4,D3
            move.w  (8,A0,D4.w*8),(SP)
            move.w  ($A,A0,D4.w*8),(2,SP)
            move.l  ($C,A0,D4.w*8),(4,SP)
            clr.l   -(SP)
            pea     (4,SP)
            jsr     ([$1C48.w])
            move.l  (SP)+,D0
            move.l  D0,($24,SP,D3.w*4)
            dbra    D4,.L5
.L6:
            addq.l  #1,D6
            sub.l   D5,D6
            neg.l   D6
            ble.w   .L13
            moveq   #-1,D0
            move.l  D0,-(SP)
            move.w  D0,-(SP)
            clr.l   -(SP)
            clr.w   -(SP)
            btst    #5,D7
            beq.b   .L7
            pea     (6,SP)
            jsr     ([$1668.w])
            move.l  SP,-(SP)
            jsr     ([$1664.w])
.L7:
            movea.l SP,A1
            movea.l A1,A2
            moveq   #2,D0
.L8:
            move.w  #$8000,-(SP)
            move.w  (A1)+,-(SP)
            dbra    D0,.L8
            movea.l A2,A1
            lea     ($3C,SP,D5.w*4),A2
            subq.w  #1,D6
            beq.b   .L12
            lea     (6,A1),A0
            moveq   #2,D0
.L9:
            moveq   #0,D1
            move.w  (A0)+,D1
            sub.w   (A1)+,D1
            scs     D7
            bcc.b   .L10
            neg.w   D1
.L10:
            swap    D1
            divu.l  D6,D1
            tst.b   D7
            beq.b   .L11
            neg.l   D1
.L11:
            move.l  D1,-(SP)
            dbra    D0,.L9
            movem.l (SP)+,D3-D5
.L12:
            cmpi.l  #$7FFFFFFF,-(A2)
            bne.b   .L12
            move.w  (8,SP),($C,SP)
            move.w  (4,SP),($E,SP)
            move.w  (SP),($10,SP)
            clr.l   -(SP)
            pea     ($10,SP)
            jsr     ([$16CC.w])
            move.l  (SP)+,D0
            move.l  D0,(A2)
            movem.l (SP)+,D0-D2
            add.l   D3,D0
            add.l   D4,D1
            add.l   D5,D2
            movem.l D0-D2,-(SP)
            dbra    D6,.L12
            lea     ($18,SP),SP
.L13:
            movem.l (SP)+,D0-D1/D3-D7/A2
            rts
            dc.w    0
PATDITHER:
            link.w  A6,#-$1E
            movem.l A4,-(SP)
            movea.l (8,A6),A0
            movea.l (A0),A2
            cmpi.w  #2,(A2)
            bne.w   hocuspocus.L4
            movea.l (2,A2),A0
            movea.l (A0),A0
            movea.l ($2A,A0),A0
            movea.l (A0),A0
            lea     ($28,A0),A0
            lea     (-$C,A6),A2
            move.l  (2,A0),(A2)+
            move.w  (6,A0),(A2)
            clr.l   -(SP)
            pea     (-$C,A6)
            jsr     ([$16CC.w])
            pea     (-6,A6)
            jsr     ([$16D0.w])
            move.w  (-$C,A6),D0
            move.w  (-6,A6),D1
            bsr.b   hocuspocus
            move.w  D0,(-$1E,A6)
            move.w  (-$A,A6),D0
            move.w  (-4,A6),D1
            bsr.b   hocuspocus
            move.w  D0,(-$1C,A6)
            move.w  (-8,A6),D0
            move.w  (-2,A6),D1
            bsr.b   hocuspocus
            move.w  D0,(-$1A,A6)
            clr.l   -(SP)
            pea     (-$1E,A6)
            jsr     ([$16CC.w])
            pea     (-$18,A6)
            jsr     ([$16D0.w])
            move.w  (-$1E,A6),D0
            move.w  (-$18,A6),D1
            bsr.b   hocuspocus
            move.w  D0,(-$18,A6)
            move.w  (-$1C,A6),D0
            move.w  (-$16,A6),D1
            bsr.b   hocuspocus
            move.w  D0,(-$16,A6)
            move.w  (-$1A,A6),D0
            move.w  (-$14,A6),D1
            bsr.b   hocuspocus
            move.w  D0,(-$14,A6)
            clr.l   -(SP)
            pea     (-$18,A6)
            jsr     ([$16CC.w])
            pea     (-$12,A6)
            jsr     ([$16D0.w])
            bra.b   hocuspocus.L3
hocuspocus:
            add.w   D0,D0
            bcs.b   .L1
            sub.w   D1,D0
            bcc.b   .L2
            moveq   #0,D0
            rts
.L1:
            sub.w   D1,D0
            bcs.b   .L2
            moveq   #-1,D0
.L2:
            rts
.L3:
            move.w  (-$18,A6),D0
            move.w  (-$12,A6),D1
            bsr.b   hocuspocus
            move.w  D0,(-$12,A6)
            move.w  (-$16,A6),D0
            move.w  (-$10,A6),D1
            bsr.b   hocuspocus
            move.w  D0,(-$10,A6)
            move.w  (-$14,A6),D0
            move.w  (-$E,A6),D1
            bsr.b   hocuspocus
            move.w  D0,(-$E,A6)
            clr.l   -(SP)
            pea     (-$12,A6)
            jsr     ([$16CC.w])
            pea     (-$12,A6)
            jsr     ([$16D0.w])
            movea.l (8,A6),A2
            movea.l (A2),A2
            movea.l (2,A2),A2
            movea.l (A2),A2
            movea.l ($2A,A2),A2
            movea.l (A2),A2
            lea     (8,A2),A2
            clr.w   (A2)+
            move.l  (-6,A6),(A2)+
            move.w  (-2,A6),(A2)+
            move.w  #1,(A2)+
            move.l  (-$12,A6),(A2)+
            move.w  (-$E,A6),(A2)+
            move.w  #2,(A2)+
            move.l  (-$18,A6),(A2)+
            move.w  (-$14,A6),(A2)+
            move.w  #3,(A2)+
            move.l  (-$1E,A6),(A2)+
            move.w  (-$1A,A6),(A2)+
.L4:
            movem.l (SP)+,A4
            unlk    A6
            rts
            ds.b    6
MAKERGBPAT:
            link.w  A6,#0
            movem.l A2-A3,-(SP)
            movea.l ($C,A6),A1
            movea.l (A1),A0
            move.w  #2,(A0)
            move.w  #$FFFF,($E,A0)
            move.l  #$AA55AA55,D0
            move.l  D0,($14,A0)
            move.l  D0,($18,A0)
            movea.l (2,A0),A3
            movea.l (A3),A0
            movea.l ($2A,A0),A0
            moveq   #$30,D0
            jsr     RSetHSize
            movea.l (A0),A0
            clr.l   -(SP)
            jsr     ([$16A0.w])
            move.l  (SP)+,(A0)
            clr.w   (4,A0)
            move.w  #4,(6,A0)
            lea     ($28,A0),A0
            movea.l (8,A6),A2
            move.w  #4,(A0)+
            move.l  (A2)+,(A0)+
            move.w  (A2)+,(A0)
            movea.l (A1),A0
            movea.l (6,A0),A0
            moveq   #$10,D0
            jsr     RSetHSize
            movea.l (A0),A0
            move.l  #$1111BBBB,D0
            move.l  D0,(A0)+
            move.l  D0,(A0)+
            move.l  D0,(A0)+
            move.l  D0,(A0)+
            movea.l (A3),A2
            move.l  ($2A,A2),-(SP)
            lea     OneBitData,A1
            jsr     COPYPMAP
            movea.l (A3),A2
            move.l  (SP)+,($2A,A2)
            move.w  #2,(4,A2)
            clr.l   (6,A2)
            move.l  #$80008,($A,A2)
            move.w  #2,($20,A2)
            move.w  #2,($24,A2)
            movem.l (SP)+,A2-A3
            unlk    A6
            rtd     #8
            ds.b    12
GetCIcon:
            link.w  A6,#0
            movem.l D3-D4/A2-A4,-(SP)
            clr.l   ($A,A6)
            subq.w  #4,SP
            move.l  #'cicn',-(SP)
            move.w  (8,A6),-(SP)
            jsr     ([$1480.w])
            movea.l (SP)+,A0
            move.l  A0,D0
            beq.w   .L1
            jsr     ([$1584.w])
            movea.l A0,A4
            _HLock
            movea.l (A4),A3
            move.w  ($A,A3),D4
            sub.w   (6,A3),D4
            lea     ($52,A3),A2
            move.w  ($36,A3),D0
            mulu.w  D4,D0
            adda.w  D0,A2
            move.w  ($44,A3),D0
            mulu.w  D4,D0
            adda.w  D0,A2
            clr.l   -(SP)
            jsr     ([$16A0.w])
            move.l  (SP)+,(A2)
            movea.l A2,A0
            move.w  (6,A2),D0
            addq.w  #1,D0
            mulu.w  #8,D0
            addq.w  #8,D0
            ext.l   D0
            move.l  D0,D3
            jsr     ([$158C.w])
            bne.w   .L1
            move.l  A0,($2A,A3)
            movea.l A2,A0
            adda.l  D3,A0
            move.w  (4,A3),D0
            andi.w  #$7FFF,D0
            mulu.w  D4,D0
            mulu.w  ($20,A3),D0
            jsr     ([$158C.w])
            bne.w   .L1
            move.l  A0,($4E,A3)
            movea.l A4,A0
            _HUnlock
            move.l  A2,D0
            sub.l   A3,D0
            movea.l A4,A0
            jsr     RSetHSize
            move.l  A4,($A,A6)
.L1:
            movem.l (SP)+,D3-D4/A2-A4
            unlk    A6
            rtd     #2
            ds.b    12
PlotCIcon:
            link.w  A6,#-$70
            movem.l D3/A2-A4,-(SP)
            pea     (-6,A6)
            jsr     ([$1664.w])
            pea     (-$C,A6)
            jsr     ([$1668.w])
            moveq   #$21,D0
            move.l  D0,-(SP)
            jsr     ([$F88.w])
            moveq   #$1E,D0
            move.l  D0,-(SP)
            jsr     ([$F8C.w])
            movea.l (8,A6),A4
            movea.l A4,A0
            _HLock
            movea.l (A4),A3
            move.w  ($A,A3),D3
            sub.w   (6,A3),D3
            lea     ($52,A3),A0
            move.l  A0,($32,A3)
            move.w  ($36,A3),D0
            mulu.w  D3,D0
            adda.l  D0,A0
            move.l  A0,($40,A3)
            movea.l ($4E,A3),A0
            _HLock
            movea.l (A0),A0
            move.l  A0,(A3)
            movea.l (A5),A0
            movea.l (A0),A0
            lea     (2,A0),A1
            lea     (-$5A,A6),A2
            jsr     ([$1A08.w])
            move.w  (-$3A,A6),D0
            suba.l  A0,A0
            move.w  D2,D3
            beq.b   .L2
            movea.l DeviceList,A2
            movea.l (A2),A1
            tst.l   ($1E,A1)
            beq.b   .L2
            movea.l ($C,A6),A0
            lea     (-$62,A6),A1
            move.l  (A0)+,(A1)+
            move.l  (A0),(A1)+
            move.l  (-$54,A6),D0
            move.w  D0,D1
            swap    D0
            sub.w   D1,-(A1)
            sub.w   D0,-(A1)
            sub.w   D1,-(A1)
            sub.w   D0,-(A1)
            lea     (-$6C,A6),A0
            move.l  A0,(-$70,A6)
            move.w  #$A,(A0)
.L1:
            movea.l (A2),A0
            tst.w   ($14,A0)
            bpl.b   .L5
            clr.b   -(SP)
            pea     (-$62,A6)
            pea     ($22,A0)
            pea     (-$6A,A6)
            jsr     ([$10A8.w])
            tst.b   (SP)+
            beq.b   .L5
            move.l  (-$54,A6),D0
            move.w  D0,D1
            swap    D0
            lea     (-$6A,A6),A0
            add.w   D0,(A0)+
            add.w   D1,(A0)+
            add.w   D0,(A0)+
            add.w   D1,(A0)
            movea.l (A2),A0
            movea.l ($16,A0),A0
            movea.l (A0),A0
            move.w  ($20,A0),D0
            lea     (-$70,A6),A0
.L2:
            lea     ($40,A3),A1
            tst.w   (4,A1)
            beq.b   .L3
            cmpi.w  #2,D0
            ble.b   .L4
.L3:
            movea.l A3,A1
.L4:
            move.l  A1,-(SP)
            pea     ($32,A3)
            pea     (-$5A,A6)
            pea     (6,A1)
            pea     ($38,A3)
            move.l  ($C,A6),-(SP)
            bsr.w   COPYCICON
            tst.w   D3
            beq.b   .L6
.L5:
            movea.l (A2),A0
            move.l  ($1E,A0),D0
            movea.l D0,A2
            bne.b   .L1
.L6:
            movea.l ($4E,A3),A0
            _HUnlock
            movea.l A4,A0
            _HUnlock
            pea     (-6,A6)
            jsr     ([$1650.w])
            pea     (-$C,A6)
            jsr     ([$1654.w])
            movem.l (SP)+,D3/A2-A4
            unlk    A6
            rtd     #8
            ds.b    10
DisposCIcon:
            movea.l (SP)+,A1
            movea.l (SP),A0
            movea.l (A0),A0
            move.l  ($2A,A0),-(SP)
            movea.l ($4E,A0),A0
            _DisposHandle
            movea.l (SP)+,A0
            _DisposHandle
            movea.l (SP)+,A0
            _DisposHandle
            jmp     (A1)
            ds.b    6
NewHandle:
            moveq   #0,D0
            movea.l (SP)+,A1
            move.w  (SP)+,D0
            bne.b   .L1
            moveq   #2,D0
.L1:
            _NewHandleClear
            bne.b   .L2
            move.l  A0,(SP)
            jmp     (A1)
.L2:
            moveq   #$19,D0
            jsr     ([$1524.w])
JACKSONPOLLOCK:
            _Debugger
RNewHandle:
            _NewHandleClear
            bne.b   NewHandle.L2
            rts
SetHSize:
            moveq   #0,D0
            movea.l (SP)+,A1
            move.w  (SP)+,D0
            movea.l (SP)+,A0
            _SetHandleSize
            bne.b   NewHandle.L2
            jmp     (A1)
RSetHSize:
            _SetHandleSize
            bne.b   NewHandle.L2
            rts
            ds.b    10
NEWTEMPHANDLE:
            movem.l D1-D3,-(SP)
            move.l  D0,D3
            move.l  ($107C).w,D0
            cmp.l   ($103C).w,D0
            bne.b   .L1
            moveq   #0,D0
            movea.l D0,A0
            bra.b   .L2
.L1:
            clr.l   -(SP)
            move.l  D3,-(SP)
            pea     MemErr
            move.w  #$1D,-(SP)
            _OSDispatch
            move.l  (SP)+,D0
            movea.l D0,A0
            beq.b   .L2
            move.l  D3,D0
.L2:
            movem.l (SP)+,D1-D3
            rts
            ds.b    14
NewTempBuffer:
            movem.l D1-D3,-(SP)
            move.l  D0,D3
            move.l  ($107C).w,D0
            cmp.l   ($103C).w,D0
            beq.b   .L5
            clr.l   -(SP)
            move.l  D3,-(SP)
            pea     MemErr
            move.w  #$1D,-(SP)
            _OSDispatch
            move.l  (SP)+,D0
            beq.b   .L3
.L1:
            move.l  D0,-(SP)
            move.l  D0,-(SP)
            pea     MemErr
            move.w  #$1E,-(SP)
            _OSDispatch
            movea.l (SP)+,A0
            move.l  D3,D0
.L2:
            movem.l (SP)+,D1-D3
            rts
.L3:
            clr.l   -(SP)
            clr.l   -(SP)
            pea     (4,SP)
            move.w  #$15,-(SP)
            _OSDispatch
            move.l  (SP)+,D3
            addq.w  #4,SP
            tst.l   D3
            ble.b   .L5
.L4:
            clr.l   -(SP)
            move.l  D3,-(SP)
            pea     MemErr
            move.w  #$1D,-(SP)
            _OSDispatch
            move.l  (SP)+,D0
            bne.b   .L1
            subi.l  #$1000,D3
            bgt.b   .L4
.L5:
            moveq   #0,D0
            movea.l D0,A0
            bra.b   .L2
DisposeTempBuffer:
            move.l  A0,D0
            beq.b   .L1
            move.l  A0,-(SP)
            pea     MemErr
            move.w  #$20,-(SP)
            _OSDispatch
.L1:
            rts
            ds.b    14
InitGraf:
            link.w  A6,#0
            movem.l D2/A2/A4,-(SP)
            movea.l (8,A6),A4
            move.l  A4,(A5)
            clr.b   QDExist
            jsr     ([$F48.w])
            lea     (-$CA,A4),A0
            lea     (4,A4),A1
.L1:
            clr.w   (A0)+
            cmpa.l  A1,A0
            bne.b   .L1
            move.w  #1,(-$9E,A4)
            lea     (-$90,A4),A4
            move.l  A4,D0
            move.w  #$A,(A4)+
            move.l  #$80018001,(A4)+
            move.l  #$7FFF7FFF,(A4)+
            move.l  A4,D1
            move.l  D0,(A4)+
            move.l  D1,(A4)+
            moveq   #1,D0
            move.l  D0,(A4)+
            move.l  A4,-(SP)
            _ScrnBitMap
            lea     ($E,A4),A4
            moveq   #$1A,D0
            lea     .L7,A0
.L2:
            move.l  (A0)+,(A4)+
            dbra    D0,.L2
            move.l  #$60082,D0
            lea     ($DA0).w,A0
            _ReadXPRam
            bsr.l   CheckDevices
            movea.l MainDevice,A0
            move.l  A0,TheGDevice
            move.l  A0,SrcDevice
            move.l  QDColors,D0
            movea.l D0,A0
            bgt.b   .L4
            subq.w  #4,SP
            move.w  #$7F,-(SP)
            jsr     ([$1660.w])
            moveq   #$40,D0
            _NewPtrSysClear
            move.l  A0,QDColors
            movea.l (SP),A1
            movea.l (A1),A1
            addq.w  #8,A1
            moveq   #$F,D0
.L3:
            move.l  (A1)+,(A0)+
            dbra    D0,.L3
            jsr     ([$1690.w])
.L4:
            movea.l QDColors,A0
            cmpi.w  #$64AF,($2C,A0)
            bne.b   .L5
            move.w  #$8000,($2C,A0)
.L5:
            moveq   #-1,D0
            movea.l PortList,A0
            cmp.l   A0,D0
            bne.b   .L6
            moveq   #2,D0
            jsr     RNewHandle
            move.l  A0,PortList
.L6:
            bsr.l   GetDevPix
            movea.l A0,A4
            movea.l (A5),A1
            lea     (-$7A,A1),A1
            move.l  (A0)+,(A1)+
            move.w  (A0)+,D2
            andi.w  #$7FFF,D2
            move.w  ($20,A4),D1
            move.w  D2,D0
            ext.l   D0
            divu.w  D1,D0
            move.w  D0,(A1)+
            move.l  (A0)+,(A1)+
            move.l  (A0)+,(A1)+
            jsr     ([$1674.w])
            move.l  TheGDevice,LastTxGDevice
            jsr     ([$11F8.w])
            jsr     ([$F4C.w])
            movem.l (SP)+,D2/A2/A4
            unlk    A6
            rtd     #4
.L7:
            dc.w    0,$4000,$6000,$7000,$7800,$7C00,$7E00,$7F00
            dc.w    $7F80,$7C00,$6C00,$4600,$0600,$0300,$0300,0
            dc.w    $C000,$E000,$F000,$F800,$FC00,$FE00,$FF00,$FF80
            dc.w    $FFC0,$FFE0,$FE00,$EF00,$CF00,$8780,$0780,$0380
            dc.w    $0001,$0001,$77DD,$77DD,$77DD,$77DD,$8822,$8822
            dc.w    $8822,$8822,$AA55,$AA55,$AA55,$AA55,$FFFF,$FFFF
            dc.w    $FFFF,$FFFF
            ds.b    16
NewPort:
            clr.l   -(SP)
            jsr     ([$1160.w])
            clr.l   -(SP)
            jsr     ([$1160.w])
            movea.l ($C,SP),A0
            move.l  (SP)+,($1C,A0)
            move.l  (SP)+,($18,A0)
            move.l  (SP)+,(SP)
            rts
OpenPort:
            move.l  (4,SP),-(SP)
            move.l  (SP),-(SP)
            jsr     NewPort
            jsr     InsPortList
InitPort:
            move.l  A2,-(SP)
            movea.l (8,SP),A2
            movea.l (A5),A0
            lea     (-$7A,A0),A0
            lea     (2,A2),A1
            move.l  (A0)+,(A1)+
            move.w  (A0)+,(A1)+
            move.l  (A0),(A1)+
            move.l  (4,A0),(A1)+
            jsr     InitShared
            lea     ($20,A2),A1
            clr.l   (A1)+
            clr.l   (A1)+
            moveq   #-1,D0
            move.l  D0,(A1)+
            move.l  D0,(A1)+
            lea     ($3A,A2),A1
            move.l  D0,(A1)+
            move.l  D0,(A1)+
            lea     ($50,A2),A1
            move.l  #$21,(A1)+
            move.l  #$1E,(A1)+
            movea.l (SP)+,A2
            move.l  (SP)+,(SP)
            rts
            ds.b    8
InitShared:
            movea.l (A5),A0
            move.l  A2,(A0)
            clr.w   (A2)
            lea     (-$74,A0),A0
            lea     ($10,A2),A1
            move.l  (A0),(A1)+
            move.l  (4,A0),(A1)+
            move.l  (A1)+,-(SP)
            move.l  A0,-(SP)
            jsr     ([$117C.w])
            movea.l (A5),A0
            move.l  (-$82,A0),-(SP)
            move.l  ($1C,A2),-(SP)
            jsr     ([$1170.w])
            lea     ($30,A2),A1
            clr.l   (A1)+
            move.l  #$10001,(A1)+
            move.w  #8,(A1)+
            lea     ($42,A2),A1
            clr.w   (A1)+
            clr.l   (A1)+
            move.w  #1,(A1)+
            clr.w   (A1)+
            clr.l   (A1)+
            lea     ($58,A2),A1
            clr.l   (A1)+
            clr.l   (A1)+
            clr.l   (A1)+
            clr.l   (A1)+
            clr.l   (A1)+
            rts
            dc.w    0
SetStdProcs:
            movea.l (SP)+,A0
            movea.l (SP)+,A1
            move.l  JStdTEXT,(A1)+
            move.l  ($1040).w,(A1)+
            move.l  ($1080).w,(A1)+
            move.l  ($10BC).w,(A1)+
            move.l  ($10D8).w,(A1)+
            move.l  ($10F4).w,(A1)+
            move.l  ($1114).w,(A1)+
            move.l  ($1144).w,(A1)+
            move.l  ($11AC).w,(A1)+
            move.l  ($11C4).w,(A1)+
            move.l  ($11B4).w,(A1)+
            move.l  ($11B8).w,(A1)+
            move.l  ($11C0).w,(A1)+
            jmp     (A0)
            ds.b    6
SetStdCProcs:
            move.l  (4,SP),-(SP)
            jsr     ([$11A8.w])
            movea.l (SP)+,A0
            movea.l (SP)+,A1
            lea     ($34,A1),A1
            move.l  ($1DE0).w,(A1)+
            moveq   #5,D0
.L1:
            clr.l   (A1)+
            dbra    D0,.L1
            jmp     (A0)
LocalToGlobal:
            movem.l D0-D2/A0-A1,-(SP)
            moveq   #1,D2
            bra.b   GlobalToLocal.L1
GlobalToLocal:
            movem.l D0-D2/A0-A1,-(SP)
            moveq   #0,D2
.L1:
            movea.l (A5),A0
            movea.l (A0),A0
            jsr     ([$1A5C.w])
            movea.l ($18,SP),A1
            move.w  (6,A0),D0
            move.w  (8,A0),D1
            bsr.b   ADDSUB
            movem.l (SP)+,D0-D2/A0-A1
            bra.b   SubPt.L2
ADDSUB:
            tst.w   D2
            beq.b   .L1
            neg.w   D0
            neg.w   D1
.L1:
            add.w   D0,(A1)+
            add.w   D1,(A1)+
            rts
AddPt:
            movem.l D0-D2/A1,-(SP)
            moveq   #0,D2
            bra.b   SubPt.L1
SubPt:
            movem.l D0-D2/A1,-(SP)
            moveq   #1,D2
.L1:
            movea.l ($14,SP),A1
            move.w  ($18,SP),D0
            move.w  ($1A,SP),D1
            bsr.b   ADDSUB
            movem.l (SP)+,D0-D2/A1
            move.l  (SP)+,(SP)
.L2:
            move.l  (SP)+,(SP)
            rts
SetPort:
            movea.l (A5),A0
            move.l  (4,SP),(A0)
            bra.b   SubPt.L2
GetPort:
            movea.l (A5),A0
            movea.l (4,SP),A1
            move.l  (A0),(A1)
            bra.b   SubPt.L2
            ds.b    14
GrafDevice:
            moveq   #0,D0
            jmp     PortWord
            ds.b    10
SetPortBits:
            movea.l (A5),A0
            movea.l (A0),A0
            lea     (2,A0),A0
            tst.w   (4,A0)
            bmi.b   .L2
            movea.l (4,SP),A1
            move.l  (A1)+,(A0)+
            move.w  (A1)+,(A0)+
.L1:
            move.l  (A1)+,(A0)+
            move.l  (A1)+,(A0)+
.L2:
            move.l  (SP)+,(SP)
            rts
BackPat:
            movea.l (A5),A0
            movea.l (A0),A0
            tst.w   (6,A0)
            bmi.b   .L1
            lea     ($20,A0),A0
            movea.l (4,SP),A1
            bra.b   SetPortBits.L1
.L1:
            move.l  (4,SP),-(SP)
            pea     ($20,A0)
            jsr     ([$1A44.w])
            bra.b   SetPortBits.L2
            ds.b    14
PortSize:
            movea.l (A5),A0
            movea.l (A0),A0
            move.w  ($12,A0),D0
            add.w   (6,SP),D0
            move.w  D0,($16,A0)
            move.w  ($10,A0),D0
            add.w   (4,SP),D0
            move.w  D0,($14,A0)
            move.l  (SP)+,(SP)
            rts
MovePortTo:
            movea.l (A5),A0
            movea.l (A0),A0
            move.w  ($12,A0),D0
            move.w  ($10,A0),D1
            jsr     ([$1A5C.w])
            sub.w   (8,A0),D0
            sub.w   (6,SP),D0
            sub.w   (6,A0),D1
            sub.w   (4,SP),D1
            move.l  (SP)+,(SP)
sub_40831924:
            addq.w  #6,A0
OFSRECT:
            add.w   D1,(A0)+
            add.w   D0,(A0)+
            add.w   D1,(A0)+
            add.w   D0,(A0)+
            rts
SetOrigin:
            movea.l (A5),A0
            movea.l (A0),A0
            move.l  (4,SP),D0
            cmp.l   ($10,A0),D0
            beq.b   .L1
            move.w  (6,SP),D0
            sub.w   ($12,A0),D0
            move.w  (4,SP),D1
            sub.w   ($10,A0),D1
            move.l  ($18,A0),-(SP)
            move.w  D0,-(SP)
            move.w  D1,-(SP)
            pea     ($10,A0)
            jsr     ([$1A5C.w])
            bsr.b   sub_40831924
            movea.l (SP)+,A0
            bsr.b   OFSRECT
            jsr     ([$1180.w])
.L1:
            move.l  (SP)+,(SP)
            rts
ClipRect:
            movea.l (A5),A0
            movea.l (A0),A0
            move.l  ($1C,A0),-(SP)
            move.l  (8,SP),-(SP)
            jsr     ([$117C.w])
            bra.b   SetOrigin.L1
            ds.b    12
SetClip:
            movea.l (SP)+,A0
            movea.l (A5),A1
            movea.l (A1),A1
            move.l  ($1C,A1),-(SP)
            bra.b   GetClip.L1
GetClip:
            movea.l (SP)+,A0
            move.l  (SP)+,D0
            movea.l (A5),A1
            movea.l (A1),A1
            move.l  ($1C,A1),-(SP)
            move.l  D0,-(SP)
.L1:
            move.l  A0,-(SP)
            jmp     CopyRgn
SetPt:
            movea.l (SP)+,A0
            move.l  (SP)+,D0
            movea.l (SP)+,A1
            move.l  D0,(A1)
            jmp     (A0)
            ds.b    6
EqualPt:
            movea.l (SP)+,A0
            move.l  (SP)+,D0
            cmp.l   (SP)+,D0
            seq     (SP)
            neg.b   (SP)
            jmp     (A0)
            ds.b    4
InsPortList:
            clr.l   -(SP)
            move.l  PortList,-(SP)
            moveq   #2,D0
            move.l  D0,-(SP)
            clr.l   -(SP)
            clr.l   -(SP)
            pea     ($18,SP)
            moveq   #4,D0
            move.l  D0,-(SP)
            jsr     ([$1580.w])
            move.l  (SP)+,D0
            movea.l PortList,A0
            movea.l (A0),A0
            addq.w  #1,(A0)
            move.l  (SP)+,(SP)
            rts
            ds.b    6
DelPortList:
            movea.l PortList,A0
            movea.l (A0),A0
            tst.w   (A0)
            beq.b   .L1
            subq.w  #1,(A0)
            clr.l   -(SP)
            move.l  PortList,-(SP)
            moveq   #2,D0
            move.l  D0,-(SP)
            pea     ($10,SP)
            moveq   #4,D0
            move.l  D0,-(SP)
            pea     .L1
            clr.l   -(SP)
            jsr     ([$1580.w])
            move.l  (SP)+,D0
.L1:
            move.l  (SP)+,(SP)
            rts
StdComment:
            link.w  A6,#0
            movem.l D6-D7,-(SP)
            movea.l (A5),A0
            movea.l (A0),A0
            tst.l   ($5C,A0)
            beq.b   .L2
            move.w  ($E,A6),D6
            move.w  ($C,A6),D7
            bgt.b   .L1
            move.w  #$A0,D0
            jsr     DPutPicOp
            move.w  D6,-(SP)
            jsr     PutPicWord
            bra.b   .L2
.L1:
            move.w  #$A1,D0
            jsr     DPutPicOp
            move.w  D6,-(SP)
            jsr     PutPicWord
            move.w  D7,-(SP)
            jsr     PutPicWord
            movea.l (8,A6),A0
            _HLock
            move.l  (A0),-(SP)
            move.w  D7,-(SP)
            jsr     PutPicData
            movea.l (8,A6),A0
            _HUnlock
.L2:
            movem.l (SP)+,D6-D7
            unlk    A6
            rtd     #8
            dc.w    0
StdGetPic:
            movea.l (SP)+,A0
            move.w  (SP)+,D1
            movea.l (SP)+,A1
            move.l  A0,-(SP)
            movea.l (A5),A0
            move.l  (-$B4,A0),D0
            movea.l (-$9C,A0),A0
            movea.l (A0),A0
            adda.l  D0,A0
            bra.b   .L2
.L1:
            move.b  (A0)+,(A1)+
.L2:
            dbra    D1,.L1
            rts
StdPutPic:
            link.w  A6,#0
            movem.l D7/A3-A4,-(SP)
            movea.l (A5),A4
            movea.l (A4),A4
            tst.l   ($5C,A4)
            beq.b   .L4
            movea.l ($5C,A4),A4
            movea.l (A4),A1
            move.l  (8,A1),D7
            beq.b   .L4
            movea.l (A1),A3
            move.w  (8,A6),D0
            ext.l   D0
            add.l   D7,D0
            move.l  D0,(8,A1)
            movea.l (A3),A0
            move.w  D0,(A0)
            cmp.l   (4,A1),D0
            ble.b   .L1
            addi.l  #$200,D0
            move.l  D0,(4,A1)
            movea.l A3,A0
            _SetHandleSize
            movea.l (A4),A1
            beq.b   .L1
            clr.l   (8,A1)
            moveq   #$A,D0
            movea.l A3,A0
            _SetHandleSize
            movea.l (A3),A0
            move.w  #$FFFF,(A0)+
            clr.l   (A0)+
            clr.l   (A0)+
            bra.b   .L4
.L1:
            movea.l (A1),A1
            movea.l (A1),A1
            adda.l  D7,A1
            movea.l ($A,A6),A0
            move.w  (8,A6),D0
            bra.b   .L3
.L2:
            move.b  (A0)+,(A1)+
.L3:
            dbra    D0,.L2
.L4:
            movem.l (SP)+,D7/A3-A4
            unlk    A6
            rtd     #6
            dc.w    0
StdOpcodeProc:
            link.w  A6,#0
            movem.l D6-D7,-(SP)
            move.l  #$100,D6
            suba.l  D6,SP
            move.w  ($A,A6),D0
            bmi.b   .L1
            lsr.w   #8,D0
            add.w   D0,D0
            ext.l   D0
            bra.b   .L2
.L1:
            andi.w  #$7F00,D0
            beq.b   .L5
            jsr     GetLong
.L2:
            move.l  D0,D7
.L3:
            move.w  D6,D0
            cmp.l   D6,D7
            bge.b   .L4
            move.w  D7,D0
.L4:
            move.l  SP,-(SP)
            move.w  D0,-(SP)
            jsr     GetPicData
            sub.l   D6,D7
            bgt.b   .L3
.L5:
            adda.l  D6,SP
            movem.l (SP)+,D6-D7
            unlk    A6
            rtd     #$C
            ds.b    6
PicComment:
            movea.l (A5),A0
            movea.l (A0),A0
            move.l  ($68,A0),D0
            movea.l ($11C4).w,A0
            beq.b   .L1
            movea.l D0,A0
            movea.l ($24,A0),A0
.L1:
            jmp     (A0)
            ds.b    10
OpenCPicture:
            link.w  A6,#-2
            move.w  #$2FF,(-2,A6)
            jmp     OPShare
            dc.w    0
OpenPicture:
            link.w  A6,#-2
            move.w  #1,(-2,A6)
OPShare:
            movem.l D3/A3-A4,-(SP)
            clr.l   ($C,A6)
            movea.l (A5),A4
            movea.l (A4),A3
            tst.l   ($5C,A3)
            bne.w   .L5
            jsr     ([$1058.w])
            tst.w   (6,A3)
            bpl.b   .L1
            move.w  #$2FF,(-2,A6)
            move.l  #$3E8,D0
            _NewHandle
            bne.w   .L5
            _DisposHandle
.L1:
            move.l  #$8C,D0
            _NewHandle
            movea.l A0,A4
            move.l  A4,($5C,A3)
            clr.l   -(SP)
            jsr     ([$1160.w])
            move.l  #$100,D0
            _NewHandle
            movea.l A0,A1
            move.l  A1,($C,A6)
            movea.l (A4),A4
            move.l  A1,(A4)+
            movea.l (A1),A1
            move.w  #$A,(A1)+
            movea.l (8,A6),A0
            move.l  (A0)+,(A1)+
            move.l  (A0)+,(A1)+
            move.l  #$100,(A4)+
            move.l  #$A,(A4)+
            move.l  (SP)+,(A4)+
            clr.l   (A4)+
            clr.l   (A4)+
            clr.l   (A4)+
            move.w  #1,(A4)+
            clr.w   (A4)+
            clr.l   (A4)+
            move.l  #$10001,D0
            move.l  D0,(A4)+
            move.l  D0,(A4)+
            clr.l   (A4)+
            clr.l   (A4)+
            move.l  D0,(A4)+
            move.w  #8,(A4)+
            moveq   #-1,D0
            move.l  D0,(A4)+
            move.l  D0,(A4)+
            move.l  D0,(A4)+
            move.l  D0,(A4)+
            clr.l   (A4)+
            clr.l   (A4)+
            clr.l   (A4)+
            move.l  ($10,A3),(A4)+
            move.l  #$21,(A4)+
            move.l  #$1E,(A4)+
            move.w  (-2,A6),(A4)+
            clr.l   (A4)+
            clr.w   (A4)+
            move.l  D0,(A4)+
            move.w  D0,(A4)+
            move.l  #$8000,(A4)+
            clr.l   (A4)+
            clr.w   (A4)+
            clr.l   (A4)+
            clr.w   (A4)+
            cmpi.w  #1,(-2,A6)
            beq.b   .L3
            moveq   #2,D3
.L2:
            clr.l   -(SP)
            suba.l  ([$5C.w,A3]),A4
            jsr     ([$161C.w])
            movea.l (SP)+,A0
            adda.l  ([$5C.w,A3]),A4
            move.l  A0,(A4)+
            movea.l (A0),A0
            clr.w   (A0)
            dbra    D3,.L2
.L3:
            moveq   #$11,D0
            jsr     DPutPicOp
            move.w  (-2,A6),D0
            cmpi.w  #1,D0
            bne.b   .L4
            jsr     DPutPicByte
            bra.b   .L5
.L4:
            move.w  D0,-(SP)
            jsr     PutPicWord
            move.w  #$C00,D0
            jsr     DPutPicOp
            clr.l   -(SP)
            movea.l (8,A6),A0
            move.l  (4,A0),D0
            clr.w   D0
            move.l  D0,-(SP)
            move.l  (6,A0),D0
            clr.w   D0
            move.l  D0,-(SP)
            move.l  (A0),D0
            clr.w   D0
            move.l  D0,-(SP)
            move.l  (2,A0),D0
            clr.w   D0
            move.l  D0,-(SP)
            moveq   #-1,D0
            move.l  D0,-(SP)
            move.l  SP,-(SP)
            move.w  #$18,-(SP)
            jsr     PutPicData
            lea     ($18,SP),SP
.L5:
            movem.l (SP)+,D3/A3-A4
            unlk    A6
            rtd     #4
            ds.b    4
ClosePicture:
            movem.l D6-D7/A3,-(SP)
            movea.l (A5),A3
            movea.l (A3),A3
            move.l  ($5C,A3),D7
            beq.b   .L3
            move.w  #$FF,-(SP)
            jsr     PutPicOp
            movea.l D7,A0
            movea.l (A0),A0
            move.l  ($C,A0),D6
            move.l  (8,A0),D0
            beq.b   .L1
            movea.l (A0),A0
            _SetHandleSize
.L1:
            movea.l D6,A0
            _DisposHandle
            movea.l D7,A0
            movea.l (A0),A0
            cmpi.w  #1,($62,A0)
            beq.b   .L2
            lea     ($80,A0),A0
            move.l  (A0)+,-(SP)
            move.l  (A0)+,-(SP)
            move.l  (A0)+,-(SP)
            jsr     ([$1620.w])
            jsr     ([$1620.w])
            jsr     ([$1620.w])
.L2:
            movea.l D7,A0
            _DisposHandle
            clr.l   ($5C,A3)
            jsr     ([$105C.w])
.L3:
            movem.l (SP)+,D6-D7/A3
            rts
            ds.b    8
KillPicture:
            movea.l (SP)+,A1
            movea.l (SP)+,A0
            _DisposHandle
            jmp     (A1)
            ds.b    8
DrawPicture:
            link.w  A6,#-$AA
            movem.l D3-D7/A2-A4,-(SP)
            movea.l (A5),A4
            movea.l (A4),A3
            tst.l   ($C,A6)
            beq.w   .L8
            movea.l (8,A6),A0
            move.w  (6,A0),D0
            sub.w   (2,A0),D0
            ble.w   .L8
            move.w  D0,(-$18,A6)
            move.w  (4,A0),D0
            sub.w   (A0),D0
            ble.w   .L8
            move.w  D0,(-$1A,A6)
            lea     (-$22,A6),A1
            move.l  (A0)+,(A1)+
            move.l  (A0)+,(A1)+
            movea.l ($C,A6),A0
            movea.l (A0),A0
            lea     (2,A0),A0
            move.w  (6,A0),D0
            sub.w   (2,A0),D0
            ble.w   .L8
            move.w  D0,(-$14,A6)
            move.w  (4,A0),D0
            sub.w   (A0),D0
            ble.w   .L8
            move.w  D0,(-$16,A6)
            lea     (-$2A,A6),A1
            move.l  (A0)+,(A1)+
            move.l  (A0)+,(A1)+
            movea.l A3,A0
            lea     (-$AA,A6),A1
            moveq   #$35,D0
.L1:
            move.w  (A0)+,(A1)+
            dbra    D0,.L1
            clr.l   (-$A8,A4)
            move.l  ($C,A6),(-$9C,A4)
            move.l  #$A,(-$B4,A4)
            lea     (-$3E,A6),A0
            clr.l   (A0)+
            clr.l   (A0)+
            clr.l   (A0)+
            clr.l   (A0)+
            clr.l   (A0)+
            move.l  ($1C,A3),(-$E,A6)
            clr.l   -(SP)
            jsr     ([$1160.w])
            move.l  (SP)+,(-$12,A6)
            move.w  #$8000,D0
            move.w  D0,(-8,A6)
            move.w  D0,(-6,A6)
            clr.l   -(SP)
            jsr     ([$1160.w])
            move.l  (SP)+,($1C,A3)
            lea     ($20,A3),A0
            clr.l   (A0)+
            clr.l   (A0)+
            moveq   #-1,D0
            move.l  D0,(A0)+
            move.l  D0,(A0)+
            clr.l   (A0)+
            move.l  #$10001,D1
            move.l  D1,(A0)+
            move.w  #8,(A0)+
            move.l  D0,(A0)+
            move.l  D0,(A0)+
            addq.w  #2,A0
            clr.l   (A0)+
            move.w  #1,(A0)+
            clr.w   (A0)+
            clr.l   (A0)+
            move.l  #$21,(A0)+
            move.l  #$1E,(A0)+
            pea     ($34,A3)
            pea     (-$2A,A6)
            pea     (-$22,A6)
            jsr     ([$11E0.w])
            tst.w   (6,A3)
            bmi.b   .L2
            clr.l   -(SP)
            jsr     ([$161C.w])
            move.l  (SP)+,(-4,A6)
            bra.b   .L3
.L2:
            clr.l   ($20,A3)
            clr.l   ($3A,A3)
            clr.l   ($3E,A3)
            move.l  A3,-(SP)
            jsr     INITCOLORSTUFF
.L3:
            move.w  #1,(-$A,A6)
            movea.l ($C,A6),A0
            _HGetState
            move.w  D0,-(SP)
            _HLock
.L4:
            clr.b   -(SP)
            pea     (-$3E,A6)
            jsr     ([$1C68.w])
            move.b  (SP)+,D0
            bne.b   .L4
            movea.l ($C,A6),A0
            move.w  (SP)+,D0
            _HSetState
            movea.l (-$12,A6),A0
            _DisposHandle
            tst.w   (6,A3)
            bmi.b   .L5
            move.l  (-4,A6),-(SP)
            jsr     ([$1620.w])
            bra.b   .L6
.L5:
            move.l  ($20,A3),-(SP)
            jsr     ([$1620.w])
            move.l  ($3A,A3),-(SP)
            jsr     ([$1620.w])
            move.l  ($3E,A3),-(SP)
            jsr     ([$1620.w])
.L6:
            movea.l ($1C,A3),A0
            _DisposHandle
            lea     (-$AA,A6),A0
            moveq   #$35,D0
.L7:
            move.w  (A0)+,(A3)+
            dbra    D0,.L7
            clr.l   (-$A8,A4)
            clr.l   (-$9C,A4)
            clr.l   (-$B4,A4)
.L8:
            movem.l (SP)+,D3-D7/A2-A4
            unlk    A6
            rtd     #8
            ds.b    4
PicItem1:
            link.w  A6,#-$16E
            movem.l D3-D7/A2-A4,-(SP)
            move.l  SP,(-$16E,A6)
            clr.l   (-$C,A6)
            movea.l (A5),A4
            movea.l (A4),A3
            movea.l (8,A6),A2
            clr.b   ($C,A6)
            bsr.w   GetPicOp
            move.w  D0,D7
            cmpi.w  #$FF,D7
            beq.w   GETHND2.L7
            bcs.b   .L2
            move.l  ($68,A3),D0
            movea.l ($1DE0).w,A0
            beq.b   .L1
            tst.w   (6,A3)
            bpl.b   .L1
            movea.l D0,A0
            movea.l ($34,A0),A0
.L1:
            pea     ($14,A2)
            pea     ($1C,A2)
            move.w  D7,-(SP)
            move.w  ($34,A2),-(SP)
            jsr     (A0)
            move.b  #1,($C,A6)
            bra.w   GETHND2.L7
.L2:
            move.b  #1,($C,A6)
            cmpi.w  #$20,D7
            bcs.b   .L4
            move.b  D7,D0
            andi.w  #$F0,D0
            btst    #3,D7
            sne     (-$5E,A6)
            andi.w  #7,D7
            lsr.w   #3,D0
            move.w  .L3(PC,D0.w),D0
            jmp     .L3(PC,D0.w)
.L3:
            dc.w    GETHND2.L7-.L3
            dc.w    GETHND2.L7-.L3
            dc.w    sub_4083237E.L4-.L3
            dc.w    sub_4083237E.L16-.L3
            dc.w    sub_4083237E.L19-.L3
            dc.w    sub_4083237E.L22-.L3
            dc.w    sub_4083237E.L25-.L3
            dc.w    sub_4083237E.L28-.L3
            dc.w    sub_4083237E.L32-.L3
            dc.w    sub_4083237E.L36-.L3
            dc.w    sub_4083237E.L49-.L3
            dc.w    GETHND2.L7-.L3
            dc.w    GETHND2.L7-.L3
            dc.w    sub_408320D8.L41-.L3
            dc.w    sub_408320D8.L40-.L3
            dc.w    sub_408320D8.L40-.L3
.L4:
            andi.w  #$1F,D7
            add.w   D7,D7
            move.w  .L5(PC,D7.w),D0
            jmp     .L5(PC,D0.w)
.L5:
            dc.w    GETHND2.L7-.L5
            dc.w    .L6-.L5
            dc.w    sub_408320D8.L1-.L5
            dc.w    sub_408320D8.L8-.L5
            dc.w    sub_408320D8.L9-.L5
            dc.w    sub_408320D8.L10-.L5
            dc.w    sub_408320D8.L12-.L5
            dc.w    sub_408320D8.L13-.L5
            dc.w    sub_408320D8.L17-.L5
            dc.w    sub_408320D8.L4-.L5
            dc.w    sub_408320D8.L5-.L5
            dc.w    sub_408320D8.L21-.L5
            dc.w    sub_408320D8.L22-.L5
            dc.w    sub_408320D8.L11-.L5
            dc.w    sub_408320D8.L6-.L5
            dc.w    sub_408320D8.L7-.L5
            dc.w    sub_408320D8.L14-.L5
            dc.w    sub_408320D8.L15-.L5
            dc.w    sub_408320D8.L25-.L5
            dc.w    sub_408320D8.L26-.L5
            dc.w    sub_408320D8.L27-.L5
            dc.w    sub_408320D8.L29-.L5
            dc.w    sub_408320D8.L31-.L5
            dc.w    GETHND2.L7-.L5
            dc.w    GETHND2.L7-.L5
            dc.w    GETHND2.L7-.L5
            dc.w    sub_408320D8.L23-.L5
            dc.w    sub_408320D8.L24-.L5
            dc.w    sub_408320D8.L32-.L5
            dc.w    sub_408320D8.L33-.L5
            dc.w    sub_408320D8.L35-.L5
            dc.w    sub_408320D8.L37-.L5
.L6:
            bsr.w   sub_40832AE6
            movea.l (8,A6),A2
            move.l  (-4,A6),-(SP)
            move.l  ($2C,A2),-(SP)
.L7:
            jsr     ([$1170.w])
            movea.l (8,A6),A2
            movea.l (-4,A6),A0
            movea.l (A0),A0
            cmpi.w  #$A,(A0)+
            bne.b   .L8
            cmpi.l  #$80018001,(A0)+
            bne.b   .L8
            cmpi.l  #$7FFF7FFF,(A0)+
            bra.b   .L9
.L8:
            move.l  (-4,A6),-(SP)
            pea     ($14,A2)
            pea     ($1C,A2)
            jsr     ([$11EC.w])
.L9:
            movea.l (8,A6),A2
            move.l  (-4,A6),-(SP)
            move.l  ($30,A2),-(SP)
            move.l  ($1C,A3),-(SP)
            jsr     ([$1190.w])
            bra.w   GETHND2.L4
            moveq   #8,D6
            bra.w   sub_4083237E.L56
.L10:
            moveq   #4,D6
            bra.w   sub_4083237E.L56
.L11:
            moveq   #2,D6
            bra.w   sub_4083237E.L56
sub_408320C6:
            tst.w   (6,A3)
            bmi.b   .L1
            rts
.L1:
            move.l  A0,-(SP)
            jsr     ([$1620.w])
            rts
sub_408320D8:
            movea.l (SP)+,A0
            moveq   #8,D0
            suba.w  D0,SP
            move.l  SP,-(SP)
            move.l  (SP),-(SP)
            move.w  D0,-(SP)
            move.l  A0,-(SP)
            jmp     GetPicData
.L1:
            movea.l ($20,A3),A0
            bsr.b   sub_408320C6
            bsr.b   sub_408320D8
            jsr     ([$FF0.w])
.L2:
            addq.w  #8,SP
.L3:
            move.b  #1,($C,A6)
            bra.w   GETHND2.L7
.L4:
            movea.l ($3A,A3),A0
            bsr.b   sub_408320C6
            bsr.b   sub_408320D8
            jsr     ([$1074.w])
            bra.b   .L2
.L5:
            movea.l ($3E,A3),A0
            bsr.b   sub_408320C6
            bsr.b   sub_408320D8
            moveq   #0,D0
            jsr     SetFillPat
            bra.b   .L2
.L6:
            jsr     GetLong
            move.l  D0,-(SP)
            jsr     ([$F88.w])
            bra.b   .L3
.L7:
            jsr     GetLong
            move.l  D0,-(SP)
            jsr     ([$F8C.w])
            bra.b   .L3
.L8:
            lea     ($44,A3),A3
            bra.w   PicItem1.L11
.L9:
            lea     ($46,A3),A3
            moveq   #1,D6
            bra.w   sub_4083237E.L56
.L10:
            pea     ($48,A3)
            bra.w   .L18
.L11:
            lea     ($4A,A3),A3
            bra.w   PicItem1.L11
.L12:
            lea     ($4C,A3),A3
            bra.w   PicItem1.L10
.L13:
            jsr     GetLong
            move.l  D0,($34,A3)
            pea     ($34,A3)
            movea.l (8,A6),A2
            pea     ($14,A2)
            pea     ($1C,A2)
            jsr     ([$11E0.w])
            bra.w   GETHND2.L7
.L14:
            movea.l (8,A6),A3
            jsr     GetLong
            move.l  D0,($24,A3)
            jsr     GetLong
            move.l  D0,($28,A3)
            pea     ($24,A3)
            pea     ($28,A3)
            pea     ($14,A3)
            jsr     MapRatio
            pea     ($24,A3)
            pea     ($14,A3)
            pea     ($1C,A3)
            jsr     ([$11E0.w])
            bra.w   GETHND2.L7
.L15:
            jsr     GetUByte
            cmpi.w  #1,D0
            beq.b   .L16
            move.w  D0,D6
            lsl.w   #8,D6
            jsr     GetUByte
            move.b  D0,D6
            move.w  D6,D0
.L16:
            movea.l (8,A6),A3
            move.w  D0,($34,A3)
            bra.w   GETHND2.L7
.L17:
            pea     ($38,A3)
.L18:
            jsr     GetWord
            tst.w   (6,A3)
            bmi.b   .L19
            tst.l   ($68,A3)
            beq.b   .L19
            btst    #5,D0
            beq.b   .L19
            andi.w  #7,D0
            move.b  .L20(PC,D0.w),D0
.L19:
            movea.l (SP)+,A0
            move.w  D0,(A0)
            bra.w   GETHND2.L7
.L20:
            dc.w    $0003,$0201,$0103,$0201
.L21:
            jsr     GetLong
            movea.l (8,A6),A2
            move.l  D0,($10,A2)
            pea     ($10,A2)
            pea     ($14,A2)
            pea     ($1C,A2)
            jsr     ([$11E0.w])
            bra.w   GETHND2.L7
.L22:
            jsr     GetLong
            movea.l (8,A6),A2
            add.w   D0,($14,A2)
            add.w   D0,($18,A2)
            add.w   D0,(-$A8,A4)
            swap    D0
            add.w   D0,($16,A2)
            add.w   D0,($1A,A2)
            add.w   D0,(-$A6,A4)
            move.l  ($2C,A2),-(SP)
            clr.l   -(SP)
            jsr     ([$1160.w])
            move.l  (SP),(-4,A6)
            bra.w   PicItem1.L7
.L23:
            jsr     GetLong
            move.l  D0,D6
            jsr     GetWord
            move.w  D0,-(SP)
            move.l  D6,-(SP)
            move.l  SP,-(SP)
            jsr     ([$1650.w])
            addq.w  #6,SP
            bra.w   GETHND2.L7
.L24:
            jsr     GetLong
            move.l  D0,D6
            jsr     GetWord
            move.w  D0,-(SP)
            move.l  D6,-(SP)
            move.l  SP,-(SP)
            jsr     ([$1654.w])
            addq.w  #6,SP
            bra.w   GETHND2.L7
.L25:
            pea     ($20,A3)
            move.l  ($20,A3),-(SP)
            bra.b   .L28
.L26:
            pea     ($3A,A3)
            move.l  ($3A,A3),-(SP)
            bra.b   .L28
.L27:
            pea     ($28,A3)
            move.l  ($3E,A3),-(SP)
.L28:
            jsr     GetPicPixPat
            bra.w   GETHND2.L7
.L29:
            jsr     GetWord
            tst.w   (6,A3)
            bpl.b   .L30
            movea.l (8,A6),A2
            move.w  D0,($38,A2)
.L30:
            bra.w   GETHND2.L7
.L31:
            jsr     GetWord
            tst.w   (6,A3)
            bpl.b   .L30
            move.w  D0,($C,A3)
            bra.w   GETHND2.L7
.L32:
            bclr    #7,HiliteMode
            bra.w   GETHND2.L7
.L33:
            jsr     GetLong
            move.l  D0,D6
            jsr     GetWord
            tst.w   (6,A3)
            bpl.b   .L34
            movea.l (8,A3),A0
            movea.l (A0),A0
            move.l  D6,(6,A0)
            move.w  D0,($A,A0)
.L34:
            bra.w   GETHND2.L7
.L35:
            tst.w   (6,A3)
            bpl.b   .L36
            movea.l (8,A3),A0
            movea.l (A0),A0
            move.l  ($DA0).w,(6,A0)
            move.w  ($DA4).w,($A,A0)
.L36:
            bra.w   GETHND2.L7
.L37:
            jsr     GetLong
            move.l  D0,D6
            jsr     GetWord
            tst.w   (6,A3)
            bpl.b   .L38
            movea.l (8,A3),A0
            movea.l (A0),A0
            move.l  D6,(A0)
            move.w  D0,(4,A0)
.L38:
            bra.w   GETHND2.L7
.L39:
            tst.b   (-$5E,A6)
            beq.b   .L42
            move.l  D1,D0
            bra.b   .L42
.L40:
            jsr     GetLong
            bra.b   .L42
.L41:
            jsr     GetWord
            swap    D0
            clr.w   D0
            swap    D0
.L42:
            bsr.b   sub_4083237E
            bra.w   GETHND2.L7
sub_4083237E:
            movem.l D6-D7,-(SP)
            move.l  #$100,D6
            suba.l  D6,SP
            move.l  D0,D7
            beq.b   .L3
.L1:
            move.w  D6,D0
            cmp.l   D6,D7
            bge.b   .L2
            move.w  D7,D0
.L2:
            move.l  SP,-(SP)
            move.w  D0,-(SP)
            jsr     GetPicData
            sub.l   D6,D7
            bgt.b   .L1
.L3:
            adda.l  D6,SP
            movem.l (SP)+,D6-D7
            rts
.L4:
            cmpi.w  #3,D7
            bgt.b   sub_408320D8.L41
            tst.b   (-$5E,A6)
            bne.w   .L9
            movea.l (8,A6),A2
            move.l  (8,A2),D0
            ror.w   #1,D7
            bcs.b   .L5
            jsr     GetLong
.L5:
            move.l  D0,($30,A3)
            move.l  D0,(-$62,A6)
            movea.l (8,A6),A2
            pea     ($30,A3)
            pea     ($14,A2)
            pea     ($1C,A2)
            jsr     ([$11E4.w])
            ror.w   #1,D7
            bcs.b   .L6
            jsr     GetLong
            move.l  D0,(-$62,A6)
            bra.b   .L7
.L6:
            bsr.w   GETSBYTE
            add.w   D0,(-$60,A6)
            bsr.w   GETSBYTE
            add.w   D0,(-$62,A6)
.L7:
            movea.l (8,A6),A2
            move.l  (-$62,A6),(8,A2)
            pea     (-$62,A6)
            pea     ($14,A2)
            pea     ($1C,A2)
            jsr     ([$11E4.w])
            move.l  (-$62,A6),-(SP)
            movea.l ($1040).w,A0
            move.l  ($68,A3),D0
            beq.b   .L8
            movea.l D0,A0
            movea.l (4,A0),A0
.L8:
            bra.w   GETHND2.L1
.L9:
            movea.l (8,A6),A2
            move.w  ($38,A2),($36,A2)
            move.w  #$8000,($38,A2)
            andi.w  #3,D7
            beq.b   .L11
            ror.w   #1,D7
            bcc.b   .L10
            jsr     GetUByte
            movea.l (8,A6),A2
            add.w   D0,($E,A2)
.L10:
            ror.w   #1,D7
            bcc.b   .L12
            jsr     GetUByte
            movea.l (8,A6),A2
            add.w   D0,($C,A2)
            bra.b   .L12
.L11:
            jsr     GetLong
            movea.l (8,A6),A2
            move.l  D0,($C,A2)
.L12:
            jsr     GetUByte
            move.w  D0,D6
            pea     (-$162,A6)
            move.w  D6,-(SP)
            jsr     GetPicData
            move.l  ($C,A2),($30,A3)
            movea.l (8,A6),A2
            cmpi.w  #1,($34,A2)
            beq.b   .L13
            tst.w   (6,A3)
            bpl.b   .L13
            move.w  ($36,A2),-(SP)
            move.w  ($E,A2),-(SP)
            move.w  #$8000,-(SP)
            move.w  ($C,A2),-(SP)
            move.l  SP,-(SP)
            pea     ($14,A2)
            pea     ($1C,A2)
            jsr     MapFixPt
            move.w  (SP)+,($30,A3)
            move.w  (SP)+,D0
            move.w  (SP)+,($32,A3)
            move.w  (SP)+,($E,A3)
            bra.b   .L14
.L13:
            pea     ($30,A3)
            pea     ($14,A2)
            pea     ($1C,A2)
            jsr     ([$11E4.w])
.L14:
            move.w  D6,-(SP)
            pea     (-$162,A6)
            movea.l (8,A6),A2
            move.l  ($24,A2),-(SP)
            move.l  ($28,A2),-(SP)
            movea.l JStdTEXT,A0
            move.l  ($68,A3),D0
            beq.b   .L15
            movea.l D0,A0
            movea.l (A0),A0
.L15:
            bra.w   GETHND2.L1
.L16:
            cmpi.w  #4,D7
            ble.w   .L17
            moveq   #8,D0
            moveq   #0,D1
            bra.w   sub_408320D8.L39
.L17:
            move.b  D7,-(SP)
            bsr.w   sub_40832A82
            movea.l ($1080).w,A0
            move.l  ($68,A3),D0
            beq.b   .L18
            movea.l D0,A0
            movea.l (8,A0),A0
.L18:
            bra.w   GETHND2.L1
.L19:
            cmpi.w  #4,D7
            ble.w   .L20
            moveq   #8,D0
            moveq   #0,D1
            bra.w   sub_408320D8.L39
.L20:
            move.b  D7,-(SP)
            bsr.w   sub_40832A82
            movea.l (8,A6),A2
            move.l  ($10,A2),-(SP)
            movea.l ($10BC).w,A0
            move.l  ($68,A3),D0
            beq.b   .L21
            movea.l D0,A0
            movea.l ($C,A0),A0
.L21:
            bra.w   GETHND2.L1
.L22:
            cmpi.w  #4,D7
            ble.w   .L23
            moveq   #8,D0
            moveq   #0,D1
            bra.w   sub_408320D8.L39
.L23:
            move.b  D7,-(SP)
            bsr.w   sub_40832A82
            movea.l ($10D8).w,A0
            move.l  ($68,A3),D0
            beq.b   .L24
            movea.l D0,A0
            movea.l ($10,A0),A0
.L24:
            bra.w   GETHND2.L1
.L25:
            cmpi.w  #4,D7
            ble.w   .L26
            moveq   #$C,D0
            moveq   #4,D1
            bra.w   sub_408320D8.L39
.L26:
            move.b  D7,-(SP)
            bsr.w   sub_40832A82
            jsr     GetWord
            move.w  D0,-(SP)
            jsr     GetWord
            move.w  D0,-(SP)
            movea.l ($10F4).w,A0
            move.l  ($68,A3),D0
            beq.b   .L27
            movea.l D0,A0
            movea.l ($14,A0),A0
.L27:
            bra.w   GETHND2.L1
.L28:
            cmpi.w  #4,D7
            ble.w   .L30
            tst.b   (-$5E,A6)
            bne.b   .L29
            bsr.w   sub_40832AE6
.L29:
            bra.w   GETHND2.L7
.L30:
            bsr.w   sub_40832AE6
            move.l  (-4,A6),-(SP)
            movea.l (8,A6),A2
            pea     ($14,A2)
            pea     ($1C,A2)
            jsr     ([$11F0.w])
            move.b  D7,-(SP)
            move.l  (-4,A6),-(SP)
            movea.l ($1114).w,A0
            move.l  ($68,A3),D0
            beq.b   .L31
            movea.l D0,A0
            movea.l ($18,A0),A0
.L31:
            bra.w   GETHND2.L2
.L32:
            cmpi.w  #4,D7
            ble.w   .L34
            tst.b   (-$5E,A6)
            bne.b   .L33
            bsr.w   sub_40832AE6
.L33:
            bra.w   GETHND2.L7
.L34:
            bsr.w   sub_40832AE6
            move.l  (-4,A6),-(SP)
            movea.l (8,A6),A2
            pea     ($14,A2)
            pea     ($1C,A2)
            jsr     ([$11EC.w])
            move.b  D7,-(SP)
            move.l  (-4,A6),-(SP)
            movea.l ($1144).w,A0
            move.l  ($68,A3),D0
            beq.b   .L35
            movea.l D0,A0
            movea.l ($1C,A0),A0
.L35:
            bra.w   GETHND2.L2
.L36:
            cmpi.w  #3,D7
            bgt.w   sub_408320D8.L41
            cmpi.w  #1,D7
            ble.b   .L37
            jsr     GetLong
.L37:
            jsr     GetWord
            move.w  D0,(-$4A,A6)
            moveq   #8,D1
            move.w  D0,D6
            bpl.b   .L38
            moveq   #$2C,D1
.L38:
            pea     (-$48,A6)
            move.w  D1,-(SP)
            jsr     GetPicData
            clr.w   (-$40,A6)
            tst.w   D6
            bpl.b   .L39
            clr.l   (-$24,A6)
            btst    #1,D7
            bne.b   .L39
            moveq   #8,D0
            jsr     RNewHandle
            move.l  A0,(-$24,A6)
            move.l  A0,-(SP)
            jsr     GetPicTable
.L39:
            pea     (-$1C,A6)
            move.w  #$10,-(SP)
            jsr     GetPicData
            movea.l (8,A6),A2
            pea     (-$14,A6)
            pea     ($14,A2)
            pea     ($1C,A2)
            jsr     ([$11E8.w])
            pea     (-$4E,A6)
            pea     (-$1C,A6)
            pea     (-$14,A6)
            jsr     GetWord
            move.w  D0,-(SP)
            clr.l   -(SP)
            btst    #0,D7
            beq.b   .L40
            bsr.w   sub_40832AE6
            move.l  (-4,A6),-(SP)
            movea.l (8,A6),A2
            pea     ($14,A2)
            pea     ($1C,A2)
            jsr     ([$11EC.w])
            move.l  (-4,A6),(SP)
            move.l  (-4,A6),(-8,A6)
.L40:
            move.w  (-$44,A6),D6
            sub.w   (-$48,A6),D6
            move.w  D6,D5
            move.w  (-$4A,A6),D0
            andi.w  #$7FFF,D0
            mulu.w  D0,D5
            move.l  D5,D0
            _NewHandle
            bne.w   .L46
            move.l  A0,(-4,A6)
            _HLock
.L41:
            pea     (-$4E,A6)
            move.l  A0,-(SP)
            jsr     GetPMData
            movea.l (-4,A6),A0
            move.l  (A0),(-$4E,A6)
            movea.l ($11AC).w,A0
            move.l  ($68,A3),D0
            beq.b   .L43
            exg     D0,A0
            cmp.l   ($20,A0),D0
            beq.b   .L42
            tst.w   (-$4A,A6)
            bpl.b   .L42
            tst.w   (6,A3)
            bmi.b   .L42
            lea     (-$4A,A6),A0
            moveq   #0,D0
            move.w  (A0)+,D0
            andi.w  #$7FFF,D0
            lsl.l   #3,D0
            divu.w  (-$2E,A6),D0
            addi.w  #$F,D0
            lsr.l   #4,D0
            beq.b   .L44
            add.w   D0,D0
            lea     (-$58,A6),A1
            move.w  D0,(A1)+
            move.l  (A0)+,(A1)+
            move.l  (A0)+,(A1)+
            move.l  (-$4E,A6),(-$5C,A6)
            pea     (-$4E,A6)
            pea     (-$5C,A6)
            pea     (-$48,A6)
            move.l  (SP),-(SP)
            clr.w   -(SP)
            clr.l   -(SP)
            jsr     ([$11B0.w])
            lea     (-$5C,A6),A0
            move.l  A0,($E,SP)
            movea.l ($68,A3),A0
.L42:
            movea.l ($20,A0),A0
.L43:
            jsr     (A0)
.L44:
            tst.w   (-$4A,A6)
            bpl.b   .L45
            move.l  (-$24,A6),D0
            beq.b   .L45
            movea.l D0,A0
            _DisposHandle
.L45:
            btst    #0,D7
            beq.w   GETHND2.L4
            bra.w   GETHND2.L3
.L46:
            move.l  D5,D0
            jsr     ([$1A70.w])
            move.l  A0,(-$C,A6)
            move.l  A0,(-4,A6)
            move.l  D0,D4
            cmp.l   D5,D0
            bge.w   .L41
            move.w  (-$4A,A6),D5
            andi.w  #$7FFF,D5
            ext.l   D5
            _PurgeSpace
            move.l  A0,D3
            cmp.l   D3,D4
            ble.b   .L47
            move.l  D4,D3
            divu.l  D5,D3
            bne.b   .L48
            bra.w   GETHND2.L6
.L47:
            movea.l (-$C,A6),A0
            jsr     ([$1A78.w])
            clr.l   (-$C,A6)
            divu.l  D5,D3
            beq.w   GETHND2.L6
            move.l  D5,D0
            mulu.l  D3,D0
            _NewHandle
            bne.w   GETHND2.L6
            move.l  A0,(-4,A6)
            _HLock
.L48:
            move.w  (-$44,A6),D6
            move.w  (-$48,A6),D0
            add.w   D3,D0
            move.w  D0,(-$44,A6)
            move.w  (-$1C,A6),D0
            add.w   D3,D0
            move.w  D0,(-$18,A6)
            move.w  (-$10,A6),D5
            move.w  D5,D4
            sub.w   (-$14,A6),D4
            clr.l   -(SP)
            move.w  D4,-(SP)
            move.w  D6,-(SP)
            move.w  (-$48,A6),D0
            sub.w   D0,(SP)
            jsr     ([$FA4.w])
            move.l  (SP)+,D0
            move.l  D0,D4
            dc.w    $4C03,$4004,$342E,$FFEC,$4842,$4242,$D484,$4842
            dc.w    $3D42,$FFF0,$4842,$206E,$FFFC,$2D50,$FFB2,$2878
            dc.b    $11,$AC,$08,$87,$00,$1F,$20,$2B,$00
            dc.b    'hgR @ ('
            dc.w    $0020,$B08C
            dc.b    'gH(@Jn'
            dc.w    $FFB6,$6A40,$4A6B,$0006,$6B3A,$08C7,$001F,$41EE
            dc.w    $FFB6,$7000,$3018,$0240,$7FFF,$E788,$80EE,$FFD2
            dc.w    $0640,$000F,$E888,$6700,$FEEC,$D040,$43EE,$FFA8
            dc.w    $32C0,$22D8,$22D8,$2D6E,$FFB2,$FFA4,$41EE,$FFA4
            dc.w    $2F48,$000E,$486E,$FFB2,$2F2E,$FFFC,$2442,$4EBA
            dc.w    $0D26,$4A87,$6A18,$486E,$FFB2,$486E,$FFA4,$486E
            dc.w    $FFB8,$2F17,$4267,$42A7,$4EB0,$81E1,$11B0,$2F2F
            dc.w    $000E,$2F2F,$000E,$2F2F,$000E,$3F2F,$0010,$2F2F
            dc.w    $000E,$4E94,$240A,$D76E,$FFB8,$D76E,$FFBC,$D76E
            dc.w    $FFAA,$D76E,$FFAE,$D76E,$FFE4,$D76E,$FFE8,$3D6E
            dc.w    $FFF0,$FFEC,$D484,$4842,$3D42,$FFF0,$4842,$BC6E
            dc.w    $FFBC,$6E90,$3D45,$FFF0,$3D46,$FFBC,$3D46,$FFAE
            dc.w    $3D46,$FFE8,$486E,$FFB2,$2F2E,$FFFC,$4EBA,$0CA8
            dc.w    $4A87,$6A18,$486E,$FFB2,$486E,$FFA4,$486E,$FFB8
            dc.w    $2F17,$4267,$42A7,$4EB0,$81E1,$11B0,$4E94,$6000
            dc.w    $FE24
.L49:
            tst.b   (-$5E,A6)
            bne.w   sub_408320D8.L41
            cmpi.w  #1,D7
            bgt.w   sub_408320D8.L41
            jsr     GetWord
            move.w  D0,-(SP)
            tst.b   D7
            bne.b   .L51
            clr.w   -(SP)
            clr.l   -(SP)
            movea.l ($11C4).w,A0
            move.l  ($68,A3),D0
            beq.b   .L50
            movea.l D0,A0
            movea.l ($24,A0),A0
.L50:
            bra.w   GETHND2.L1
.L51:
            jsr     GetWord
            move.w  D0,-(SP)
            clr.w   D4
            bsr.w   GETHND2
            move.l  (-4,A6),-(SP)
            movea.l ($11C4).w,A0
            move.l  ($68,A3),D0
            beq.b   .L52
            movea.l D0,A0
            movea.l ($24,A0),A0
.L52:
            bra.w   GETHND2.L2
            movea.l (A5),A0
            movea.l (-$7A,A0),A1
            move.w  (-$76,A0),D0
            andi.w  #$7FFF,D0
            lea     .L55,A0
            moveq   #$18,D1
.L53:
            move.l  (A0)+,(A1)
            adda.w  D0,A1
            dbra    D1,.L53
.L54:
            bra.b   .L54
.L55:
            ds.b    4
            dc.w    $7EE9,$D200,$44A9,$1A00,$74A9,$9610,$14A9,$1230
            dc.b    $74,$EF,$D2,$60,$00,$00,$00
            dc.b    '@wtCXEW'
            dc.w    $C7FC,$7755,$4FFE,$4654,$4FF8,$4574,$4FF0,0
            dc.w    $0FF0,$7774,$EFF8,$5554,$8FFE,$7774,$CFFE,$5444
            dc.w    $87BC,$5447,$E318
            ds.b    4
            dc.w    $7745,$D7FE
            dc.b    'EmUJEU'
            dc.w    $D56E,$4545,$154C,$7745,$1D7A
            ds.b    4
.L56:
            move.l  A3,-(SP)
            move.w  D6,-(SP)
            jsr     GetPicData
            bra.w   GETHND2.L7
GETSBYTE:
            clr.b   -(SP)
            move.l  SP,-(SP)
            move.w  #1,-(SP)
            jsr     GetPicData
            move.b  (SP)+,D0
            ext.w   D0
            rts
sub_40832A82:
            tst.b   (-$5E,A6)
            bne.b   .L1
            movea.l (8,A6),A2
            pea     (A2)
            move.w  #8,-(SP)
            jsr     GetPicData
.L1:
            movea.l (8,A6),A2
            move.l  (A2),(-$14,A6)
            move.l  (4,A2),(-$10,A6)
            pea     (-$14,A6)
            pea     ($14,A2)
            pea     ($1C,A2)
            jsr     ([$11E8.w])
            movea.l (SP)+,A0
            pea     (-$14,A6)
            jmp     (A0)
GetPicOp:
            movea.l (8,A6),A2
            cmpi.w  #1,($34,A2)
            beq.b   .L2
            movea.l (A5),A0
            move.l  (-$B4,A0),D0
            btst    #0,D0
            beq.b   .L1
            jsr     GetUByte
.L1:
            jsr     GetWord
            rts
.L2:
            jsr     GetUByte
            rts
sub_40832AE6:
            moveq   #2,D4
            jsr     GetWord
GETHND2:
            ext.l   D0
            move.l  D0,D5
            _NewHandle
            bne.b   .L6
            move.l  A0,(-4,A6)
            _HLock
            movea.l (A0),A0
            move.w  D5,(A0)
            sub.w   D4,D5
            pea     (0,A0,D4.w)
            move.w  D5,-(SP)
            jsr     GetPicData
            movea.l (-4,A6),A0
            _HUnlock
            rts
.L1:
            jsr     (A0)
            bra.b   .L7
.L2:
            jsr     (A0)
            bra.b   .L4
.L3:
            movea.l (-8,A6),A0
            _DisposHandle
.L4:
            tst.l   (-$C,A6)
            beq.b   .L5
            movea.l (-$C,A6),A0
            jsr     ([$1A78.w])
            bra.b   .L7
.L5:
            movea.l (-4,A6),A0
            _DisposHandle
            bra.b   .L7
.L6:
            movea.l (-$16E,A6),SP
            clr.b   ($C,A6)
            move.w  #$FF6F,QDErr
.L7:
            movem.l (SP)+,D3-D7/A2-A4
            unlk    A6
            rtd     #4
            ds.b    14
GetUByte:
            clr.b   -(SP)
            move.l  SP,-(SP)
            move.w  #1,-(SP)
            jsr     GetPicData
            clr.w   D0
            move.b  (SP)+,D0
            rts
            ds.b    14
GetWord:
            clr.w   -(SP)
            move.l  SP,-(SP)
            move.w  #2,-(SP)
            jsr     GetPicData
            move.w  (SP)+,D0
            rts
GetLong:
            clr.l   -(SP)
            move.l  SP,-(SP)
            move.w  #4,-(SP)
            jsr     GetPicData
            move.l  (SP)+,D0
            rts
GetPicData:
            movea.l (A5),A0
            movea.l (A0),A0
            move.l  ($68,A0),D0
            movea.l ($11B8).w,A0
            beq.b   .L1
            movea.l D0,A0
            movea.l ($2C,A0),A0
.L1:
            move.l  (6,SP),-(SP)
            move.w  (8,SP),-(SP)
            jsr     (A0)
            movea.l (A5),A0
            moveq   #0,D0
            move.w  (4,SP),D0
            add.l   D0,(-$B4,A0)
            rtd     #6
            dc.w    0
PutPicData:
            movea.l (A5),A0
            movea.l (A0),A0
            move.l  ($68,A0),D0
            movea.l ($11C0).w,A0
            beq.b   .L1
            movea.l D0,A0
            movea.l ($30,A0),A0
.L1:
            jmp     (A0)
            ds.b    10
DPutPicByte:
            movea.l (SP)+,A0
            move.b  D0,-(SP)
            move.l  A0,-(SP)
PutPicByte:
            pea     (4,SP)
            move.w  #1,-(SP)
            jsr     PutPicData
            movea.l (SP)+,A0
            tst.b   (SP)+
            jmp     (A0)
            ds.b    8
PutPicWord:
            pea     (4,SP)
            move.w  #2,-(SP)
            jsr     PutPicData
            movea.l (SP)+,A0
            tst.w   (SP)+
            jmp     (A0)
            ds.b    14
PutPicLong:
            pea     (4,SP)
            move.w  #4,-(SP)
            jsr     PutPicData
            move.l  (SP)+,(SP)
            rts
PutPicRect:
            movea.l (SP)+,A0
            movea.l (SP)+,A1
            moveq   #0,D0
            move.b  (SP)+,D0
            move.l  A0,-(SP)
            move.l  (A1),D2
            move.l  (4,A1),D1
            movea.l (A5),A0
            movea.l (A0),A0
            movea.l ($5C,A0),A0
            movea.l (A0),A0
            cmp.l   ($4A,A0),D2
            bne.b   .L1
            cmp.l   ($4E,A0),D1
            bne.b   .L1
            addq.w  #8,D0
            jmp     DPutPicOp
.L1:
            move.l  D2,($4A,A0)
            move.l  D1,($4E,A0)
            move.l  A1,-(SP)
            move.w  #8,-(SP)
            jsr     DPutPicOp
            jsr     PutPicData
            rts
            ds.b    12
DPutPicOp:
            movea.l (SP)+,A0
            move.w  D0,-(SP)
            move.l  A0,-(SP)
PutPicOp:
            jsr     PutPicPad
PutPicOp2:
            movea.l (A5),A0
            movea.l (A0),A0
            movea.l ($5C,A0),A0
            movea.l (A0),A0
            moveq   #2,D0
            lea     (4,SP),A1
            cmpi.w  #1,($62,A0)
            bne.b   .L1
            moveq   #1,D0
            addq.w  #1,A1
.L1:
            move.l  A1,-(SP)
            move.w  D0,-(SP)
            jsr     PutPicData
            movea.l (SP)+,A0
            tst.w   (SP)+
            jmp     (A0)
            ds.b    12
PutPicRgn:
            movea.l (4,SP),A0
            _HLock
            movea.l (A0),A0
            move.l  A0,-(SP)
            move.w  (A0),-(SP)
            jsr     PutPicData
            movea.l (4,SP),A0
            _HUnlock
            move.l  (SP)+,(SP)
            rts
            ds.b    6
PutPicPad:
            movea.l (A5),A0
            movea.l (A0),A0
            movea.l ($5C,A0),A0
            movea.l (A0),A0
            cmpi.w  #1,($62,A0)
            beq.b   .L1
            movea.l (A0),A0
            movea.l (A0),A0
            move.w  (A0),D0
            btst    #0,D0
            beq.b   .L1
            moveq   #0,D0
            jsr     DPutPicByte
.L1:
            rts
            ds.b    10
PutPicPat:
            movea.l (SP)+,A0
            move.w  #8,-(SP)
            move.l  A0,-(SP)
            jmp     PutPicData
            ds.b    4
PutPicVerb:
            link.w  A6,#0
            movem.l D7/A3-A4,-(SP)
            movea.l (A5),A4
            movea.l (A4),A3
            movea.l ($5C,A3),A4
            movea.l (A4),A4
            move.b  (8,A6),D7
            cmpi.b  #1,D7
            blt.b   .L2
            beq.b   .L3
            cmpi.b  #3,D7
            beq.w   .L6
            blt.b   .L1
            pea     ($28,A3)
            move.l  ($3E,A3),-(SP)
            pea     ($42,A4)
            move.l  ($80,A4),-(SP)
            move.w  #$A,-(SP)
            move.w  #$14,-(SP)
            jsr     UpdatePat
            bra.w   .L6
.L1:
            pea     ($20,A3)
            move.l  ($20,A3),-(SP)
            pea     ($10,A4)
            move.l  ($88,A4),-(SP)
            move.w  #2,-(SP)
            move.w  #$12,-(SP)
            jsr     UpdatePat
            bra.b   .L6
.L2:
            move.l  ($34,A3),D7
            cmp.l   ($34,A4),D7
            beq.b   .L3
            moveq   #7,D0
            jsr     DPutPicOp
            move.l  D7,-(SP)
            jsr     PutPicLong
            movea.l ($5C,A3),A4
            movea.l (A4),A4
            move.l  D7,($34,A4)
.L3:
            move.w  ($38,A3),D7
            cmp.w   ($38,A4),D7
            beq.b   .L5
            cmpi.w  #1,($62,A4)
            bne.b   .L4
            btst    #5,D7
            beq.b   .L4
            andi.w  #7,D7
            move.b  .L7(PC,D7.w),D7
            cmp.w   ($1C,A4),D7
            beq.b   .L5
.L4:
            moveq   #8,D0
            jsr     DPutPicOp
            move.w  D7,-(SP)
            jsr     PutPicWord
            movea.l ($5C,A3),A4
            movea.l (A4),A4
            move.w  D7,($38,A4)
.L5:
            pea     ($3A,A3)
            move.l  ($3A,A3),-(SP)
            pea     ($3A,A4)
            move.l  ($84,A4),-(SP)
            move.w  #9,-(SP)
            move.w  #$13,-(SP)
            jsr     UpdatePat
.L6:
            movem.l (SP)+,D7/A3-A4
            unlk    A6
            rtd     #2
.L7:
            dc.w    $0003,$0201,$0103,$0201
UpdatePat:
            link.w  A6,#0
            movem.l D5-D6,-(SP)
            cmpi.w  #1,($62,A4)
            bne.b   .L3
            movea.l ($18,A6),A0
            move.l  (A0)+,D5
            move.l  (A0),D6
.L1:
            movea.l ($10,A6),A0
            cmp.l   (A0)+,D5
            bne.b   .L2
            cmp.l   (A0),D6
            beq.w   .L6
.L2:
            movea.l ($10,A6),A0
            move.l  D5,(A0)+
            move.l  D6,(A0)
            move.w  ($A,A6),D0
            jsr     DPutPicOp
            move.l  ($10,A6),-(SP)
            jsr     PutPicPat
            bra.b   .L6
.L3:
            movea.l ($C,A6),A1
            movea.l (A1),A1
            move.w  (A1),D0
            movea.l ($14,A6),A0
            movea.l (A0),A0
            cmpi.w  #0,(A0)
            bne.b   .L4
            clr.w   (A1)
            movea.l (6,A0),A0
            movea.l (A0),A0
            move.l  (A0)+,D5
            move.l  (A0),D6
            cmpi.w  #0,D0
            bne.b   .L2
            bra.b   .L1
.L4:
            cmpi.w  #0,D0
            beq.b   .L5
            clr.b   -(SP)
            move.l  ($14,A6),-(SP)
            move.l  ($C,A6),-(SP)
            jsr     EqualPat
            tst.b   (SP)+
            bne.b   .L6
.L5:
            move.l  ($14,A6),-(SP)
            move.l  ($C,A6),-(SP)
            jsr     ([$1624.w])
            move.w  (8,A6),D0
            jsr     DPutPicOp
            move.l  ($C,A6),-(SP)
            jsr     PutPicPixPat
.L6:
            movem.l (SP)+,D5-D6
            unlk    A6
            rtd     #$14
            ds.b    8
EqualPat:
            link.w  A6,#0
            movem.l A3-A4,-(SP)
            clr.b   ($10,A6)
            movea.l (8,A6),A4
            movea.l (A4),A0
            movea.l (6,A0),A0
            movea.l (A0),A1
            _GetHandleSize
            move.l  D0,D2
            movea.l ($C,A6),A3
            movea.l (A3),A0
            movea.l (6,A0),A0
            _GetHandleSize
            cmp.l   D0,D2
            bne.b   .L4
            lsr.l   #1,D0
            subq.w  #1,D0
            movea.l (A0),A0
.L1:
            cmpm.w  (A0)+,(A1)+
            bne.b   .L4
            dbra    D0,.L1
            movea.l (A3),A0
            movea.l (A4),A1
            cmpm.w  (A0)+,(A1)+
            bne.b   .L4
            move.l  ($12,A0),D0
            cmp.l   ($12,A1),D0
            bne.b   .L4
            move.l  ($16,A0),D1
            cmp.w   ($16,A1),D1
            bne.b   .L4
            movea.l (A0),A0
            movea.l (A0),A0
            movea.l (A1),A1
            movea.l (A1),A1
            cmpm.l  (A0)+,(A1)+
            move.w  #$12,D0
.L2:
            cmpm.w  (A0)+,(A1)+
            bne.b   .L4
            dbra    D0,.L2
            movea.l (A0),A0
            movea.l (A0),A0
            movea.l (A1),A1
            movea.l (A1),A1
            cmpm.l  (A0)+,(A1)+
            cmpm.w  (A0)+,(A1)+
            bne.b   .L4
            move.w  (A0)+,D0
            cmp.w   (A1)+,D0
            bne.b   .L4
.L3:
            cmpm.l  (A0)+,(A1)+
            bne.b   .L4
            cmpm.l  (A0)+,(A1)+
            bne.b   .L4
            dbra    D0,.L3
            move.b  #1,($10,A6)
.L4:
            movem.l (SP)+,A3-A4
            unlk    A6
            rtd     #8
            ds.b    4
GetPicTable:
            jsr     GetLong
            cmpi.l  #$3FF,D0
            blt.b   .L1
            clr.l   -(SP)
            jsr     ([$16A0.w])
            move.l  (SP)+,D0
.L1:
            move.l  D0,-(SP)
            jsr     GetLong
            move.l  D0,-(SP)
            move.w  D0,D2
            addq.w  #1,D2
            mulu.w  #8,D2
            move.l  D2,D0
            addq.w  #8,D0
            movea.l ($C,SP),A0
            jsr     RSetHSize
            _HLock
            movea.l (A0),A0
            move.l  (SP)+,D0
            move.l  (SP)+,(A0)+
            move.l  D0,(A0)+
            move.l  A0,-(SP)
            move.w  D2,-(SP)
            jsr     GetPicData
            movea.l (4,SP),A0
            _HUnlock
            move.l  (SP)+,(SP)
            rts
            dc.w    0
PutPicTable:
            movea.l (4,SP),A0
            _HLock
            movea.l (A0),A0
            move.l  A0,-(SP)
            move.w  (6,A0),D0
            addq.w  #1,D0
            mulu.w  #8,D0
            addq.w  #8,D0
            move.w  D0,-(SP)
            jsr     PutPicData
            movea.l (4,SP),A0
            _HUnlock
            move.l  (SP)+,(SP)
            rts
            ds.b    10
GetPicPixMap:
            movea.l (4,SP),A0
            _HLock
            movea.l (A0),A0
            move.l  ($2A,A0),-(SP)
            clr.l   (A0)+
            move.l  A0,-(SP)
            move.w  #$2E,-(SP)
            jsr     GetPicData
            move.l  (SP)+,D0
            movea.l (4,SP),A0
            movea.l (A0),A0
            move.l  D0,($2A,A0)
            move.l  D0,-(SP)
            jsr     GetPicTable
            movea.l (4,SP),A0
            _HUnlock
            move.l  (SP)+,(SP)
            rts
            ds.b    12
PutPicPixMap:
            movea.l (4,SP),A0
            _HLock
            movea.l (A0),A0
            pea     (4,A0)
            move.w  #$2E,-(SP)
            jsr     PutPicData
            movea.l (4,SP),A0
            movea.l (A0),A0
            move.l  ($2A,A0),D0
            beq.b   .L1
            move.l  D0,-(SP)
            jsr     PutPicTable
.L1:
            movea.l (4,SP),A0
            _HUnlock
            move.l  (SP)+,(SP)
            rts
GetPicPixPat:
            moveq   #$A,D0
            suba.w  D0,SP
            move.l  SP,-(SP)
            move.w  D0,-(SP)
            jsr     GetPicData
            cmpi.w  #2,(SP)
            bne.w   PutGray.L3
            subq.w  #6,SP
            bsr.w   GetLong
            move.l  D0,(SP)
            bsr.w   GetWord
            move.w  D0,(4,SP)
            tst.w   (6,A3)
            bmi.b   PutGray.L2
            move.l  SP,-(SP)
            move.l  ($1C,SP),-(SP)
            bsr.b   PutGray
            lea     ($10,SP),SP
            bra.w   PutGray.L6
PutGray:
            movea.l (8,SP),A1
            move.w  (A1)+,D0
            mulu.w  #$4CCC,D0
            move.w  (A1)+,D1
            mulu.w  #$970A,D1
            add.l   D1,D0
            move.w  (A1)+,D1
            mulu.w  #$1C28,D1
            add.l   D1,D0
            clr.w   D0
            rol.l   #3,D0
            lea     .L1,A0
            lea     (0,A0,D0.w*4),A0
            movea.l (4,SP),A1
            move.l  (A0),(A1)+
            move.l  (A0),(A1)
            rtd     #8
.L1:
            dc.w    $FFFF,$FFFF,$DDFF,$77FF,$FF55,$FF55,$EE55,$BB55
            dc.b    $AA,$55,$AA,$55,$88,$55,$22,$55,$88,$00,$22
            ds.b    5
.L2:
            move.l  ($14,SP),-(SP)
            pea     (4,SP)
            jsr     ([$1634.w])
            addq.w  #6,SP
.L3:
            tst.w   (6,A3)
            bmi.b   .L4
            movea.l ($12,SP),A1
            move.w  (SP)+,D0
            move.l  (SP)+,(A1)+
            move.l  (SP)+,(A1)+
            movea.l (8,A6),A2
            move.l  ($3A,A2),-(SP)
            bsr.b   GETPMD
            bra.b   .L6
.L4:
            movea.l ($E,SP),A0
            movea.l (A0),A0
            move.w  (SP)+,(A0)
            move.l  (SP)+,($14,A0)
            move.l  (SP)+,($18,A0)
            cmpi.w  #2,(A0)
            beq.b   .L5
            move.l  (4,SP),-(SP)
            bsr.b   GETPMD
.L5:
            move.l  (4,SP),-(SP)
            jsr     ([$1A4C.w])
.L6:
            rtd     #8
GETPMD:
            movea.l (4,SP),A0
            movea.l (A0),A0
            move.l  (2,A0),-(SP)
            jsr     GetPicPixMap
            movea.l (4,SP),A0
            movea.l (A0),A0
            movea.l (2,A0),A1
            movea.l (A1),A1
            movea.l (6,A0),A0
            move.w  ($A,A1),D1
            sub.w   (6,A1),D1
            move.w  (4,A1),D0
            andi.w  #$7FFF,D0
            mulu.w  D1,D0
            jsr     RSetHSize
            movea.l (4,SP),A0
            movea.l (A0),A0
            movea.l (6,A0),A0
            _HLock
            movea.l A0,A1
            movea.l (4,SP),A0
            movea.l (A0),A0
            movea.l (2,A0),A0
            move.l  A0,-(SP)
            move.l  A1,-(SP)
            _HLock
            move.l  (A0),-(SP)
            move.l  A1,-(SP)
            jsr     GetPMData
            movea.l (SP)+,A0
            _HUnlock
            movea.l (SP)+,A0
            _HUnlock
            rtd     #4
            ds.b    8
PutPicPixPat:
            move.l  A2,-(SP)
            movea.l (8,SP),A0
            _HLock
            movea.l (A0),A2
            movea.l (2,A2),A0
            movea.l (A0),A0
            move.w  (A2),-(SP)
            jsr     PutPicWord
            move.l  ($14,A2),-(SP)
            jsr     PutPicLong
            move.l  ($18,A2),-(SP)
            jsr     PutPicLong
            cmpi.w  #2,(A2)
            bne.b   .L1
            movea.l (2,A2),A0
            movea.l (A0),A0
            movea.l ($2A,A0),A0
            movea.l (A0),A0
            lea     ($28,A0),A0
            move.w  (6,A0),-(SP)
            move.l  (2,A0),-(SP)
            jsr     PutPicLong
            jsr     PutPicWord
            bra.b   .L2
.L1:
            move.l  (2,A2),-(SP)
            jsr     PutPicPixMap
            movea.l (6,A2),A0
            _HLock
            movea.l (2,A2),A1
            movea.l (A1),A1
            move.l  A1,-(SP)
            move.l  (A0),-(SP)
            move.w  (4,A1),D0
            andi.w  #$7FFF,D0
            move.w  D0,-(SP)
            jsr     PutPMData
            movea.l (6,A2),A0
            _HUnlock
.L2:
            movea.l (8,SP),A0
            _HUnlock
            movea.l (SP)+,A2
            move.l  (SP)+,(SP)
            rts
            ds.b    10
GETDIRECTPMDATA:
            link.w  A6,#-$14
            movem.l D3-D7/A2-A4,-(SP)
            move.l  SP,(-$14,A6)
            movea.l ($C,A6),A2
            movea.l (8,A6),A0
            movea.l (A0),A3
            moveq   #8,D6
            move.w  ($A,A2),D7
            sub.w   (6,A2),D7
            move.w  (4,A2),D5
            andi.w  #$7FFF,D5
            cmp.w   D6,D5
            blt.w   .L23
            cmpi.w  #4,($10,A2)
            bgt.w   .L17
            beq.b   .L2
            cmpi.w  #3,($10,A2)
            beq.w   .L12
            move.w  D5,D0
            mulu.w  D7,D0
            lsr.l   #2,D0
            move.l  D0,D7
            add.l   D0,D0
            add.l   D7,D0
            move.l  A3,-(SP)
            add.l   D7,(SP)
            move.l  D0,-(SP)
            jsr     GETBIGPICDATA
            movea.l A3,A0
            movea.l A3,A1
            adda.l  D7,A1
.L1:
            clr.b   (A0)+
            move.b  (A1)+,(A0)+
            move.b  (A1)+,(A0)+
            move.b  (A1)+,(A0)+
            subq.l  #1,D7
            bhi.b   .L1
            bra.w   .L24
.L2:
            suba.w  D5,SP
            move.l  SP,(-$C,A6)
            suba.w  D5,SP
            move.w  D5,D0
            lsr.w   #7,D0
            addq.w  #2,D0
            bclr    #0,D0
            suba.w  D0,SP
            move.l  SP,(-$10,A6)
            cmpi.w  #4,($22,A2)
            beq.b   .L5
            move.w  D5,D1
            mulu.w  D7,D1
            lsr.l   #2,D1
            move.w  D1,D2
            swap    D1
            moveq   #0,D3
            movea.l A3,A0
            bra.b   .L4
.L3:
            move.l  D3,(A0)+
.L4:
            dbra    D2,.L3
            dbra    D1,.L4
.L5:
            addq.w  #4,A3
            suba.w  ($22,A2),A3
            move.w  D5,D4
            lsr.w   #2,D4
            mulu.w  ($22,A2),D4
            bra.b   .L11
.L6:
            cmpi.w  #$FA,D5
            bgt.b   .L7
            jsr     GetUByte
            bra.b   .L8
.L7:
            jsr     GetWord
.L8:
            move.l  (-$10,A6),-(SP)
            move.l  (SP),(-4,A6)
            move.w  D0,-(SP)
            jsr     GetPicData
            move.l  (-$C,A6),(-8,A6)
            pea     (-4,A6)
            pea     (-8,A6)
            move.w  D4,-(SP)
            jsr     ([$1140.w])
            move.w  ($22,A2),D3
            subq.w  #1,D3
            movea.l (-$C,A6),A0
            move.w  D5,D0
            lsr.w   #2,D0
            subq.w  #1,D0
.L9:
            movea.l A3,A4
            addq.w  #1,A3
            move.w  D0,D6
.L10:
            move.b  (A0)+,(A4)
            addq.w  #4,A4
            dbra    D6,.L10
            dbra    D3,.L9
            suba.w  ($22,A2),A3
            adda.w  D5,A3
.L11:
            dbra    D7,.L6
            bra.b   .L24
.L12:
            suba.w  D5,SP
            suba.w  D5,SP
            move.l  SP,(-$10,A6)
            move.l  A3,(-8,A6)
            bra.b   .L16
.L13:
            cmpi.w  #$FA,D5
            bgt.b   .L14
            jsr     GetUByte
            bra.b   .L15
.L14:
            jsr     GetWord
.L15:
            move.l  (-$10,A6),-(SP)
            move.l  (SP),(-4,A6)
            move.w  D0,-(SP)
            jsr     GetPicData
            pea     (-4,A6)
            pea     (-8,A6)
            move.w  D5,-(SP)
            jsr     UNPACKWORDS
.L16:
            dbra    D7,.L13
            bra.b   .L24
.L17:
            move.w  D5,D6
            mulu.w  D7,D6
            bra.b   .L21
.L18:
            cmpi.w  #$FA,D5
            bgt.b   .L19
            jsr     GetUByte
            bra.b   .L20
.L19:
            jsr     GetWord
.L20:
            move.l  A3,-(SP)
            move.w  D0,-(SP)
            jsr     GetPicData
.L21:
            dbra    D7,.L18
            movea.l A3,A0
.L22:
            clr.b   (A0)+
            subq.l  #1,D6
            bhi.b   .L22
            bra.b   .L24
.L23:
            mulu.w  D7,D5
            move.l  A3,-(SP)
            move.l  D5,-(SP)
            jsr     GETBIGPICDATA
.L24:
            movea.l (8,A6),A0
            movea.l (-$14,A6),SP
            movem.l (SP)+,D3-D7/A2-A4
            unlk    A6
            rtd     #8
            ds.b    12
PUTDIRECTPMDATA:
            link.w  A6,#-$14
            movem.l D3-D7/A2-A4,-(SP)
            move.l  SP,(-$14,A6)
            movea.l ($E,A6),A2
            movea.l ($A,A6),A3
            move.w  (8,A6),D4
            moveq   #8,D6
            move.w  ($A,A2),D7
            sub.w   (6,A2),D7
            move.l  SP,D1
            andi.b  #$FC,D1
            movea.l D1,SP
            move.w  (4,A2),D5
            andi.w  #$7FFF,D5
            cmp.w   D6,D5
            blt.w   .L17
            cmpi.w  #2,($10,A2)
            blt.w   .L17
            beq.w   .L12
            cmpi.w  #3,($10,A2)
            beq.w   .L7
            suba.w  D5,SP
            move.l  SP,(-$C,A6)
            suba.w  D5,SP
            move.w  D5,D0
            lsr.w   #8,D0
            addq.w  #1,D0
            add.l   D0,D0
            suba.w  D0,SP
            move.l  SP,(-$10,A6)
            addq.w  #4,A3
            suba.w  ($22,A2),A3
            bra.b   .L6
.L1:
            move.w  ($22,A2),D3
            subq.w  #1,D3
            movea.l (-$C,A6),A0
            move.w  D5,D0
            lsr.w   #2,D0
            subq.w  #1,D0
.L2:
            movea.l A3,A4
            addq.w  #1,A3
            move.w  D0,D6
.L3:
            move.b  (A4),(A0)+
            addq.w  #4,A4
            dbra    D6,.L3
            dbra    D3,.L2
            suba.w  ($22,A2),A3
            move.l  (-$C,A6),(-4,A6)
            movea.l (-$10,A6),A0
            move.l  A0,(-8,A6)
            pea     (-4,A6)
            pea     (-8,A6)
            addq.w  #1,D0
            mulu.w  ($22,A2),D0
            move.w  D0,-(SP)
            jsr     ([$113C.w])
            move.l  (-8,A6),D6
            movea.l (-$10,A6),A0
            sub.l   A0,D6
            cmpi.w  #$FA,D5
            bgt.b   .L4
            move.b  D6,-(SP)
            jsr     PutPicByte
            bra.b   .L5
.L4:
            move.w  D6,-(SP)
            jsr     PutPicWord
.L5:
            move.l  (-$10,A6),-(SP)
            move.w  D6,-(SP)
            jsr     PutPicData
            adda.w  D4,A3
.L6:
            dbra    D7,.L1
            bra.w   .L18
.L7:
            suba.w  D5,SP
            suba.w  D5,SP
            move.l  SP,(-$10,A6)
            bra.b   .L11
.L8:
            move.l  A3,(-4,A6)
            movea.l (-$10,A6),A0
            move.l  A0,(-8,A6)
            pea     (-4,A6)
            pea     (-8,A6)
            move.w  D5,-(SP)
            jsr     PACKWORDS
            move.l  (-8,A6),D6
            movea.l (-$10,A6),A0
            sub.l   A0,D6
            cmpi.w  #$FA,D5
            bgt.b   .L9
            move.b  D6,-(SP)
            jsr     PutPicByte
            bra.b   .L10
.L9:
            move.w  D6,-(SP)
            jsr     PutPicWord
.L10:
            move.l  (-$10,A6),-(SP)
            move.w  D6,-(SP)
            jsr     PutPicData
            adda.w  D4,A3
.L11:
            dbra    D7,.L8
            bra.w   .L18
.L12:
            suba.w  D5,SP
            move.l  SP,(-$C,A6)
            move.w  D5,D6
            lsr.w   #2,D6
            subq.w  #1,D6
            bra.b   .L15
.L13:
            movea.l (-$C,A6),A0
            movea.l A3,A4
            move.w  D6,D0
.L14:
            addq.w  #1,A4
            move.b  (A4)+,(A0)+
            move.b  (A4)+,(A0)+
            move.b  (A4)+,(A0)+
            dbra    D0,.L14
            suba.l  (-$C,A6),A0
            move.l  (-$C,A6),-(SP)
            move.w  A0,-(SP)
            jsr     PutPicData
            adda.w  D4,A3
.L15:
            dbra    D7,.L13
            bra.b   .L18
.L16:
            move.l  A3,-(SP)
            move.w  D5,-(SP)
            jsr     PutPicData
            adda.w  D4,A3
.L17:
            dbra    D7,.L16
.L18:
            movea.l (-$14,A6),SP
            movem.l (SP)+,D3-D7/A2-A4
            unlk    A6
            rtd     #$A
            ds.b    12
GETBIGPICDATA:
            movem.l D7/A3-A4,-(SP)
            movea.l ($14,SP),A3
            movea.l ($10,SP),A4
            move.l  A4,D7
            moveq   #$E,D0
            lsr.l   D0,D7
            beq.b   .L2
.L1:
            move.l  A3,-(SP)
            move.w  #$4000,-(SP)
            jsr     GetPicData
            lea     ($4000,A3),A3
            suba.w  #$4000,A4
            subq.l  #1,D7
            bne.b   .L1
.L2:
            move.l  A3,-(SP)
            move.w  A4,-(SP)
            jsr     GetPicData
            movem.l (SP)+,D7/A3-A4
            rtd     #8
            ds.b    6
PUTBIGPICDATA:
            movem.l D7/A3-A4,-(SP)
            movea.l ($14,SP),A3
            movea.l ($10,SP),A4
            move.l  A4,D7
            moveq   #$E,D0
            lsr.l   D0,D7
            beq.b   .L2
.L1:
            move.l  A3,-(SP)
            move.w  #$4000,-(SP)
            jsr     PutPicData
            lea     ($4000,A3),A3
            suba.w  #$4000,A4
            subq.l  #1,D7
            bne.b   .L1
.L2:
            move.l  A3,-(SP)
            move.w  A4,-(SP)
            jsr     PutPicData
            movem.l (SP)+,D7/A2-A4
            rtd     #8
            ds.b    6
GetPMData:
            link.w  A6,#-$10
            movem.l D4-D6/A2-A3,-(SP)
            move.l  SP,(-$10,A6)
            movea.l ($C,A6),A2
            movea.l (8,A6),A0
            movea.l (A0),A3
            moveq   #8,D6
            move.w  ($A,A2),D4
            sub.w   (6,A2),D4
            move.w  (4,A2),D5
            andi.w  #$7FFF,D5
            cmp.w   D6,D5
            blt.b   .L6
            tst.w   (4,A2)
            bpl.b   .L1
            cmpi.w  #$10,($1E,A2)
            bne.b   .L1
            cmpi.w  #1,($10,A2)
            beq.b   .L6
            movem.l (SP)+,D4-D6/A2-A3
            unlk    A6
            jmp     GETDIRECTPMDATA
.L1:
            move.l  SP,D1
            andi.b  #$FC,D1
            movea.l D1,SP
            suba.w  D5,SP
            suba.w  D5,SP
            move.l  SP,(-$C,A6)
            move.l  A3,(-8,A6)
            bra.b   .L5
.L2:
            cmpi.w  #$FA,D5
            bgt.b   .L3
            jsr     GetUByte
            bra.b   .L4
.L3:
            jsr     GetWord
.L4:
            move.l  (-$C,A6),-(SP)
            move.l  (SP),(-4,A6)
            move.w  D0,-(SP)
            jsr     GetPicData
            pea     (-4,A6)
            pea     (-8,A6)
            move.w  D5,-(SP)
            jsr     ([$1140.w])
.L5:
            dbra    D4,.L2
            bra.b   .L7
.L6:
            mulu.w  D4,D5
            move.l  A3,-(SP)
            move.l  D5,-(SP)
            jsr     GETBIGPICDATA
.L7:
            movea.l (8,A6),A0
            movea.l (-$10,A6),SP
            movem.l (SP)+,D4-D6/A2-A3
            unlk    A6
            rtd     #8
            ds.b    14
PutPMData:
            link.w  A6,#-$10
            movem.l D4-D7/A2-A3,-(SP)
            move.l  SP,(-$10,A6)
            movea.l ($E,A6),A2
            movea.l ($A,A6),A3
            move.w  (8,A6),D4
            moveq   #8,D6
            move.w  ($A,A2),D7
            sub.w   (6,A2),D7
            move.w  (4,A2),D5
            andi.w  #$7FFF,D5
            cmp.w   D6,D5
            blt.b   .L6
            move.l  SP,D1
            andi.b  #$FC,D1
            movea.l D1,SP
            suba.w  D5,SP
            suba.w  D5,SP
            move.l  SP,(-$C,A6)
            bra.b   .L4
.L1:
            move.l  A3,(-4,A6)
            movea.l (-$C,A6),A0
            move.l  A0,(-8,A6)
            pea     (-4,A6)
            pea     (-8,A6)
            move.w  D5,-(SP)
            jsr     ([$113C.w])
            move.l  (-8,A6),D6
            movea.l (-$C,A6),A0
            sub.l   A0,D6
            cmpi.w  #$FA,D5
            bgt.b   .L2
            move.b  D6,-(SP)
            jsr     PutPicByte
            bra.b   .L3
.L2:
            move.w  D6,-(SP)
            jsr     PutPicWord
.L3:
            move.l  (-$C,A6),-(SP)
            move.w  D6,-(SP)
            jsr     PutPicData
            adda.w  D4,A3
.L4:
            dbra    D7,.L1
            bra.b   .L7
.L5:
            move.l  A3,-(SP)
            move.w  D5,-(SP)
            jsr     PutPicData
            adda.w  D4,A3
.L6:
            dbra    D7,.L5
.L7:
            movea.l (-$10,A6),SP
            movem.l (SP)+,D4-D7/A2-A3
            unlk    A6
            rtd     #$A
            ds.b    8
CheckPic:
            movem.l D6-D7,-(SP)
            movea.l (A5),A4
            movea.l (A4),A3
            tst.l   ($5C,A3)
            beq.w   .L18
            cmpi.w  #$FFFF,($42,A3)
            blt.w   .L18
            movea.l ($5C,A3),A4
            movea.l (A4),A4
            cmpi.w  #1,($62,A4)
            beq.w   .L7
            tst.w   (6,A3)
            bpl.w   .L6
            movea.l (8,A3),A0
            movea.l (A0),A0
            move.l  (A0),D7
            move.w  (4,A0),D6
            cmp.l   ($74,A4),D7
            bne.b   .L1
            cmp.w   ($78,A4),D6
            beq.b   .L2
.L1:
            moveq   #$1F,D0
            jsr     DPutPicOp
            move.l  D7,-(SP)
            jsr     PutPicLong
            move.w  D6,-(SP)
            jsr     PutPicWord
            movea.l ($5C,A3),A4
            movea.l (A4),A4
            move.l  D7,($74,A4)
            move.w  D6,($78,A4)
.L2:
            movea.l (8,A3),A0
            movea.l (A0),A0
            move.l  (6,A0),D7
            move.w  ($A,A0),D6
            cmp.l   ($7A,A4),D7
            bne.b   .L3
            cmp.w   ($7E,A4),D6
            beq.b   .L6
.L3:
            cmp.l   ($DA0).w,D7
            bne.b   .L4
            cmp.w   ($DA4).w,D6
            bne.b   .L4
            moveq   #$1E,D0
            jsr     DPutPicOp
            bra.b   .L5
.L4:
            moveq   #$1D,D0
            jsr     DPutPicOp
            move.l  D7,-(SP)
            jsr     PutPicLong
            move.w  D6,-(SP)
            jsr     PutPicWord
.L5:
            movea.l ($5C,A3),A4
            movea.l (A4),A4
            move.l  D7,($7A,A4)
            move.w  D6,($7E,A4)
.L6:
            btst    #7,HiliteMode
            bne.b   .L7
            moveq   #$1C,D0
            jsr     DPutPicOp
.L7:
            move.l  ($50,A3),D7
            tst.w   (6,A3)
            bpl.b   .L8
            move.l  ($24,A3),D7
            move.w  ($28,A3),D6
            cmpi.w  #1,($62,A4)
            bne.b   .L9
            move.w  D6,-(SP)
            move.l  D7,-(SP)
            movea.l SP,A1
            bsr.l   RGB2Old
            move.l  D0,D7
            addq.w  #6,SP
.L8:
            cmp.l   ($5A,A4),D7
            beq.b   .L11
            moveq   #$E,D0
            jsr     DPutPicOp
            move.l  D7,-(SP)
            jsr     PutPicLong
            movea.l ($5C,A3),A4
            movea.l (A4),A4
            move.l  D7,($5A,A4)
            bra.b   .L11
.L9:
            cmp.l   ($64,A4),D7
            bne.b   .L10
            cmp.w   ($68,A4),D6
            beq.b   .L11
.L10:
            moveq   #$1A,D0
            jsr     DPutPicOp
            move.l  D7,-(SP)
            jsr     PutPicLong
            move.w  D6,-(SP)
            jsr     PutPicWord
            movea.l ($5C,A3),A4
            movea.l (A4),A4
            move.l  D7,($64,A4)
            move.w  D6,($68,A4)
.L11:
            move.l  ($54,A3),D7
            tst.w   (6,A3)
            bpl.b   .L12
            move.l  ($2A,A3),D7
            move.w  ($2E,A3),D6
            cmpi.w  #1,($62,A4)
            bne.b   .L13
            move.w  D6,-(SP)
            move.l  D7,-(SP)
            movea.l SP,A1
            bsr.l   RGB2Old
            move.l  D0,D7
            addq.w  #6,SP
.L12:
            cmp.l   ($5E,A4),D7
            beq.b   .L15
            moveq   #$F,D0
            jsr     DPutPicOp
            move.l  D7,-(SP)
            jsr     PutPicLong
            movea.l ($5C,A3),A4
            movea.l (A4),A4
            move.l  D7,($5E,A4)
            bra.b   .L15
.L13:
            cmp.l   ($6A,A4),D7
            bne.b   .L14
            cmp.w   ($6E,A4),D6
            beq.b   .L15
.L14:
            moveq   #$1B,D0
            jsr     DPutPicOp
            move.l  D7,-(SP)
            jsr     PutPicLong
            move.w  D6,-(SP)
            jsr     PutPicWord
            movea.l ($5C,A3),A4
            movea.l (A4),A4
            move.l  D7,($6A,A4)
            move.w  D6,($6E,A4)
.L15:
            move.l  ($10,A3),D0
            cmp.l   ($56,A4),D0
            beq.b   .L16
            move.w  ($12,A3),D7
            sub.w   ($58,A4),D7
            add.w   D7,($58,A4)
            swap    D7
            move.w  ($10,A3),D7
            sub.w   ($56,A4),D7
            add.w   D7,($56,A4)
            moveq   #$C,D0
            jsr     DPutPicOp
            move.l  D7,-(SP)
            jsr     PutPicLong
            movea.l ($5C,A3),A4
            movea.l (A4),A4
.L16:
            clr.b   -(SP)
            move.l  ($1C,A3),-(SP)
            move.l  ($C,A4),-(SP)
            jsr     ([$118C.w])
            tst.b   (SP)+
            bne.b   .L17
            move.l  ($1C,A3),-(SP)
            move.l  ($C,A4),-(SP)
            moveq   #1,D0
            jsr     DPutPicOp
            move.l  ($1C,A3),-(SP)
            jsr     PutPicRgn
            jsr     ([$1170.w])
.L17:
            movea.l (A5),A4
            moveq   #1,D0
.L18:
            movem.l (SP)+,D6-D7
            rts
            dc.w    0
ScalePt:
            link.w  A6,#0
            movem.l D0-D3/A0-A2,-(SP)
            movea.l ($10,A6),A0
            movea.l ($C,A6),A1
            movea.l (8,A6),A2
            bsr.b   SCALE1
            addq.w  #2,A0
            addq.w  #2,A1
            addq.w  #2,A2
            bsr.b   SCALE1
            movem.l (SP)+,D0-D3/A0-A2
            unlk    A6
            rtd     #$C
SCALE1:
            move.w  (4,A1),D3
            sub.w   (A1),D3
            move.w  (4,A2),D2
            sub.w   (A2),D2
            cmp.w   D2,D3
            beq.b   .L3
            move.w  D3,D1
            lsr.w   #1,D1
            ext.l   D1
            move.w  (A0),D0
            bgt.b   .L1
            clr.w   (A0)
            rts
.L1:
            mulu.w  D2,D0
            add.l   D1,D0
            divu.w  D3,D0
            bne.b   .L2
            moveq   #1,D0
.L2:
            move.w  D0,(A0)
.L3:
            rts
            ds.b    12
MapPt:
            link.w  A6,#0
            movem.l D0-D5/A0-A2,-(SP)
            movea.l ($10,A6),A0
            movea.l ($C,A6),A1
            movea.l (8,A6),A2
            bsr.b   MAP1_Pictures
            addq.w  #2,A0
            addq.w  #2,A1
            addq.w  #2,A2
            bsr.b   MAP1_Pictures
            movem.l (SP)+,D0-D5/A0-A2
            unlk    A6
            rtd     #$C
MAP1_Pictures:
            move.w  (A1),D2
            move.w  (4,A1),D3
            sub.w   D2,D3
            move.w  (A2),D4
            move.w  (4,A2),D5
            sub.w   D4,D5
            move.w  (A0),D0
            sub.w   D2,D0
            cmp.w   D3,D5
            beq.b   .L2
            move.w  D3,D1
            lsr.w   #1,D1
            ext.l   D1
            move.w  D0,D2
            bpl.b   .L1
            neg.w   D0
.L1:
            mulu.w  D5,D0
            add.l   D1,D0
            divu.w  D3,D0
            tst.w   D2
            bpl.b   .L2
            neg.w   D0
.L2:
            add.w   D4,D0
            move.w  D0,(A0)
            rts
            dc.w    0
MapFixPt:
            link.w  A6,#0
            movem.l D0-D7/A0-A2,-(SP)
            movea.l ($10,A6),A0
            movea.l ($C,A6),A1
            movea.l (8,A6),A2
            bsr.b   MAP1_Pictures_2
            addq.w  #4,A0
            addq.w  #2,A1
            addq.w  #2,A2
            bsr.b   MAP1_Pictures_2
            movem.l (SP)+,D0-D7/A0-A2
            unlk    A6
            rtd     #$C
MAP1_Pictures_2:
            move.l  (A1),D2
            clr.w   D2
            move.l  (4,A1),D3
            clr.w   D3
            sub.l   D2,D3
            move.l  (A2),D4
            clr.w   D4
            move.l  (4,A2),D5
            clr.w   D5
            sub.l   D4,D5
            move.l  (A0),D0
            sub.l   D2,D0
            cmp.l   D3,D5
            beq.b   .L1
            muls.l  D5,D6:D0
            divs.l  D3,D6:D0
.L1:
            add.l   D4,D0
            move.l  D0,(A0)
            rts
            ds.b    10
MapRect:
            move.l  ($C,SP),-(SP)
            move.l  ($C,SP),-(SP)
            move.l  ($C,SP),-(SP)
            bsr.w   MapPt
            addq.l  #4,($C,SP)
            bra.w   MapPt
            ds.b    8
MapRatio:
            link.w  A6,#0
            movem.l D0-D1/A0-A2,-(SP)
            movea.l ($10,A6),A0
            movea.l ($C,A6),A1
            movea.l (8,A6),A2
            move.w  (6,A2),D0
            sub.w   (2,A2),D0
            move.w  (2,A0),D1
            mulu.w  D0,D1
            divu.w  (2,A1),D1
            move.w  D1,(2,A0)
            move.w  D0,(2,A1)
            move.w  (4,A2),D0
            sub.w   (A2),D0
            move.w  (A0),D1
            mulu.w  D0,D1
            divu.w  (A1),D1
            move.w  D1,(A0)
            move.w  D0,(A1)
            movem.l (SP)+,D0-D1/A0-A2
            unlk    A6
            rtd     #$C
            ds.b    8
StdPoly:
            link.w  A6,#-8
            movem.l D5-D7/A2-A4,-(SP)
            moveq   #0,D7
            move.b  ($C,A6),D7
            jsr     ([$1A3C.w])
            ble.b   .L1
            move.b  D7,-(SP)
            jsr     PutPicVerb
            moveq   #$70,D0
            add.w   D7,D0
            jsr     DPutPicOp
            move.l  (8,A6),-(SP)
            jsr     PutPicRgn
.L1:
            pea     StdDraw_Polygons
            pea     GetRect_Polygons
            jsr     ([$1AA0.w])
            movem.l (SP)+,D5-D7/A2-A4
            unlk    A6
            rtd     #6
GetRect_Polygons:
            move.l  (SP)+,D0
            movea.l (SP)+,A1
            move.l  D0,-(SP)
            movea.l (8,A6),A0
            movea.l (A0),A0
            lea     (2,A0),A0
            move.l  (A0)+,(A1)+
            move.l  (A0),(A1)
            pea     (-4,A1)
            move.l  ($34,A3),D0
            neg.w   D0
            move.w  D0,-(SP)
            swap    D0
            neg.w   D0
            move.w  D0,-(SP)
            jsr     ([$10A4.w])
            rts
StdDraw_Polygons:
            movea.l (8,A6),A2
            tst.b   D7
            bne.b   .L1
            move.l  A2,-(SP)
            jsr     FrPoly
            bra.b   .L2
.L1:
            movea.l (A2),A0
            pea     (2,A0)
            movea.l ($18,A3),A0
            movea.l (A0),A0
            pea     (2,A0)
            movea.l ($1C,A3),A0
            movea.l (A0),A0
            pea     (2,A0)
            move.w  #3,-(SP)
            pea     (-8,A6)
            jsr     ([$1A84.w])
            beq.b   .L2
            move.l  A2,-(SP)
            jsr     ([$1A60.w])
            jsr     DrawPoly
.L2:
            rts
            ds.b    6
FramePoly:
            moveq   #0,D0
            bra.b   CallPoly
PaintPoly:
            moveq   #1,D0
            bra.b   CallPoly
ErasePoly:
            moveq   #2,D0
            bra.b   CallPoly
InvertPoly:
            moveq   #3,D0
            bra.b   CallPoly
FillPoly:
            moveq   #0,D0
            bra.b   FillCPoly.L1
FillCPoly:
            moveq   #1,D0
.L1:
            movea.l (SP)+,A0
            movea.l (SP)+,A1
            move.l  A0,-(SP)
            move.l  A1,-(SP)
            jsr     ([$1A8C.w])
            moveq   #4,D0
CallPoly:
            movea.l (SP)+,A0
            movea.l (SP)+,A1
            move.b  D0,-(SP)
            move.l  A1,-(SP)
            move.l  A0,-(SP)
            movea.l (A5),A0
            movea.l (A0),A0
            move.l  ($68,A0),D0
            movea.l ($1114).w,A0
            beq.b   .L1
            movea.l D0,A0
            movea.l ($18,A0),A0
.L1:
            jmp     (A0)
            ds.b    10
OpenPoly:
            jsr     ([$1058.w])
            clr.l   -(SP)
            move.w  #$8A,-(SP)
            jsr     NewHandle
            movea.l (SP)+,A1
            move.l  A1,(4,SP)
            movea.l (A5),A0
            move.l  A1,(-$A2,A0)
            move.w  #$8A,(-$A4,A0)
            movea.l (A0),A0
            moveq   #1,D0
            move.l  D0,($64,A0)
            movea.l (A1),A1
            move.w  #$A,(A1)+
            clr.l   (A1)+
            clr.l   (A1)+
            rts
            ds.b    10
ClosePoly:
            movem.l D3-D7/A4,-(SP)
            movea.l (A5),A4
            movea.l (A4),A0
            clr.l   ($64,A0)
            movea.l (-$A2,A4),A4
            movea.l (A4),A0
            move.w  (A0)+,D7
            clr.l   (A0)+
            clr.l   (A0)+
            move.w  D7,D6
            subi.w  #$A,D6
            lsr.w   #2,D6
            beq.b   .L6
            move.w  (A0)+,D1
            move.w  D1,D2
            move.w  (A0)+,D3
            move.w  D3,D4
            subq.w  #1,D6
            bra.b   .L5
.L1:
            move.w  (A0)+,D0
            cmp.w   D1,D0
            bge.b   .L2
            move.w  D0,D1
.L2:
            cmp.w   D2,D0
            ble.b   .L3
            move.w  D0,D2
.L3:
            move.w  (A0)+,D0
            cmp.w   D3,D0
            bge.b   .L4
            move.w  D0,D3
.L4:
            cmp.w   D4,D0
            ble.b   .L5
            move.w  D0,D4
.L5:
            dbra    D6,.L1
            movea.l (A4),A0
            lea     (2,A0),A0
            move.w  D1,(A0)+
            move.w  D3,(A0)+
            move.w  D2,(A0)+
            move.w  D4,(A0)+
.L6:
            move.l  A4,-(SP)
            move.w  D7,-(SP)
            jsr     SetHSize
            jsr     ([$105C.w])
            movem.l (SP)+,D3-D7/A4
            rts
KillPoly:
            movea.l (SP)+,A1
            movea.l (SP)+,A0
            _DisposHandle
            jmp     (A1)
            ds.b    8
OffsetPoly:
            movea.l (SP)+,A0
            move.w  (SP)+,D0
            move.w  (SP)+,D1
            movea.l (SP)+,A1
            movea.l (A1),A1
            move.w  (A1)+,D2
            subq.w  #2,D2
            lsr.w   #2,D2
            subq.w  #1,D2
.L1:
            add.w   D0,(A1)+
            add.w   D1,(A1)+
            dbra    D2,.L1
            jmp     (A0)
            ds.b    4
MapPoly:
            link.w  A6,#0
            movem.l D7/A2-A4,-(SP)
            movea.l ($C,A6),A2
            movea.l (8,A6),A3
            move.l  (A2),D0
            cmp.l   (A3),D0
            bne.b   .L1
            move.l  (4,A2),D0
            cmp.l   (4,A3),D0
            beq.b   .L4
.L1:
            movea.l ($10,A6),A4
            movea.l (A4),A4
            pea     (2,A4)
            move.l  A2,-(SP)
            move.l  A3,-(SP)
            jsr     ([$11E8.w])
            moveq   #$A,D0
            move.w  (A4),D7
            sub.w   D0,D7
            lsr.w   #2,D7
            adda.w  D0,A4
            bra.b   .L3
.L2:
            move.l  A4,-(SP)
            move.l  A2,-(SP)
            move.l  A3,-(SP)
            jsr     ([$11E4.w])
            addq.w  #4,A4
.L3:
            dbra    D7,.L2
.L4:
            movem.l (SP)+,D7/A2-A4
            unlk    A6
            rtd     #$C
            ds.b    4
FrPoly:
            link.w  A6,#0
            movem.l D6-D7/A4,-(SP)
            movea.l (8,A6),A4
            movea.l (A4),A0
            move.w  (A0),D7
            subi.w  #$A,D7
            lsr.w   #2,D7
            beq.b   .L3
            move.l  ($A,A0),-(SP)
            jsr     ([$104C.w])
            moveq   #$E,D6
            subq.w  #1,D7
            bra.b   .L2
.L1:
            move.b  HiliteMode,-(SP)
            movea.l (A4),A0
            move.l  (0,A0,D6.w),-(SP)
            addq.w  #4,D6
            jsr     ([$1A40.w])
            move.b  (SP)+,HiliteMode
.L2:
            dbra    D7,.L1
.L3:
            movem.l (SP)+,D6-D7/A4
            bset    #7,HiliteMode
            unlk    A6
            rtd     #4
            ds.b    14
XDrawPoly:
SortVectors:
            link.w  A6,#0
            movem.l D3-D4/A2-A4,-(SP)
            movea.l ($A,A6),A3
            move.w  A3,D3
            andi.w  #7,D3
            moveq   #0,D0
            move.w  (8,A6),D0
            ble.b   .L10
            lsl.l   #3,D0
            movea.l A3,A4
            adda.l  D0,A4
            subq.l  #8,A4
            move.l  SP,D4
            movem.l A3-A4,-(SP)
.L1:
            movem.l (SP)+,A3-A4
.L2:
            movea.l A3,A1
            movea.l A4,A2
            move.l  A3,D0
            add.l   A4,D0
            roxr.l  #1,D0
            andi.w  #$FFF8,D0
            or.w    D3,D0
            movea.l D0,A0
            move.w  (2,A0),D1
            move.w  (A0),D2
            bra.b   .L4
.L3:
            addq.l  #8,A1
.L4:
            cmp.w   (A1),D2
            bgt.b   .L3
            blt.b   .L6
            cmp.w   (2,A1),D1
            bgt.b   .L3
            bra.b   .L6
.L5:
            subq.l  #8,A2
.L6:
            cmp.w   (A2),D2
            blt.b   .L5
            bgt.b   .L7
            cmp.w   (2,A2),D1
            blt.b   .L5
.L7:
            cmpa.l  A2,A1
            bgt.b   .L8
            move.l  (A1),D0
            move.l  (A2),(A1)
            move.l  D0,(A2)
            move.l  (4,A1),D0
            move.l  (4,A2),(4,A1)
            move.l  D0,(4,A2)
            addq.l  #8,A1
            subq.l  #8,A2
.L8:
            cmpa.l  A2,A1
            bls.b   .L4
            cmpa.l  A4,A1
            bcc.b   .L9
            movem.l A1/A4,-(SP)
.L9:
            movea.l A2,A4
            cmpa.l  A4,A3
            bcs.b   .L2
            cmpa.l  D4,SP
            bne.b   .L1
.L10:
            movem.l (SP)+,D3-D4/A2-A4
            unlk    A6
            rtd     #6
PaintVector:
            link.w  A6,#-$144
            movem.l D3-D7/A2-A4,-(SP)
            move.l  SP,(-$144,A6)
            clr.l   (-$20,A6)
            movea.l (A5),A0
            movea.l (A0),A4
            tst.w   ($42,A4)
            blt.w   .L57
            lea     (-$88,A6),A0
            move.l  A0,(A0)
            clr.l   (-$96,A6)
            clr.w   (-$8A,A6)
            move.w  #1,(-$8E,A6)
            move.l  SP,D1
            andi.b  #$FC,D1
            movea.l D1,SP
            lea     (2,A4),A1
            lea     (-$F4,A6),A2
            jsr     ([$1A08.w])
            move.l  D1,(-$134,A6)
            move.b  D2,(-$130,A6)
            lea     ShftTbl,A0
            move.w  (-$D4,A6),D0
            moveq   #0,D1
            move.b  (0,A0,D0.w),D1
            move.w  D1,(-$76,A6)
            move.l  (8,A6),(-$9C,A6)
            move.w  ($C,A6),D0
            bset    #3,D0
            moveq   #$10,D1
            btst    #5,D0
            beq.b   .L1
            cmpi.w  #$3A,D0
            beq.b   .L2
            moveq   #$30,D1
.L1:
            cmp.w   D1,D0
            bgt.w   .L57
.L2:
            move.w  D0,(-$98,A6)
            tst.w   (6,A4)
            smi     (-$A6,A6)
            clr.b   (-$101,A6)
            jsr     ([$1A10.w])
            movea.l ($1C,A4),A2
            movea.l (A2),A2
            movea.l ($18,A4),A3
            movea.l (A3),A3
            move.l  ($E,A6),-(SP)
            pea     (-$EE,A6)
            pea     (2,A2)
            pea     (2,A3)
            move.w  #4,-(SP)
            pea     (-$74,A6)
            jsr     ([$1A84.w])
            beq.w   .L57
            clr.b   (-$12E,A6)
            cmpi.w  #$A,(A2)
            bne.b   .L7
            cmpi.w  #$A,(A3)
            beq.b   .L3
            move.l  ($18,A4),-(SP)
            pea     (-$74,A6)
            move.w  #$FFFF,-(SP)
            jsr     ([$1AA4.w])
            blt.w   .L57
            bgt.b   .L7
.L3:
            btst    #5,(-$97,A6)
            bne.b   .L7
            movea.l (-$9C,A6),A0
            tst.b   (-$A6,A6)
            beq.b   .L4
            movea.l (A0),A0
            movea.l (A0),A0
            tst.w   (A0)
            bne.b   .L7
            movea.l (6,A0),A0
            movea.l (A0),A0
.L4:
            move.l  (A0)+,D0
            cmp.l   (A0)+,D0
            bne.b   .L7
            not.l   D0
            beq.b   .L5
            not.l   D0
            bne.b   .L7
            eori.w  #4,(-$98,A6)
.L5:
            st      (-$12E,A6)
            moveq   #7,D0
            and.w   (-$98,A6),D0
            move.b  .L6(PC,D0.w),D0
            bmi.w   .L57
            move.w  D0,(-$98,A6)
            bra.b   .L7
.L6:
            dc.w    0,$0102,$02FF,$FFFF
.L7:
            tst.b   (-$130,A6)
            beq.b   .L8
            pea     (-$74,A6)
            move.l  (-$134,A6),-(SP)
            jsr     ([$F54.w])
.L8:
            move.w  (-$76,A6),D5
            move.w  (-$72,A6),D2
            sub.w   (-$EC,A6),D2
            ext.l   D2
            lsl.l   D5,D2
            andi.l  #$FFFFFFE0,D2
            move.l  D2,D0
            lsr.l   #3,D0
            move.w  D0,(-$90,A6)
            lsr.l   D5,D2
            add.w   (-$EC,A6),D2
            move.w  D2,(-$E,A6)
            tst.b   (-$12E,A6)
            bne.w   .L10
            move.w  (-$6E,A6),D0
            sub.w   D2,D0
            move.w  D0,D1
            ext.l   D1
            lsl.l   D5,D1
            subq.l  #1,D1
            lsr.l   #5,D1
            move.w  D1,(-$10,A6)
            lsr.w   #5,D0
            addq.w  #1,D0
            lsl.w   D5,D0
            subq.w  #1,D0
.L9:
            clr.l   -(SP)
            dbra    D0,.L9
            move.l  SP,(-8,A6)
            lea     .L56,A0
            move.l  A0,(-$80,A6)
            move.l  Lo3Bytes,(-$84,A6)
            clr.l   (-$7C,A6)
            clr.l   (-$C,A6)
            move.l  ($18,A4),-(SP)
            move.l  ($1C,A4),-(SP)
            move.l  #1,-(SP)
            jsr     ([$1A34.w])
.L10:
            move.w  (-$74,A6),D1
            sub.w   (-$EE,A6),D1
            move.w  (-$F0,A6),D0
            andi.w  #$7FFF,D0
            ext.l   D0
            move.l  D0,(-$7C,A6)
            muls.w  D0,D1
            add.l   (-$F4,A6),D1
            move.w  (-$E,A6),D2
            sub.w   (-$EC,A6),D2
            move.w  (-$76,A6),D7
            lsl.w   D7,D2
            lsr.w   #3,D2
            ext.l   D2
            add.l   D2,D1
            move.l  D1,(-$124,A6)
            move.w  (-$E,A6),D1
            sub.w   D1,(-$72,A6)
            sub.w   D1,(-$6E,A6)
            move.w  (-$98,A6),D2
            tst.b   (-$12E,A6)
            beq.b   .L11
            jsr     ([$1A30.w])
            move.l  A4,(-$120,A6)
            bra.b   .L15
.L11:
            moveq   #0,D7
            move.w  (-$98,A6),D2
            btst    #5,D2
            bne.b   .L12
            bclr    #2,D2
            beq.b   .L12
            not.l   D7
.L12:
            jsr     ([$1A54.w])
            move.w  (-$8E,A6),D1
            bne.b   .L13
            moveq   #$F,D0
            moveq   #4,D1
            move.w  D1,(-$8E,A6)
            move.w  #3,(-$8C,A6)
            move.w  #$3F,(-$8A,A6)
            bra.b   .L14
.L13:
            moveq   #0,D0
            move.w  (-$8A,A6),D0
            addq.w  #1,D0
            divu.w  (-$8E,A6),D0
            subq.w  #1,D0
.L14:
            and.w   (-$74,A6),D0
            mulu.w  D1,D0
            move.l  D0,(-$96,A6)
            move.w  (-$98,A6),D2
            jsr     ([$1A94.w])
            move.l  A4,(-$120,A6)
.L15:
            moveq   #1,D0
            jsr     ([$574.w])
            move.b  D0,(-$102,A6)
            clr.l   (-$138,A6)
            clr.l   (-$140,A6)
            _StackSpace
            move.l  SP,D1
            sub.l   D0,D1
            addi.l  #$640,D1
            move.l  D1,(-$13C,A6)
            move.l  ($16,A6),D0
            jsr     ([$644.w])
            movea.l D0,A3
            move.w  (A3),D4
            move.w  D4,(-4,A6)
            move.w  ($14,A6),D3
.L16:
            suba.l  A0,A0
            suba.l  A1,A1
            tst.w   D3
            beq.w   .L29
.L17:
            cmp.w   (A3),D4
            bne.w   .L29
            movea.l (-$138,A6),A2
            move.l  A2,D0
            bne.b   .L18
            suba.w  #$14,SP
            movea.l SP,A2
            cmpa.l  (-$13C,A6),A2
            bge.b   .L19
            move.w  #$FF70,QDErr
            bra.w   .L55
.L18:
            move.l  (A2),(-$138,A6)
.L19:
            movem.l A0-A1,-(SP)
            clr.l   -(SP)
            move.l  (4,A3),-(SP)
            jsr     ([$FA4.w])
            move.l  (SP)+,D2
            movem.l (SP)+,A0-A1
            move.w  (2,A3),D1
            sub.w   (-$E,A6),D1
            swap    D1
            move.w  #$8000,D1
            move.l  D2,D0
            asr.l   #1,D0
            add.l   D0,D1
            move.l  #$10000,D0
            tst.l   D2
            bmi.b   .L20
            cmp.l   D0,D2
            bge.b   .L21
            add.l   D2,D1
            bra.b   .L21
.L20:
            cmpi.l  #$FFFF0000,D2
            bge.b   .L21
            add.l   D0,D1
.L21:
            move.l  D1,(8,A2)
            move.l  D2,($C,A2)
            moveq   #1,D1
            move.w  (4,A3),D0
            bpl.b   .L22
            neg.w   D0
            neg.w   D1
.L22:
            add.w   D4,D0
            move.w  D0,($10,A2)
            tst.b   ($12,A6)
            beq.b   .L23
            moveq   #0,D1
.L23:
            move.w  D1,($12,A2)
            move.l  A0,D0
            bne.b   .L24
            movea.l A2,A0
            movea.l A2,A1
            clr.l   (A2)
            clr.l   (4,A2)
            bra.b   .L28
.L24:
            movea.l A1,A4
            move.l  (8,A2),D0
.L25:
            cmp.l   (8,A4),D0
            bge.b   .L26
            movea.l (4,A4),A4
            move.l  A4,D1
            bne.b   .L25
            move.l  A0,(A2)
            move.l  A2,(4,A0)
            clr.l   (4,A2)
            movea.l A2,A0
            bra.b   .L28
.L26:
            cmpa.l  A1,A4
            beq.b   .L27
            move.l  A4,(4,A2)
            move.l  (A4),D0
            move.l  A2,(A4)
            move.l  D0,(A2)
            movea.l D0,A4
            move.l  A2,(4,A4)
            bra.b   .L28
.L27:
            move.l  A2,(A1)
            move.l  A1,(4,A2)
            clr.l   (A2)
            movea.l A2,A1
.L28:
            addq.l  #8,A3
            subq.w  #1,D3
            bgt.w   .L17
.L29:
            suba.l  A1,A1
            movea.l (-$140,A6),A4
.L30:
            move.l  A4,D0
            bne.b   .L32
            move.l  A0,D0
            beq.b   .L39
            move.l  A1,(4,A0)
            bne.b   .L31
            move.l  A0,(-$140,A6)
            bra.b   .L39
.L31:
            move.l  A0,(A1)
            bra.b   .L39
.L32:
            move.l  A0,D0
            bne.b   .L34
            move.l  A1,(4,A4)
            bne.b   .L33
            move.l  A4,(-$140,A6)
            bra.b   .L39
.L33:
            move.l  A4,(A1)
            bra.b   .L39
.L34:
            move.l  (8,A4),D0
            cmp.l   (8,A0),D0
            ble.b   .L35
            movea.l A0,A2
            movea.l (A2),A0
            bra.b   .L36
.L35:
            movea.l A4,A2
            movea.l (A2),A4
.L36:
            move.l  A1,(4,A2)
            bne.b   .L37
            move.l  A2,(-$140,A6)
            bra.b   .L38
.L37:
            move.l  A2,(A1)
.L38:
            clr.l   (A2)
            movea.l A2,A1
            bra.b   .L30
.L39:
            cmp.w   (-$74,A6),D4
            blt.b   .L40
            tst.b   (-$12E,A6)
            bne.b   .L40
            move.w  D4,(-4,A6)
            jsr     ([-$1C.w,A6])
.L40:
            movea.l (-$140,A6),A4
            moveq   #0,D5
.L41:
            movea.l A4,A1
            movea.l (A1),A4
            cmp.w   ($10,A1),D4
            bge.w   .L49
            move.w  ($12,A1),D0
            beq.b   .L44
            tst.w   D5
            bne.b   .L42
            move.w  (8,A1),D6
.L42:
            add.w   D0,D5
            bne.b   .L46
.L43:
            move.w  (8,A1),D0
            cmp.w   D6,D0
            bgt.b   .L45
            bra.b   .L46
.L44:
            eori.w  #1,D5
            beq.b   .L43
            move.w  (8,A1),D6
            bra.b   .L46
.L45:
            cmp.w   (-$74,A6),D4
            blt.b   .L46
            move.w  D6,D1
            move.w  D0,D2
            movem.l D3-D6/A1-A4,-(SP)
            move.l  (-$96,A6),D6
            lea     ([-$88.w,A6],D6.l),A0
            move.l  (A0),D6
            movea.l (-$124,A6),A1
            movea.l (-8,A6),A2
            lea     (-$74,A6),A3
            movea.l (-$120,A6),A4
            move.w  (-$76,A6),D0
            move.l  (-$A0,A6),D4
            move.l  (-$A4,A6),D5
            jsr     ([$1A2C.w])
            move.l  A4,(-$120,A6)
            movem.l (SP)+,D3-D6/A1-A4
.L46:
            move.l  (8,A1),D0
            add.l   ($C,A1),D0
            move.l  D0,(8,A1)
            movea.l (4,A1),A2
            move.l  A2,D1
            beq.b   .L53
            cmp.l   (8,A2),D0
            bge.b   .L53
            move.l  (A1),(A2)
            beq.b   .L47
            movea.l (A1),A0
            move.l  A2,(4,A0)
.L47:
            movea.l (4,A2),A2
            move.l  A2,D1
            bne.b   .L48
            movea.l (-$140,A6),A2
            move.l  A2,(A1)
            clr.l   (4,A1)
            move.l  A1,(4,A2)
            move.l  A1,(-$140,A6)
            bra.b   .L53
.L48:
            cmp.l   (8,A2),D0
            blt.b   .L47
            movea.l (A2),A0
            move.l  A0,(A1)
            move.l  A2,(4,A1)
            move.l  A1,(4,A0)
            move.l  A1,(A2)
            bra.b   .L53
.L49:
            movea.l (4,A1),A0
            move.l  A0,D0
            bne.b   .L50
            move.l  (A1),(-$140,A6)
            bra.b   .L51
.L50:
            move.l  (A1),(A0)
.L51:
            beq.b   .L52
            movea.l (A1),A2
            move.l  A0,(4,A2)
.L52:
            move.l  (-$138,A6),(A1)
            move.l  A1,(-$138,A6)
            movea.l A0,A1
.L53:
            move.l  A4,D0
            bne.w   .L41
            cmp.w   (-$74,A6),D4
            blt.b   .L54
            move.l  (-$96,A6),D0
            add.w   (-$8E,A6),D0
            and.w   (-$8A,A6),D0
            move.l  D0,(-$96,A6)
            move.l  (-$7C,A6),D0
            add.l   D0,(-$124,A6)
.L54:
            addq.w  #1,D4
            move.w  D4,(-4,A6)
            cmp.w   (-$70,A6),D4
            bge.b   .L55
            tst.l   (-$140,A6)
            bne.w   .L16
            tst.w   D3
            bne.w   .L16
.L55:
            move.b  (-$102,A6),D0
            jsr     ([$574.w])
.L56:
            tst.b   (-$130,A6)
            beq.b   .L57
            jsr     ([$F4C.w])
.L57:
            bset    #7,HiliteMode
            movea.l (-$144,A6),SP
            movem.l (SP)+,D3-D7/A2-A4
            unlk    A6
            rtd     #$12
            ds.b    6
DrawPoly:
            link.w  A6,#-8
            movea.l ([$E.w,A6]),A0
            move.w  (A0)+,D0
            cmpi.w  #$1E,D0
            bne.b   .L1
            move.l  ($18,A0),D1
            cmp.l   (8,A0),D1
            bne.b   .L4
            bra.b   .L2
.L1:
            cmpi.w  #$1A,D0
            bne.b   .L4
.L2:
            moveq   #2,D0
            addq.w  #8,A0
            lea     (4,A0),A1
.L3:
            cmpm.w  (A0)+,(A1)+
            seq     D1
            cmpm.w  (A0)+,(A1)+
            seq     D2
            or.b    D1,D2
            beq.b   .L4
            dbra    D0,.L3
            lea     (-$C,A0),A1
            cmpm.w  (A0)+,(A1)+
            seq     D1
            cmpm.w  (A0)+,(A1)+
            seq     D2
            or.b    D1,D2
            beq.b   .L4
            lea     (-8,A6),A0
            move.l  A0,-(SP)
            move.l  (-$C,A1),(A0)+
            move.l  (-8,A1),(A0)
            move.w  ($C,A6),-(SP)
            move.l  (8,A6),-(SP)
            bsr.w   DrawRect
            bra.w   .L14
.L4:
            movem.l D3-D5/A2,-(SP)
            movea.l (A5),A0
            movea.l (A0),A0
            tst.w   ($42,A0)
            bmi.w   .L13
            movea.l ($E,A6),A0
            move.l  A0,D0
            beq.w   .L13
            _HLock
            movea.l (A0),A0
            move.l  (2,A0),(-8,A6)
            move.l  (6,A0),(-4,A6)
            move.w  (A0),D4
            subi.w  #$A,D4
            lsr.w   #2,D4
            moveq   #0,D0
            move.w  D4,D0
            addq.l  #1,D0
            asl.l   #3,D0
            _NewHandle
            tst.w   D0
            bne.w   .L12
            movea.l A0,A2
            _HLock
            moveq   #0,D3
            movea.l ($E,A6),A1
            movea.l (A1),A1
            adda.w  #$A,A1
            move.l  (A1)+,D5
            move.w  D4,D2
            subq.l  #1,D2
            movea.l (A2),A0
            bra.b   .L8
.L5:
            move.l  D5,D4
            move.l  (A1)+,D5
            move.l  D4,D0
            move.l  D5,D1
            sub.w   D0,D1
            swap    D0
            swap    D1
            sub.w   D0,D1
            beq.b   .L8
            bmi.b   .L6
            move.l  D4,(A0)+
            bra.b   .L7
.L6:
            move.l  D5,(A0)+
.L7:
            addq.w  #1,D3
            swap    D1
            move.l  D1,(A0)+
.L8:
            dbra    D2,.L5
            move.l  D5,D4
            movea.l ($E,A6),A1
            movea.l (A1),A1
            move.l  ($A,A1),D5
            cmp.l   D4,D5
            beq.b   .L11
            move.l  D4,D0
            move.l  D5,D1
            sub.w   D0,D1
            swap    D0
            swap    D1
            sub.w   D0,D1
            beq.b   .L11
            bmi.b   .L9
            move.l  D4,(A0)+
            bra.b   .L10
.L9:
            move.l  D5,(A0)+
.L10:
            addq.w  #1,D3
            swap    D1
            move.l  D1,(A0)+
.L11:
            movea.l ($E,A6),A0
            _HUnlock
            move.l  (A2),-(SP)
            move.w  D3,-(SP)
            jsr     XDrawPoly
            move.l  (A2),-(SP)
            move.w  D3,-(SP)
            st      -(SP)
            pea     (-8,A6)
            move.w  ($C,A6),-(SP)
            move.l  (8,A6),-(SP)
            jsr     PaintVector
            movea.l A2,A0
            _HUnlock
            movea.l A2,A0
            _DisposHandle
            moveq   #0,D0
            bra.b   .L13
.L12:
            movea.l ($E,A6),A0
            _HUnlock
.L13:
            movem.l (SP)+,D3-D5/A2
.L14:
            unlk    A6
            rtd     #$A
            ds.b    10
StdRRect:
            link.w  A6,#0
            movem.l D7/A3-A4,-(SP)
            move.b  ($10,A6),D7
            jsr     ([$1A3C.w])
            ble.b   .L2
            move.b  D7,-(SP)
            jsr     PutPicVerb
            movea.l ($5C,A3),A0
            movea.l (A0),A0
            move.l  (8,A6),D0
            cmp.l   ($52,A0),D0
            beq.b   .L1
            move.l  D0,($52,A0)
            move.l  D0,-(SP)
            moveq   #$B,D0
            jsr     DPutPicOp
            jsr     PutPicLong
.L1:
            moveq   #$40,D0
            add.w   D7,D0
            move.b  D0,-(SP)
            move.l  ($C,A6),-(SP)
            jsr     PutPicRect
.L2:
            pea     sub_408345E0
            pea     GetRect_RRects
            jsr     ([$1AA0.w])
            movem.l (SP)+,D7/A3-A4
            unlk    A6
            rtd     #$A
GetRect_RRects:
            move.l  (SP)+,D0
            movea.l (SP)+,A1
            movea.l ($C,A6),A0
            move.l  (A0)+,(A1)+
            move.l  (A0),(A1)
            movea.l D0,A0
            jmp     (A0)
sub_408345E0:
            move.l  ($C,A6),-(SP)
            clr.b   -(SP)
            tst.b   D7
            bne.b   .L2
            tst.l   ($60,A3)
            beq.b   .L1
            move.l  ($C,A6),-(SP)
            move.l  (8,A6),-(SP)
            move.l  (-$94,A4),-(SP)
            pea     (-$96,A4)
            pea     (-$98,A4)
            jsr     ([$1A68.w])
.L1:
            move.b  #1,(SP)
.L2:
            move.l  (8,A6),-(SP)
            jsr     ([$1A60.w])
            clr.w   -(SP)
            move.w  #$168,-(SP)
            jsr     ([$1A24.w])
            rts
            ds.b    10
FrameRoundRect:
            moveq   #0,D0
            bra.b   CallRRect
PaintRoundRect:
            moveq   #1,D0
            bra.b   CallRRect
EraseRoundRect:
            moveq   #2,D0
            bra.b   CallRRect
InvertRoundRect:
            moveq   #3,D0
            bra.b   CallRRect
FillRoundRect:
            moveq   #0,D0
            bra.b   FillCRoundRect.L1
FillCRoundRect:
            moveq   #1,D0
.L1:
            movea.l (SP)+,A0
            movea.l (SP)+,A1
            move.l  A0,-(SP)
            move.l  A1,-(SP)
            jsr     ([$1A8C.w])
            moveq   #4,D0
CallRRect:
            movea.l (SP)+,A0
            move.l  (SP)+,D1
            movea.l (SP)+,A1
            move.b  D0,-(SP)
            move.l  A1,-(SP)
            move.l  D1,-(SP)
            move.l  A0,-(SP)
            movea.l (A5),A0
            movea.l (A0),A0
            move.l  ($68,A0),D0
            movea.l ($10BC).w,A0
            beq.b   .L1
            movea.l D0,A0
            movea.l ($C,A0),A0
.L1:
            jmp     (A0)
            ds.b    6
DrawArc:
            link.w  A6,#-$1C4
            movem.l D0-D7/A1-A4,-(SP)
            move.l  SP,(-$124,A6)
            clr.l   (-$20,A6)
            movea.l (A5),A0
            movea.l (A0),A4
            tst.w   ($42,A4)
            blt.w   ONESLAB.L9
            lea     (-$88,A6),A0
            move.l  A0,(A0)
            clr.l   (-$96,A6)
            clr.w   (-$8A,A6)
            move.w  #1,(-$8E,A6)
            move.l  SP,D1
            andi.b  #$FC,D1
            movea.l D1,SP
            lea     (2,A4),A1
            lea     (-$F4,A6),A2
            jsr     ([$1A08.w])
            move.l  D1,(-$1C4,A6)
            move.b  D2,(-$166,A6)
            lea     ShftTbl,A0
            move.w  (-$D4,A6),D0
            moveq   #0,D1
            move.b  (0,A0,D0.w),D1
            move.w  D1,(-$76,A6)
            move.l  ($C,A6),(-$9C,A6)
            move.w  ($10,A6),D0
            bset    #3,D0
            moveq   #$10,D1
            btst    #5,D0
            beq.b   .L1
            cmpi.w  #$3A,D0
            beq.b   .L2
            moveq   #$30,D1
.L1:
            cmp.w   D1,D0
            bgt.w   ONESLAB.L9
.L2:
            move.w  D0,(-$98,A6)
            tst.w   (6,A4)
            smi     (-$A6,A6)
            clr.b   (-$101,A6)
            jsr     ([$1A10.w])
            movea.l ($1C,A4),A2
            movea.l (A2),A2
            movea.l ($18,A4),A3
            movea.l (A3),A3
            move.l  ($18,A6),-(SP)
            pea     (-$EE,A6)
            pea     (2,A2)
            pea     (2,A3)
            move.w  #4,-(SP)
            pea     (-$74,A6)
            jsr     ([$1A84.w])
            beq.w   ONESLAB.L9
            clr.b   (-$136,A6)
            cmpi.w  #$A,(A2)
            bne.b   .L7
            cmpi.w  #$A,(A3)
            beq.b   .L3
            move.l  ($18,A4),-(SP)
            pea     (-$74,A6)
            move.w  #$FFFF,-(SP)
            jsr     ([$1AA4.w])
            blt.w   ONESLAB.L9
            bgt.b   .L7
.L3:
            btst    #5,(-$97,A6)
            bne.b   .L7
            movea.l (-$9C,A6),A0
            tst.b   (-$A6,A6)
            beq.b   .L4
            movea.l (A0),A0
            movea.l (A0),A0
            tst.w   (A0)
            bne.b   .L7
            movea.l (6,A0),A0
            movea.l (A0),A0
.L4:
            move.l  (A0)+,D0
            cmp.l   (A0)+,D0
            bne.b   .L7
            not.l   D0
            beq.b   .L5
            not.l   D0
            bne.b   .L7
            eori.w  #4,(-$98,A6)
.L5:
            st      (-$136,A6)
            moveq   #7,D0
            and.w   (-$98,A6),D0
            move.b  .L6(PC,D0.w),D0
            bmi.w   ONESLAB.L9
            move.w  D0,(-$98,A6)
            bra.b   .L7
.L6:
            dc.w    0,$0102,$02FF,$FFFF
.L7:
            clr.b   (-$19A,A6)
            move.w  (8,A6),D0
            beq.w   ONESLAB.L9
            bpl.b   .L8
            add.w   D0,($A,A6)
            neg.w   D0
            move.w  D0,(8,A6)
.L8:
            cmpi.w  #$168,D0
            slt     (-$199,A6)
            bge.w   .L16
            move.w  ($A,A6),D0
            ext.l   D0
            divs.w  #$168,D0
            swap    D0
            tst.w   D0
            bpl.b   .L9
            addi.w  #$168,D0
.L9:
            move.w  D0,($A,A6)
            add.w   (8,A6),D0
            cmpi.w  #$168,D0
            blt.b   .L10
            subi.w  #$168,D0
.L10:
            move.w  D0,(-$19C,A6)
            movea.l ($18,A6),A0
            move.w  (A0),D0
            add.w   (4,A0),D0
            asr.w   #1,D0
            move.w  D0,(-$19E,A6)
            move.w  (2,A0),D0
            add.w   (6,A0),D0
            asr.w   #1,D0
            move.w  D0,(-$1A0,A6)
            move.w  (6,A0),D0
            sub.w   (2,A0),D0
            move.w  D0,(-$1A2,A6)
            move.w  (4,A0),D0
            sub.w   (A0),D0
            move.w  D0,(-$1A4,A6)
            clr.l   -(SP)
            move.w  (-$1A2,A6),-(SP)
            move.w  (-$1A4,A6),-(SP)
            jsr     ([$FA4.w])
            move.l  (SP)+,D7
            clr.l   -(SP)
            move.w  ($A,A6),-(SP)
            jsr     ([$10F0.w])
            move.l  (SP)+,D0
            clr.l   -(SP)
            move.l  D0,-(SP)
            move.l  D7,-(SP)
            jsr     ([$FA0.w])
            move.l  (SP)+,(-$1A8,A6)
            clr.l   -(SP)
            move.w  (-$19C,A6),-(SP)
            jsr     ([$10F0.w])
            move.l  (SP)+,D0
            clr.l   -(SP)
            move.l  D0,-(SP)
            move.l  D7,-(SP)
            jsr     ([$FA0.w])
            move.l  (SP)+,(-$1AC,A6)
            move.w  (-$1A0,A6),D6
            swap    D6
            clr.w   D6
            move.w  (-$1A4,A6),D7
            lsr.w   #1,D7
            move.w  (-$1A6,A6),D0
            mulu.w  D7,D0
            move.l  D0,(-$1B0,A6)
            move.w  (-$1A8,A6),D0
            muls.w  D7,D0
            add.w   D0,(-$1B0,A6)
            move.l  D6,D0
            sub.l   (-$1B0,A6),D0
            move.l  D0,(-$1B0,A6)
            move.w  (-$1AA,A6),D0
            mulu.w  D7,D0
            move.l  D0,(-$1B4,A6)
            move.w  (-$1AC,A6),D0
            muls.w  D7,D0
            add.w   D0,(-$1B4,A6)
            sub.l   (-$1B4,A6),D6
            move.l  D6,(-$1B4,A6)
            move.w  ($A,A6),D0
            cmpi.w  #$B4,D0
            bge.b   .L11
            subi.w  #$5A,D0
            bra.b   .L12
.L11:
            subi.w  #$10E,D0
            neg.w   D0
.L12:
            move.w  D0,(-$1B6,A6)
            move.w  (-$19C,A6),D0
            cmpi.w  #$B4,D0
            bge.b   .L13
            subi.w  #$5A,D0
            bra.b   .L14
.L13:
            subi.w  #$10E,D0
            neg.w   D0
.L14:
            move.w  D0,(-$1B8,A6)
            move.w  (8,A6),D0
            cmpi.w  #$B4,D0
            bgt.b   .L16
            blt.b   .L15
            cmpi.w  #$5A,($A,A6)
            seq     (-$19A,A6)
            bra.b   .L16
.L15:
            move.w  (-$1B6,A6),D0
            or.w    (-$1B8,A6),D0
            spl     (-$19A,A6)
.L16:
            movea.l ($18,A6),A0
            lea     (-$194,A6),A1
            move.w  ($12,A6),D1
            move.w  ($14,A6),D2
            jsr     InitOval
            move.w  ($12,A6),D0
            asr.w   #1,D0
            add.w   (-$194,A6),D0
            move.w  D0,(-$196,A6)
            movea.l ($18,A6),A0
            add.w   (4,A0),D0
            sub.w   (A0),D0
            sub.w   ($12,A6),D0
            move.w  D0,(-$198,A6)
            move.w  #$7FFF,(-$164,A6)
            tst.b   ($16,A6)
            beq.b   .L17
            movea.l ($18,A6),A0
            movem.w (A0),D0-D3
            move.l  ($34,A4),D4
            add.w   D4,D1
            sub.w   D4,D3
            cmp.w   D3,D1
            bge.b   .L17
            swap    D4
            add.w   D4,D0
            sub.w   D4,D2
            cmp.w   D2,D0
            bge.b   .L17
            movem.w D0-D3,(-$134,A6)
            lea     (-$134,A6),A0
            lea     (-$164,A6),A1
            move.w  ($12,A6),D1
            sub.w   D4,D1
            sub.w   D4,D1
            move.w  ($14,A6),D2
            swap    D4
            sub.w   D4,D2
            sub.w   D4,D2
            jsr     InitOval
.L17:
            tst.b   (-$166,A6)
            beq.b   .L18
            pea     (-$74,A6)
            move.l  (-$1C4,A6),-(SP)
            jsr     ([$F54.w])
.L18:
            move.w  (-$76,A6),D5
            move.w  (-$72,A6),D2
            sub.w   (-$EC,A6),D2
            ext.l   D2
            lsl.l   D5,D2
            andi.l  #$FFFFFFE0,D2
            move.l  D2,D0
            lsr.l   #3,D0
            move.w  D0,(-$90,A6)
            lsr.l   D5,D2
            add.w   (-$EC,A6),D2
            move.w  D2,(-$E,A6)
            tst.b   (-$136,A6)
            bne.w   .L20
            move.w  (-$6E,A6),D0
            sub.w   D2,D0
            move.w  D0,D1
            ext.l   D1
            lsl.l   D5,D1
            subq.l  #1,D1
            lsr.l   #5,D1
            move.w  D1,(-$10,A6)
            lsr.w   #5,D0
            addq.w  #1,D0
            lsl.w   D5,D0
            subq.w  #1,D0
.L19:
            clr.l   -(SP)
            dbra    D0,.L19
            move.l  SP,(-8,A6)
            lea     ONESLAB.L8,A0
            move.l  A0,(-$80,A6)
            move.l  Lo3Bytes,(-$84,A6)
            clr.l   (-$7C,A6)
            clr.l   (-$C,A6)
            move.l  ($18,A4),-(SP)
            move.l  ($1C,A4),-(SP)
            move.l  #1,-(SP)
            jsr     ([$1A34.w])
.L20:
            move.w  (-$74,A6),D1
            sub.w   (-$EE,A6),D1
            move.w  (-$F0,A6),D0
            andi.w  #$7FFF,D0
            ext.l   D0
            move.l  D0,(-$7C,A6)
            muls.w  D0,D1
            add.l   (-$F4,A6),D1
            move.w  (-$E,A6),D2
            sub.w   (-$EC,A6),D2
            move.w  (-$76,A6),D7
            lsl.w   D7,D2
            lsr.w   #3,D2
            ext.l   D2
            add.l   D2,D1
            move.l  D1,(-$12C,A6)
            move.w  (-$E,A6),D1
            sub.w   D1,(-$72,A6)
            sub.w   D1,(-$6E,A6)
            sub.w   D1,(-$172,A6)
            sub.w   D1,(-$16E,A6)
            sub.w   D1,(-$142,A6)
            sub.w   D1,(-$13E,A6)
            sub.w   D1,(-$1B0,A6)
            sub.w   D1,(-$1B4,A6)
            move.w  (-$98,A6),D2
            tst.b   (-$136,A6)
            beq.b   .L21
            jsr     ([$1A30.w])
            move.l  A4,(-$128,A6)
            bra.b   .L25
.L21:
            moveq   #0,D7
            move.w  (-$98,A6),D2
            btst    #5,D2
            bne.b   .L22
            bclr    #2,D2
            beq.b   .L22
            not.l   D7
.L22:
            jsr     ([$1A54.w])
            move.w  (-$8E,A6),D1
            bne.b   .L23
            moveq   #$F,D0
            moveq   #4,D1
            move.w  D1,(-$8E,A6)
            move.w  #3,(-$8C,A6)
            move.w  #$3F,(-$8A,A6)
            bra.b   .L24
.L23:
            moveq   #0,D0
            move.w  (-$8A,A6),D0
            addq.w  #1,D0
            divu.w  (-$8E,A6),D0
            subq.w  #1,D0
.L24:
            and.w   (-$74,A6),D0
            mulu.w  D1,D0
            move.l  D0,(-$96,A6)
            move.w  (-$98,A6),D2
            jsr     ([$1A94.w])
            move.l  A4,(-$128,A6)
.L25:
            moveq   #1,D0
            jsr     ([$574.w])
            move.b  D0,(-$102,A6)
            move.w  (-$194,A6),D7
            move.w  D7,(-4,A6)
.L26:
            cmp.w   (-$196,A6),D7
            blt.b   .L27
            cmp.w   (-$198,A6),D7
            blt.b   .L28
.L27:
            move.w  D7,-(SP)
            move.w  D7,D0
            lea     (-$194,A6),A3
            jsr     BumpOval
            move.w  (SP),D0
            lea     (-$164,A6),A3
            jsr     BumpOval
            move.w  (SP)+,D7
.L28:
            cmp.w   (-$19E,A6),D7
            bne.b   .L31
            tst.b   (-$199,A6)
            beq.b   .L31
            neg.w   (-$1B6,A6)
            neg.w   (-$1B8,A6)
            clr.b   (-$19A,A6)
            move.w  (8,A6),D0
            cmpi.w  #$B4,D0
            bgt.b   .L30
            blt.b   .L29
            cmpi.w  #$10E,($A,A6)
            bne.b   .L30
            bra.w   ONESLAB.L7
.L29:
            move.w  (-$1B6,A6),D0
            or.w    (-$1B8,A6),D0
            bpl.w   ONESLAB.L7
.L30:
            move.w  (-$1B6,A6),D0
            move.w  (-$1B8,A6),(-$1B6,A6)
            move.w  D0,(-$1B8,A6)
            move.l  (-$1B0,A6),D0
            move.l  (-$1B4,A6),(-$1B0,A6)
            move.l  D0,(-$1B4,A6)
            move.l  (-$1A8,A6),D0
            move.l  (-$1AC,A6),(-$1A8,A6)
            move.l  D0,(-$1AC,A6)
.L31:
            cmp.w   (-$74,A6),D7
            blt.w   ONESLAB.L6
            tst.b   (-$19A,A6)
            bne.w   ONESLAB.L5
            tst.b   (-$136,A6)
            bne.b   .L32
            jsr     ([-$1C.w,A6])
.L32:
            tst.b   (-$199,A6)
            bne.b   .L33
            cmp.w   (-$164,A6),D7
            blt.w   ONESLAB.L3
            cmp.w   (-$162,A6),D7
            bge.w   ONESLAB.L3
            bra.w   ONESLAB.L2
.L33:
            move.w  (-$172,A6),D1
            tst.w   (-$1B6,A6)
            bpl.b   .L34
            cmp.w   (-$1B0,A6),D1
            bge.b   .L34
            move.w  (-$1B0,A6),D1
.L34:
            move.w  D1,(-$1BA,A6)
            move.w  (-$16E,A6),D2
            tst.w   (-$1B8,A6)
            bpl.b   .L35
            cmp.w   (-$1B4,A6),D2
            ble.b   .L35
            move.w  (-$1B4,A6),D2
.L35:
            move.w  D2,(-$1BC,A6)
            cmp.w   (-$164,A6),D7
            blt.w   ONESLAB.L1
            cmp.w   (-$162,A6),D7
            bge.w   ONESLAB.L1
            move.w  (-$142,A6),D0
            tst.w   (-$1B8,A6)
            bpl.b   .L36
            cmp.w   (-$1B4,A6),D0
            ble.b   .L36
            move.w  (-$1B4,A6),D0
.L36:
            move.w  D0,(-$1BE,A6)
            move.w  (-$13E,A6),D0
            tst.w   (-$1B6,A6)
            bpl.b   .L37
            cmp.w   (-$1B0,A6),D0
            bge.b   .L37
            move.w  (-$1B0,A6),D0
.L37:
            move.w  D0,(-$1C0,A6)
            cmp.w   D2,D1
            bge.b   .L38
            move.w  (-$1BE,A6),D2
            bsr.b   ONESLAB
            move.w  (-$1C0,A6),D1
            move.w  (-$1BC,A6),D2
            bra.w   ONESLAB.L4
.L38:
            move.w  (-$1B6,A6),D0
            and.w   (-$1B8,A6),D0
            bpl.w   ONESLAB.L5
            cmpi.w  #$B4,(8,A6)
            ble.w   ONESLAB.L5
            cmp.w   (-$1BE,A6),D2
            bne.b   .L39
            move.w  (-$142,A6),D2
            bra.b   .L40
.L39:
            move.w  (-$1BA,A6),D0
            cmp.w   (-$1C0,A6),D0
            bne.b   .L41
            move.w  (-$13E,A6),D1
            move.w  (-$1BC,A6),D2
.L40:
            bsr.b   ONESLAB
.L41:
            move.w  (-$172,A6),D1
            move.w  (-$1BE,A6),D2
            bsr.b   ONESLAB
            move.w  (-$1C0,A6),D1
            move.w  (-$16E,A6),D2
            bra.b   ONESLAB.L4
ONESLAB:
            move.l  (-$96,A6),D6
            lea     ([-$88.w,A6],D6.l),A0
            move.l  (A0),D6
            movea.l (-$12C,A6),A1
            movea.l (-8,A6),A2
            lea     (-$74,A6),A3
            move.w  (-$76,A6),D0
            move.l  (-$A0,A6),D4
            move.l  (-$A4,A6),D5
            jsr     ([$1A2C.w])
            rts
.L1:
            cmp.w   D2,D1
            blt.b   .L4
            move.w  (-$1B6,A6),D0
            and.w   (-$1B8,A6),D0
            bpl.b   .L5
            cmpi.w  #$B4,(8,A6)
            ble.b   .L5
            move.w  (-$172,A6),D1
            bsr.b   ONESLAB
            move.w  (-$1BA,A6),D1
            move.w  (-$16E,A6),D2
            bra.b   .L4
.L2:
            move.w  (-$172,A6),D1
            move.w  (-$142,A6),D2
            bsr.b   ONESLAB
            move.w  (-$13E,A6),D1
            move.w  (-$16E,A6),D2
            bsr.b   ONESLAB
            bra.b   .L5
.L3:
            move.w  (-$172,A6),D1
            move.w  (-$16E,A6),D2
.L4:
            bsr.b   ONESLAB
.L5:
            move.l  (-$96,A6),D0
            add.w   (-$8E,A6),D0
            and.w   (-$8A,A6),D0
            move.l  D0,(-$96,A6)
            move.l  (-$7C,A6),D0
            add.l   D0,(-$12C,A6)
.L6:
            move.l  (-$1A8,A6),D0
            add.l   D0,(-$1B0,A6)
            move.l  (-$1AC,A6),D0
            add.l   D0,(-$1B4,A6)
            addq.w  #1,D7
            move.w  D7,(-4,A6)
            cmp.w   (-$70,A6),D7
            blt.w   DrawArc.L26
.L7:
            move.b  (-$102,A6),D0
            jsr     ([$574.w])
.L8:
            tst.b   (-$166,A6)
            beq.b   .L9
            jsr     ([$F4C.w])
.L9:
            bset    #7,HiliteMode
            movea.l (-$124,A6),SP
            movem.l (SP)+,D0-D7/A1-A4
            unlk    A6
            rtd     #$14
            ds.b    6
InitOval:
            move.w  (A0),(A1)
            move.w  (4,A0),(2,A1)
            tst.w   D2
            bpl.b   .L1
            clr.w   D2
.L1:
            tst.w   D1
            bpl.b   .L2
            clr.w   D1
.L2:
            move.w  (6,A0),D0
            sub.w   (2,A0),D0
            cmp.w   D0,D2
            ble.b   .L3
            move.w  D0,D2
.L3:
            move.w  (4,A0),D0
            sub.w   (A0),D0
            cmp.w   D0,D1
            ble.b   .L4
            move.w  D0,D1
.L4:
            move.w  (6,A0),($26,A1)
            clr.w   ($28,A1)
            move.w  (2,A0),($22,A1)
            clr.w   ($24,A1)
            move.w  D2,D0
            swap    D0
            clr.w   D0
            lsr.l   #1,D0
            add.l   D0,($22,A1)
            sub.l   D0,($26,A1)
            move.l  #$8000,D0
            move.l  D0,($2A,A1)
            add.l   D0,($26,A1)
            moveq   #1,D0
            sub.w   D1,D0
            move.w  D0,(4,A1)
            move.w  D1,D0
            ext.l   D0
            add.l   D0,D0
            subq.l  #1,D0
            move.l  D0,(6,A1)
            clr.l   ($A,A1)
            clr.l   ($E,A1)
            clr.l   -(SP)
            move.w  D1,-(SP)
            move.w  D2,-(SP)
            jsr     ([$FA4.w])
            move.l  (SP),-(SP)
            pea     ($12,A1)
            jsr     ([$F9C.w])
            move.l  ($16,A1),D0
            add.l   D0,D0
            move.l  D0,($1E,A1)
            move.l  ($12,A1),D0
            addx.l  D0,D0
            move.l  D0,($1A,A1)
            rts
            ds.b    6
BumpOval:
            cmp.w   (A3)+,D0
            blt.b   .L5
            cmp.w   (A3)+,D0
            bge.b   .L5
            move.w  (A3),D0
            addq.w  #2,(A3)+
            movem.l (A3),D1-D7/A0-A2
            bra.b   .L2
.L1:
            adda.l  A2,A1
            suba.l  A2,A0
            add.l   D5,D3
            addx.l  D4,D2
            add.l   D7,D5
            addx.l  D6,D4
.L2:
            cmp.l   D1,D2
            blt.b   .L1
            bra.b   .L4
.L3:
            suba.l  A2,A1
            adda.l  A2,A0
            sub.l   D7,D5
            subx.l  D6,D4
            sub.l   D5,D3
            subx.l  D4,D2
.L4:
            cmp.l   D1,D2
            bgt.b   .L3
            addq.w  #1,D0
            ext.l   D0
            asl.l   #2,D0
            sub.l   D0,D1
            movem.l D1-D7/A0-A2,(A3)
.L5:
            rts
            ds.b    14
StdBits:
            link.w  A6,#-$F6
            movem.l D3-D7/A2-A4,-(SP)
            jsr     ([$1A3C.w])
            ble.w   .L26
            movea.l ($5C,A3),A0
            movea.l (A0),A0
            cmpi.w  #1,($62,A0)
            seq     (-$F6,A6)
            movea.l ($16,A6),A1
            tst.w   (4,A1)
            spl     D7
            or.b    (-$F6,A6),D7
            lea     (-$4E,A6),A2
            jsr     ([$1A08.w])
            lea     ShftTbl,A0
            move.w  (-$2E,A6),D0
            moveq   #0,D3
            move.b  (0,A0,D0.w),D3
            clr.l   (-$AC,A6)
            tst.b   D2
            beq.w   .L6
            movea.l ($12,A6),A0
            lea     (-$9C,A6),A1
            move.l  (A0)+,(A1)+
            move.l  (A0)+,(A1)+
            pea     (-$9C,A6)
            movea.l ($16,A6),A0
            move.l  (6,A0),D0
            neg.w   D0
            swap    D0
            neg.w   D0
            swap    D0
            move.l  D0,-(SP)
            jsr     ([$10A0.w])
            clr.l   -(SP)
            pea     (-$9C,A6)
            jsr     ([$169C.w])
            move.l  (SP)+,D0
            beq.w   .L25
            move.l  TheGDevice,-(SP)
            move.l  D0,TheGDevice
            movea.l D0,A0
            movea.l (A0),A0
            movea.l ($16,A0),A0
            movea.l (A0),A0
            lea     (-$80,A6),A1
            moveq   #$18,D0
.L1:
            move.w  (A0)+,(A1)+
            dbra    D0,.L1
            clr.w   (-$72,A6)
            movea.l ($12,A6),A0
            lea     (-$7A,A6),A1
            move.l  (A0)+,D1
            move.l  D1,(A1)+
            move.l  (A0)+,D0
            move.l  D0,(A1)+
            move.w  D0,D5
            sub.w   D1,D5
            ext.l   D5
            moveq   #0,D3
            tst.b   D7
            bne.b   .L2
            lea     ShftTbl,A0
            move.w  (-$60,A6),D2
            move.b  (0,A0,D2.w),D3
.L2:
            lsl.l   D3,D5
            moveq   #$F,D2
            add.l   D2,D5
            asr.l   #4,D5
            ble.w   .L25
            add.w   D5,D5
            move.w  D5,(-$7C,A6)
            move.w  D5,D4
            tst.b   D7
            bne.b   .L3
            ori.w   #$8000,(-$7C,A6)
.L3:
            swap    D1
            swap    D0
            sub.w   D1,D0
            mulu.w  D5,D0
            move.l  D0,D5
            clr.b   (-$F5,A6)
            _NewHandle
            beq.b   .L4
            st      (-$F5,A6)
            move.l  D5,D0
            jsr     ([$1AB4.w])
            cmp.l   D5,D0
            bge.b   .L4
            move.l  (SP)+,TheGDevice
            move.w  #$FF71,QDErr
            bra.w   .L25
.L4:
            move.l  A0,(-$AC,A6)
            _HLock
            movea.l (A0),A0
            move.l  A0,(-$80,A6)
            move.l  ($5C,A3),-(SP)
            clr.l   ($5C,A3)
            subq.w  #6,SP
            move.l  SP,-(SP)
            jsr     ([$1664.w])
            moveq   #$21,D0
            move.l  D0,-(SP)
            jsr     ([$F88.w])
            pea     (-$4E,A6)
            pea     (-$80,A6)
            move.l  ($12,A6),-(SP)
            move.l  (SP),-(SP)
            clr.w   -(SP)
            clr.l   -(SP)
            jsr     ([$11B0.w])
            move.l  SP,-(SP)
            jsr     ([$1650.w])
            addq.w  #6,SP
            move.l  (SP)+,($5C,A3)
            move.l  (SP)+,TheGDevice
            lea     (-$80,A6),A0
            lea     (-$4E,A6),A1
            moveq   #$18,D0
.L5:
            move.w  (A0)+,(A1)+
            dbra    D0,.L5
.L6:
            lea     (-$4E,A6),A1
            movea.l (A1),A3
            move.w  (4,A1),D4
            andi.w  #$7FFF,D4
            movea.l ($12,A6),A0
            move.w  (A0),D0
            sub.w   (6,A1),D0
            ble.b   .L7
            add.w   D0,(6,A1)
            mulu.w  D4,D0
            adda.l  D0,A3
.L7:
            move.w  (4,A0),D0
            cmp.w   ($A,A1),D0
            bge.b   .L8
            move.w  D0,($A,A1)
.L8:
            move.w  (2,A0),D0
            sub.w   (8,A1),D0
            ble.b   .L9
            ext.l   D0
            lsl.l   D3,D0
            asr.l   #3,D0
            adda.l  D0,A3
            lsl.l   #3,D0
            asr.l   D3,D0
            add.w   D0,(8,A1)
.L9:
            move.w  (6,A0),D0
            sub.w   (8,A1),D0
            ext.l   D0
            addq.l  #7,D0
            lsl.l   D3,D0
            andi.w  #$FFF8,D0
            asr.l   D3,D0
            add.w   (8,A1),D0
            cmp.w   ($C,A1),D0
            bge.b   .L10
            move.w  D0,($C,A1)
.L10:
            move.w  ($C,A1),D5
            sub.w   (8,A1),D5
            ext.l   D5
            lsl.l   D3,D5
            moveq   #$F,D0
            add.l   D0,D5
            asr.l   #4,D5
            ble.w   .L25
            add.w   D5,D5
            move.w  D5,(4,A1)
            ori.w   #$8000,(4,A1)
            clr.w   (-$40,A6)
            moveq   #8,D6
            move.w  #$90,-(SP)
            tst.l   (8,A6)
            beq.b   .L11
            addq.w  #1,(SP)
.L11:
            cmp.w   D6,D5
            bge.b   .L12
            move.w  #1,(-$3E,A6)
            bra.b   .L13
.L12:
            addq.w  #8,(SP)
.L13:
            tst.b   D7
            bne.b   .L17
            move.w  (-$30,A6),D2
            cmpi.w  #$10,D2
            bne.b   .L17
            ori.w   #$A,(SP)
            bsr.w   PutPicOp
            move.l  #$FF,-(SP)
            bsr.w   PutPicLong
            lea     (-$3E,A6),A0
            cmpi.w  #1,(A0)
            beq.b   .L15
            cmpi.w  #$10,(-$2E,A6)
            bne.b   .L14
            move.w  #3,(A0)
            bra.b   .L15
.L14:
            cmpi.w  #2,(A0)
            beq.b   .L15
            move.w  #4,(A0)
.L15:
            move.w  (-$44,A6),D1
            sub.w   (-$48,A6),D1
            mulu.w  D1,D5
            pea     (-$4A,A6)
            move.w  #$2E,-(SP)
            bsr.w   PutPicData
            bra.b   .L19
.L16:
            dc.w    $0003,$0201,$0103,$0201
.L17:
            bsr.w   PutPicOp
            moveq   #$2E,D0
            tst.b   D7
            beq.b   .L18
            andi.w  #$7FFF,(-$4A,A6)
            moveq   #$A,D0
.L18:
            pea     (-$4A,A6)
            move.w  D0,-(SP)
            bsr.w   PutPicData
            tst.b   D7
            bne.b   .L19
            move.l  (-$24,A6),-(SP)
            bsr.w   PutPicTable
.L19:
            move.l  ($12,A6),-(SP)
            move.w  D6,-(SP)
            bsr.w   PutPicData
            move.l  ($E,A6),-(SP)
            move.w  D6,-(SP)
            bsr.w   PutPicData
            move.w  ($C,A6),D0
            tst.b   (-$F6,A6)
            beq.b   .L20
            btst    #5,D0
            beq.b   .L20
            andi.w  #7,D0
            move.b  .L16(PC,D0.w),D0
.L20:
            move.w  D0,-(SP)
            bsr.w   PutPicWord
            tst.l   (8,A6)
            beq.b   .L21
            move.l  (8,A6),-(SP)
            bsr.w   PutPicRgn
.L21:
            cmpi.w  #$10,(-$30,A6)
            bne.b   .L22
            lea     (-$4E,A6),A0
            move.l  A0,-(SP)
            move.l  A3,-(SP)
            move.w  D4,-(SP)
            bsr.w   PUTDIRECTPMDATA
            bra.b   .L23
.L22:
            lea     (-$4E,A6),A0
            move.l  A0,-(SP)
            move.l  A3,-(SP)
            move.w  D4,-(SP)
            bsr.w   PutPMData
.L23:
            move.l  (-$AC,A6),D0
            beq.b   .L25
            movea.l D0,A0
            tst.b   (-$F5,A6)
            beq.b   .L24
            jsr     ([$1A78.w])
            bra.b   .L25
.L24:
            _DisposHandle
.L25:
            movea.l (A4),A3
.L26:
            tst.w   ($42,A3)
            blt.b   .L27
            lea     (2,A3),A0
            move.l  A0,(-$84,A6)
            move.l  ($18,A3),(-$E8,A6)
            move.l  ($1C,A3),(-$EC,A6)
            clr.l   (-$F0,A6)
            clr.l   (-$F4,A6)
            jsr     ([$1C78.w])
.L27:
            movem.l (SP)+,D3-D7/A2-A4
            unlk    A6
            rtd     #$12
BitsDevLoop:
            movea.l DeviceList,A0
            movea.l (A0),A0
            move.l  ($1E,A0),D0
            bne.b   .MANYVIDI
            move.l  ($16,A6),-(SP)
            move.l  (-$F0,A6),-(SP)
            move.l  (-$84,A6),-(SP)
            move.l  ($12,A6),-(SP)
            move.l  (-$F4,A6),-(SP)
            move.l  ($E,A6),-(SP)
            move.w  ($C,A6),-(SP)
            andi.w  #$FFF7,(SP)
            clr.l   -(SP)
            move.l  (-$E8,A6),-(SP)
            move.l  (-$EC,A6),-(SP)
            move.l  (8,A6),-(SP)
            bne.b   .MASKOK1
            movea.l (A5),A0
            move.l  (-$82,A0),(SP)
.MASKOK1:
            clr.w   -(SP)
            jsr     ([$1A9C.w])
            rts
.MANYVIDI:
            move.l  SP,(-$D6,A6)
            lea     (-$CA,A6),A1
            move.l  A1,(-$D2,A6)
            movea.l TheGDevice,A0
            move.l  A0,(A1)+
            clr.l   (A1)+
            move.l  A1,(-$CE,A6)
            lea     (-$BA,A6),A2
            move.l  A2,(A1)+
            clr.l   (A1)+
            move.l  A0,(2,A2)
            movea.l MainDevice,A0
            movea.l (A0),A0
            movea.l ($16,A0),A0
            movea.l (A0),A0
            move.l  (A0),D0
            movea.l (-$84,A6),A0
            jsr     ([$1A04.w])
            movea.l A0,A1
            movea.l ($16,A6),A0
            jsr     ([$1A04.w])
            movea.l A0,A2
            cmp.l   (A0),D0
            seq     D6
            cmp.l   (A1),D0
            seq     D7
            moveq   #6,D2
            move.b  D6,D5
            and.b   D7,D5
            beq.b   .DIROK
            moveq   #0,D2
            move.l  ([$12.w,A6]),D0
            sub.w   (8,A0),D0
            move.l  ([$E.w,A6]),D1
            sub.w   (8,A1),D1
            cmp.w   D1,D0
            ble.b   .TORT
            addq.w  #2,D2
.TORT:
            swap    D0
            swap    D1
            sub.w   (6,A0),D0
            sub.w   (6,A1),D1
            cmp.w   D1,D0
            ble.b   .DIROK
            addq.w  #4,D2
.DIROK:
            lea     .L46,A4
            adda.w  (0,A4,D2.w),A4
            tst.b   D6
            beq.w   .L17
            movea.l ($12,A6),A1
            lea     (-$8C,A6),A0
            move.l  (A1)+,(A0)
            move.l  (A1)+,(4,A0)
            move.l  (6,A2),D0
            move.l  D0,D1
            swap    D1
            sub.w   D1,(A0)+
            bvc.b   .L5
            jsr     ([$1A58.w])
.L5:
            sub.w   D0,(A0)+
            bvc.b   .L6
            jsr     ([$1A58.w])
.L6:
            sub.w   D1,(A0)+
            bvc.b   .L7
            jsr     ([$1A58.w])
.L7:
            sub.w   D0,(A0)+
            bvc.b   .L8
            jsr     ([$1A58.w])
.L8:
            movea.l DeviceList,A2
            clr.w   -(SP)
.L9:
            movea.l (A2),A0
            tst.w   ($14,A0)
            bpl.b   .L10
            clr.b   -(SP)
            pea     (-$8C,A6)
            pea     ($22,A0)
            pea     (-$AC,A6)
            jsr     ([$10A8.w])
            tst.b   (SP)+
            beq.b   .L10
            lea     (-$AC,A6),A0
            move.l  (4,A0),-(SP)
            move.l  (A0),-(SP)
            move.l  A2,-(SP)
            move.w  #1,-(SP)
.L10:
            movea.l (A2),A0
            move.l  ($1E,A0),D0
            movea.l D0,A2
            bne.b   .L9
            movea.l SP,A2
            clr.l   -(SP)
            moveq   #0,D1
.L11:
            movea.l A2,A0
            movea.l D1,A1
.L12:
            tst.w   (A0)
            bmi.b   .L14
            beq.b   .L15
            cmp.l   A1,D1
            beq.b   .L13
            jsr     (A4)
            beq.b   .L14
.L13:
            movea.l A0,A1
.L14:
            lea     ($E,A0),A0
            bra.b   .L12
.L15:
            cmp.l   A1,D1
            beq.b   .L16
            st      (A1)
            move.l  A1,-(SP)
            bra.b   .L11
.L16:
            move.l  SP,(-$CE,A6)
.L17:
            tst.b   D7
            beq.w   .L30
            movea.l ($E,A6),A0
            lea     (-$94,A6),A1
            move.l  (A0)+,(A1)
            move.l  (A0)+,(4,A1)
            movea.l (-$84,A6),A0
            jsr     ([$1A04.w])
            move.l  (6,A0),D0
            move.l  D0,D1
            swap    D1
            sub.w   D1,(A1)+
            bvc.b   .L18
            jsr     ([$1A58.w])
.L18:
            sub.w   D0,(A1)+
            bvc.b   .L19
            jsr     ([$1A58.w])
.L19:
            sub.w   D1,(A1)+
            bvc.b   .L20
            jsr     ([$1A58.w])
.L20:
            sub.w   D0,(A1)+
            bvc.b   .L21
            jsr     ([$1A58.w])
.L21:
            movea.l DeviceList,A2
            clr.w   -(SP)
.L22:
            movea.l (A2),A0
            tst.w   ($14,A0)
            bpl.b   .L23
            clr.b   -(SP)
            pea     (-$94,A6)
            pea     ($22,A0)
            pea     (-$AC,A6)
            jsr     ([$10A8.w])
            tst.b   (SP)+
            beq.b   .L23
            lea     (-$AC,A6),A0
            move.l  (4,A0),-(SP)
            move.l  (A0),-(SP)
            move.l  A2,-(SP)
            move.w  #1,-(SP)
.L23:
            movea.l (A2),A0
            move.l  ($1E,A0),D0
            movea.l D0,A2
            bne.b   .L22
            movea.l SP,A2
            clr.l   -(SP)
            moveq   #0,D1
.L24:
            movea.l A2,A0
            movea.l D1,A1
.L25:
            tst.w   (A0)
            bmi.b   .L27
            beq.b   .L28
            cmp.l   A1,D1
            beq.b   .L26
            jsr     (A4)
            beq.b   .L27
.L26:
            movea.l A0,A1
.L27:
            lea     ($E,A0),A0
            bra.b   .L25
.L28:
            cmp.l   A1,D1
            beq.b   .L29
            st      (A1)
            move.l  (2,A1),-(SP)
            bra.b   .L24
.L29:
            move.l  SP,(-$D2,A6)
.L30:
            move.l  TheGDevice,-(SP)
            move.l  SrcDevice,-(SP)
            movea.l TheGDevice,A0
            movea.l (A0),A0
            movea.l ($16,A0),A0
            movea.l (A0),A0
            movea.l ($2A,A0),A0
            movea.l (A0),A0
            move.l  (A0),(-$DA,A6)
            move.l  ($50,A3),(-$DE,A6)
            move.l  ($54,A3),(-$E2,A6)
            move.b  HiliteMode,(-$E4,A6)
            lea     (-$A4,A6),A1
            movea.l ($E,A6),A0
            move.l  (A0)+,D0
            move.l  D0,(A1)+
            move.l  (A0)+,D7
            move.l  D7,(A1)+
            sub.w   D0,D7
            swap    D0
            swap    D7
            sub.w   D0,D7
            movea.l ($12,A6),A0
            move.l  (A0)+,D0
            move.l  D0,(A1)+
            move.l  (A0)+,D1
            move.l  D1,(A1)+
            swap    D7
            add.w   D0,D7
            sub.w   D1,D7
            swap    D7
            swap    D0
            swap    D1
            add.w   D0,D7
            sub.w   D1,D7
            movea.l (-$CE,A6),A2
.L31:
            movea.l (-$D2,A6),A4
            move.l  (A2)+,D0
            movea.l D0,A0
            beq.w   .DONE
            move.l  (2,A0),SrcDevice
.L32:
            move.l  (A4)+,D1
            beq.b   .L31
            move.l  D1,TheGDevice
            tst.b   D6
            beq.w   .CLIPOK
            movea.l (-4,A2),A0
            addq.w  #6,A0
            move.l  (A0)+,D0
            move.l  (A0)+,D1
            cmp.l   (-$8C,A6),D0
            bne.b   .DOTRIM
            cmp.l   (-$88,A6),D1
            beq.b   .CLIPOK
.DOTRIM:
            movea.l ($E,A6),A0
            lea     (-$A4,A6),A1
            move.l  (A0)+,(A1)+
            move.l  (A0)+,(A1)+
            movea.l ($12,A6),A0
            move.l  (A0)+,(A1)+
            move.l  (A0)+,(A1)+
            sub.w   (-$8A,A6),D0
            ble.b   .L34
            add.w   D0,(-$9A,A6)
            add.w   D0,(-$A2,A6)
.L34:
            swap    D0
            sub.w   (-$8C,A6),D0
            ble.b   .L35
            add.w   D0,(-$9C,A6)
            add.w   D0,(-$A4,A6)
.L35:
            sub.w   (-$86,A6),D1
            bpl.b   .L36
            add.w   D1,(-$96,A6)
            add.w   D1,(-$9E,A6)
.L36:
            swap    D1
            sub.w   (-$88,A6),D1
            bpl.b   .L37
            add.w   D1,(-$98,A6)
            add.w   D1,(-$A0,A6)
.L37:
            tst.l   D7
            beq.b   .CLIPOK
            lea     (-$9C,A6),A0
            lea     (-$A4,A6),A1
            move.l  (A0)+,(A1)+
            move.l  (A0)+,(A1)+
            pea     (-$A4,A6)
            move.l  ($12,A6),-(SP)
            move.l  ($E,A6),-(SP)
            jsr     ([$11E8.w])
.CLIPOK:
            move.b  (-$E4,A6),HiliteMode
            tst.w   (6,A3)
            bpl.w   .DOIT
            movea.l TheGDevice,A0
            movea.l (A0),A0
            movea.l ($16,A0),A0
            movea.l (A0),A0
            movea.l ($2A,A0),A0
            movea.l (A0),A0
            move.l  (A0),D0
            cmp.l   (-$DA,A6),D0
            beq.b   .DOIT
            move.l  D0,(-$DA,A6)
            subq.w  #6,SP
            clr.l   -(SP)
            move.l  (8,A3),D0
            beq.b   .NoPlt
            movea.l D0,A0
            movea.l (A0),A0
            tst.l   ($C,A0)
            beq.b   .NoPlt
            move.w  ($18,A0),D2
            move.w  ($16,A0),(2,SP)
            btst    #1,D2
            sne     (SP)
            btst    #0,D2
            beq.b   .NoPlt
            move.w  ($10,A0),-(SP)
            jsr     ([$185C.w])
            bra.b   .NoPlt1
.NoPlt:
            pea     (4,SP)
            move.l  (SP),-(SP)
            jsr     ([$1664.w])
            jsr     ([$1650.w])
.NoPlt1:
            tst.b   (SP)
            beq.b   .NoPlt2
            move.w  (2,SP),-(SP)
            jsr     ([$1860.w])
            bra.b   .BkDone
.NoPlt2:
            pea     (4,SP)
            move.l  (SP),-(SP)
            jsr     ([$1668.w])
            jsr     ([$1654.w])
.BkDone:
            lea     ($A,SP),SP
.DOIT:
            move.l  ($16,A6),-(SP)
            move.l  (-$F0,A6),-(SP)
            move.l  (-$84,A6),-(SP)
            pea     (-$9C,A6)
            move.l  (-$F4,A6),-(SP)
            pea     (-$A4,A6)
            move.w  ($C,A6),-(SP)
            andi.w  #$FFF7,(SP)
            clr.l   -(SP)
            move.l  (-$E8,A6),-(SP)
            move.l  (-$EC,A6),-(SP)
            move.l  (8,A6),-(SP)
            bne.b   .MASKOK
            movea.l (A5),A0
            move.l  (-$82,A0),(SP)
.MASKOK:
            clr.w   -(SP)
            jsr     ([$1A9C.w])
            bra.w   .L32
.DONE:
            move.l  (SP)+,SrcDevice
            move.l  (SP)+,TheGDevice
            move.l  (-$DE,A6),($50,A3)
            move.l  (-$E2,A6),($54,A3)
            bset    #7,HiliteMode
            movea.l (-$D6,A6),SP
            rts
.L46:
            dc.w    $0008,$003A,$0024,$0050,$3028,$000A,$B069,$0006
            dc.w    $6F0E,$3028,$000C,$B069,$0008,$6F04
.L47:
            moveq   #0,D0
            rts
XTRUE:
            moveq   #1,D0
            rts
            move.w  (6,A0),D0
            cmp.w   ($A,A1),D0
            bge.b   XTRUE
            move.w  ($C,A0),D0
            cmp.w   (8,A1),D0
            ble.b   XTRUE
            bra.b   BitsDevLoop.L47
            move.w  ($A,A0),D0
            cmp.w   (6,A1),D0
            ble.b   XTRUE
            move.w  (8,A0),D0
            cmp.w   ($C,A1),D0
            bge.b   XTRUE
            bra.b   BitsDevLoop.L47
            move.w  (6,A0),D0
            cmp.w   ($A,A1),D0
            bge.b   XTRUE
            move.w  (8,A0),D0
            cmp.w   ($C,A1),D0
            bge.b   XTRUE
            bra.b   BitsDevLoop.L47
            dc.w    0
CopyBits:
            link.w  A6,#-$10
            movem.l D2/D6-D7/A2-A4,-(SP)
            movea.l (A5),A4
            movea.l (A4),A3
            movea.l ($1A,A6),A0
            jsr     ([$1A04.w])
            movea.l A0,A2
            move.l  (-$7A,A4),D6
            move.l  (A2),D7
            cmp.l   D6,D7
            bne.b   .L1
            move.l  ($12,A6),-(SP)
            move.l  (6,A2),-(SP)
            jsr     ([$F54.w])
.L1:
            movea.l ($16,A6),A0
            jsr     ([$1A04.w])
            movea.l A0,A1
            move.l  A3,D0
            beq.b   .L3
            btst    #0,D0
            bne.b   .L3
            movea.l A3,A0
            jsr     ([$1A5C.w])
            move.l  (A1),D1
            cmp.l   (A0),D1
            beq.b   .L2
            cmp.l   D6,D1
            bne.b   .L3
            move.l  ROMBase,D0
            cmp.l   (A0),D0
            bne.b   .L3
            bra.w   .L6
.L2:
            move.l  (6,A0),D0
            cmp.l   (6,A1),D0
            beq.w   .L6
.L3:
            cmp.l   D6,D7
            beq.w   .L5
            movem.l D1/A1,-(SP)
            subq.w  #6,SP
            clr.l   -(SP)
            pea     (4,SP)
            move.l  (SP),-(SP)
            jsr     ([$1664.w])
            jsr     ([$1650.w])
            pea     (4,SP)
            move.l  (SP),-(SP)
            jsr     ([$1668.w])
            jsr     ([$1654.w])
            lea     ($A,SP),SP
            movem.l (SP)+,D1/A1
            cmp.l   D6,D1
            beq.b   .L5
            move.l  ($1A,A6),-(SP)
            clr.l   -(SP)
            move.l  ($16,A6),-(SP)
            move.l  ($12,A6),-(SP)
            clr.l   -(SP)
            move.l  ($E,A6),-(SP)
            move.w  ($C,A6),-(SP)
            andi.w  #$FFF7,(SP)
            clr.l   -(SP)
            move.l  (-$82,A4),-(SP)
            move.l  (SP),-(SP)
            move.l  (8,A6),-(SP)
            bne.b   .L4
            move.l  (-$82,A4),(SP)
.L4:
            clr.w   -(SP)
            jsr     ([$1A9C.w])
            bra.w   .L10
.L5:
            move.l  ($1A,A6),-(SP)
            movea.l ($16,A6),A1
            move.l  ($12,A6),-(SP)
            move.l  ($E,A6),-(SP)
            move.w  ($C,A6),-(SP)
            move.l  (8,A6),-(SP)
            jsr     GoDevLoop
            bra.w   .L10
.L6:
            move.w  (4,A2),D1
            bpl.w   .L8
            tst.w   (6,A3)
            bmi.w   .L8
            move.l  ($68,A3),D0
            beq.w   .L8
            movea.l ($11AC).w,A1
            exg     D0,A1
            cmp.l   ($20,A1),D0
            beq.w   .L8
            move.l  A0,-(SP)
            suba.w  #$12,SP
            moveq   #0,D0
            move.w  D1,D0
            lsl.w   #3,D0
            move.w  ($20,A2),D1
            divu.w  D1,D0
            moveq   #$F,D2
            add.l   D2,D0
            asr.l   #4,D0
            ble.w   .L7
            add.w   D0,D0
            move.w  D0,(4,SP)
            move.l  (6,A2),D1
            move.l  ($A,A2),D2
            move.l  D1,(6,SP)
            move.l  D2,($A,SP)
            swap    D1
            swap    D2
            sub.w   D1,D2
            mulu.w  D2,D0
            _NewHandle
            bne.b   .L7
            move.l  A0,($E,SP)
            _HLock
            movea.l (A0),A0
            move.l  A0,(SP)
            move.l  ($5C,A3),-(SP)
            clr.l   ($5C,A3)
            subq.w  #6,SP
            move.l  SP,-(SP)
            jsr     ([$1664.w])
            moveq   #$21,D0
            move.l  D0,-(SP)
            jsr     ([$F88.w])
            move.l  ($1A,A6),-(SP)
            pea     ($E,SP)
            move.l  ($12,A6),-(SP)
            move.l  (SP),-(SP)
            clr.w   -(SP)
            clr.l   -(SP)
            jsr     ([$11B0.w])
            move.l  SP,-(SP)
            jsr     ([$1650.w])
            addq.w  #6,SP
            move.l  (SP)+,($5C,A3)
            move.l  SP,-(SP)
            move.l  ($12,A6),-(SP)
            move.l  ($E,A6),-(SP)
            move.w  ($C,A6),-(SP)
            move.l  (8,A6),-(SP)
            move.l  ($68,A3),D0
            movea.l D0,A0
            movea.l ($20,A0),A0
            jsr     (A0)
            movea.l ($E,SP),A0
            _DisposHandle
.L7:
            lea     ($12,SP),SP
            movea.l (SP)+,A0
            bra.b   .L10
.L8:
            move.l  A2,-(SP)
            move.l  ($12,A6),-(SP)
            move.l  ($E,A6),-(SP)
            move.w  ($C,A6),-(SP)
            move.l  (8,A6),-(SP)
            move.l  ($68,A3),D0
            movea.l ($11AC).w,A0
            beq.b   .L9
            movea.l D0,A0
            movea.l ($20,A0),A0
.L9:
            jsr     (A0)
.L10:
            cmp.l   D6,D7
            bne.b   .L11
            jsr     ([$F4C.w])
.L11:
            movem.l (SP)+,D2/D6-D7/A2-A4
            unlk    A6
            rtd     #$16
            ds.b    4
GoDevLoop:
            link.w  A6,#-$F4
            movem.l D3-D7,-(SP)
            move.l  A1,(-$84,A6)
            move.l  (-$82,A4),(-$E8,A6)
            move.l  (-$82,A4),(-$EC,A6)
            clr.l   (-$F0,A6)
            clr.l   (-$F4,A6)
            jsr     ([$1C78.w])
            movem.l (SP)+,D3-D7
            unlk    A6
            rtd     #$12
COPYCICON:
            bra.b   CopyMask.L1
CopyMask:
            suba.l  A0,A0
.L1:
            link.w  A6,#0
            movem.l D3-D7/A2-A4,-(SP)
            movea.l ($14,A6),A1
            move.l  ($18,A6),D0
            move.l  ($C,A6),D1
            movea.l (A5),A4
            movea.l (A4),A3
            move.l  (-$82,A4),D2
            move.l  D2,D3
            move.l  ($1C,A6),-(SP)
            move.l  ($10,A6),-(SP)
            move.l  (8,A6),-(SP)
            clr.w   -(SP)
            move.l  D2,-(SP)
            tst.l   A0
            beq.b   .L2
            move.l  A0,(SP)
.L2:
            movea.l ($14,A6),A0
            jsr     ([$1A04.w])
            movea.l A0,A1
            move.l  A3,D4
            beq.b   .L3
            btst    #0,D4
            bne.b   .L3
            movea.l D4,A0
            jsr     ([$1A5C.w])
            move.l  (A0),D4
            cmp.l   (A1),D4
            bne.b   .L3
            move.l  (6,A0),D4
            cmp.l   (6,A1),D4
            bne.b   .L3
            move.l  ($1C,A3),D2
            move.l  ($18,A3),D3
.L3:
            movea.l ($14,A6),A1
            jsr     CMDEVLOOP
            movem.l (SP)+,D3-D7/A2-A4
            unlk    A6
            rtd     #$18
CMDEVLOOP:
            link.w  A6,#-$F4
            move.l  A1,(-$84,A6)
            move.l  D0,(-$F0,A6)
            move.l  D1,(-$F4,A6)
            move.l  D2,(-$E8,A6)
            move.l  D3,(-$EC,A6)
            jsr     ([$1C78.w])
            unlk    A6
            rtd     #$12
            ds.b    12
SeedFill:
            movea.l (SP)+,A0
            moveq   #-1,D0
            move.l  D0,-(SP)
            bra.b   CalcMask.L1
CalcMask:
            movea.l (SP)+,A0
            moveq   #-1,D0
            move.l  D0,-(SP)
            clr.l   -(SP)
.L1:
            move.l  A0,-(SP)
            link.w  A6,#-6
            movem.l D3-D7/A2-A4,-(SP)
            move.l  SP,(-6,A6)
            move.w  ($10,A6),D5
            ble.w   .L22
            subq.w  #1,D5
            subq.w  #1,($12,A6)
            blt.w   .L22
            move.w  ($10,A6),D0
            add.w   D0,D0
            move.w  ($14,A6),D1
            sub.w   D0,D1
            move.w  D1,(-2,A6)
            movea.l ($18,A6),A2
            moveq   #-1,D0
            move.w  ($12,A6),D3
.L2:
            move.w  D5,D2
.L3:
            move.w  D0,(A2)+
            dbra    D2,.L3
            adda.w  D1,A2
            dbra    D3,.L2
            move.w  ($C,A6),D0
            blt.b   .L4
            mulu.w  ($14,A6),D0
            movea.l ($18,A6),A0
            adda.l  D0,A0
            move.w  ($E,A6),D0
            move.w  D0,D1
            asr.w   #3,D0
            not.w   D1
            bclr    D1,(0,A0,D0.w)
.L4:
            move.l  (8,A6),D6
            move.w  D5,D1
.L5:
            move.w  D6,-(SP)
            dbra    D1,.L5
            movea.l ($1C,A6),A0
            movea.l ($18,A6),A2
.L6:
            sf      D7
            move.w  ($12,A6),D4
            movea.l SP,A1
.L7:
            move.l  D6,D1
            move.w  D5,D3
.L8:
            move.w  (A2),D1
            bne.b   .L9
            addq.w  #2,A0
            addq.w  #2,A1
            addq.w  #2,A2
            swap    D1
            dbra    D3,.L8
            bra.b   .L13
.L9:
            move.w  (A0)+,D2
            and.w   (A1)+,D1
            or.w    D2,D1
            bra.b   .L11
.L10:
            move.w  D0,D1
.L11:
            move.l  D1,D0
            lsr.l   #1,D0
            and.w   D1,D0
            or.w    D2,D0
            cmp.w   D1,D0
            bne.b   .L10
            cmp.w   (A2),D1
            beq.b   .L12
            st      D7
.L12:
            move.w  D1,(A2)+
            swap    D1
            dbra    D3,.L8
.L13:
            move.l  D6,D1
            move.w  D5,D3
.L14:
            move.w  -(A2),D1
            bne.b   .L15
            subq.w  #2,A0
            subq.w  #2,A1
            swap    D1
            dbra    D3,.L14
            bra.b   .L19
.L15:
            move.w  -(A0),D2
            and.w   -(A1),D1
            or.w    D2,D1
            bra.b   .L17
.L16:
            move.w  D0,D1
.L17:
            move.l  D1,D0
            rol.l   #1,D0
            and.w   D1,D0
            or.w    D2,D0
            cmp.w   D1,D0
            bne.b   .L16
            cmp.w   (A2),D1
            beq.b   .L18
            st      D7
            move.w  D1,(A2)
.L18:
            swap    D1
            dbra    D3,.L14
.L19:
            adda.w  ($16,A6),A0
            adda.w  ($14,A6),A2
            movea.l A2,A1
            suba.w  ($14,A6),A1
            dbra    D4,.L7
            neg.w   ($16,A6)
            neg.w   ($14,A6)
            adda.w  ($16,A6),A0
            adda.w  ($14,A6),A2
            tst.b   D7
            bne.w   .L6
            tst.w   D6
            bpl.b   .L22
            move.w  (-2,A6),D1
            movea.l ($18,A6),A2
            move.w  ($12,A6),D3
.L20:
            move.w  D5,D2
.L21:
            not.w   (A2)+
            dbra    D2,.L21
            adda.w  D1,A2
            dbra    D3,.L20
.L22:
            movea.l (-6,A6),SP
            movem.l (SP)+,D3-D7/A2-A4
            unlk    A6
            rtd     #$18
            ds.b    8
ScrollRect:
            link.w  A6,#-8
            movem.l D6-D7/A3-A4,-(SP)
            movea.l (A5),A4
            movea.l (A4),A3
            move.l  ($5C,A3),-(SP)
            clr.l   ($5C,A3)
            tst.w   ($42,A3)
            blt.w   .L2
            tst.l   ($C,A6)
            beq.w   .L2
            subq.w  #6,SP
            move.l  SP,-(SP)
            jsr     ([$1664.w])
            move.l  #$21,-(SP)
            jsr     ([$F88.w])
            subq.w  #6,SP
            move.l  SP,-(SP)
            jsr     ([$1668.w])
            move.l  #$1E,-(SP)
            jsr     ([$F8C.w])
            subq.w  #8,SP
            jsr     ([$1160.w])
            move.l  (SP)+,D7
            jsr     ([$1160.w])
            move.l  (SP)+,D6
            move.l  D7,-(SP)
            move.l  ($10,A6),-(SP)
            jsr     ([$117C.w])
            move.l  D7,-(SP)
            move.l  ($18,A3),-(SP)
            move.l  D7,-(SP)
            jsr     ([$1190.w])
            move.l  D7,-(SP)
            move.l  ($1C,A3),-(SP)
            move.l  D7,-(SP)
            jsr     ([$1190.w])
            move.l  D7,-(SP)
            move.l  D6,-(SP)
            jsr     ([$1170.w])
            move.l  D6,-(SP)
            move.l  ($C,A6),-(SP)
            jsr     ([$1180.w])
            movea.l ($10,A6),A0
            move.l  (A0)+,(-8,A6)
            move.l  (A0)+,(-4,A6)
            move.l  ($C,A6),D0
            add.w   D0,(-6,A6)
            add.w   D0,(-2,A6)
            swap    D0
            add.w   D0,(-8,A6)
            add.w   D0,(-4,A6)
            move.l  D7,-(SP)
            move.l  D6,-(SP)
            move.l  D6,-(SP)
            jsr     ([$1190.w])
            pea     (2,A3)
            move.l  (SP),-(SP)
            move.l  ($10,A6),-(SP)
            pea     (-8,A6)
            clr.w   -(SP)
            move.l  D6,-(SP)
            jsr     ([$11B0.w])
            move.l  SP,-(SP)
            jsr     ([$1654.w])
            addq.w  #6,SP
            move.l  SP,-(SP)
            jsr     ([$1650.w])
            addq.w  #6,SP
            move.l  (8,A6),D0
            beq.b   .L1
            move.l  D0,-(SP)
            move.l  D7,-(SP)
            move.l  D6,-(SP)
            move.l  D0,-(SP)
            jsr     ([$1198.w])
            jsr     ([$1150.w])
.L1:
            movea.l D7,A0
            _DisposHandle
            movea.l D6,A0
            _DisposHandle
            bra.b   .L3
.L2:
            move.l  (8,A6),D0
            beq.b   .L3
            move.l  D0,-(SP)
            jsr     ([$1174.w])
.L3:
            move.l  (SP)+,($5C,A3)
            movem.l (SP)+,D6-D7/A3-A4
            unlk    A6
            rtd     #$C
            ds.b    6
PackBits:
            movem.l D3-D4/A2,-(SP)
            move.w  #$80,D4
            movea.l ($16,SP),A0
            movea.l (A0),A0
            movea.l ($12,SP),A1
            movea.l (A1),A1
            move.w  ($10,SP),D3
            subq.w  #1,D3
            blt.b   .L12
.L1:
            move.b  (A0)+,D0
            bra.b   .L3
.L2:
            move.b  (-1,A0),D0
            sub.w   A0,D2
            add.w   D2,D3
            addq.w  #1,D2
            move.b  D2,(A2)
.L3:
            moveq   #$7F,D1
            cmp.w   D4,D3
            bge.b   .L4
            move.w  D3,D1
.L4:
            move.w  A0,D2
            movea.l A1,A2
            clr.b   (A1)+
            cmp.b   (A0),D0
            bne.b   .L6
            cmp.b   (1,A0),D0
            bne.b   .L6
            bra.b   .L9
.L5:
            move.b  (A0)+,D0
            cmp.b   (A0),D0
            bne.b   .L6
            cmp.b   (1,A0),D0
            beq.b   .L7
.L6:
            move.b  D0,(A1)+
            dbra    D1,.L5
            sub.w   A0,D2
            neg.w   D2
            move.b  D2,(A2)
            sub.w   D4,D3
            bpl.b   .L1
            bra.b   .L12
.L7:
            tst.w   D1
            beq.b   .L6
            sub.w   A0,D2
            add.w   D2,D3
            not.w   D2
            move.b  D2,(A2)
            moveq   #$7F,D1
            cmp.w   D4,D3
            bge.b   .L8
            move.w  D3,D1
.L8:
            move.l  A0,D2
            movea.l A1,A2
            clr.b   (A1)+
.L9:
            move.b  D0,(A1)+
.L10:
            cmp.b   (A0)+,D0
            dbne    D1,.L10
            beq.b   .L11
            subq.w  #1,D1
            bge.b   .L2
.L11:
            subq.w  #1,A0
            sub.w   A0,D2
            move.b  D2,(A2)
            sub.w   D4,D3
            bpl.b   .L1
.L12:
            moveq   #0,D0
            move.w  ($10,SP),D0
            movea.l ($16,SP),A0
            add.l   D0,(A0)
            movea.l ($12,SP),A2
            move.l  A1,(A2)
            movem.l (SP)+,D3-D4/A2
.L13:
            movea.l (SP)+,A0
            lea     ($A,SP),SP
            jmp     (A0)
UnpackBits:
            movea.l ($A,SP),A0
            movea.l (A0),A0
            movea.l (6,SP),A1
            movea.l (A1),A1
            move.w  (4,SP),D2
            ext.l   D2
            add.l   A1,D2
            bra.b   .L3
.L1:
            ext.w   D1
.L2:
            move.b  (A0)+,(A1)+
            dbra    D1,.L2
.L3:
            cmpa.l  D2,A1
            bcc.b   .L5
            move.b  (A0)+,D1
            bpl.b   .L1
            neg.b   D1
            bvs.b   .L3
            ext.w   D1
            move.b  (A0)+,D0
.L4:
            move.b  D0,(A1)+
            dbra    D1,.L4
            bra.b   .L3
.L5:
            move.l  A0,D0
            movea.l ($A,SP),A0
            move.l  D0,(A0)
            movea.l (6,SP),A0
            move.l  A1,(A0)
            bra.b   PackBits.L13
            ds.b    6
PACKWORDS:
            movem.l D3-D4/A2,-(SP)
            move.w  #$80,D4
            movea.l ($16,SP),A0
            movea.l (A0),A0
            movea.l ($12,SP),A1
            movea.l (A1),A1
            move.w  ($10,SP),D3
            lsr.w   #1,D3
            subq.w  #1,D3
            blt.w   .L12
.L1:
            move.w  (A0)+,D0
            bra.b   .L3
.L2:
            move.w  (-2,A0),D0
            sub.w   A0,D2
            asr.w   #1,D2
            add.w   D2,D3
            addq.w  #1,D2
            move.b  D2,(A2)
.L3:
            moveq   #$7F,D1
            cmp.w   D4,D3
            bge.b   .L4
            move.w  D3,D1
.L4:
            move.w  A0,D2
            movea.l A1,A2
            clr.b   (A1)+
            cmp.w   (A0),D0
            bne.b   .L6
            cmp.w   (2,A0),D0
            bne.b   .L6
            bra.b   .L9
.L5:
            move.w  (A0)+,D0
            cmp.w   (A0),D0
            bne.b   .L6
            cmp.w   (2,A0),D0
            beq.b   .L7
.L6:
            move.w  D0,(A1)+
            dbra    D1,.L5
            sub.w   A0,D2
            neg.w   D2
            asr.w   #1,D2
            move.b  D2,(A2)
            sub.w   D4,D3
            bpl.b   .L1
            bra.b   .L12
.L7:
            tst.w   D1
            beq.b   .L6
            sub.w   A0,D2
            asr.w   #1,D2
            add.w   D2,D3
            not.w   D2
            move.b  D2,(A2)
            moveq   #$7F,D1
            cmp.w   D4,D3
            bge.b   .L8
            move.w  D3,D1
.L8:
            move.l  A0,D2
            movea.l A1,A2
            clr.b   (A1)+
.L9:
            move.w  D0,(A1)+
.L10:
            cmp.w   (A0)+,D0
            dbne    D1,.L10
            beq.b   .L11
            subq.w  #1,D1
            bge.b   .L2
.L11:
            subq.w  #2,A0
            sub.w   A0,D2
            asr.w   #1,D2
            move.b  D2,(A2)
            sub.w   D4,D3
            bpl.w   .L1
.L12:
            moveq   #0,D0
            move.w  ($10,SP),D0
            movea.l ($16,SP),A0
            add.l   D0,(A0)
            movea.l ($12,SP),A2
            move.l  A1,(A2)
            movem.l (SP)+,D3-D4/A2
.L13:
            movea.l (SP)+,A0
            lea     ($A,SP),SP
            jmp     (A0)
UNPACKWORDS:
            movea.l ($A,SP),A0
            movea.l (A0),A0
            movea.l (6,SP),A1
            movea.l (A1),A1
            move.w  (4,SP),D2
            ext.l   D2
            add.l   A1,D2
            bra.b   .L3
.L1:
            ext.w   D1
.L2:
            move.w  (A0)+,(A1)+
            dbra    D1,.L2
.L3:
            cmpa.l  D2,A1
            bcc.b   .L5
            move.b  (A0)+,D1
            bpl.b   .L1
            neg.b   D1
            bvs.b   .L3
            ext.w   D1
            move.w  (A0)+,D0
.L4:
            move.w  D0,(A1)+
            dbra    D1,.L4
            bra.b   .L3
.L5:
            move.l  A0,D0
            movea.l ($A,SP),A0
            move.l  D0,(A0)
            movea.l (6,SP),A0
            move.l  A1,(A0)
            bra.b   PACKWORDS.L13
            ds.b    8
StdRgn:
            link.w  A6,#0
            movem.l D6-D7/A2-A4,-(SP)
            moveq   #0,D7
            move.b  ($C,A6),D7
            jsr     ([$1A3C.w])
            ble.b   .L1
            move.b  D7,-(SP)
            jsr     PutPicVerb
            move.w  #$80,D0
            add.w   D7,D0
            jsr     DPutPicOp
            move.l  (8,A6),-(SP)
            jsr     PutPicRgn
.L1:
            pea     StdDraw_Regions
            pea     GetRect_Regions
            jsr     ([$1AA0.w])
            movem.l (SP)+,D6-D7/A2-A4
            unlk    A6
            rtd     #6
GetRect_Regions:
            move.l  (SP)+,D0
            movea.l (SP)+,A1
            movea.l (8,A6),A0
            movea.l (A0),A0
            lea     (2,A0),A0
            move.l  (A0)+,(A1)+
            move.l  (A0),(A1)
            movea.l D0,A0
            jmp     (A0)
StdDraw_Regions:
            move.l  (8,A6),-(SP)
            jsr     ([$1A60.w])
            tst.b   D7
            bne.b   .L2
            tst.l   ($60,A3)
            beq.b   .L1
            move.l  (8,A6),-(SP)
            move.l  (-$94,A4),-(SP)
            pea     (-$96,A4)
            pea     (-$98,A4)
            jsr     ([$1A6C.w])
.L1:
            jsr     FrRgn
            bra.b   .L3
.L2:
            jsr     DrawRgn
.L3:
            rts
            ds.b    14
FrameRgn:
            moveq   #0,D0
            bra.b   CallRgn
PaintRgn:
            moveq   #1,D0
            bra.b   CallRgn
EraseRgn:
            moveq   #2,D0
            bra.b   CallRgn
InvertRgn:
            moveq   #3,D0
            bra.b   CallRgn
FillRgn:
            moveq   #0,D0
            bra.b   FillCRgn.L1
FillCRgn:
            moveq   #1,D0
.L1:
            movea.l (SP)+,A0
            movea.l (SP)+,A1
            move.l  A0,-(SP)
            move.l  A1,-(SP)
            jsr     ([$1A8C.w])
            moveq   #4,D0
CallRgn:
            movea.l (SP)+,A0
            movea.l (SP)+,A1
            move.b  D0,-(SP)
            move.l  A1,-(SP)
            move.l  A0,-(SP)
            movea.l (A5),A0
            movea.l (A0),A0
            move.l  ($68,A0),D0
            movea.l ($1144).w,A0
            beq.b   .L1
            movea.l D0,A0
            movea.l ($1C,A0),A0
.L1:
            jmp     (A0)
            ds.b    10
DrawRgn:
            link.w  A6,#-8
            movea.l ($E,A6),A0
            movea.l (A0),A0
            move.l  (2,A0),(-8,A6)
            move.l  (6,A0),(-4,A6)
            movea.l (A5),A0
            movea.l (A0),A0
            tst.w   ($42,A0)
            bmi.b   .L1
            movea.l A0,A1
            jsr     ([$1A5C.w])
            move.l  A0,-(SP)
            clr.l   -(SP)
            move.l  A0,-(SP)
            pea     (-8,A6)
            clr.l   -(SP)
            pea     (-8,A6)
            move.w  ($C,A6),-(SP)
            ori.w   #8,(SP)
            move.l  (8,A6),-(SP)
            move.l  ($1C,A1),-(SP)
            move.l  ($18,A1),-(SP)
            move.l  ($E,A6),-(SP)
            clr.w   -(SP)
            jsr     ([$1A9C.w])
.L1:
            unlk    A6
            rtd     #$A
            dc.w    0
FrRgn:
            link.w  A6,#0
            movem.l D7/A3-A4,-(SP)
            movea.l (A5),A4
            movea.l (A4),A3
            tst.w   ($42,A3)
            bmi.b   .L2
            movea.l ($E,A6),A0
            movea.l (A0),A0
            cmpi.w  #$A,(A0)
            bne.b   .L1
            pea     (2,A0)
            bsr.l   FrmRect
            bra.b   .L2
.L1:
            clr.l   -(SP)
            jsr     ([$1160.w])
            move.l  (SP)+,D7
            move.l  ($E,A6),-(SP)
            move.l  D7,-(SP)
            jsr     ([$1170.w])
            move.l  D7,-(SP)
            move.l  ($34,A3),-(SP)
            jsr     ([$1184.w])
            move.l  ($E,A6),-(SP)
            move.l  D7,-(SP)
            move.l  D7,-(SP)
            jsr     ([$1198.w])
            move.l  D7,-(SP)
            move.w  ($C,A6),-(SP)
            move.l  (8,A6),-(SP)
            jsr     DrawRgn
            movea.l D7,A0
            _DisposHandle
.L2:
            movem.l (SP)+,D7/A3-A4
            unlk    A6
            rtd     #$A
            ds.b    10
NewRgn:
            moveq   #$A,D0
            _NewHandle
            move.l  A0,(4,SP)
            tst.w   D0
            bne.b   .L1
            movea.l (A0),A0
            move.w  #$A,(A0)+
            clr.l   (A0)+
            clr.l   (A0)+
.L1:
            rts
            ds.b    8
DisposeRgn:
            movea.l (SP)+,A1
            movea.l (SP)+,A0
            _DisposHandle
            jmp     (A1)
            ds.b    8
OpenRgn:
            movem.l D3/A2-A4,-(SP)
            movea.l (A5),A4
            movea.l (A4),A0
            moveq   #1,D0
            move.l  D0,($60,A0)
            clr.w   (-$96,A4)
            clr.l   -(SP)
            move.w  #$100,-(SP)
            move.w  (SP),(-$98,A4)
            jsr     NewHandle
            move.l  (SP)+,(-$94,A4)
            jsr     ([$1058.w])
            movem.l (SP)+,D3/A2-A4
            rts
CloseRgn:
            link.w  A6,#-2
            movem.l D3/A2-A4,-(SP)
            movea.l (A5),A4
            movea.l (A4),A0
            tst.l   ($60,A0)
            beq.b   .L2
            clr.l   ($60,A0)
            jsr     ([$105C.w])
            move.w  (-$96,A4),D0
            cmpi.w  #$FF6D,QDErr
            bne.b   .L1
            moveq   #0,D0
            move.w  D0,QDErr
.L1:
            lsr.w   #2,D0
            move.w  D0,(-2,A6)
            movea.l (-$94,A4),A3
            move.l  (A3),-(SP)
            move.w  D0,-(SP)
            jsr     ([$1A98.w])
            move.l  (A3),-(SP)
            pea     (-2,A6)
            jsr     ([$1A18.w])
            move.l  A3,-(SP)
            move.w  (-2,A6),-(SP)
            move.l  (8,A6),-(SP)
            jsr     ([$1A48.w])
            movea.l A3,A0
            _DisposHandle
.L2:
            movem.l (SP)+,D3/A2-A4
            unlk    A6
            rtd     #4
            ds.b    4
CopyRgn:
            link.w  A6,#0
            movea.l ($C,A6),A0
            movea.l (8,A6),A1
            cmpa.l  A0,A1
            beq.b   .L4
            movea.l (A0),A0
            movea.l (A1),A1
            move.w  (A0),D0
            cmp.w   (A1),D0
            beq.b   .L1
            movem.l D0/D3/A2,-(SP)
            move.l  (8,A6),-(SP)
            move.w  D0,-(SP)
            jsr     SetHSize
            movem.l (SP)+,D0/D3/A2
            movea.l ($C,A6),A0
            movea.l (8,A6),A1
            movea.l (A0),A0
            movea.l (A1),A1
.L1:
            lsr.w   #2,D0
            bcc.b   .L3
            move.w  (A0)+,(A1)+
            bra.b   .L3
.L2:
            move.l  (A0)+,(A1)+
.L3:
            dbra    D0,.L2
.L4:
            unlk    A6
            rtd     #8
            ds.b    4
SetEmptyRgn:
            movea.l (SP)+,A0
            clr.l   -(SP)
            clr.l   -(SP)
            move.l  A0,-(SP)
            jmp     SetRectRgn
            ds.b    4
SetRectRgn:
            link.w  A6,#0
            movem.l D3/A2,-(SP)
            movea.l ($10,A6),A0
            movea.l (A0),A1
            moveq   #$A,D0
            cmp.w   (A1),D0
            beq.b   .L1
            move.l  A0,-(SP)
            move.w  D0,-(SP)
            jsr     SetHSize
            movea.l ($10,A6),A0
            movea.l (A0),A1
            move.w  #$A,(A1)
.L1:
            move.l  ($C,A6),(2,A1)
            move.l  (8,A6),(6,A1)
            move.w  (4,A1),D0
            cmp.w   (8,A1),D0
            bge.b   .L2
            move.w  (2,A1),D0
            cmp.w   (6,A1),D0
            blt.b   .L3
.L2:
            clr.l   (2,A1)
            clr.l   (6,A1)
.L3:
            movem.l (SP)+,D3/A2
            unlk    A6
            rtd     #$C
            ds.b    8
RectRgn:
            movea.l (SP)+,A0
            movea.l (SP)+,A1
            move.l  (A1)+,-(SP)
            move.l  (A1)+,-(SP)
            move.l  A0,-(SP)
            jmp     SetRectRgn
            dc.w    0
OffsetRgn:
            movea.l (SP)+,A1
            move.w  (SP)+,D1
            move.w  (SP)+,D0
            movea.l (SP)+,A0
            movea.l (A0),A0
            addq.w  #2,A0
            add.w   D1,(A0)+
            add.w   D0,(A0)+
            add.w   D1,(A0)+
            add.w   D0,(A0)+
            cmpi.w  #$A,(-$A,A0)
            beq.b   .L3
.L1:
            add.w   D1,(A0)+
.L2:
            add.w   D0,(A0)+
            add.w   D0,(A0)+
            cmpi.w  #$7FFF,(A0)
            bne.b   .L2
            addq.w  #2,A0
            cmpi.w  #$7FFF,(A0)
            bne.b   .L1
.L3:
            jmp     (A1)
            ds.b    14
InsetRgn:
            link.w  A6,#0
            movem.l D3-D7/A2-A4,-(SP)
            move.l  (8,A6),D6
            beq.b   .L2
            movea.l ($C,A6),A4
            movea.l (A4),A3
            move.w  (A3)+,D7
            cmpi.w  #$A,D7
            bne.b   .L3
            move.l  A3,-(SP)
            move.l  D6,-(SP)
            jsr     ([$10A4.w])
            move.w  (2,A3),D0
            cmp.w   (6,A3),D0
            bge.b   .L1
            move.w  (A3),D0
            cmp.w   (4,A3),D0
            blt.b   .L2
.L1:
            clr.l   (A3)+
            clr.l   (A3)+
.L2:
            bra.b   sub_40836272.L4
.L3:
            add.w   D7,D7
            clr.l   -(SP)
            move.w  D7,-(SP)
            jsr     NewHandle
            movea.l (SP)+,A3
            bsr.b   sub_40836272
            swap    D6
            bsr.b   sub_40836272
            bra.b   sub_40836272.L3
sub_40836272:
            clr.w   -(SP)
            move.l  A4,-(SP)
            move.l  A4,-(SP)
            move.l  A3,-(SP)
            move.w  D7,-(SP)
            move.w  #8,-(SP)
            move.w  D6,-(SP)
            st      -(SP)
            jsr     ([$1A80.w])
            move.w  (SP)+,D5
            movea.l (A3),A0
            move.w  D5,D1
            bra.b   .L2
.L1:
            move.l  (A0),D0
            swap    D0
            move.l  D0,(A0)+
.L2:
            dbra    D1,.L1
            move.l  (A3),-(SP)
            move.w  D5,-(SP)
            jsr     ([$1A98.w])
            move.l  A3,-(SP)
            move.w  D5,-(SP)
            move.l  A4,-(SP)
            jsr     ([$1A48.w])
            rts
.L3:
            movea.l A3,A0
            _DisposHandle
.L4:
            movem.l (SP)+,D3-D7/A2-A4
            unlk    A6
            rtd     #8
            ds.b    14
EmptyRgn:
            movea.l (SP)+,A0
            movea.l (SP)+,A1
            movea.l (A1),A1
            pea     (2,A1)
            move.l  A0,-(SP)
            jmp     ([$10B8.w])
            ds.b    14
EqualRgn:
            movea.l (4,SP),A0
            movea.l (8,SP),A1
            cmpa.l  A0,A1
            beq.b   .L3
            movea.l (A0),A0
            movea.l (A1),A1
            move.w  (A0),D0
            move.w  D0,D1
            lsr.w   #2,D1
            subq.w  #1,D1
.L1:
            cmpm.l  (A0)+,(A1)+
            dbne    D1,.L1
            bne.b   .L4
            andi.w  #3,D0
            beq.b   .L3
.L2:
            cmpm.b  (A0)+,(A1)+
            bne.b   .L4
            subq.w  #1,D0
            bne.b   .L2
.L3:
            moveq   #1,D0
            bra.b   .L5
.L4:
            moveq   #0,D0
.L5:
            move.b  D0,($C,SP)
            movea.l (SP)+,A0
            addq.w  #8,SP
            jmp     (A0)
            dc.w    0
SectRgn:
            moveq   #0,D0
            bra.b   DoRgnOp
UnionRgn:
            moveq   #4,D0
            bra.b   DoRgnOp
DiffRgn:
            moveq   #2,D0
            bra.b   DoRgnOp
XorRgn:
            moveq   #6,D0
DoRgnOp:
            link.w  A6,#-8
            movem.l D3-D7/A2-A4,-(SP)
            move.w  D0,D5
            movea.l ($10,A6),A2
            movea.l ($C,A6),A3
            movea.l (8,A6),A4
            moveq   #2,D7
            clr.b   -(SP)
            move.l  A2,-(SP)
            move.l  A3,-(SP)
            jsr     ([$118C.w])
            tst.b   (SP)+
            beq.b   .L3
            and.w   D7,D5
            bne.b   .L2
.L1:
            move.l  A2,-(SP)
            move.l  A4,-(SP)
            jsr     ([$1170.w])
            bra.b   .L6
.L2:
            move.l  A4,-(SP)
            jsr     ([$1174.w])
            bra.b   .L6
.L3:
            movea.l (A2),A0
            movea.l (A3),A1
            cmp.w   D7,D5
            bgt.b   .L7
            blt.b   .L4
            move.w  (4,A1),D0
            cmp.w   (8,A1),D0
            bge.b   .L1
.L4:
            pea     (2,A0)
            pea     (2,A1)
            move.w  D7,-(SP)
            pea     (-8,A6)
            jsr     ([$1A84.w])
            bne.b   .L5
            tst.w   D5
            beq.b   .L2
            bra.b   .L1
.L5:
            movea.l (A2),A0
            movea.l (A3),A1
            tst.w   D5
            bne.b   .L8
            moveq   #$A,D0
            cmp.w   (A0),D0
            bne.b   .L8
            cmp.w   (A1),D0
            bne.b   .L8
            move.l  A4,-(SP)
            pea     (-8,A6)
            jsr     ([$117C.w])
.L6:
            bra.b   .L9
.L7:
            move.w  (4,A1),D0
            cmp.w   (8,A1),D0
            bge.b   .L1
            move.w  (4,A0),D0
            cmp.w   (8,A0),D0
            blt.b   .L8
            movea.l A3,A2
            bra.b   .L1
.L8:
            move.w  (A0),D4
            add.w   (A1),D4
            add.w   D4,D4
            clr.l   -(SP)
            move.w  D4,-(SP)
            jsr     NewHandle
            movea.l (SP)+,A3
            clr.w   -(SP)
            move.l  ($10,A6),-(SP)
            move.l  ($C,A6),-(SP)
            move.l  A3,-(SP)
            move.w  D4,-(SP)
            move.w  D5,-(SP)
            clr.w   -(SP)
            st      -(SP)
            jsr     ([$1A80.w])
            move.w  (SP)+,D6
            move.l  A3,-(SP)
            move.w  D6,-(SP)
            move.l  A4,-(SP)
            jsr     ([$1A48.w])
            movea.l A3,A0
            _DisposHandle
.L9:
            movem.l (SP)+,D3-D7/A2-A4
            unlk    A6
            rtd     #$C
            dc.w    0
PtInRgn:
            link.w  A6,#0
            move.l  D3,-(SP)
            move.w  ($E,A6),D1
            move.w  ($C,A6),D2
            clr.w   D3
            movea.l (8,A6),A0
            movea.l (A0),A0
            cmp.w   (4,A0),D1
            blt.b   .L4
            cmp.w   (8,A0),D1
            bge.b   .L4
            cmp.w   (2,A0),D2
            blt.b   .L4
            cmp.w   (6,A0),D2
            bge.b   .L4
            cmpi.w  #$A,(A0)
            bne.b   .L1
            not.w   D3
            bra.b   .L4
.L1:
            lea     ($A,A0),A0
.L2:
            cmp.w   (A0)+,D2
            blt.b   .L4
.L3:
            move.w  (A0)+,D0
            cmpi.w  #$7FFF,D0
            beq.b   .L2
            cmp.w   D1,D0
            bgt.b   .L3
            not.w   D3
            bra.b   .L3
.L4:
            neg.b   D3
            move.b  D3,($10,A6)
            move.l  (SP)+,D3
            unlk    A6
            rtd     #8
            dc.w    0
RectInRgn:
            link.w  A6,#-$24
            movem.l D0-D7/A1-A5,-(SP)
            move.l  SP,(-$C,A6)
            clr.b   ($10,A6)
            movea.l (8,A6),A1
            movea.l (A1),A1
            move.l  ($C,A6),-(SP)
            pea     (2,A1)
            move.w  #2,-(SP)
            pea     (-8,A6)
            jsr     ([$1A84.w])
            beq.b   .L4
            cmpi.w  #$A,(A1)
            beq.b   .L3
            movea.l A1,A0
            lea     (-$24,A6),A1
            move.w  (-6,A6),D0
            move.w  (-2,A6),D1
            move.w  D0,D2
            jsr     ([$1C54.w])
            move.w  ($C,A1),D5
            move.w  (-8,A6),D0
            jsr     ([$1A88.w])
            move.w  (-4,A6),D6
.L1:
            movea.l (8,A1),A0
            move.w  D5,D0
.L2:
            tst.l   (A0)+
            dbne    D0,.L2
            bne.b   .L3
            move.w  ($10,A1),D0
            cmp.w   D0,D6
            ble.b   .L4
            jsr     ([$1A88.w])
            bra.b   .L1
.L3:
            addq.b  #1,($10,A6)
.L4:
            movea.l (-$C,A6),SP
            movem.l (SP)+,D0-D7/A1-A5
            unlk    A6
            rtd     #8
            ds.b    4
TrimRect:
            link.w  A6,#0
            movem.l D0-D7/A1-A5,-(SP)
            movea.l ($A,A6),A0
            movem.l (A0),D4-D5
            move.l  D4,D6
            swap    D6
            movea.l ($E,A6),A3
            movea.l (A3),A3
            move.w  (A3),D2
            cmpi.w  #$A,D2
            beq.w   .L21
            lea     ($A,A3),A3
            movea.l ($594).w,A0
            jsr     (A0)
            subi.l  #$640,D0
            ext.l   D2
            cmp.l   D2,D0
            bge.b   .L1
            move.w  D5,D2
            sub.w   D4,D2
            ext.l   D2
            lsl.l   #2,D2
            cmp.l   D0,D2
            ble.b   .L1
            bra.w   .L21
.L1:
            lsr.l   #1,D2
            bclr    #0,D2
            movea.l SP,A0
            suba.l  D2,SP
            movea.l SP,A4
            suba.l  D2,SP
            movea.l SP,A5
            moveq   #0,D2
            move.w  #$7FFF,D7
            movea.l A4,A1
            bra.b   .L3
.L2:
            cmp.w   D7,D0
            bne.b   .L4
.L3:
            move.w  D7,(A1)
            cmp.w   (A3)+,D6
            blt.b   .L12
            movea.l A4,A2
            movea.l A5,A1
            exg     A4,A5
.L4:
            move.w  (A2)+,D1
.L5:
            move.w  (A3)+,D0
.L6:
            cmp.w   D1,D0
            beq.b   .L2
            blt.b   .L7
            move.w  D1,(A1)+
            move.w  (A2)+,D1
            bra.b   .L6
.L7:
            cmp.w   D4,D0
            ble.b   .L8
            cmp.w   D0,D5
            ble.b   .L5
            move.w  D0,(A1)+
            bra.b   .L5
.L8:
            addq.w  #1,D2
            bra.b   .L5
.L9:
            move.w  (A3)+,D0
            cmp.w   D4,D0
            ble.b   .L10
            cmp.w   D0,D7
            beq.b   .L14
            cmp.w   D0,D5
            ble.b   .L9
            bra.b   .L11
.L10:
            move.w  (A3)+,D0
            cmp.w   D4,D0
            ble.b   .L9
.L11:
            cmpi.w  #0,D7
            bra.b   .L20
.L12:
            suba.l  A4,A1
            move.w  A1,D3
            cmpi.w  #4,D3
            bgt.b   .L20
            blt.b   .L13
            andi.w  #1,D2
            bne.b   .L11
.L13:
            move.l  D5,D6
            swap    D6
            subq.w  #2,A3
.L14:
            cmp.w   (A3)+,D6
            bgt.b   .L9
            tst.w   (8,A6)
            bne.b   .L15
            tst.w   D3
            beq.b   .L18
            bra.b   .L11
.L15:
            movea.l ($A,A6),A1
            move.w  D2,D0
            cmpi.w  #2,D3
            blt.b   .L18
            bgt.b   .L16
            btst    #0,D0
            bne.b   .L17
            move.w  (A4),(2,A1)
            bra.b   .L19
.L16:
            move.w  (A4)+,(2,A1)
.L17:
            move.w  (A4),(6,A1)
            bra.b   .L19
.L18:
            moveq   #1,D0
            and.w   D0,D2
.L19:
            cmp.w   D0,D2
.L20:
            movea.l A0,SP
.L21:
            movem.l (SP)+,D0-D7/A1-A5
            unlk    A6
            rtd     #$A
            dc.w    0
MapRgn:
            link.w  A6,#-6
            movem.l D3/D6-D7/A2-A4,-(SP)
            movea.l ($C,A6),A0
            movea.l (8,A6),A1
            cmpm.l  (A0)+,(A1)+
            bne.b   .L1
            cmpm.l  (A0)+,(A1)+
            beq.b   .L2
.L1:
            movea.l ($10,A6),A4
            movea.l (A4),A0
            cmpi.w  #$A,(A0)
            bne.b   .L3
            pea     (2,A0)
            move.l  ($C,A6),-(SP)
            move.l  (8,A6),-(SP)
            jsr     ([$11E8.w])
.L2:
            bra.b   .L6
.L3:
            clr.l   -(SP)
            move.w  #$100,-(SP)
            move.w  (SP),(-4,A6)
            jsr     NewHandle
            movea.l (SP)+,A3
            clr.w   (-2,A6)
            move.l  A4,-(SP)
            move.l  A3,-(SP)
            pea     (-2,A6)
            pea     (-4,A6)
            jsr     ([$1A6C.w])
            move.w  (-2,A6),D7
            lsr.w   #2,D7
            move.w  D7,D6
            movea.l (A3),A2
            bra.b   .L5
.L4:
            move.l  A2,-(SP)
            move.l  ($C,A6),-(SP)
            move.l  (8,A6),-(SP)
            jsr     ([$11E4.w])
            addq.l  #4,A2
.L5:
            dbra    D6,.L4
            move.l  (A3),-(SP)
            move.w  D7,-(SP)
            jsr     ([$1A98.w])
            move.l  (A3),-(SP)
            move.w  D7,(-6,A6)
            pea     (-6,A6)
            jsr     ([$1A18.w])
            move.l  A3,-(SP)
            move.w  (-6,A6),-(SP)
            move.l  A4,-(SP)
            jsr     ([$1A48.w])
            movea.l A3,A0
            _DisposHandle
.L6:
            movem.l (SP)+,D3/D6-D7/A2-A4
            unlk    A6
            rtd     #$C
            ds.b    10
BITMAPRGN:
            link.w  A6,#-$1E
            movem.l D3-D7/A2-A5,-(SP)
            clr.l   (-$C,A6)
            clr.w   ($10,A6)
            movea.l ($C,A6),A0
            movea.l (A0),A2
            moveq   #0,D0
            move.w  (A2),D0
            move.l  D0,(-$1A,A6)
            movea.l (8,A6),A1
            move.w  (4,A1),D0
            bpl.b   .L2
            btst    #$E,D0
            beq.b   .L1
            movea.l (A1),A0
            movea.l (A0),A1
.L1:
            cmpi.w  #1,($20,A1)
            beq.b   .L2
            move.w  #$FF6C,D0
            bra.w   sub_4083692A.L6
.L2:
            move.w  (4,A1),(-$10,A6)
            andi.w  #$7FFF,(-$10,A6)
            move.l  (6,A1),D2
            move.w  ($C,A1),D0
            sub.w   D2,D0
            ble.w   sub_4083692A.L7
            ext.l   D0
            move.l  D0,D4
            add.l   D4,D4
            addq.l  #6,D4
            add.l   D4,D4
            move.l  D4,(-$1E,A6)
            moveq   #$20,D7
            divu.w  D7,D0
            move.l  D0,D3
            swap    D3
            moveq   #-1,D1
            tst.w   D3
            beq.b   .L3
            addq.w  #1,D0
            sub.w   D3,D7
            asl.l   D7,D1
.L3:
            move.l  D1,(-8,A6)
            ext.l   D0
            move.l  D0,(-4,A6)
            asl.l   #2,D0
            _NewHandleClear
            bne.w   sub_4083692A.L6
            move.l  A0,(-$C,A6)
            move.l  D2,D3
            swap    D3
            move.w  ($A,A1),D0
            sub.w   D3,D0
            ble.w   sub_4083692A.L7
            move.w  D0,(-$E,A6)
            movea.l (A1),A4
            move.w  #$A,D7
.L4:
            movea.l ($C,A6),A2
            movea.l (A2),A2
.L5:
            lea     (0,A2,D7.w),A5
            move.l  (-$1A,A6),D1
            sub.w   D7,D1
            cmp.l   (-$1E,A6),D1
            bge.b   .L6
            move.l  (-$1A,A6),D0
            add.l   (-$1E,A6),D0
            move.l  D0,(-$1A,A6)
            movea.l ($C,A6),A0
            _SetHandleSize
            bne.w   sub_4083692A.L6
            bra.b   .L4
.L6:
            move.w  D2,D4
            moveq   #0,D6
            movea.l A4,A1
            move.l  (-4,A6),D5
            movea.l (-$C,A6),A3
            movea.l (A3),A3
            move.w  D3,D0
            bsr.w   sub_4083692A
            move.w  D7,(-$12,A6)
            bra.w   sub_40836862.L7
.L7:
            move.l  (A1)+,D0
.L8:
            move.l  (A3),D1
            eor.l   D0,D1
            bne.w   sub_40836862.L2
            tst.b   D6
            beq.b   .L9
            move.w  D4,(A5)+
            moveq   #0,D6
.L9:
            addi.w  #$20,D4
            addq.w  #4,A3
            bra.w   sub_40836862.L7
.L14:
            addq.w  #3,D4
.L10:
            move.w  D4,(A5)+
            addq.w  #1,D4
.L11:
            not.b   D6
            rts
.L15:
            addq.w  #2,D4
            move.w  D4,(A5)+
.L12:
            bsr.b   sub_4083683A
.L13:
            addq.w  #1,D4
            rts
.L16:
            addq.w  #2,D4
            move.w  D4,(A5)+
            addq.w  #2,D4
            bra.b   .L11
sub_40836820:
            bsr.b   sub_4083683A
            bsr.b   sub_4083683A
.L1:
            addq.w  #2,D4
            rts
.L2:
            bsr.b   sub_40836820
            subq.w  #1,D4
            bra.b   BITMAPRGN.L10
.L3:
            bsr.b   sub_4083683A
            addq.w  #1,D4
            bra.b   BITMAPRGN.L12
.L4:
            bsr.b   sub_4083683A
            addq.w  #3,D4
            bra.b   BITMAPRGN.L11
sub_4083683A:
            addq.w  #1,D4
            move.w  D4,(A5)+
            rts
.L1:
            move.w  D4,(A5)+
            bsr.b   sub_4083683A
            addq.w  #3,D4
            rts
.L2:
            move.w  D4,(A5)+
            bsr.b   sub_4083683A
            addq.w  #2,D4
            bra.b   BITMAPRGN.L10
.L3:
            move.w  D4,(A5)+
            bsr.b   sub_4083683A
            bsr.b   sub_4083683A
            bra.b   BITMAPRGN.L12
.L4:
            move.w  D4,(A5)+
            bsr.b   sub_4083683A
            bsr.b   sub_4083683A
            addq.w  #2,D4
            bra.b   BITMAPRGN.L11
sub_40836862:
            move.w  D4,(A5)+
            addq.w  #2,D4
            move.w  D4,(A5)+
            bra.b   sub_40836820.L1
.L12:
            bsr.b   sub_40836862
            subq.w  #1,D4
            bra.b   BITMAPRGN.L10
.L13:
            move.w  D4,(A5)+
            addq.w  #3,D4
            move.w  D4,(A5)+
            bra.b   BITMAPRGN.L13
.L1:
            bra.b   .L11
            bra.b   BITMAPRGN.L14
            bra.b   BITMAPRGN.L15
            bra.b   BITMAPRGN.L16
            bra.b   sub_40836820
            bra.b   sub_40836820.L2
            bra.b   sub_40836820.L3
            bra.b   sub_40836820.L4
            bra.b   sub_4083683A.L1
            bra.b   sub_4083683A.L2
            bra.b   sub_4083683A.L3
            bra.b   sub_4083683A.L4
            bra.b   sub_40836862
            bra.b   .L12
            bra.b   .L13
            move.w  D4,(A5)+
            not.b   D6
.L11:
            addq.w  #4,D4
            rts
.L2:
            move.l  D0,(A3)+
            moveq   #3,D7
            moveq   #0,D0
.L3:
            rol.l   #8,D1
            tst.b   D1
            bne.b   .L5
            tst.b   D6
            bne.b   .L5
            addq.w  #8,D4
            bra.b   .L6
.L4:
            move.l  (A1),D0
            and.l   (-8,A6),D0
            bra.w   BITMAPRGN.L8
.L5:
            move.b  D1,D0
            eor.b   D6,D0
            lsr.b   #4,D0
            add.w   D0,D0
            jsr     .L1(PC,D0.w)
            move.b  D1,D0
            eor.b   D6,D0
            andi.w  #$F,D0
            add.w   D0,D0
            jsr     .L1(PC,D0.w)
.L6:
            dbra    D7,.L3
.L7:
            subq.w  #1,D5
            bgt.w   BITMAPRGN.L7
            beq.b   .L4
            move.w  A5,D7
            sub.w   A2,D7
            cmp.w   (-$12,A6),D7
            beq.b   .L10
            blt.w   sub_4083692A.L5
            tst.b   D6
            beq.b   .L8
            move.w  D4,(A5)+
            addq.w  #2,D7
.L8:
            bsr.b   sub_40836926
.L9:
            addq.w  #1,D3
            move.w  D2,D4
            adda.w  (-$10,A6),A4
            subq.w  #1,(-$E,A6)
            bgt.w   BITMAPRGN.L5
            blt.b   sub_4083692A.L1
            move.l  (-4,A6),D0
            asl.l   #2,D0
            _NewHandleClear
            bne.b   sub_4083692A.L6
            move.l  A0,(-$16,A6)
            movea.l (A0),A4
            bra.w   BITMAPRGN.L4
.L10:
            subq.l  #2,A5
            subq.w  #2,D7
            bra.b   .L9
sub_40836926:
            move.w  #$7FFF,D0
sub_4083692A:
            move.w  D0,(A5)+
            addq.w  #2,D7
            rts
.L1:
            movea.l (-$16,A6),A0
            _DisposHandle
            cmpi.w  #$A,D7
            beq.b   .L7
            bsr.b   sub_40836926
            bmi.b   .L5
            lea     ($A,A2),A0
            move.w  #$7FFF,D4
            move.w  D4,D1
            move.w  #$8000,D2
            move.w  (A0),D3
            bra.b   .L4
.L2:
            movea.l A0,A1
            cmp.w   (A0)+,D1
            ble.b   .L3
            move.w  (-2,A0),D1
.L3:
            cmp.w   (A0)+,D4
            bne.b   .L3
            cmp.w   (-4,A0),D2
            bge.b   .L4
            move.w  (-4,A0),D2
.L4:
            move.w  (A0)+,D0
            cmp.w   D4,D0
            bne.b   .L2
            swap    D3
            move.w  D1,D3
            move.w  (-2,A1),D4
            swap    D4
            move.w  D2,D4
            cmpi.w  #$1C,D7
            beq.b   .L8
            bra.b   .L9
.L5:
            move.w  #$FE0C,D0
.L6:
            move.w  D0,($10,A6)
.L7:
            movea.l ($C,A6),A0
            movea.l (A0),A2
            moveq   #0,D3
            moveq   #0,D4
.L8:
            moveq   #$A,D7
.L9:
            move.w  D7,(A2)+
            move.l  D3,(A2)+
            move.l  D4,(A2)
            move.l  D7,D0
            movea.l ($C,A6),A0
            _SetHandleSize
            movea.l (-$C,A6),A0
            _DisposHandle
            movem.l (SP)+,D3-D7/A2-A5
            unlk    A6
            movea.l (SP)+,A0
            addq.w  #8,SP
            jmp     (A0)
            ds.b    8
InitRgn:
            move.w  D0,($12,A1)
            move.w  D1,($14,A1)
            move.w  D2,($16,A1)
            move.l  A0,D0
            jsr     ([$644.w])
            movea.l D0,A0
            move.l  A0,(A1)
            move.w  #$8001,($E,A1)
            move.w  (2,A0),($10,A1)
            lea     ($A,A0),A0
            move.l  A0,(4,A1)
            movea.l (SP)+,A0
            sub.w   D2,D1
            subq.w  #1,D1
            lsr.w   #5,D1
            move.w  D1,($C,A1)
.L1:
            clr.l   -(SP)
            dbra    D1,.L1
            move.l  SP,(8,A1)
            jmp     (A0)
            ds.b    12
SeekRgn:
            cmp.w   ($10,A1),D0
            bge.b   SEEKDOWN
            cmp.w   ($E,A1),D0
            blt.b   SEEKUP
            move.w  ($10,A1),D1
            sub.w   D0,D1
            move.w  D0,D2
            sub.w   ($E,A1),D2
            cmp.w   D1,D2
            blt.b   .L1
            move.w  D1,D2
.L1:
            rts
.L2:
            movea.l (8,A1),A0
            move.w  ($C,A1),D1
.L3:
            clr.l   (A0)+
            dbra    D1,.L3
            movea.l (A1),A0
            move.w  (2,A0),($10,A1)
            move.w  #$8001,($E,A1)
            lea     ($A,A0),A0
            move.l  A0,(4,A1)
            cmp.w   ($10,A1),D0
            bge.b   SEEKDOWN
            moveq   #1,D2
            bra.b   SEEKDOWN.L4
SEEKDOWN:
            movem.l D0/D3-D7/A2-A4,-(SP)
            move.w  D0,D2
            movea.l (4,A1),A2
            lea     .L2,A4
            move.w  ($12,A1),D6
            move.w  ($14,A1),D7
.L1:
            move.w  (A2)+,($E,A1)
.L2:
            move.w  (A2)+,D3
            cmpi.w  #$7FFF,D3
            beq.b   .L3
            move.w  (A2)+,D4
            bra.b   SEEKUP.L6
.L3:
            cmp.w   (A2),D2
            bge.b   .L1
            sub.w   (A2),D2
            neg.w   D2
            move.w  (A2),($10,A1)
            move.l  A2,(4,A1)
            movem.l (SP)+,D0/D3-D7/A2-A4
.L4:
            rts
SEEKUP:
            movea.l (A1),A0
            move.w  (2,A0),D1
            cmp.w   D1,D0
            blt.b   SeekRgn.L2
            movem.l D0/D3-D7/A2-A5,-(SP)
            move.w  D0,D2
            lea     ($A,A0),A5
            lea     .L2,A4
            move.w  ($12,A1),D6
            move.w  ($14,A1),D7
.L1:
            movea.l (4,A1),A2
            subq.w  #2,A2
.L2:
            move.w  -(A2),D4
            move.w  -(A2),D3
            cmpi.w  #$7FFF,D3
            beq.b   .L3
            bra.b   .L6
.L3:
            move.l  A2,D0
            addq.l  #2,D0
            move.l  D0,(4,A1)
            move.w  D4,($10,A1)
.L4:
            move.w  -(A2),D4
            cmpa.l  A5,A2
            ble.b   .L5
            move.w  -(A2),D3
            cmpi.w  #$7FFF,D3
            bne.b   .L4
.L5:
            move.w  D4,($E,A1)
            cmp.w   D4,D2
            blt.b   .L1
            sub.w   D4,D2
            addq.w  #1,D2
            movem.l (SP)+,D0/D3-D7/A2-A5
            rts
.L6:
            cmp.w   D6,D4
            ble.b   .L9
            cmp.w   D7,D3
            bge.b   .L9
            cmp.w   D6,D3
            bge.b   .L7
            move.w  D6,D3
.L7:
            cmp.w   D7,D4
            ble.b   .L8
            move.w  D7,D4
.L8:
            sub.w   ($16,A1),D3
            sub.w   ($16,A1),D4
            moveq   #$1F,D0
            move.w  D3,D1
            and.w   D0,D1
            moveq   #-1,D5
            lsr.l   D1,D5
            and.w   D4,D0
            moveq   #-1,D1
            lsr.l   D0,D1
            not.l   D1
            lsr.w   #5,D3
            movea.l (8,A1),A3
            move.w  D3,D0
            lsl.w   #2,D0
            adda.w  D0,A3
            lsr.w   #5,D4
            sub.w   D3,D4
            bgt.b   .L10
            and.l   D5,D1
            eor.l   D1,(A3)
.L9:
            jmp     (A4)
.L10:
            eor.l   D5,(A3)+
            bra.b   .L12
.L11:
            not.l   (A3)+
            not.l   (A3)+
.L12:
            subq.w  #2,D4
            bgt.b   .L11
            blt.b   .L13
            not.l   (A3)+
.L13:
            eor.l   D1,(A3)
            jmp     (A4)
            ds.b    14
StretchBits:
            link.w  A6,#-$2C8
            movem.l D0-D7/A1-A5,-(SP)
            move.l  SP,(-$1CC,A6)
            move.l  A5,(-$1D0,A6)
            move.b  MMU32bit,(-$102,A6)
            clr.l   (-$20,A6)
            clr.l   (-$2B4,A6)
            move.l  SP,D1
            andi.b  #$FC,D1
            movea.l D1,SP
            move.l  TheGDevice,-(SP)
            move.l  SrcDevice,TheGDevice
            movea.l ($30,A6),A1
            lea     (-$168,A6),A2
            jsr     ([$1A08.w])
            move.l  (SP)+,TheGDevice
            movea.l ($28,A6),A1
            lea     (-$F4,A6),A2
            jsr     ([$1A08.w])
            move.l  D1,(-$244,A6)
            move.b  D2,(-$240,A6)
            lea     ShftTbl,A0
            move.w  (-$148,A6),D0
            moveq   #0,D3
            move.b  (0,A0,D0.w),D3
            move.w  D3,(-$1C2,A6)
            move.w  (-$D4,A6),D0
            moveq   #0,D4
            move.b  (0,A0,D0.w),D4
            move.w  D4,(-$76,A6)
            move.l  ($2C,A6),D0
            beq.b   .L1
            movea.l D0,A1
            lea     (-$1B8,A6),A2
            jsr     ([$1A08.w])
            clr.w   (-$1C4,A6)
            move.w  (-$198,A6),D0
            cmpi.w  #1,D0
            beq.b   .L1
            clr.l   ($2C,A6)
.L1:
            move.l  ($1C,A6),-(SP)
            pea     (-$EE,A6)
            movea.l ($12,A6),A0
            movea.l (A0),A0
            pea     (2,A0)
            movea.l ($E,A6),A0
            movea.l (A0),A0
            pea     (2,A0)
            movea.l ($A,A6),A0
            movea.l (A0),A0
            pea     (2,A0)
            move.w  #5,-(SP)
            pea     (-$74,A6)
            jsr     ([$1A84.w])
            beq.w   DONESTRETCH.L3
            move.l  ($16,A6),(-$9C,A6)
            move.w  ($1A,A6),(-$98,A6)
            tst.w   ([$28.w,A6],4.w)
            smi     (-$A6,A6)
            bclr    #6,(-$97,A6)
            sne     (-$A5,A6)
            move.b  (8,A6),(-$101,A6)
            jsr     ([$1A10.w])
            moveq   #0,D7
            move.w  (-$98,A6),D2
            btst    #5,D2
            bne.b   .L2
            bclr    #2,D2
            beq.b   .L2
            not.l   D7
.L2:
            move.l  D7,(-$1C8,A6)
            clr.w   (-$8E,A6)
            btst    #3,D2
            beq.b   .L3
            jsr     ([$1A54.w])
.L3:
            tst.b   (-$240,A6)
            beq.b   .L4
            pea     (-$74,A6)
            move.l  (-$244,A6),-(SP)
            jsr     ([$F54.w])
.L4:
            lea     (-$168,A6),A4
            move.w  #$7FFF,D0
            ext.l   D0
            move.w  (4,A4),D1
            and.l   D0,D1
            move.l  D1,(-$1BC,A6)
            lea     (-$1B8,A6),A0
            move.w  (4,A0),D1
            and.l   D0,D1
            move.l  D1,(-$1C0,A6)
            lea     (-$F4,A6),A5
            move.w  (4,A5),D1
            and.l   D0,D1
            move.l  D1,(-$7C,A6)
            movea.l ($24,A6),A2
            move.l  A2,D0
            jsr     ([$644.w])
            move.l  D0,($24,A6)
            movea.l ($1C,A6),A3
            move.l  A3,D0
            jsr     ([$644.w])
            move.l  D0,($1C,A6)
            move.w  (-$98,A6),D0
            ror.w   #4,D0
            bcs.b   BLITCASE.L2
            move.w  (4,A2),D1
            sub.w   (A2),D1
            swap    D1
            move.w  (6,A2),D1
            sub.w   (2,A2),D1
            move.w  D1,D0
            subq.w  #1,D0
            move.w  D0,(-$22C,A6)
            move.w  (4,A3),D0
            sub.w   (A3),D0
            swap    D0
            move.w  (6,A3),D0
            sub.w   (2,A3),D0
            jsr     ([$1C60.w])
BLITCASE:
            clr.b   (-$2B5,A6)
            tst.l   ($2C,A6)
            bne.w   .L9
            cmp.l   D0,D1
            bne.w   .L9
            cmp.w   D3,D4
            beq.b   .L1
            cmpi.w  #$10,(-$14A,A6)
            bne.w   .L4
            movea.l ([TheGDevice.w]),A0
            tst.l   ($C,A0)
            bne.w   .L9
            bra.w   .L4
.L1:
            cmpi.w  #$10,(-$D6,A6)
            beq.b   .L2
            movea.l (-$13E,A6),A0
            movea.l (A0),A0
            move.l  (A0),D2
            movea.l (-$CA,A6),A0
            movea.l (A0),A0
            cmp.l   (A0),D2
            beq.b   .L2
            bne.b   .L4
.L2:
            moveq   #$A,D0
            movea.l ($A,A6),A0
            movea.l (A0),A0
            cmp.w   (A0),D0
            bne.w   .L8
            movea.l ($E,A6),A0
            movea.l (A0),A0
            cmp.w   (A0),D0
            beq.b   .L3
            move.l  ($E,A6),-(SP)
            pea     (-$74,A6)
            move.w  #$FFFF,-(SP)
            jsr     ([$1AA4.w])
            blt.w   DONESTRETCH
            bgt.w   .L8
            movea.l (-$1D0,A6),A1
            movea.l (A1),A1
            move.l  (-$82,A1),($E,A6)
.L3:
            movea.l ($12,A6),A0
            movea.l (A0),A0
            cmp.w   (A0),D0
            beq.b   .L7
            move.l  ($12,A6),-(SP)
            pea     (-$74,A6)
            move.w  #$FFFF,-(SP)
            jsr     ([$1AA4.w])
            blt.w   DONESTRETCH
            beq.b   .L7
            movea.l ($12,A6),A1
            move.l  ($A,A6),($12,A6)
            move.l  A1,($A,A6)
            bra.b   .L8
.L4:
            tst.w   (-$98,A6)
            bne.b   .L9
            tst.w   (-$104,A6)
            bne.b   .L9
            tst.w   D7
            bne.b   .L9
            st      (-$2B5,A6)
            cmpi.w  #5,D4
            bne.b   .L6
            cmpi.w  #3,D3
            bgt.b   .L9
.L5:
            move.l  ($1C5C).w,(-$80,A6)
            jsr     ([$1C58.w])
            tst.w   D0
            beq.w   .L2
            bra.w   DONESTRETCH
.L6:
            cmpi.w  #5,D3
            bne.b   .L9
            cmpi.w  #3,D4
            bne.b   .L9
            bra.b   .L5
.L7:
            moveq   #1,D0
            jsr     ([$574.w])
            move.b  D0,(-$102,A6)
            movea.l ($24,A6),A2
            movea.l ($1C,A6),A3
            jsr     ([$1A00.w])
            bra.w   DONESTRETCH
.L8:
            move.l  ($1C5C).w,(-$80,A6)
            movea.l ($594).w,A0
            jsr     (A0)
            lsr.l   #2,D0
            subi.l  #$190,D0
            move.l  D0,(-$84,A6)
            jsr     ([$1A7C.w])
            bra.w   DONESTRETCH
.L9:
            movem.l D3-D4,-(SP)
            move.l  D0,(-$208,A6)
            move.l  D1,(-$20C,A6)
            jsr     ([$1A90.w])
            move.l  A0,(-$21C,A6)
            move.w  D0,(-$222,A6)
            movem.l (SP)+,D3-D4
            movea.l ($594).w,A0
            jsr     (A0)
            lsr.l   #2,D0
            subi.l  #$190,D0
            move.l  D0,(-$84,A6)
            bpl.b   .L10
            jsr     ([$1C5C.w])
.L10:
            move.l  (-$208,A6),D0
            move.l  (-$20C,A6),D1
            clr.b   (-$2AA,A6)
            cmp.l   D1,D0
            beq.b   .L14
            blt.b   .L11
            cmp.w   D1,D0
            bge.b   .L14
.L11:
            cmpi.w  #5,D3
            bne.b   .L14
            seq     (-$2AA,A6)
            moveq   #0,D2
            move.w  D1,D2
            add.w   D2,D2
            add.w   D1,D2
            lsr.w   #1,D2
            move.w  D2,(-$2AC,A6)
            sub.l   D2,(-$84,A6)
            bpl.b   .L12
            jsr     ([$1C5C.w])
.L12:
            clr.l   -(SP)
.L13:
            clr.l   -(SP)
            dbra    D2,.L13
            move.l  SP,(-$2B0,A6)
.L14:
            clr.l   (-$228,A6)
            move.w  (-$14A,A6),D0
            beq.w   STSEARCHTAB.L1
            cmpi.w  #$10,D0
            bne.w   DONESTRETCH
            cmp.w   D3,D4
            beq.w   ONEBITPROC.L3
            moveq   #4,D0
            move.l  D0,D5
            cmp.w   D3,D5
            beq.b   .L15
            moveq   #0,D5
.L15:
            cmp.w   D4,D0
            bne.b   .L16
            addq.w  #2,D5
.L16:
            movea.l ([TheGDevice.w]),A2
            cmpi.w  #$10,(-$D6,A6)
            beq.w   .L24
            tst.w   D4
            bne.b   .L17
            movea.l ($28,A6),A1
            tst.w   (4,A1)
            bmi.b   .L17
            addq.w  #8,D5
            bra.w   .L26
.L17:
            addq.w  #1,D5
            movea.l ([$16.w,A2]),A1
            movea.l ($2A,A1),A0
            move.l  ([A0]),D1
            movea.l ([6.w,A2]),A0
            cmp.l   (A0),D1
            beq.b   .L19
            move.l  ($2A,A1),-(SP)
            move.l  (6,A2),-(SP)
            move.w  ($A,A2),-(SP)
            jsr     ([$16E4.w])
            tst.w   QDErr
            beq.b   .L18
            addq.w  #4,SP
            bra.w   DONESTRETCH.L1
.L18:
            movea.l ([TheGDevice.w]),A2
            movea.l ([6.w,A2]),A0
.L19:
            addq.w  #6,A0
            move.l  A0,(-$28C,A6)
            subq.w  #6,A0
            move.w  (4,A0),(-$29E,A6)
            movea.l ([$16.w,A2]),A1
            move.l  ([$2A.w,A1]),(-$29C,A6)
            move.l  ($C,A2),D0
            bne.b   .L25
            moveq   #1,D0
            move.w  (4,A0),D2
            lsl.l   D2,D0
            lsl.l   D2,D0
            lsl.l   D2,D0
            lea     (6,A0,D0.l),A1
            tst.w   (2,A1)
            bpl.b   .L20
            addq.w  #6,A1
            move.l  A1,(-$290,A6)
            addq.w  #8,D5
            moveq   #$28,D0
            cmp.l   (A0),D0
            beq.b   .L26
.L20:
            tst.b   (-$A5,A6)
            beq.b   .L26
            addq.w  #2,D5
            moveq   #0,D0
            move.w  (-$206,A6),D0
            lsl.l   D4,D0
            addi.l  #$1F,D0
            lsr.l   D4,D0
            btst    #3,D5
            bne.b   .L21
            move.w  D0,D1
            add.w   D0,D0
            add.w   D1,D0
.L21:
            lsr.w   #1,D0
            sub.l   D0,(-$84,A6)
            bpl.b   .L22
            jsr     ([$1C5C.w])
.L22:
            clr.l   -(SP)
.L23:
            clr.l   -(SP)
            dbra    D0,.L23
            move.l  SP,(-$2A4,A6)
            clr.b   (-$2A9,A6)
            bra.b   .L26
.L24:
            move.l  ($C,A2),D0
            beq.b   .L26
.L25:
            move.l  D0,(-$294,A6)
            bset    #4,D5
.L26:
            move.w  D5,D0
            lsr.w   #3,D0
            lea     ($1CA0.w,D0.w*4),A0
            movea.l (A0),A0
            andi.w  #7,D5
            adda.l  (0,A0,D5.w*4),A0
            move.l  A0,(-$228,A6)
            bra.w   ONEBITPROC.L3
            dc.w    $6000,$0908,0
STCOLORTAB:
            dc.w    $FFFF,$FFFA,0,$2790,0,$2A30,0,$2390
            dc.w    0,$2C50,0,$2B00,$FFFF,$FFFA,0,$24A0
STGRAYTAB:
            dc.w    0,$2830,0,$27D0,$FFFF,$FFDA,0,$2590
            dc.w    0,$28F0,0,$2880,$FFFF,$FFDA,0,$2670
STSEARCHTAB:
            dc.w    $FFFF,$FFBA,0,$2940,0,$2A20,$FFFF,$FFBA
            dc.w    0,$2CB0,0,$2B30,$FFFF,$FFBA,$FFFF,$FFBA
.L1:
            movea.l (-$13E,A6),A0
            movea.l (A0),A0
            move.l  (A0),D0
            movea.l (-$CA,A6),A0
            cmpi.w  #$10,(-$D6,A6)
            beq.b   .L2
            movea.l (A0),A0
            cmp.l   (A0),D0
            bne.b   .L2
            cmp.w   D3,D4
            beq.w   ONEBITPROC.L3
.L2:
            tst.w   D3
            bne.b   .L3
            moveq   #1,D1
            cmp.l   D0,D1
            beq.w   ONEBITPROC.L2
.L3:
            move.w  (-$148,A6),D1
            moveq   #1,D0
            lsl.w   D1,D0
            sub.l   D0,(-$84,A6)
            bpl.b   .L4
            jsr     ([$1C5C.w])
.L4:
            moveq   #0,D7
            cmpi.w  #1,(-$D4,A6)
            bne.b   .L5
            movea.l ($28,A6),A1
            tst.w   (4,A1)
            bmi.b   .L5
            moveq   #1,D7
            pea     ONEBITPROC
            jsr     ([$16E8.w])
.L5:
            movea.l (-$1D0,A6),A5
            move.l  A4,-(SP)
            move.w  #$20,-(SP)
            jsr     ([$1A38.w])
            move.w  (-$148,A6),D1
            cmp.w   (-$D4,A6),D1
            bne.b   .L8
            moveq   #1,D0
            lsl.w   D1,D0
            move.w  D0,D1
            lsl.w   #2,D1
            subq.w  #1,D0
            movea.l SP,A0
            adda.w  D1,A0
.L6:
            cmp.l   -(A0),D0
            dbne    D0,.L6
            bne.b   .L8
            tst.w   D7
            beq.b   .L7
            pea     ONEBITPROC
            jsr     ([$1730.w])
.L7:
            lea     (-$F4,A6),A5
            tst.l   ($2C,A6)
            bne.w   ONEBITPROC.L3
            move.l  (-$208,A6),D0
            cmp.l   (-$20C,A6),D0
            bne.w   ONEBITPROC.L3
            move.l  (-$1C8,A6),D7
            bra.w   BLITCASE.L2
.L8:
            move.l  SP,(-$23C,A6)
            lea     (-$F4,A6),A5
            tst.w   D7
            beq.b   .L9
            pea     ONEBITPROC
            jsr     ([$1730.w])
.L9:
            movea.l ($1CAC).w,A0
            move.l  A0,(-$228,A6)
            bra.b   ONEBITPROC.L3
            dc.w    0
ONEBITPROC:
            st      ($C,SP)
            movea.l (8,SP),A0
            moveq   #0,D0
            moveq   #0,D1
            move.w  (A0),D0
            movea.l D0,A1
            move.w  (2,A0),D1
            add.l   D0,D1
            move.w  (4,A0),D0
            add.l   D0,D1
            add.l   D0,D1
            lsr.l   #2,D1
            add.l   A1,D1
            move.w  (2,A0),D0
            add.l   D0,D1
            add.l   D0,D1
            lsr.l   #2,D1
            movea.l (4,SP),A1
            clr.l   (A1)
            tst.w   D1
            bmi.b   .L1
            addq.l  #1,(A1)
.L1:
            rtd     #8
.L2:
            movea.l ($1AAC).w,A0
            adda.l  (0,A0,D4.w*4),A0
            move.l  A0,(-$228,A6)
            bra.b   .L5
.L3:
            tst.b   (-$103,A6)
            bne.b   .L4
            move.l  #$FFFFFFFF,(-$A0,A6)
.L4:
            tst.b   (-$104,A6)
            bne.b   .L5
            clr.l   (-$A4,A6)
.L5:
            moveq   #0,D0
            move.w  (-$20A,A6),D0
            lsl.l   D3,D0
            subq.l  #1,D0
            lsr.l   #5,D0
            move.w  D0,(-$1EC,A6)
            sub.l   D0,(-$84,A6)
            bpl.b   .L6
            jsr     ([$1C5C.w])
.L6:
            clr.l   -(SP)
.L7:
            clr.l   -(SP)
            dbra    D0,.L7
            move.l  SP,(-$1D4,A6)
            move.l  SP,(-$1D8,A6)
            move.l  SP,(-$1DC,A6)
            moveq   #0,D0
            move.w  (-$206,A6),D0
            cmp.w   (-$20A,A6),D0
            beq.b   .L10
            lsl.l   D3,D0
            subq.l  #1,D0
            lsr.l   #5,D0
            move.w  D0,(-$1F2,A6)
            sub.l   D0,(-$84,A6)
            bpl.b   .L8
            jsr     ([$1C5C.w])
.L8:
            clr.l   -(SP)
.L9:
            clr.l   -(SP)
            dbra    D0,.L9
            move.l  SP,(-$1D8,A6)
            move.l  SP,(-$1DC,A6)
.L10:
            clr.l   (-$210,A6)
            clr.l   (-$214,A6)
            move.l  ($2C,A6),D0
            beq.w   .L15
            movea.l ($20,A6),A0
            move.w  (4,A0),D1
            sub.w   (A0),D1
            swap    D1
            move.w  (6,A0),D1
            sub.w   (2,A0),D1
            move.w  (4,A3),D0
            sub.w   (A3),D0
            swap    D0
            move.w  (6,A3),D0
            sub.w   (2,A3),D0
            movem.l D3-D4,-(SP)
            move.l  D0,(-$210,A6)
            move.l  D1,(-$214,A6)
            jsr     ([$1A90.w])
            move.l  A0,(-$220,A6)
            move.w  D0,(-$224,A6)
            movem.l (SP)+,D3-D4
            moveq   #0,D0
            move.w  (-$212,A6),D0
            subq.w  #1,D0
            lsr.w   #5,D0
            move.w  D0,(-$1EE,A6)
            sub.l   D0,(-$84,A6)
            bpl.b   .L11
            jsr     ([$1C5C.w])
.L11:
            clr.l   -(SP)
.L12:
            clr.l   -(SP)
            dbra    D0,.L12
            move.l  SP,(-$1E8,A6)
            move.l  SP,(-$20,A6)
            moveq   #0,D0
            move.w  (-$20E,A6),D0
            cmp.w   (-$212,A6),D0
            beq.b   .L15
            subq.w  #1,D0
            lsr.w   #5,D0
            move.w  D0,(-$1F0,A6)
            sub.l   D0,(-$84,A6)
            bpl.b   .L13
            jsr     ([$1C5C.w])
.L13:
            clr.l   -(SP)
.L14:
            clr.l   -(SP)
            dbra    D0,.L14
            move.l  SP,(-$20,A6)
.L15:
            tst.l   (-$228,A6)
            beq.b   .L18
            moveq   #0,D0
            move.w  (-$206,A6),D0
            subq.l  #1,D0
            lsl.l   D4,D0
            lsr.l   #5,D0
            move.w  D0,(-$1F4,A6)
            sub.l   D0,(-$84,A6)
            bpl.b   .L16
            jsr     ([$1C5C.w])
.L16:
            clr.l   -(SP)
            clr.l   -(SP)
.L17:
            clr.l   -(SP)
            dbra    D0,.L17
            move.l  SP,(-$1DC,A6)
.L18:
            movea.l ($1C,A6),A0
            move.w  (2,A0),D1
            sub.w   (8,A5),D1
            lsl.l   D4,D1
            andi.w  #$FFE0,D1
            asr.l   D4,D1
            add.w   (8,A5),D1
            move.w  D1,(-$E,A6)
            moveq   #0,D0
            move.w  (-$6E,A6),D0
            sub.w   D1,D0
            move.w  D0,(-$10,A6)
            move.w  D0,D1
            ext.l   D1
            lsl.l   D4,D1
            subq.l  #1,D1
            lsr.l   #5,D1
            addq.l  #1,D1
            btst    #5,(-$97,A6)
            bne.b   .L19
            move.w  D1,(-$10,A6)
.L19:
            lsr.w   #5,D0
            addq.w  #1,D0
            lsl.w   D4,D0
            sub.l   D0,(-$84,A6)
            bpl.b   .L20
            jsr     ([$1C5C.w])
.L20:
            clr.l   -(SP)
            clr.l   -(SP)
.L21:
            clr.l   -(SP)
            dbra    D0,.L21
            move.l  SP,(-8,A6)
            move.l  ($1C5C).w,(-$80,A6)
            clr.l   (-$C,A6)
            move.l  ($A,A6),-(SP)
            move.l  ($E,A6),-(SP)
            move.l  ($12,A6),-(SP)
            move.l  #2,-(SP)
            jsr     ([$1A34.w])
            move.w  (-$98,A6),D0
            btst    #5,D0
            beq.b   .L26
            cmpi.w  #$40,D0
            bgt.w   DONESTRETCH
            btst    #3,D0
            bne.w   DONESTRETCH
            andi.w  #$17,D0
            bclr    #4,D0
            beq.b   .L22
            subq.w  #2,D0
            bne.w   DONESTRETCH
            addq.w  #8,D0
.L22:
            cmpi.w  #$10,(-$D4,A6)
            bge.b   .L23
            addq.w  #4,D0
            bra.b   .L27
.L23:
            bne.b   .L25
            movea.l ($1C98).w,A0
.L24:
            bclr    #4,D0
            adda.l  (0,A0,D0.w*4),A0
            move.l  A0,(-$218,A6)
            bra.b   .L28
.L25:
            movea.l ($1C9C).w,A0
            bra.b   .L24
.L26:
            move.l  (-$1C8,A6),D7
            bclr    #2,D0
            cmpi.w  #7,D0
            bgt.w   DONESTRETCH
.L27:
            lea     ($1BCC).w,A0
            move.l  (0,A0,D0.w*4),(-$218,A6)
.L28:
            tst.l   ($2C,A6)
            beq.b   .L29
            move.w  (-$1C4,A6),D3
            lea     (-$1B8,A6),A2
            move.l  (-$1C0,A6),D2
            movea.l ($20,A6),A0
            move.w  (2,A0),D1
            sub.w   (8,A2),D1
            ext.l   D1
            moveq   #$1F,D5
            and.l   D1,D5
            move.l  D5,(-$238,A6)
            move.w  (A0),D0
            sub.w   (6,A2),D0
            muls.w  D2,D0
            add.l   (A2),D0
            sub.l   D5,D1
            asr.l   #3,D1
            add.l   D1,D0
            move.l  D0,(-$1FC,A6)
.L29:
            moveq   #1,D0
            jsr     ([$574.w])
            move.b  D0,(-$102,A6)
            move.w  (-$1C2,A6),D3
            lea     (-$168,A6),A2
            move.l  (-$1BC,A6),D2
            move.w  ($A,A2),D1
            sub.w   (6,A2),D1
            move.w  D1,(-$22A,A6)
            movea.l ($24,A6),A0
            move.w  (2,A0),D1
            sub.w   (8,A2),D1
            ext.l   D1
            lsl.l   D3,D1
            moveq   #$1F,D5
            and.l   D1,D5
            move.l  D5,(-$230,A6)
            move.w  (A0),D0
            sub.w   (6,A2),D0
            muls.w  D2,D0
            add.l   (A2),D0
            sub.l   D5,D1
            asr.l   #3,D1
            add.l   D1,D0
            move.l  D0,(-$1F8,A6)
            move.w  (-$76,A6),D4
            move.l  (-$7C,A6),D2
            movea.l ($1C,A6),A0
            move.w  (A0),(-4,A6)
            move.w  (2,A0),D1
            sub.w   (8,A5),D1
            ext.l   D1
            lsl.l   D4,D1
            moveq   #$1F,D6
            and.l   D1,D6
            neg.l   D6
            move.l  D6,(-$234,A6)
            move.l  D6,D0
            asr.l   D4,D0
            move.l  D0,(-$24,A6)
            move.w  (-$74,A6),D0
            sub.w   (6,A5),D0
            muls.w  D2,D0
            add.l   (A5),D0
            asr.l   #5,D1
            lsl.l   #2,D1
            add.l   D1,D0
            move.l  D0,(-$200,A6)
            jsr     ([$1C64.w])
STSCANLOOP:
            tst.b   (-$2B5,A6)
            beq.b   .L2
            cmpi.w  #8,(-$D4,A6)
            bne.b   .L1
            cmpi.w  #8,(-$148,A6)
            beq.w   CB8TO8CLIP
            cmpi.w  #1,(-$148,A6)
            bne.b   .L2
            movea.l ($1AAC).w,A0
            adda.l  ($C,A0),A0
            cmpa.l  (-$228,A6),A0
            bne.b   .L2
            bra.w   ANDY
.L1:
            cmpi.w  #1,(-$D4,A6)
            bne.b   .L2
            cmpi.w  #8,(-$148,A6)
            beq.w   CB8TO1CLIP
.L2:
            move.w  (-$20C,A6),D0
            lsr.w   #1,D0
            neg.w   D0
            move.w  D0,(-$23E,A6)
.L3:
            tst.w   (-$22A,A6)
            ble.w   DONESTRETCH
            tst.b   (-$2AA,A6)
            bne.w   .L13
            movea.l (-$1F8,A6),A0
            movea.l (-$1D4,A6),A1
            move.w  (-$1EC,A6),D1
            move.l  (-$230,A6),D5
.L4:
            bfextu  (A0){D5:0},D0
            addq.w  #4,A0
            move.l  D0,(A1)+
            dbra    D1,.L4
            tst.l   ($2C,A6)
            beq.b   .L6
            movea.l (-$1FC,A6),A0
            movea.l (-$1E8,A6),A1
            move.w  (-$1EE,A6),D1
            move.l  (-$238,A6),D3
.L5:
            bfextu  (A0){D3:0},D0
            addq.w  #4,A0
            move.l  D0,(A1)+
            dbra    D1,.L5
            move.l  (-$1C0,A6),D0
            add.l   D0,(-$1FC,A6)
.L6:
            move.l  (-$1BC,A6),D2
            add.l   D2,(-$1F8,A6)
            subq.w  #1,(-$22A,A6)
            move.w  (-$208,A6),D0
            add.w   D0,(-$23E,A6)
            bgt.w   .L32
            tst.w   (-$1C2,A6)
            beq.w   .L28
.L7:
            tst.w   (-$22A,A6)
            ble.w   .L32
            movea.l (-$1F8,A6),A0
            movea.l (-$1D4,A6),A1
            move.w  (-$1EC,A6),D6
            move.w  (-$148,A6),D3
            moveq   #0,D4
.L8:
            bfextu  (A0){D5:0},D0
            move.l  (A1),D1
.L9:
            bfextu  D0{D4:D3},D2
            bfextu  D1{D4:D3},D7
            cmp.l   D7,D2
            ble.b   .L10
            bfins   D2,D1{D4:D3}
.L10:
            add.w   D3,D4
            andi.w  #$1F,D4
            bne.b   .L9
            addq.w  #4,A0
            move.l  D1,(A1)+
            dbra    D6,.L8
            tst.l   ($2C,A6)
            beq.b   .L12
            movea.l (-$1FC,A6),A0
            movea.l (-$1E8,A6),A1
            move.w  (-$1EE,A6),D1
            move.l  (-$238,A6),D2
.L11:
            bfextu  (A0){D2:0},D0
            addq.w  #4,A0
            or.l    D0,(A1)+
            dbra    D1,.L11
            move.l  (-$1C0,A6),D0
            add.l   D0,(-$1FC,A6)
.L12:
            move.l  (-$1BC,A6),D0
            add.l   D0,(-$1F8,A6)
            subq.w  #1,(-$22A,A6)
            move.w  (-$208,A6),D0
            add.w   D0,(-$23E,A6)
            ble.b   .L7
            move.l  (-$230,A6),D5
            move.l  (-$234,A6),D6
            move.l  (-$1C8,A6),D7
            bra.w   .L32
            ds.b    10
.L13:
            moveq   #0,D1
            tst.l   ($2C,A6)
            beq.b   .L15
            movea.l (-$1E8,A6),A0
            move.w  (-$1EE,A6),D0
.L14:
            move.l  D1,(A0)+
            dbra    D0,.L14
.L15:
            moveq   #0,D4
            move.w  (-$23E,A6),D0
            add.w   (-$208,A6),D0
            bgt.b   .L19
            cmpi.w  #1,(-$22A,A6)
            beq.b   .L19
            move.w  (-$2AC,A6),D0
            movea.l (-$2B0,A6),A0
.L16:
            move.l  D1,(A0)+
            dbra    D0,.L16
.L17:
            tst.w   (-$22A,A6)
            ble.w   .L22
            movea.l (-$1F8,A6),A0
            movea.l (-$2B0,A6),A1
            move.w  (-$1EC,A6),D6
            addq.w  #1,D4
            moveq   #0,D1
            moveq   #0,D2
            moveq   #0,D3
.L18:
            move.l  (A0)+,D0
            move.b  D0,D3
            lsr.l   #8,D0
            move.b  D0,D2
            lsr.l   #8,D0
            move.b  D0,D1
            add.w   D1,(A1)+
            add.w   D2,(A1)+
            add.w   D3,(A1)+
            dbra    D6,.L18
.L19:
            tst.l   ($2C,A6)
            beq.b   .L21
            movea.l (-$1FC,A6),A0
            movea.l (-$1E8,A6),A1
            move.w  (-$1EE,A6),D1
            move.l  (-$238,A6),D2
.L20:
            bfextu  (A0){D2:0},D0
            addq.w  #4,A0
            or.l    D0,(A1)+
            dbra    D1,.L20
            move.l  (-$1C0,A6),D0
            add.l   D0,(-$1FC,A6)
.L21:
            move.l  (-$1BC,A6),D0
            add.l   D0,(-$1F8,A6)
            subq.w  #1,(-$22A,A6)
            move.w  (-$208,A6),D0
            add.w   D0,(-$23E,A6)
            ble.b   .L17
.L22:
            movea.l (-$1D4,A6),A1
            movea.l (-$2B0,A6),A0
            move.w  (-$1EC,A6),D6
            cmpi.w  #2,D4
            blt.b   .L25
            beq.b   .L24
.L23:
            moveq   #0,D1
            move.w  (A0)+,D1
            divu.w  D4,D1
            move.w  D1,D0
            lsl.l   #8,D0
            moveq   #0,D1
            move.w  (A0)+,D1
            divu.w  D4,D1
            move.b  D1,D0
            lsl.l   #8,D0
            moveq   #0,D1
            move.w  (A0)+,D1
            divu.w  D4,D1
            move.b  D1,D0
            move.l  D0,(A1)+
            dbra    D6,.L23
            bra.b   .L27
.L24:
            move.w  (A0)+,D1
            lsr.w   #1,D1
            move.w  D1,D0
            lsl.l   #8,D0
            move.w  (A0)+,D1
            lsr.w   #1,D1
            move.b  D1,D0
            lsl.l   #8,D0
            move.w  (A0)+,D1
            lsr.w   #1,D1
            move.b  D1,D0
            move.l  D0,(A1)+
            dbra    D6,.L24
            bra.b   .L27
.L25:
            move.l  (-$1BC,A6),D0
            movea.l (-$1F8,A6),A0
            suba.l  D0,A0
.L26:
            move.l  (A0)+,(A1)+
            dbra    D6,.L26
.L27:
            move.l  (-$230,A6),D5
            move.l  (-$234,A6),D6
            move.l  (-$1C8,A6),D7
            bra.b   .L32
            dc.w    0
.L28:
            tst.w   (-$22A,A6)
            ble.b   .L32
            movea.l (-$1F8,A6),A0
            movea.l (-$1D4,A6),A1
            move.w  (-$1EC,A6),D1
.L29:
            bfextu  (A0){D5:0},D0
            addq.w  #4,A0
            or.l    D0,(A1)+
            dbra    D1,.L29
            tst.l   ($2C,A6)
            beq.b   .L31
            movea.l (-$1FC,A6),A0
            movea.l (-$1E8,A6),A1
            move.w  (-$1EE,A6),D1
            move.l  (-$238,A6),D3
.L30:
            bfextu  (A0){D3:0},D0
            addq.w  #4,A0
            or.l    D0,(A1)+
            dbra    D1,.L30
            move.l  (-$1C0,A6),D0
            add.l   D0,(-$1FC,A6)
.L31:
            add.l   D2,(-$1F8,A6)
            subq.w  #1,(-$22A,A6)
            move.w  (-$208,A6),D0
            add.w   D0,(-$23E,A6)
            ble.b   .L28
.L32:
            move.w  (-4,A6),D0
            cmp.w   (-$74,A6),D0
            bge.b   .L33
            addq.w  #1,(-4,A6)
            move.w  (-$20C,A6),D0
            sub.w   D0,(-$23E,A6)
            bge.b   .L32
            blt.w   .L3
.L33:
            move.w  (-$206,A6),D0
            cmp.w   (-$20A,A6),D0
            beq.b   .L34
            move.w  (-$1F2,A6),D0
            movea.l (-$1D4,A6),A0
            movea.l (-$1D8,A6),A1
            lea     (4,A1,D0.w*4),A2
            move.w  (-$222,A6),D4
            move.w  (-$148,A6),D5
            movea.l (-$21C,A6),A3
            moveq   #0,D0
            jsr     (A3)
.L34:
            move.w  (-$20E,A6),D0
            cmp.w   (-$212,A6),D0
            beq.b   .L35
            move.w  (-$1F0,A6),D0
            movea.l (-$1E8,A6),A0
            movea.l (-$20,A6),A1
            lea     (4,A1,D0.w*4),A2
            move.w  (-$224,A6),D4
            moveq   #1,D5
            movea.l (-$220,A6),A3
            moveq   #0,D0
            jsr     (A3)
.L35:
            move.l  (-$228,A6),D1
            beq.b   .L36
            move.w  (-$148,A6),D3
            move.w  (-$D4,A6),D4
            movea.l (-$1D8,A6),A0
            movea.l (-$1DC,A6),A1
            move.w  (-$1F4,A6),D0
            lea     (4,A1,D0.w*4),A2
            movea.l D1,A3
            movea.l (-$23C,A6),A4
            moveq   #0,D0
            jsr     (A3)
.L36:
            move.l  (-$A0,A6),D3
            move.l  (-$A4,A6),D4
            btst    #5,(-$97,A6)
            beq.b   .L39
            moveq   #0,D7
            move.w  (-$D4,A6),D7
            moveq   #$20,D5
            divu.w  D7,D5
            tst.w   (-$104,A6)
            beq.b   .L38
            movea.l (-$1DC,A6),A3
            move.w  (-$10,A6),D2
.L37:
            move.l  (A3),D0
            and.l   D3,D0
            not.l   (A3)
            and.l   D4,(A3)
            or.l    D0,(A3)+
            sub.w   D5,D2
            bge.b   .L37
.L38:
            movea.l (-$108,A6),A5
            cmpi.w  #$24,(-$98,A6)
            bne.b   .L39
            bfextu  (-$114,A6){0:D7},D0
            movea.l D0,A5
.L39:
            move.w  (-4,A6),D0
            cmp.w   (-$74,A6),D0
            blt.b   .L44
            jsr     ([-$1C.w,A6])
            movea.l (-$1DC,A6),A3
            movea.l (-$200,A6),A4
            movea.l (-8,A6),A2
            move.w  (-$10,A6),D2
            movea.l (-$218,A6),A0
            btst    #5,(-$97,A6)
            beq.b   .L41
            move.l  (-$114,A6),D4
            cmpi.w  #$24,(-$98,A6)
            beq.b   .L40
            move.w  (-$10E,A6),D5
.L40:
            moveq   #0,D3
            move.l  (-$234,A6),D6
            sub.l   D7,D6
.L41:
            cmpa.l  (-$F4,A6),A4
            bcs.b   .L45
.L42:
            jmp     (A0)
.L43:
            move.l  (-$7C,A6),D0
            add.l   D0,(-$200,A6)
.L44:
            addq.w  #1,(-4,A6)
            move.w  (-4,A6),D0
            cmp.w   (-$70,A6),D0
            beq.b   DONESTRETCH
            move.w  (-$20C,A6),D0
            sub.w   D0,(-$23E,A6)
            blt.w   .L3
            tst.b   (-$A5,A6)
            bne.w   .L35
            bra.b   .L39
.L45:
            move.l  (-$F4,A6),D1
            btst    #5,(-$97,A6)
            beq.b   .L47
.L46:
            lea     (0,A4,D3.w),A1
            cmp.l   A1,D1
            bls.b   .L42
            subq.w  #1,D2
            bmi.b   .L43
            add.l   D7,D6
            add.l   D7,D3
            bra.b   .L46
.L47:
            lea     (4,A4),A1
            cmp.l   A1,D1
            bls.b   .L42
            subq.w  #1,D2
            bmi.b   .L43
            addq.l  #4,A2
            addq.l  #4,A3
            addq.l  #4,A4
            bra.b   .L47
DONESTRETCH:
            clr.w   QDErr
.L1:
            move.b  (-$102,A6),D0
            jsr     ([$574.w])
.L2:
            movea.l (-$1D0,A6),A5
            tst.b   (-$240,A6)
            beq.b   .L3
            jsr     ([$F4C.w])
.L3:
            bset    #7,HiliteMode
            movea.l (-$1CC,A6),SP
            move.l  (-$2B4,A6),D0
            beq.b   .L4
            movea.l D0,A0
            jsr     ([$1A78.w])
            move.l  SP,StkLowPt
            move.l  (-$2C4,A6),HiHeapMark
.L4:
            movem.l (SP)+,D0-D7/A1-A5
            unlk    A6
            rtd     #$2C
            dc.w    0
STNOSTACK:
            tst.l   (-$84,A6)
            bpl.b   DONESTRETCH.L2
            movem.l D0-D3/A0-A2,-(SP)
            tst.l   (-$2B4,A6)
            bne.b   .L1
            moveq   #1,D0
            swap    D0
            jsr     ([$1A70.w])
            move.l  D0,D2
            beq.b   .L1
            move.l  A0,(-$2B4,A6)
            subi.l  #$640,D2
            asr.l   #2,D2
            add.l   D2,(-$84,A6)
            bmi.b   .L1
            clr.l   StkLowPt
            movea.l SP,A2
            move.l  HiHeapMark,(-$2C4,A6)
            movea.l (A0),A0
            exg     D0,A0
            jsr     ([$644.w])
            move.l  D0,HiHeapMark
            adda.l  D0,A0
            move.l  ($1C,SP),-(A0)
            movea.l A0,SP
            movem.l (A2),D0-D3/A0-A2
            rts
.L1:
            move.w  #$FF6B,QDErr
            bra.w   DONESTRETCH.L2
            ds.b    14
stMASK0:
            bfextu  (A3){D6:0},D0
            addq.w  #4,A3
            move.l  (A2)+,D1
            eor.l   D7,D0
            move.l  D0,D5
            and.l   D3,D0
            not.l   D5
            and.l   D4,D5
            or.l    D5,D0
            and.l   D1,D0
            not.l   D1
            and.l   (A4),D1
            or.l    D1,D0
            move.l  D0,(A4)+
            dbra    D2,stMASK0
            bra.w   STSCANLOOP.L43
            ds.b    10
stMASK1:
            bfextu  (A3){D6:0},D0
            addq.w  #4,A3
            eor.l   D7,D0
            move.l  (A2)+,D1
            and.l   D1,D0
            move.l  D0,D1
            and.l   D3,D1
            not.l   D0
            and.l   (A4),D0
            or.l    D1,D0
            move.l  D0,(A4)+
            dbra    D2,stMASK1
            bra.w   STSCANLOOP.L43
stMASK2:
            bfextu  (A3){D6:0},D0
            addq.w  #4,A3
            eor.l   D7,D0
            and.l   (A2)+,D0
            eor.l   D0,(A4)+
            dbra    D2,stMASK2
            bra.w   STSCANLOOP.L43
            ds.b    12
stMASK3:
            bfextu  (A3){D6:0},D0
            addq.w  #4,A3
            eor.l   D7,D0
            move.l  (A2)+,D1
            and.l   D1,D0
            move.l  D0,D1
            and.l   D4,D1
            not.l   D0
            and.l   (A4),D0
            or.l    D1,D0
            move.l  D0,(A4)+
            dbra    D2,stMASK3
            bra.w   STSCANLOOP.L43
stAddOver:
            add.l   D7,D6
            bfextu  (A2){D3:D7},D0
            beq.b   .L1
            bfextu  (A3){D6:D7},D0
            lea     (0,A5,D0.w*8),A0
            bfextu  (A4){D3:D7},D0
            lea     (0,A5,D0.w*8),A1
            move.w  (A0)+,D0
            add.w   (A1)+,D0
            asl.l   D5,D0
            move.w  (A0)+,D0
            add.w   (A1)+,D0
            asl.l   D5,D0
            move.w  (A0)+,D0
            add.w   (A1)+,D0
            asl.l   D5,D0
            swap    D0
            move.b  ([-$10C.w,A6],D0.w,6.w),D0
            bfins   D0,(A4){D3:D7}
.L1:
            add.l   D7,D3
            dbra    D2,stAddOver
            bra.w   STSCANLOOP.L43
            ds.b    14
stAddPin:
            add.l   D7,D6
            bfextu  (A2){D3:D7},D0
            beq.b   .L7
            bfextu  (A3){D6:D7},D0
            lea     (0,A5,D0.w*8),A0
            bfextu  (A4){D3:D7},D0
            lea     (0,A5,D0.w*8),A1
            move.w  (A0)+,D0
            add.w   (A1)+,D0
            bcs.b   .L1
            cmp.w   (-$F6,A6),D0
            bls.b   .L2
.L1:
            move.w  (-$F6,A6),D0
.L2:
            asl.l   D5,D0
            move.w  (A0)+,D0
            add.w   (A1)+,D0
            bcs.b   .L3
            cmp.w   (-$F8,A6),D0
            bls.b   .L4
.L3:
            move.w  (-$F8,A6),D0
.L4:
            asl.l   D5,D0
            move.w  (A0)+,D0
            add.w   (A1)+,D0
            bcs.b   .L5
            cmp.w   (-$FA,A6),D0
            bls.b   .L6
.L5:
            move.w  (-$FA,A6),D0
.L6:
            asl.l   D5,D0
            swap    D0
            move.b  ([-$10C.w,A6],D0.w,6.w),D0
            bfins   D0,(A4){D3:D7}
.L7:
            add.l   D7,D3
            dbra    D2,stAddPin
            bra.w   STSCANLOOP.L43
            ds.b    10
stSubOver:
            add.l   D7,D6
            bfextu  (A2){D3:D7},D0
            beq.b   .L1
            bfextu  (A3){D6:D7},D0
            lea     (0,A5,D0.w*8),A0
            bfextu  (A4){D3:D7},D0
            lea     (0,A5,D0.w*8),A1
            move.w  (A1)+,D0
            sub.w   (A0)+,D0
            asl.l   D5,D0
            move.w  (A1)+,D0
            sub.w   (A0)+,D0
            asl.l   D5,D0
            move.w  (A1)+,D0
            sub.w   (A0)+,D0
            asl.l   D5,D0
            swap    D0
            move.b  ([-$10C.w,A6],D0.w,6.w),D0
            bfins   D0,(A4){D3:D7}
.L1:
            add.l   D7,D3
            dbra    D2,stSubOver
            bra.w   STSCANLOOP.L43
            ds.b    14
stSubPin:
            add.l   D7,D6
            bfextu  (A2){D3:D7},D0
            beq.b   .L7
            bfextu  (A3){D6:D7},D0
            lea     (0,A5,D0.w*8),A0
            bfextu  (A4){D3:D7},D0
            lea     (0,A5,D0.w*8),A1
            move.w  (A1)+,D0
            sub.w   (A0)+,D0
            bcs.b   .L1
            cmp.w   (-$F6,A6),D0
            bcc.b   .L2
.L1:
            move.w  (-$F6,A6),D0
.L2:
            asl.l   D5,D0
            move.w  (A1)+,D0
            sub.w   (A0)+,D0
            bcs.b   .L3
            cmp.w   (-$F8,A6),D0
            bcc.b   .L4
.L3:
            move.w  (-$F8,A6),D0
.L4:
            asl.l   D5,D0
            move.w  (A1)+,D0
            sub.w   (A0)+,D0
            bcs.b   .L5
            cmp.w   (-$FA,A6),D0
            bcc.b   .L6
.L5:
            move.w  (-$FA,A6),D0
.L6:
            asl.l   D5,D0
            swap    D0
            move.b  ([-$10C.w,A6],D0.w,6.w),D0
            bfins   D0,(A4){D3:D7}
.L7:
            add.l   D7,D3
            dbra    D2,stSubPin
            bra.w   STSCANLOOP.L43
            ds.b    10
stMax:
            add.l   D7,D6
            bfextu  (A2){D3:D7},D0
            beq.b   .L4
            bfextu  (A3){D6:D7},D0
            lea     (0,A5,D0.w*8),A0
            bfextu  (A4){D3:D7},D0
            lea     (0,A5,D0.w*8),A1
            move.w  (A0)+,D0
            cmp.w   (A1),D0
            bcc.b   .L1
            move.w  (A1),D0
.L1:
            addq.w  #2,A1
            asl.l   D5,D0
            move.w  (A0)+,D0
            cmp.w   (A1),D0
            bcc.b   .L2
            move.w  (A1),D0
.L2:
            addq.w  #2,A1
            asl.l   D5,D0
            move.w  (A0)+,D0
            cmp.w   (A1),D0
            bcc.b   .L3
            move.w  (A1),D0
.L3:
            asl.l   D5,D0
            swap    D0
            move.b  ([-$10C.w,A6],D0.w,6.w),D0
            bfins   D0,(A4){D3:D7}
.L4:
            add.l   D7,D3
            dbra    D2,stMax
            bra.w   STSCANLOOP.L43
            ds.b    14
stMin:
            add.l   D7,D6
            bfextu  (A2){D3:D7},D0
            beq.b   .L4
            bfextu  (A3){D6:D7},D0
            lea     (0,A5,D0.w*8),A0
            bfextu  (A4){D3:D7},D0
            lea     (0,A5,D0.w*8),A1
            move.w  (A0)+,D0
            cmp.w   (A1),D0
            bls.b   .L1
            move.w  (A1),D0
.L1:
            addq.w  #2,A1
            asl.l   D5,D0
            move.w  (A0)+,D0
            cmp.w   (A1),D0
            bls.b   .L2
            move.w  (A1),D0
.L2:
            addq.w  #2,A1
            asl.l   D5,D0
            move.w  (A0)+,D0
            cmp.w   (A1),D0
            bls.b   .L3
            move.w  (A1),D0
.L3:
            asl.l   D5,D0
            swap    D0
            move.b  ([-$10C.w,A6],D0.w,6.w),D0
            bfins   D0,(A4){D3:D7}
.L4:
            add.l   D7,D3
            dbra    D2,stMin
            bra.w   STSCANLOOP.L43
            ds.b    14
stAvg:
            add.l   D7,D6
            bfextu  (A2){D3:D7},D0
            beq.b   .L2
            bfextu  (A3){D6:D7},D0
            lea     (0,A5,D0.w*8),A0
            bfextu  (A4){D3:D7},D0
            lea     (0,A5,D0.w*8),A1
            moveq   #2,D1
            move.w  (-$10E,A6),D5
            add.w   D5,D5
            clr.w   -(SP)
.L1:
            move.w  (A0)+,D0
            mulu.w  (-$FA.w,A6,D1.w*2),D0
            move.w  (A1)+,D4
            mulu.w  (-$100.w,A6,D1.w*2),D4
            add.l   D4,D0
            swap    D0
            move.w  (-$110,A6),D4
            lsr.w   D4,D0
            lsl.w   D5,D0
            or.w    D0,(SP)
            sub.w   (-$10E,A6),D5
            dbra    D1,.L1
            move.w  (SP)+,D0
            move.b  ([-$10C.w,A6],D0.w,6.w),D0
            bfins   D0,(A4){D3:D7}
.L2:
            add.l   D7,D3
            dbra    D2,stAvg
            bra.w   STSCANLOOP.L43
stTransparent:
            add.l   D7,D6
.L1:
            bfextu  (A3){D6:0},D0
            cmp.l   D0,D4
            beq.b   .L3
            bfextu  (A2){D3:D7},D0
            beq.b   .L2
            bfextu  (A3){D6:D7},D0
            cmpa.l  D0,A5
            beq.b   .L2
            bfins   D0,(A4){D3:D7}
.L2:
            add.l   D7,D3
            dbra    D2,stTransparent
            bra.w   STSCANLOOP.L43
.L3:
            addq.w  #4,A3
            addi.w  #$20,D3
            sub.w   D5,D2
            bge.b   .L1
            move.l  (-$A4,A6),D4
            bra.w   STSCANLOOP.L43
            ds.b    8
stHilite:
            bfextu  D4{0:D7},D4
            bfextu  (-$118,A6){0:D7},D5
.L1:
            add.l   D7,D6
            bfextu  (A2){D3:D7},D0
            beq.b   .L3
            bfextu  (A3){D6:D7},D0
            beq.b   .L3
            bfextu  (A4){D3:D7},D0
            cmp.l   D4,D0
            bne.b   .L2
            bfins   D5,(A4){D3:D7}
            bra.b   .L3
.L2:
            cmp.l   D5,D0
            bne.b   .L3
            bfins   D4,(A4){D3:D7}
.L3:
            add.l   D7,D3
            dbra    D2,.L1
            bra.w   STSCANLOOP.L43
            ds.b    8
            bsr.w   .L62
            move.l  #$7F7F7F,D0
            movea.l #$808080,A0
.L5:
            tst.l   (A2)+
            beq.b   .L4
            move.l  (0,A3,D6.w),D1
            move.l  A0,D7
            and.l   D1,D7
            and.l   D0,D1
            move.l  (A1),D5
            move.l  A0,D3
            and.l   D5,D3
            and.l   D0,D5
            add.l   D1,D5
            eor.l   D7,D3
            eor.l   D3,D5
            move.l  D5,(A1)
.L4:
            addq.l  #4,A1
            addq.l  #4,D6
            dbra    D2,.L5
            bra.w   STSCANLOOP.L43
            ds.b    6
.L62:
            movea.l A4,A1
            moveq   #0,D6
            rts
            ds.b    10
            bsr.b   .L62
            moveq   #0,D3
            move.b  (-$F6,A6),D3
            swap    D3
            move.w  (-$F8,A6),D3
            move.b  (-$FA,A6),D3
            move.l  Lo3Bytes,D1
.L42:
            tst.l   (A2)+
            beq.b   .L36
            move.l  (0,A3,D6.w),D7
            and.l   D1,D7
            move.l  D7,D0
            move.l  (A1),D5
            and.l   D1,D5
            clr.b   D0
            add.w   D5,D0
            bcs.b   .L37
            cmp.w   D3,D0
            bls.b   .L38
.L37:
            move.w  D3,D0
.L38:
            move.b  D7,D0
            add.b   D5,D0
            bcs.b   .L39
            cmp.b   D3,D0
            bls.b   .L40
.L39:
            move.b  D3,D0
.L40:
            clr.w   D5
            add.l   D5,D0
            cmp.l   D3,D0
            bls.b   .L41
            swap    D3
            swap    D0
            move.w  D3,D0
            swap    D0
            swap    D3
.L41:
            move.l  D0,(A1)
.L36:
            addq.l  #4,A1
            addq.l  #4,D6
            dbra    D2,.L42
            bra.w   STSCANLOOP.L43
            dc.w    0
            bsr.b   .L62
            move.l  #$7F7F7F,D0
            move.l  #$808080,D1
.L44:
            tst.l   (A2)+
            beq.b   .L43
            move.l  (0,A3,D6.w),D7
            move.l  D1,D3
            and.l   D7,D3
            eor.l   D1,D3
            and.l   D0,D7
            move.l  (A1),D5
            move.l  D1,D4
            and.l   D5,D4
            and.l   D0,D5
            or.l    D1,D5
            sub.l   D7,D5
            eor.l   D3,D4
            eor.l   D4,D5
            move.l  D5,(A1)
.L43:
            addq.l  #4,A1
            addq.l  #4,D6
            dbra    D2,.L44
            bra.w   STSCANLOOP.L43
            ds.b    4
            bsr.w   .L62
            moveq   #0,D3
            move.b  (-$F6,A6),D3
            swap    D3
            move.w  (-$F8,A6),D3
            move.b  (-$FA,A6),D3
            move.l  Lo3Bytes,D1
.L12:
            tst.l   (A2)+
            beq.b   .L6
            move.l  (0,A3,D6.w),D5
            and.l   D1,D5
            move.l  (A1),D7
            and.l   D1,D7
            move.l  D7,D0
            st      D0
            sub.w   D5,D0
            bcs.b   .L7
            cmp.w   D3,D0
            bcc.b   .L8
.L7:
            move.w  D3,D0
.L8:
            move.b  D7,D0
            sub.b   D5,D0
            bcs.b   .L9
            cmp.b   D3,D0
            bcc.b   .L10
.L9:
            move.b  D3,D0
.L10:
            clr.w   D5
            sub.l   D5,D0
            cmp.l   D3,D0
            bge.b   .L11
            swap    D3
            swap    D0
            move.w  D3,D0
            swap    D0
            swap    D3
.L11:
            move.l  D0,(A1)
.L6:
            addq.l  #4,A1
            addq.l  #4,D6
            dbra    D2,.L12
            bra.w   STSCANLOOP.L43
            bsr.w   .L62
.L17:
            tst.l   (A2)+
            beq.b   .L13
            move.l  (0,A3,D6.w),D1
            move.l  (A1),D5
            move.l  D5,D0
            cmp.w   D1,D0
            bhi.b   .L14
            move.w  D1,D0
            move.b  D5,D0
.L14:
            cmp.b   D1,D5
            bhi.b   .L15
            move.b  D1,D0
.L15:
            swap    D1
            swap    D0
            cmp.b   D1,D0
            bhi.b   .L16
            move.b  D1,D0
.L16:
            swap    D0
            move.l  D0,(A1)
.L13:
            addq.l  #4,A1
            addq.l  #4,D6
            dbra    D2,.L17
            bra.w   STSCANLOOP.L43
            ds.b    8
            bsr.w   .L62
.L22:
            tst.l   (A2)+
            beq.b   .L18
            move.l  (0,A3,D6.w),D1
            move.l  (A1),D5
            move.l  D5,D0
            cmp.w   D1,D0
            bls.b   .L19
            move.w  D1,D0
            move.b  D5,D0
.L19:
            cmp.b   D1,D5
            bls.b   .L20
            move.b  D1,D0
.L20:
            swap    D1
            swap    D0
            cmp.b   D1,D0
            bls.b   .L21
            move.b  D1,D0
.L21:
            swap    D0
            move.l  D0,(A1)
.L18:
            addq.l  #4,A1
            addq.l  #4,D6
            dbra    D2,.L22
            bra.w   STSCANLOOP.L43
            ds.b    8
            lea     .L23,A0
            move.l  A0,(-$218,A6)
            lea     (-$FA,A6),A0
            move.w  (A0)+,D3
            cmp.w   (A0)+,D3
            bne.b   .L23
            cmp.w   (A0),D3
            bne.b   .L23
            addq.w  #1,D3
            andi.w  #$FFFE,D3
            cmpi.w  #$8000,D3
            bne.b   .L23
            lea     .L24,A0
            move.l  A0,(-$218,A6)
            bra.w   .L24
.L23:
            bsr.w   .L62
            lea     (-$FA,A6),A0
            move.l  (A0)+,D1
            move.w  (A0),D0
            moveq   #0,D4
            move.l  D4,D3
            movea.l D4,A0
.L63:
            tst.l   (A2)+
            beq.b   .L75
            move.l  (0,A3,D6.w),D7
            move.l  (A1),D5
            cmp.l   D3,D7
            bne.b   .L25
            cmp.l   A0,D5
            beq.b   .L76
.L25:
            moveq   #0,D3
            move.b  D7,D3
            swap    D1
            mulu.w  D1,D3
            moveq   #0,D4
            move.b  D5,D4
            neg.w   D1
            mulu.w  D1,D4
            neg.w   D1
            add.l   D3,D4
            swap    D4
            movea.w D4,A0
            move.w  D7,D3
            lsr.w   #8,D3
            swap    D1
            mulu.w  D1,D3
            move.w  D5,D4
            lsr.w   #8,D4
            neg.w   D1
            mulu.w  D1,D4
            neg.w   D1
            add.l   D3,D4
            swap    D4
            lsl.w   #8,D4
            adda.w  D4,A0
            moveq   #0,D3
            swap    D7
            move.b  D7,D3
            mulu.w  D0,D3
            moveq   #0,D4
            swap    D5
            move.b  D5,D4
            neg.w   D0
            mulu.w  D0,D4
            neg.w   D0
            add.l   D3,D4
            move.w  A0,D4
            swap    D5
            movea.l D5,A0
            swap    D7
            move.l  D7,D3
.L76:
            move.l  D4,(A1)
.L75:
            addq.l  #4,A1
            addq.l  #4,D6
            dbra    D2,.L63
            bra.w   STSCANLOOP.L43
            ds.b    14
.L24:
            bsr.w   .L62
            move.l  #$7F7F7F,D0
            movea.l #$10101,A0
.L27:
            tst.l   (A2)+
            beq.b   .L26
            move.l  (0,A3,D6.w),D1
            move.l  A0,D3
            and.l   D1,D3
            lsr.l   #1,D1
            and.l   D0,D1
            move.l  (A1),D5
            and.l   D5,D3
            lsr.l   #1,D5
            and.l   D0,D5
            add.l   D5,D1
            add.l   D3,D1
            move.l  D1,(A1)
.L26:
            addq.l  #4,A1
            addq.l  #4,D6
            dbra    D2,.L27
            bra.w   STSCANLOOP.L43
            ds.b    6
            bsr.w   .L62
            move.l  (-$114,A6),D5
.L29:
            tst.l   (A2)+
            beq.b   .L28
            move.l  (0,A3,D6.w),D1
            cmp.l   D1,D5
            beq.b   .L28
            move.l  D1,(A1)
.L28:
            addq.l  #4,A1
            addq.l  #4,D6
            dbra    D2,.L29
            bra.w   STSCANLOOP.L43
            ds.b    14
            bsr.b   .L46
            move.w  #$3DEF,D0
            movea.w #$4210,A0
.L31:
            tst.w   (A2)+
            beq.b   .L30
            move.w  (0,A3,D6.w),D1
            move.w  A0,D7
            and.w   D1,D7
            and.w   D0,D1
            move.w  (A1),D5
            move.w  A0,D3
            and.w   D5,D3
            and.w   D0,D5
            add.w   D1,D5
            eor.w   D7,D3
            eor.w   D3,D5
            move.w  D5,(A1)
.L30:
            addq.l  #2,A1
            addq.l  #2,D6
            dbra    D2,.L31
            bra.w   STSCANLOOP.L43
            ds.b    12
.L46:
            movea.l A4,A1
            moveq   #0,D6
            tst.w   (-$234,A6)
            beq.b   .L45
            subq.w  #2,A3
.L45:
            rts
            dc.w    0
            bsr.b   .L46
            moveq   #0,D3
            move.b  (-$F6,A6),D3
            lsr.b   #3,D3
            swap    D3
            move.w  (-$F8,A6),D3
            lsr.w   #3,D3
            move.b  (-$FA,A6),D3
            lsr.b   #3,D3
.L51:
            tst.w   (A2)+
            beq.b   .L47
            moveq   #0,D7
            move.w  (0,A3,D6.w),D7
            add.w   D7,D7
            lsl.l   #5,D7
            lsr.w   #3,D7
            lsr.b   #3,D7
            moveq   #0,D5
            move.w  (A1),D5
            add.w   D5,D5
            lsl.l   #5,D5
            lsr.w   #3,D5
            lsr.b   #3,D5
            add.l   D5,D7
            move.l  D7,D0
            cmp.l   D3,D0
            bls.b   .L48
            move.l  D3,D0
.L48:
            move.w  D7,D0
            cmp.w   D3,D0
            bls.b   .L49
            move.w  D3,D0
.L49:
            move.b  D7,D0
            cmp.b   D3,D0
            bls.b   .L50
            move.b  D3,D0
.L50:
            lsl.b   #3,D0
            lsl.w   #3,D0
            lsr.l   #6,D0
            move.w  D0,(A1)
.L47:
            addq.l  #2,A1
            addq.l  #2,D6
            dbra    D2,.L51
            bra.w   STSCANLOOP.L43
            ds.b    12
            bsr.w   .L46
            move.w  #$3DEF,D0
            move.w  #$4210,D1
.L33:
            tst.w   (A2)+
            beq.b   .L32
            move.w  (0,A3,D6.w),D7
            move.w  D1,D3
            and.w   D7,D3
            eor.w   D1,D3
            and.w   D0,D7
            move.w  (A1),D5
            move.w  D1,D4
            and.w   D5,D4
            and.w   D0,D5
            or.w    D1,D5
            sub.w   D7,D5
            eor.w   D3,D4
            eor.w   D4,D5
            move.w  D5,(A1)
.L32:
            addq.l  #2,A1
            addq.l  #2,D6
            dbra    D2,.L33
            bra.w   STSCANLOOP.L43
            ds.b    6
            bsr.w   .L46
            moveq   #0,D3
            move.b  (-$F6,A6),D3
            lsr.b   #3,D3
            swap    D3
            move.w  (-$F8,A6),D3
            lsr.w   #3,D3
            move.b  (-$FA,A6),D3
            lsr.b   #3,D3
            move.l  #$808080,D1
            add.l   D1,D3
.L56:
            tst.w   (A2)+
            beq.b   .L52
            moveq   #0,D5
            move.w  (0,A3,D6.w),D5
            add.w   D5,D5
            lsl.l   #5,D5
            lsr.w   #3,D5
            lsr.b   #3,D5
            moveq   #0,D7
            move.w  (A1),D7
            add.w   D7,D7
            lsl.l   #5,D7
            lsr.w   #3,D7
            lsr.b   #3,D7
            add.l   D1,D7
            sub.l   D5,D7
            move.l  D7,D0
            cmp.l   D3,D0
            bcc.b   .L53
            move.l  D3,D0
.L53:
            move.w  D7,D0
            cmp.w   D3,D0
            bcc.b   .L54
            move.w  D3,D0
.L54:
            move.b  D7,D0
            cmp.b   D3,D0
            bcc.b   .L55
            move.b  D3,D0
.L55:
            lsl.b   #3,D0
            lsl.w   #3,D0
            lsr.l   #6,D0
            move.w  D0,(A1)
.L52:
            addq.l  #2,A1
            addq.l  #2,D6
            dbra    D2,.L56
            bra.w   STSCANLOOP.L43
            bsr.w   .L46
.L61:
            tst.w   (A2)+
            beq.b   .L57
            moveq   #0,D7
            move.w  (0,A3,D6.w),D7
            add.w   D7,D7
            lsl.l   #5,D7
            lsr.w   #3,D7
            lsr.b   #3,D7
            moveq   #0,D5
            move.w  (A1),D5
            add.w   D5,D5
            lsl.l   #5,D5
            lsr.w   #3,D5
            lsr.b   #3,D5
            move.l  D7,D0
            cmp.l   D5,D0
            bcc.b   .L58
            move.l  D5,D0
.L58:
            move.w  D7,D0
            cmp.w   D5,D0
            bcc.b   .L59
            move.w  D5,D0
.L59:
            move.b  D7,D0
            cmp.b   D5,D0
            bcc.b   .L60
            move.b  D5,D0
.L60:
            lsl.b   #3,D0
            lsl.w   #3,D0
            lsr.l   #6,D0
            move.w  D0,(A1)
.L57:
            addq.l  #2,A1
            addq.l  #2,D6
            dbra    D2,.L61
            bra.w   STSCANLOOP.L43
            dc.w    0
            bsr.w   .L46
.L68:
            tst.w   (A2)+
            beq.b   .L64
            moveq   #0,D7
            move.w  (0,A3,D6.w),D7
            add.w   D7,D7
            lsl.l   #5,D7
            lsr.w   #3,D7
            lsr.b   #3,D7
            moveq   #0,D5
            move.w  (A1),D5
            add.w   D5,D5
            lsl.l   #5,D5
            lsr.w   #3,D5
            lsr.b   #3,D5
            move.l  D7,D0
            cmp.l   D5,D0
            bls.b   .L65
            move.l  D5,D0
.L65:
            move.w  D7,D0
            cmp.w   D5,D0
            bls.b   .L66
            move.w  D5,D0
.L66:
            move.b  D7,D0
            cmp.b   D5,D0
            bls.b   .L67
            move.b  D5,D0
.L67:
            lsl.b   #3,D0
            lsl.w   #3,D0
            lsr.l   #6,D0
            move.w  D0,(A1)
.L64:
            addq.l  #2,A1
            addq.l  #2,D6
            dbra    D2,.L68
            bra.w   STSCANLOOP.L43
            dc.w    0
            lea     .L69,A0
            move.l  A0,(-$218,A6)
            lea     (-$FA,A6),A0
            move.w  (A0)+,D3
            cmp.w   (A0)+,D3
            bne.b   .L69
            cmp.w   (A0),D3
            bne.b   .L69
            addq.w  #1,D3
            andi.w  #$FFFE,D3
            cmpi.w  #$8000,D3
            bne.b   .L69
            lea     .L70,A0
            move.l  A0,(-$218,A6)
            bra.w   .L70
.L69:
            bsr.w   .L46
            lea     (-$FA,A6),A0
            move.l  (A0)+,D1
            move.w  (A0),D0
            moveq   #0,D4
            move.l  D4,D3
            movea.l D4,A0
.L74:
            tst.w   (A2)+
            beq.w   .L71
            moveq   #0,D7
            move.w  (0,A3,D6.w),D7
            moveq   #0,D5
            move.w  (A1),D5
            cmp.w   D3,D7
            bne.b   .L72
            cmp.w   A0,D5
            beq.b   .L73
.L72:
            add.w   D7,D7
            lsl.l   #5,D7
            lsr.w   #3,D7
            lsr.b   #3,D7
            add.w   D5,D5
            lsl.l   #5,D5
            lsr.w   #3,D5
            lsr.b   #3,D5
            moveq   #0,D3
            move.b  D7,D3
            swap    D1
            mulu.w  D1,D3
            moveq   #0,D4
            move.b  D5,D4
            neg.w   D1
            mulu.w  D1,D4
            neg.w   D1
            add.l   D3,D4
            swap    D4
            movea.l D4,A0
            move.w  D7,D3
            lsr.w   #8,D3
            swap    D1
            mulu.w  D1,D3
            move.w  D5,D4
            lsr.w   #8,D4
            neg.w   D1
            mulu.w  D1,D4
            neg.w   D1
            add.l   D3,D4
            swap    D4
            lsl.w   #5,D4
            adda.w  D4,A0
            moveq   #0,D3
            swap    D7
            move.b  D7,D3
            mulu.w  D0,D3
            moveq   #0,D4
            swap    D5
            move.b  D5,D4
            neg.w   D0
            mulu.w  D0,D4
            neg.w   D0
            add.l   D3,D4
            clr.w   D4
            lsr.l   #6,D4
            add.w   A0,D4
            swap    D5
            lsl.b   #3,D5
            lsl.w   #3,D5
            lsr.l   #6,D5
            movea.l D5,A0
            swap    D7
            lsl.b   #3,D7
            lsl.w   #3,D7
            lsr.l   #6,D7
            move.l  D7,D3
.L73:
            move.w  D4,(A1)
.L71:
            addq.l  #2,A1
            addq.l  #2,D6
            dbra    D2,.L74
            bra.w   STSCANLOOP.L43
            ds.b    8
.L70:
            bsr.w   .L46
            move.w  #$3DEF,D0
            movea.w #$421,A0
.L35:
            tst.w   (A2)+
            beq.b   .L34
            move.w  (0,A3,D6.w),D1
            move.w  A0,D3
            and.w   D1,D3
            lsr.w   #1,D1
            and.w   D0,D1
            move.w  (A1),D5
            and.w   D5,D3
            lsr.w   #1,D5
            and.w   D0,D5
            add.w   D5,D1
            add.w   D3,D1
            move.w  D1,(A1)
.L34:
            addq.l  #2,A1
            addq.l  #2,D6
            dbra    D2,.L35
            bra.w   STSCANLOOP.L43
            ds.b    10
            dc.w    $6100,$FD0E,$2A2E,$FEEC,$4A5A,$670A,$3233,$6000
            dc.w    $BA41,$6702,$3281,$5489,$5486,$51CA,$FFEC,$6000
            dc.w    $F4E6,0
STARITH16TAB:
            dc.w    $FFFF,$FEBC,$FFFF,$FCFC,$FFFF,$FCAC,$FFFF,$FDAC
            dc.w    $FFFF,$FFDC,$FFFF,$FE1C,$FFFF,$FD6C,$FFFF,$FE6C
            dc.w    $FFFF,$F96C
STARITH32TAB:
            dc.w    $FFFF,$FB58,$FFFF,$F9D8,$FFFF,$F988,$FFFF,$FA78
            dc.w    $FFFF,$FC58,$FFFF,$FAD8,$FFFF,$FA38,$FFFF,$FB18
            dc.w    $FFFF,$F948
            ds.b    4
SETUPSTRETCH:
            move.w  D3,-(SP)
            lea     DONESTRETCH,A0
            tst.w   D0
            ble.w   .L2
            tst.w   D1
            ble.w   .L2
            lea     PATEXTBL.L1,A0
            cmp.w   D1,D0
            beq.w   .L2
            blt.w   .L3
            move.w  D0,D3
            move.w  D1,D4
            clr.l   -(SP)
            move.w  D1,-(SP)
            move.w  D0,-(SP)
            jsr     ([$FA4.w])
            move.l  (SP)+,D0
            lea     PIXSTR,A0
            tst.w   (SP)
            bne.b   .L2
            lea     PATEXTBL.L10,A0
            cmpi.w  #$8000,D0
            beq.b   .L2
            lea     TABLE2.L2,A0
            cmpi.w  #$4000,D0
            beq.b   .L2
            lea     TABLE8.L1,A0
            cmpi.w  #$2000,D0
            beq.b   .L2
            lea     TABLE8.L2,A0
            cmpi.w  #$1000,D0
            beq.b   .L2
            lea     sub_40839140,A0
            cmpi.w  #$800,D0
            beq.b   .L2
            lea     PATEXTBL.L9,A0
            cmpi.w  #$AAAA,D0
            beq.b   .L2
            lea     TABLE2.L1,A0
            cmpi.w  #$5555,D0
            beq.b   .L2
            lea     TABLE4.L1,A0
            cmpi.w  #$2AAA,D0
            beq.b   .L2
            ext.l   D3
            divu.w  D4,D3
            move.w  D3,D1
            andi.l  #$FFFF0007,D3
            bne.b   .L1
            move.w  D1,D0
            lea     sub_40839140.L2,A0
            bra.b   .L2
.L1:
            lea     SHRINK.L4,A0
.L2:
            addq.w  #2,SP
            rts
.L3:
            clr.l   -(SP)
            move.w  D0,-(SP)
            move.w  D1,-(SP)
            jsr     ([$FA4.w])
            move.l  (SP)+,D0
            lea     PIXSHRNK,A0
            tst.w   (SP)
            bne.b   .L2
            lea     PATEXTBL.L8,A0
            cmpi.w  #$2000,D0
            beq.b   .L2
            lea     PATEXTBL.L7,A0
            cmpi.w  #$4000,D0
            beq.b   .L2
            lea     PATEXTBL.L6,A0
            cmpi.w  #$8000,D0
            beq.b   .L2
            lea     PATEXTBL.L5,A0
            cmpi.w  #$C000,D0
            beq.b   .L2
            lea     SHRINK,A0
            bra.b   .L2
EXTBL:
            ori.b   #$44,D0
            dc.w    0,$0304,0,$0574,0,$0B14,0,$0B34
            dc.w    0,$0C14,0,$0C34,0,$0C74
PATEXTBL:
            ori.b   #$34,D0
            dc.w    0,$02A4,0,$0568,0,$0A14,0,$0B34
            dc.w    0,$0B94
            ds.b    12
.L1:
            suba.l  A1,A2
            move.l  A2,D0
            lsr.l   #2,D0
            subq.w  #1,D0
.L11:
            move.l  (A0)+,(A1)+
            dbra    D0,.L11
            rts
            clr.w   (A1)+
            clr.l   (A1)+
            movea.l (A1),A1
            move.b  (A0)+,D0
            bra.b   .L3
.L2:
            move.b  (A0)+,D0
            cmp.b   D5,D0
            beq.b   .L4
.L3:
            move.b  D0,D5
            eor.b   D7,D0
            rol.b   D2,D0
            move.b  D0,D1
            lsl.l   #8,D1
            move.b  D0,D1
            move.w  D1,D0
            swap    D1
            move.w  D0,D1
            move.l  D1,D0
            and.l   D3,D0
            not.l   D1
            and.l   D4,D1
            or.l    D0,D1
.L4:
            move.l  D1,(A1)+
            move.l  D1,($1C,A1)
            dbra    D6,.L2
            rts
            ds.b    8
.L5:
            moveq   #3,D3
            ror.l   #2,D3
.L13:
            move.l  (A0)+,D0
            moveq   #7,D2
.L12:
            add.l   D0,D0
            addx.l  D1,D1
            add.l   D3,D0
            addx.l  D1,D1
            lsl.l   #3,D0
            addx.l  D1,D1
            dbra    D2,.L12
            bfins   D1,(A1){0:24}
            addq.w  #3,A1
            cmpa.l  A2,A1
            bcs.b   .L13
            rts
            ds.b    12
.L6:
            move.l  A2,D3
            sub.l   A1,D3
            lsr.w   #2,D3
            subq.w  #1,D3
            move.l  #'UUUU',D2
            move.l  #$FF00FF,D5
.L19:
            move.l  (A0)+,D0
            move.l  D0,D1
            lsr.l   #1,D1
            or.l    D0,D1
            and.l   D2,D1
            move.l  D1,D0
            lsr.l   #7,D0
            or.l    D1,D0
            and.l   D5,D0
            swap    D0
            move.b  .L20(PC,D0.w),D4
            lsl.w   #8,D4
            swap    D0
            move.b  .L20(PC,D0.w),D4
            swap    D4
            move.l  (A0)+,D0
            move.l  D0,D1
            lsr.l   #1,D1
            or.l    D0,D1
            and.l   D2,D1
            move.l  D1,D0
            lsr.l   #7,D0
            or.l    D1,D0
            and.l   D5,D0
            swap    D0
            move.b  .L20(PC,D0.w),D4
            lsl.w   #8,D4
            swap    D0
            move.b  .L20(PC,D0.w),D4
            move.l  D4,(A1)+
            dbra    D3,.L19
            rts
.L20:
            dc.w    $0001
            dc.w    $1011,$0203,$1213,$2021,$3031,$2223,$3233,$0405
            dc.w    $1415,$0607,$1617
            dc.b    '$%45&',$27,'67@APQBCRS`apqbcrsDETUFGVWdetufgvw'
            dc.w    $0809,$1819,$0A0B,$1A1B
            dc.b    '()89*+:;'
            dc.w    $0C0D,$1C1D,$0E0F,$1E1F
            dc.b    ',-<=./>?HIXYJKZ[hixyjkz'
            dc.b    $7B,$4C,$4D,$5C
            dc.b    ']NO^_lm|'
            dc.b    $7D,$6E,$6F,$7E,$7F,$80,$81,$90,$91,$82,$83,$92,$93,$A0,$A1,$B0
            dc.b    $B1,$A2,$A3,$B2,$B3,$84,$85,$94,$95,$86,$87,$96,$97,$A4,$A5,$B4
            dc.b    $B5,$A6,$A7,$B6,$B7,$C0,$C1,$D0,$D1,$C2,$C3,$D2,$D3,$E0,$E1,$F0
            dc.b    $F1,$E2,$E3,$F2,$F3,$C4,$C5,$D4,$D5,$C6,$C7,$D6,$D7,$E4,$E5,$F4
            dc.b    $F5,$E6,$E7,$F6,$F7,$88,$89,$98,$99,$8A,$8B,$9A,$9B,$A8,$A9,$B8
            dc.b    $B9,$AA,$AB,$BA,$BB,$8C,$8D,$9C,$9D,$8E,$8F,$9E,$9F,$AC,$AD,$BC
            dc.b    $BD,$AE,$AF,$BE,$BF,$C8,$C9,$D8,$D9,$CA,$CB,$DA,$DB,$E8,$E9,$F8
            dc.b    $F9,$EA,$EB,$FA,$FB,$CC,$CD,$DC,$DD,$CE,$CF,$DE,$DF,$EC,$ED,$FC
            dc.b    $FD,$EE,$EF,$FE,$FF,$00,$00
.L7:
            move.l  #$F0000000,D3
.L15:
            move.l  (A0)+,D0
            moveq   #7,D2
.L14:
            add.l   D3,D0
            addx.l  D1,D1
            lsl.l   #4,D0
            dbra    D2,.L14
            move.b  D1,(A1)+
            cmpa.l  A2,A1
            bcs.b   .L15
            rts
            ds.b    4
.L8:
            move.l  #$FF000000,D3
.L18:
            move.l  (A0)+,D0
            moveq   #3,D2
.L16:
            add.l   D3,D0
            addx.l  D1,D1
            lsl.l   #8,D0
            dbra    D2,.L16
            move.l  (A0)+,D0
            moveq   #3,D2
.L17:
            add.l   D3,D0
            addx.l  D1,D1
            lsl.l   #8,D0
            dbra    D2,.L17
            move.b  D1,(A1)+
            cmpa.l  A2,A1
            bcs.b   .L18
            rts
            ds.b    6
.L9:
            move.b  (A0)+,D0
            move.w  D0,D1
            lsr.b   #4,D1
            move.b  .L25(PC,D1.w),D2
            lsl.l   #6,D2
            andi.w  #$F,D0
            move.b  .L25(PC,D0.w),D2
            lsl.l   #6,D2
            move.b  (A0)+,D0
            move.w  D0,D1
            lsr.b   #4,D1
            move.b  .L25(PC,D1.w),D2
            lsl.l   #6,D2
            andi.w  #$F,D0
            move.b  .L25(PC,D0.w),D2
            lsr.l   #2,D2
            swap    D2
            move.b  D2,(A1)+
            swap    D2
            move.w  D2,D1
            ror.w   #8,D1
            move.b  D1,(A1)+
            move.b  D2,(A1)+
            cmpa.l  A2,A1
            bcs.b   .L9
            rts
.L25:
            dc.w    $000C,$101C,$606C,$707C,$808C,$909C,$E0EC,$F0FC
            clr.w   (A1)+
            clr.l   (A1)+
            movea.l (A1),A1
            moveq   #0,D0
            move.b  (A0)+,D0
            bra.b   .L21
.L23:
            moveq   #0,D0
            move.b  (A0)+,D0
            cmp.b   D5,D0
            beq.b   .L22
.L21:
            move.b  D0,D5
            eor.b   D7,D0
            rol.b   D2,D0
            move.w  D0,D1
            move.w  TABLE2(PC,D1.w*2),D1
            move.w  D1,D0
            swap    D1
            move.w  D0,D1
            move.l  D1,D0
            and.l   D3,D0
            not.l   D1
            and.l   D4,D1
            or.l    D0,D1
.L22:
            move.l  D1,($20,A1)
            move.l  D1,(A1)+
            dbra    D6,.L23
            rts
            ds.b    4
.L10:
            clr.w   D0
            move.l  A2,D3
            sub.l   A1,D3
            lsr.w   #1,D3
            subq.w  #1,D3
.L24:
            move.b  (A0)+,D0
            move.w  TABLE2(PC,D0.w*2),(A1)+
            dbra    D3,.L24
            rts
TABLE2:
            dc.w    0,$0003,$000C,$000F,$0030,$0033,$003C,$003F
            dc.w    $00C0,$00C3,$00CC,$00CF,$00F0,$00F3,$00FC,$00FF
            dc.w    $0300,$0303,$030C,$030F,$0330,$0333,$033C,$033F
            dc.w    $03C0,$03C3,$03CC,$03CF,$03F0,$03F3,$03FC,$03FF
            dc.w    $0C00,$0C03,$0C0C,$0C0F,$0C30,$0C33,$0C3C,$0C3F
            dc.w    $0CC0,$0CC3,$0CCC,$0CCF,$0CF0,$0CF3,$0CFC,$0CFF
            dc.w    $0F00,$0F03,$0F0C,$0F0F,$0F30,$0F33,$0F3C,$0F3F
            dc.w    $0FC0,$0FC3,$0FCC,$0FCF,$0FF0,$0FF3,$0FFC,$0FFF
            dc.w    $3000,$3003,$300C,$300F
            dc.b    '00030<0?0'
            dc.b    $C0,$30,$C3,$30,$CC,$30,$CF,$30,$F0,$30,$F3,$30,$FC,$30,$FF,$33
            dc.b    $00,$33,$03,$33,$0C,$33,$0F
            dc.b    '30333<3?3'
            dc.b    $C0,$33,$C3,$33,$CC,$33,$CF,$33,$F0,$33,$F3,$33,$FC,$33,$FF,$3C
            dc.b    $00,$3C,$03,$3C,$0C,$3C,$0F
            dc.b    '<0<3<<<?<'
            dc.b    $C0,$3C,$C3,$3C,$CC,$3C,$CF,$3C,$F0,$3C,$F3,$3C,$FC,$3C,$FF,$3F
            dc.b    $00,$3F,$03,$3F,$0C,$3F,$0F
            dc.b    '?0?3?<???'
            dc.b    $C0,$3F,$C3,$3F,$CC,$3F,$CF,$3F,$F0,$3F,$F3,$3F,$FC,$3F,$FF,$C0
            dc.b    $00,$C0,$03,$C0,$0C,$C0,$0F,$C0,$30,$C0,$33,$C0,$3C,$C0,$3F,$C0
            dc.b    $C0,$C0,$C3,$C0,$CC,$C0,$CF,$C0,$F0,$C0,$F3,$C0,$FC,$C0,$FF,$C3
            dc.b    $00,$C3,$03,$C3,$0C,$C3,$0F,$C3,$30,$C3,$33,$C3,$3C,$C3,$3F,$C3
            dc.b    $C0,$C3,$C3,$C3,$CC,$C3,$CF,$C3,$F0,$C3,$F3,$C3,$FC,$C3,$FF,$CC
            dc.b    $00,$CC,$03,$CC,$0C,$CC,$0F,$CC,$30,$CC,$33,$CC,$3C,$CC,$3F,$CC
            dc.b    $C0,$CC,$C3,$CC,$CC,$CC,$CF,$CC,$F0,$CC,$F3,$CC,$FC,$CC,$FF,$CF
            dc.b    $00,$CF,$03,$CF,$0C,$CF,$0F,$CF,$30,$CF,$33,$CF,$3C,$CF,$3F,$CF
            dc.b    $C0,$CF,$C3,$CF,$CC,$CF,$CF,$CF,$F0,$CF,$F3,$CF,$FC,$CF,$FF,$F0
            dc.b    $00,$F0,$03,$F0,$0C,$F0,$0F,$F0,$30,$F0,$33,$F0,$3C,$F0,$3F,$F0
            dc.b    $C0,$F0,$C3,$F0,$CC,$F0,$CF,$F0,$F0,$F0,$F3,$F0,$FC,$F0,$FF,$F3
            dc.b    $00,$F3,$03,$F3,$0C,$F3,$0F,$F3,$30,$F3,$33,$F3,$3C,$F3,$3F,$F3
            dc.b    $C0,$F3,$C3,$F3,$CC,$F3,$CF,$F3,$F0,$F3,$F3,$F3,$FC,$F3,$FF,$FC
            dc.b    $00,$FC,$03,$FC,$0C,$FC,$0F,$FC,$30,$FC,$33,$FC,$3C,$FC,$3F,$FC
            dc.b    $C0,$FC,$C3,$FC,$CC,$FC,$CF,$FC,$F0,$FC,$F3,$FC,$FC,$FC,$FF,$FF
            dc.b    $00,$FF,$03,$FF,$0C,$FF,$0F,$FF,$30,$FF,$33,$FF,$3C,$FF,$3F,$FF
            dc.b    $C0,$FF,$C3,$FF,$CC,$FF,$CF,$FF,$F0,$FF,$F3,$FF,$FC,$FF,$FF
            ds.b    10
.L1:
            dc.w    $1018,$3200,$3400,$EA0A,$12FB,$201A,$E409,$0241
            dc.w    $000F,$12FB,$1018,$0240,$0007,$12FB,$0020,$B3CA
            dc.w    $65DE,$4E75,$0003,$1C1F,$E0E3,$FCFF,$0001,$0E0F
            dc.w    $7071,$7E7F,$8081,$8E8F,$F0F1,$FEFF,$0007,$383F
            dc.w    $C0C7,$F8FF
            ds.b    12
.L2:
            suba.l  A1,A2
            move.l  A2,D1
            lsr.l   #2,D1
            subq.w  #1,D1
.L6:
            move.b  (A0)+,D0
            move.l  TABLE4(PC,D0.w*4),(A1)+
            dbra    D1,.L6
            rts
            clr.w   (A1)+
            clr.l   (A1)+
            movea.l (A1),A1
            moveq   #0,D0
            move.b  (A0)+,D0
            bra.b   .L4
.L3:
            moveq   #0,D0
            move.b  (A0)+,D0
            cmp.b   D5,D0
            beq.b   .L5
.L4:
            move.b  D0,D5
            eor.b   D7,D0
            rol.b   D2,D0
            move.l  TABLE4(PC,D0.w*4),D1
            move.l  D1,D0
            and.l   D3,D0
            not.l   D1
            and.l   D4,D1
            or.l    D0,D1
.L5:
            move.l  D1,(A1)+
            move.l  D1,($1C,A1)
            dbra    D6,.L3
            rts
TABLE4:
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
            dc.b    $0F,$0F,$FF,$FF,$F0,$0F,$FF,$FF,$FF,$F0,$00,$00,$00,$F0,$00,$00
            dc.b    $0F,$F0,$00,$00,$F0,$F0,$00,$00,$FF,$F0,$00,$0F,$00,$F0,$00,$0F
            dc.b    $0F,$F0,$00,$0F,$F0,$F0,$00,$0F,$FF,$F0,$00,$F0,$00,$F0,$00,$F0
            dc.b    $0F,$F0,$00,$F0,$F0,$F0,$00,$F0,$FF,$F0,$00,$FF,$00,$F0,$00,$FF
            dc.b    $0F,$F0,$00,$FF,$F0,$F0,$00,$FF,$FF,$F0,$0F,$00,$00,$F0,$0F,$00
            dc.b    $0F,$F0,$0F,$00,$F0,$F0,$0F,$00,$FF,$F0,$0F,$0F,$00,$F0,$0F,$0F
            dc.b    $0F,$F0,$0F,$0F,$F0,$F0,$0F,$0F,$FF,$F0,$0F,$F0,$00,$F0,$0F,$F0
            dc.b    $0F,$F0,$0F,$F0,$F0,$F0,$0F,$F0,$FF,$F0,$0F,$FF,$00,$F0,$0F,$FF
            dc.b    $0F,$F0,$0F,$FF,$F0,$F0,$0F,$FF,$FF,$F0,$F0,$00,$00,$F0,$F0,$00
            dc.b    $0F,$F0,$F0,$00,$F0,$F0,$F0,$00,$FF,$F0,$F0,$0F,$00,$F0,$F0,$0F
            dc.b    $0F,$F0,$F0,$0F,$F0,$F0,$F0,$0F,$FF,$F0,$F0,$F0,$00,$F0,$F0,$F0
            dc.b    $0F,$F0,$F0,$F0,$F0,$F0,$F0,$F0,$FF,$F0,$F0,$FF,$00,$F0,$F0,$FF
            dc.b    $0F,$F0,$F0,$FF,$F0,$F0,$F0,$FF,$FF,$F0,$FF,$00,$00,$F0,$FF,$00
            dc.b    $0F,$F0,$FF,$00,$F0,$F0,$FF,$00,$FF,$F0,$FF,$0F,$00,$F0,$FF,$0F
            dc.b    $0F,$F0,$FF,$0F,$F0,$F0,$FF,$0F,$FF,$F0,$FF,$F0,$00,$F0,$FF,$F0
            dc.b    $0F,$F0,$FF,$F0,$F0,$F0,$FF,$F0,$FF,$F0,$FF,$FF,$00,$F0,$FF,$FF
            dc.b    $0F,$F0,$FF,$FF,$F0,$F0,$FF,$FF,$FF,$FF,$00,$00,$00,$FF,$00,$00
            dc.b    $0F,$FF,$00,$00,$F0,$FF,$00,$00,$FF,$FF,$00,$0F,$00,$FF,$00,$0F
            dc.b    $0F,$FF,$00,$0F,$F0,$FF,$00,$0F,$FF,$FF,$00,$F0,$00,$FF,$00,$F0
            dc.b    $0F,$FF,$00,$F0,$F0,$FF,$00,$F0,$FF,$FF,$00,$FF,$00,$FF,$00,$FF
            dc.b    $0F,$FF,$00,$FF,$F0,$FF,$00,$FF,$FF,$FF,$0F,$00,$00,$FF,$0F,$00
            dc.b    $0F,$FF,$0F,$00,$F0,$FF,$0F,$00,$FF,$FF,$0F,$0F,$00,$FF,$0F,$0F
            dc.b    $0F,$FF,$0F,$0F,$F0,$FF,$0F,$0F,$FF,$FF,$0F,$F0,$00,$FF,$0F,$F0
            dc.b    $0F,$FF,$0F,$F0,$F0,$FF,$0F,$F0,$FF,$FF,$0F,$FF,$00,$FF,$0F,$FF
            dc.b    $0F,$FF,$0F,$FF,$F0,$FF,$0F,$FF,$FF,$FF,$F0,$00,$00,$FF,$F0,$00
            dc.b    $0F,$FF,$F0,$00,$F0,$FF,$F0,$00,$FF,$FF,$F0,$0F,$00,$FF,$F0,$0F
            dc.b    $0F,$FF,$F0,$0F,$F0,$FF,$F0,$0F,$FF,$FF,$F0,$F0,$00,$FF,$F0,$F0
            dc.b    $0F,$FF,$F0,$F0,$F0,$FF,$F0,$F0,$FF,$FF,$F0,$FF,$00,$FF,$F0,$FF
            dc.b    $0F,$FF,$F0,$FF,$F0,$FF,$F0,$FF,$FF,$FF,$FF,$00,$00,$FF,$FF,$00
            dc.b    $0F,$FF,$FF,$00,$F0,$FF,$FF,$00,$FF,$FF,$FF,$0F,$00,$FF,$FF,$0F
            dc.b    $0F,$FF,$FF,$0F,$F0,$FF,$FF,$0F,$FF,$FF,$FF,$F0,$00,$FF,$FF,$F0
            dc.b    $0F,$FF,$FF,$F0,$F0,$FF,$FF,$F0,$FF,$FF,$FF,$FF,$00,$FF,$FF,$FF
            dc.b    $0F,$FF,$FF,$FF,$F0,$FF,$FF,$FF,$FF
            ds.b    8
.L1:
            dc.w    $1018,$3200,$0241,$00E0,$E809,$32FB,$1020,$3200
            dc.w    $0241,$003C,$E209,$32FB,$1024,$3200,$0241,$0007
            dc.w    $D241,$32FB,$1038,$B3CA,$65D6,$4E75,0,$000F
            dc.w    $03F0,$03FF,$FC00,$FC0F,$FFF0,$FFFF,0,$0003
            dc.w    $00FC,$00FF,$3F00,$3F03,$3FFC,$3FFF,$C000,$C003
            dc.w    $C0FC,$C0FF,$FF00,$FF03,$FFFC,$FFFF,0,$003F
            dc.w    $0FC0,$0FFF,$F000,$F03F,$FFC0,$FFFF
            ds.b    4
            move.w  #8,(A1)+
            move.w  #4,(A1)+
            move.w  #$3F,(A1)+
            movea.l A0,A2
            moveq   #7,D0
.L5:
            move.b  (A2),D1
            ror.b   #4,D1
            cmp.b   (A2)+,D1
            dbne    D0,.L5
            bne.b   .L6
            clr.w   (-6,A1)
            bra.b   .L7
.L6:
            movea.l (A1),A1
.L8:
            moveq   #0,D1
            move.b  (A0)+,D1
            eor.b   D7,D1
            rol.b   D2,D1
            move.w  D1,D5
            andi.w  #$F0,D1
            lsr.w   #2,D1
            move.l  TABLE8(PC,D1.w),D1
            move.l  D1,D0
            and.l   D3,D0
            not.l   D1
            and.l   D4,D1
            or.l    D0,D1
            move.l  D1,(A1)+
            andi.w  #$F,D5
            move.l  TABLE8(PC,D5.w*4),D1
            move.l  D1,D0
            and.l   D3,D0
            not.l   D1
            and.l   D4,D1
            or.l    D0,D1
            move.l  D1,(A1)+
            dbra    D6,.L8
            rts
.L7:
            movea.l (A1),A1
            moveq   #0,D0
            move.b  (A0)+,D0
            bra.b   .L3
.L2:
            moveq   #0,D0
            move.b  (A0)+,D0
            cmp.b   D5,D0
            beq.b   .L4
.L3:
            move.b  D0,D5
            eor.b   D7,D0
            rol.b   D2,D0
            andi.w  #$F0,D0
            lsr.w   #2,D0
            move.l  TABLE8(PC,D0.w),D1
            move.l  D1,D0
            and.l   D3,D0
            not.l   D1
            and.l   D4,D1
            or.l    D0,D1
.L4:
            move.l  D1,(A1)+
            move.l  D1,($1C,A1)
            dbra    D6,.L2
            rts
TABLE8:
            ds.b    7
            dc.b    $FF,$00,$00,$FF,$00,$00,$00,$FF,$FF,$00,$FF,$00,$00,$00,$FF,$00
            dc.b    $FF,$00,$FF,$FF,$00,$00,$FF,$FF,$FF,$FF,$00,$00,$00,$FF,$00,$00
            dc.b    $FF,$FF,$00,$FF,$00,$FF,$00,$FF,$FF,$FF,$FF,$00,$00,$FF,$FF,$00
            dc.b    $FF,$FF,$FF,$FF,$00,$FF,$FF,$FF,$FF
            ds.b    12
.L1:
            move.b  (A0)+,D0
            move.w  D0,D1
            andi.w  #$F0,D1
            lsr.w   #2,D1
            move.l  TABLE8(PC,D1.w),(A1)+
            andi.w  #$F,D0
            move.l  TABLE8(PC,D0.w*4),(A1)+
            cmpa.l  A2,A1
            bcs.b   .L1
            rts
            ds.b    4
.L2:
            moveq   #$F,D2
            move.l  (A0)+,D0
.L6:
            add.l   D0,D0
            subx.l  D1,D1
            add.l   D0,D0
            subx.w  D1,D1
            move.l  D1,(A1)+
            cmpa.l  A2,A1
            dbcc    D2,.L6
            bcs.b   .L2
            rts
            ds.b    8
            move.w  #$10,(A1)+
            move.w  #$C,(A1)+
            move.w  #$7F,(A1)+
            movea.l A0,A2
            moveq   #7,D0
.L8:
            move.b  (A2)+,D1
            move.b  D1,D5
            ror.b   #1,D1
            eor.b   D1,D5
            bne.b   .L7
            dbra    D0,.L8
            bset    #$1F,D6
            clr.w   (-6,A1)
.L7:
            movea.l (A1),A1
.L3:
            move.b  (A0)+,D0
            eor.b   D7,D0
            rol.b   D2,D0
            moveq   #7,D1
.L4:
            add.b   D0,D0
            bcs.b   FORE16
            move.w  D4,(A1)+
            tst.l   D6
            bpl.b   .L5
            move.w  D4,($1E,A1)
            subq.w  #3,D1
.L5:
            dbra    D1,.L4
            dbra    D6,.L3
            rts
FORE16:
            move.w  D3,(A1)+
            tst.l   D6
            bpl.b   .L1
            move.w  D3,($1E,A1)
            subq.w  #3,D1
.L1:
            dbra    D1,TABLE8.L4
            dbra    D6,TABLE8.L3
            rts
            move.w  #$20,(A1)+
            move.w  #$1C,(A1)+
            move.w  #$FF,(A1)+
            move.l  A1,D5
            movea.l (A1),A1
            movea.l A0,A2
            moveq   #7,D0
.L2:
            move.b  (A2)+,D1
            eor.b   D7,D1
            bne.b   .L3
            move.l  D4,(A1)+
            move.l  D4,($1C,A1)
            bra.b   .L4
.L3:
            addq.b  #1,D1
            bne.b   .L5
            move.l  D3,(A1)+
            move.l  D3,($1C,A1)
.L4:
            dbra    D0,.L2
            movea.l D5,A1
            clr.w   (-6,A1)
            rts
.L5:
            movea.l D5,A1
            movea.l (A1),A1
.L6:
            move.b  (A0)+,D0
            eor.b   D7,D0
            rol.b   D2,D0
            moveq   #7,D1
.L7:
            add.b   D0,D0
            bcs.b   .L8
            move.l  D4,(A1)+
            dbra    D1,.L7
            dbra    D6,.L6
            rts
.L8:
            move.l  D3,(A1)+
            dbra    D1,.L7
            dbra    D6,.L6
            rts
sub_40839140:
            moveq   #$1F,D2
            move.l  (A0)+,D0
.L1:
            add.l   D0,D0
            subx.l  D1,D1
            move.l  D1,(A1)+
            cmpa.l  A2,A1
            dbcc    D2,.L1
            bcs.b   sub_40839140
            rts
            ds.b    12
            move.w  #$7FFF,D2
            move.l  A2,D3
            sub.l   A1,D3
            ror.l   #6,D3
            bra.b   .L3
.L5:
            moveq   #$1F,D4
            move.l  (A0)+,D0
            not.l   D0
.L4:
            add.l   D0,D0
            subx.w  D1,D1
            and.w   D2,D1
            move.w  D1,(A1)+
            dbra    D4,.L4
.L3:
            dbra    D3,.L5
            clr.w   D3
            rol.l   #5,D3
            move.l  (A0)+,D0
            not.l   D0
            bra.b   .L6
.L7:
            add.l   D0,D0
            subx.w  D1,D1
            and.w   D2,D1
            move.w  D1,(A1)+
.L6:
            dbra    D3,.L7
            rts
            ds.b    6
            move.l  Lo3Bytes,D2
            move.l  A2,D3
            sub.l   A1,D3
            ror.l   #7,D3
            bra.b   .L8
.L10:
            moveq   #$1F,D4
            move.l  (A0)+,D0
            not.l   D0
.L9:
            add.l   D0,D0
            subx.l  D1,D1
            and.l   D2,D1
            move.l  D1,(A1)+
            dbra    D4,.L9
.L8:
            dbra    D3,.L10
            clr.w   D3
            rol.l   #5,D3
            move.l  (A0)+,D0
            not.l   D0
            bra.b   .L11
.L12:
            add.l   D0,D0
            subx.l  D1,D1
            and.l   D2,D1
            move.l  D1,(A1)+
.L11:
            dbra    D3,.L12
            rts
            ds.b    6
.L2:
            lsr.w   #3,D4
            subq.w  #1,D4
            move.w  #$8000,D0
.L15:
            add.w   D0,D0
            bne.b   .L13
            move.w  (A0)+,D0
            addx.w  D0,D0
.L13:
            scs     D1
            move.w  D4,D2
.L14:
            move.b  D1,(A1)+
            cmpa.l  A2,A1
            dbhi    D2,.L14
            bls.b   .L15
            rts
SHRINK:
            clr.w   D1
            move.w  #$8000,D0
            move.w  D0,D2
            move.w  D4,D3
            lsr.w   #1,D3
.L1:
            add.w   D0,D0
            bcc.b   .L3
            bne.b   .L2
            move.w  (A0)+,D0
            addx.w  D0,D0
            bcc.b   .L3
.L2:
            or.w    D2,D1
.L3:
            add.w   D4,D3
            bcc.b   .L1
            ror.w   #1,D2
            bcc.b   .L1
            move.w  D1,(A1)+
            clr.w   D1
            cmpa.l  A2,A1
            bcs.b   .L1
            rts
            ds.b    4
.L4:
            clr.w   D1
            move.w  #$8000,D0
            move.w  D0,D2
            move.w  D4,D3
            lsr.w   #1,D3
.L5:
            add.w   D0,D0
            bcc.b   WHITE1.L1
            bne.b   .L7
            move.w  (A0)+,D0
            addx.w  D0,D0
            bcc.b   WHITE1.L1
            bra.b   .L7
.L6:
            add.w   D4,D3
            bcs.b   .L5
.L7:
            or.w    D2,D1
            ror.w   #1,D2
            bcc.b   .L6
            move.w  D1,(A1)+
            clr.w   D1
            cmpa.l  A2,A1
            bcs.b   .L6
            rts
WHITE1:
            add.w   D4,D3
            bcs.b   SHRINK.L5
.L1:
            ror.w   #1,D2
            bcc.b   WHITE1
            move.w  D1,(A1)+
            clr.w   D1
            cmpa.l  A2,A1
            bcs.b   WHITE1
            rts
AverageH32:
            movem.l D5/A5,-(SP)
            move.w  D4,D2
            move.w  D4,D3
            lsr.w   #1,D3
            moveq   #0,D5
            bra.b   .L2
.L1:
            move.l  (A0)+,(A1)+
            cmpa.l  A2,A1
            bcc.b   .L6
.L2:
            add.w   D2,D3
            bcs.b   .L1
            move.l  (A0)+,D0
            move.b  D0,D5
            movea.w D5,A5
            lsr.w   #8,D0
            movea.w D0,A4
            swap    D0
            move.b  D0,D5
            movea.w D5,A3
            moveq   #1,D4
.L3:
            move.l  (A0)+,D0
            addq.w  #1,D4
            move.b  D0,D5
            adda.w  D5,A5
            lsr.w   #8,D0
            adda.w  D0,A4
            swap    D0
            move.b  D0,D5
            adda.w  D5,A3
            add.w   D2,D3
            bcc.b   .L3
            cmpi.w  #2,D4
            blt.b   .L5
            beq.b   .L4
            moveq   #0,D1
            move.l  A3,D0
            divu.w  D4,D0
            move.b  D0,D1
            lsl.l   #8,D1
            move.l  A4,D0
            divu.w  D4,D0
            move.b  D0,D1
            lsl.l   #8,D1
            move.l  A5,D0
            divu.w  D4,D0
            move.b  D0,D1
            bra.b   .L5
.L4:
            move.l  A3,D1
            lsl.w   #7,D1
            move.l  A4,D0
            lsr.w   #1,D0
            move.b  D0,D1
            lsl.l   #8,D1
            move.l  A5,D0
            lsr.w   #1,D0
            move.b  D0,D1
.L5:
            move.l  D1,(A1)+
            cmpa.l  A2,A1
            bcs.b   .L2
.L6:
            movem.l (SP)+,D5/A5
            rts
PIXSHRNK:
            cmpi.w  #$20,D5
            beq.w   AverageH32
            movem.l D6-D7,-(SP)
            movea.w D4,A3
            move.w  D4,D3
            lsr.w   #1,D3
            moveq   #0,D2
            moveq   #0,D6
            moveq   #$1F,D7
            ext.l   D5
            move.l  (A0)+,D0
            moveq   #0,D1
.L1:
            suba.l  A4,A4
.L2:
            bfextu  D0{D2:D5},D4
            cmp.l   A4,D4
            bls.b   .L3
            bfins   D4,D1{D6:D5}
            movea.l D4,A4
.L3:
            add.l   D5,D2
            and.w   D7,D2
            bne.b   .L4
            move.l  (A0)+,D0
.L4:
            add.w   A3,D3
            bcc.b   .L2
            add.l   D5,D6
            and.w   D7,D6
            bne.b   .L1
            move.l  D1,(A1)+
            moveq   #0,D1
            cmpa.l  A2,A1
            bcs.b   .L1
            movem.l (SP)+,D6-D7
            rts
            dc.w    0
PIXSTR:
            movem.l D6-D7,-(SP)
            movea.w D4,A3
            move.w  D4,D3
            lsr.w   #1,D3
            moveq   #0,D2
            moveq   #0,D6
            moveq   #$1F,D7
            ext.l   D5
.L1:
            move.l  (A0)+,D0
.L2:
            bfextu  D0{D2:D5},D4
.L3:
            bfins   D4,D1{D6:D5}
            add.l   D5,D6
            and.w   D7,D6
            bne.b   .L4
            move.l  D1,(A1)+
            cmpa.l  A2,A1
            bcc.b   .L5
.L4:
            add.w   A3,D3
            bcc.b   .L3
            add.l   D5,D2
            and.w   D7,D2
            bne.b   .L2
            bra.b   .L1
.L5:
            movem.l (SP)+,D6-D7
            rts
            ds.b    6
SCALEINDEXEDTOINDEXED:
            movem.l D6-D7,-(SP)
            moveq   #0,D1
            moveq   #0,D2
            moveq   #$1F,D7
            bra.b   .L2
.L1:
            add.w   D3,D1
            and.w   D7,D1
            bne.b   .L3
.L2:
            move.l  (A0)+,D5
.L3:
            bfextu  D5{D1:D3},D0
            move.l  (0,A4,D0.w*4),D0
            bfins   D0,D6{D2:D4}
            add.w   D4,D2
            and.w   D7,D2
            bne.b   .L1
            move.l  D6,(A1)+
            cmpa.l  A2,A1
            bcs.b   .L1
            movem.l (SP)+,D6-D7
            rts
            ds.b    14
DITHER32TOINDEXED:
            movem.l D6-D7/A3/A5,-(SP)
            movea.l (-$2A4,A6),A4
            moveq   #0,D2
            move.l  D2,D5
            move.l  D2,D6
            move.l  D2,D7
            not.b   (-$2A9,A6)
            bne.b   .L3
            movea.l (-$2A8,A6),A0
            moveq   #$20,D2
.L1:
            sub.w   D4,D2
.L2:
            subq.w  #6,A4
            move.l  -(A0),D0
            bsr.b   sub_40839432
            asr.w   #1,D5
            move.w  D5,(A4)
            asr.w   #1,D6
            move.w  D6,(2,A4)
            asr.w   #1,D7
            move.w  D7,(4,A4)
            sub.w   D4,D2
            bge.b   .L2
            moveq   #$20,D2
            move.l  D1,-(A2)
            cmpa.l  A2,A1
            bcs.b   .L1
            move.l  A4,(-$2A4,A6)
            bra.b   .L4
.L3:
            move.l  (A0)+,D0
            bsr.b   sub_40839432
            asr.w   #1,D5
            move.w  D5,(A4)+
            asr.w   #1,D6
            move.w  D6,(A4)+
            asr.w   #1,D7
            move.w  D7,(A4)+
            add.w   D4,D2
            andi.w  #$1F,D2
            bne.b   .L3
            move.l  D1,(A1)+
            cmpa.l  A2,A1
            bcs.b   .L3
            move.l  A4,(-$2A4,A6)
            move.l  A0,(-$2A8,A6)
.L4:
            movem.l (SP)+,D6-D7/A3/A5
            rts
sub_40839432:
            add.w   (A4),D5
            add.w   (2,A4),D6
            add.w   (4,A4),D7
            moveq   #0,D3
            move.b  D0,D3
            add.w   D3,D7
            lsr.w   #8,D0
            add.w   D0,D6
            swap    D0
            move.b  D0,D3
            add.w   D3,D5
            swap    D4
            move.w  (-$29E,A6),D0
            tst.w   D5
            spl     D3
            cmp.w   D3,D5
            sgt     D4
            and.b   D5,D3
            or.b    D4,D3
            moveq   #0,D5
            move.b  D3,D5
            lsl.l   D0,D3
            tst.w   D6
            spl     D3
            cmpi.w  #$FF,D6
            sgt     D4
            and.b   D6,D3
            or.b    D4,D3
            moveq   #0,D6
            move.b  D3,D6
            lsl.l   D0,D3
            tst.w   D7
            spl     D3
            cmpi.w  #$FF,D7
            sgt     D4
            and.b   D7,D3
            or.b    D4,D3
            neg.w   D0
            addq.w  #8,D0
            moveq   #0,D7
            move.b  D3,D7
            lsr.l   D0,D3
            swap    D4
            moveq   #0,D0
            movea.l (-$28C,A6),A3
            move.b  (0,A3,D3.l),D0
            bfins   D0,D1{D2:D4}
            movea.l (-$29C,A6),A3
            lea     ($A,A3,D0.l*8),A5
            move.l  (A5)+,D0
            moveq   #0,D3
            lsr.l   #8,D0
            move.b  D0,D3
            sub.w   D3,D6
            swap    D0
            move.b  D0,D3
            sub.w   D3,D5
            move.w  (A5)+,D0
            lsr.w   #8,D0
            move.b  D0,D3
            sub.w   D3,D7
            rts
            ds.b    14
DITHER16TOINDEXED:
            movem.l D6-D7/A3/A5,-(SP)
            movea.l (-$2A4,A6),A4
            moveq   #0,D2
            move.l  D2,D5
            move.l  D2,D6
            move.l  D2,D7
            not.b   (-$2A9,A6)
            bne.b   .L3
            movea.l (-$2A8,A6),A0
            moveq   #$20,D2
.L1:
            sub.w   D4,D2
.L2:
            subq.w  #6,A4
            move.w  -(A0),D0
            bsr.b   DitherCore_Stretch
            asr.w   #1,D5
            move.w  D5,(A4)
            asr.w   #1,D6
            move.w  D6,(2,A4)
            asr.w   #1,D7
            move.w  D7,(4,A4)
            sub.w   D4,D2
            bge.b   .L2
            moveq   #$20,D2
            move.l  D1,-(A2)
            cmpa.l  A2,A1
            bcs.b   .L1
            move.l  A4,(-$2A4,A6)
            bra.b   .L4
.L3:
            move.w  (A0)+,D0
            bsr.b   DitherCore_Stretch
            asr.w   #1,D5
            move.w  D5,(A4)+
            asr.w   #1,D6
            move.w  D6,(A4)+
            asr.w   #1,D7
            move.w  D7,(A4)+
            add.w   D4,D2
            andi.w  #$1F,D2
            bne.b   .L3
            move.l  D1,(A1)+
            cmpa.l  A2,A1
            bcs.b   .L3
            move.l  A4,(-$2A4,A6)
            move.l  A0,(-$2A8,A6)
.L4:
            movem.l (SP)+,D6-D7/A3/A5
            rts
DitherCore_Stretch:
            add.w   (A4),D5
            add.w   (2,A4),D6
            add.w   (4,A4),D7
            moveq   #0,D3
            move.b  D0,D3
            lsl.b   #3,D3
            add.w   D3,D7
            lsr.l   #5,D0
            move.b  D0,D3
            lsl.b   #3,D3
            add.w   D3,D6
            lsr.l   #5,D0
            move.b  D0,D3
            lsl.b   #3,D3
            add.w   D3,D5
            swap    D4
            move.w  (-$29E,A6),D0
            tst.w   D5
            spl     D3
            cmp.w   D3,D5
            sgt     D4
            and.b   D5,D3
            or.b    D4,D3
            moveq   #0,D5
            move.b  D3,D5
            lsl.l   D0,D3
            tst.w   D6
            spl     D3
            cmpi.w  #$FF,D6
            sgt     D4
            and.b   D6,D3
            or.b    D4,D3
            moveq   #0,D6
            move.b  D3,D6
            lsl.l   D0,D3
            tst.w   D7
            spl     D3
            cmpi.w  #$FF,D7
            sgt     D4
            and.b   D7,D3
            or.b    D4,D3
            neg.w   D0
            addq.w  #8,D0
            moveq   #0,D7
            move.b  D3,D7
            lsr.l   D0,D3
            swap    D4
            moveq   #0,D0
            movea.l (-$28C,A6),A3
            move.b  (0,A3,D3.l),D0
            bfins   D0,D1{D2:D4}
            movea.l (-$29C,A6),A3
            lea     ($A,A3,D0.l*8),A5
            move.l  (A5)+,D0
            moveq   #0,D3
            lsr.l   #8,D0
            move.b  D0,D3
            sub.w   D3,D6
            swap    D0
            move.b  D0,D3
            sub.w   D3,D5
            move.w  (A5),D0
            lsr.w   #8,D0
            move.b  D0,D3
            sub.w   D3,D7
            rts
            ds.b    6
DITHER32TOGRAY:
            movem.l D6-D7/A3/A5,-(SP)
            movea.l (-$290,A6),A3
            lea     ($100,A3),A5
            movea.l (-$2A4,A6),A4
            moveq   #0,D5
            move.l  D5,D0
            move.l  D5,D1
            move.l  D5,D2
            not.b   (-$2A9,A6)
            bne.b   .L3
            movea.l (-$2A8,A6),A0
            moveq   #$20,D5
.L1:
            sub.w   D4,D5
.L2:
            subq.w  #2,A4
            move.l  -(A0),D3
            move.b  D3,D2
            lsr.l   #8,D3
            move.b  D3,D1
            lsr.w   #8,D3
            move.b  D3,D0
            add.w   D1,D3
            add.w   D2,D3
            add.w   D2,D3
            lsr.w   #2,D3
            add.w   D0,D3
            add.w   D1,D3
            add.w   D1,D3
            lsr.w   #2,D3
            add.w   D3,D7
            add.w   (A4),D7
            spl     D2
            cmp.w   D2,D7
            sgt     D1
            and.b   D2,D7
            or.b    D1,D7
            move.b  D7,D1
            move.b  (0,A3,D1.w),D0
            bfins   D0,D6{D5:D4}
            sub.b   (0,A5,D1.w),D7
            ext.w   D7
            asr.w   #1,D7
            move.w  D7,(A4)
            sub.w   D4,D5
            bge.b   .L2
            moveq   #$20,D5
            move.l  D6,-(A2)
            cmpa.l  A2,A1
            bcs.b   .L1
            move.l  A4,(-$2A4,A6)
            bra.b   .L4
.L3:
            move.l  (A0)+,D3
            move.b  D3,D2
            lsr.l   #8,D3
            move.b  D3,D1
            lsr.w   #8,D3
            move.b  D3,D0
            add.w   D1,D3
            add.w   D2,D3
            add.w   D2,D3
            lsr.w   #2,D3
            add.w   D0,D3
            add.w   D1,D3
            add.w   D1,D3
            lsr.w   #2,D3
            add.w   D3,D7
            add.w   (A4),D7
            spl     D2
            cmp.w   D2,D7
            sgt     D1
            and.b   D2,D7
            or.b    D1,D7
            move.b  D7,D1
            move.b  (0,A3,D1.w),D0
            bfins   D0,D6{D5:D4}
            sub.b   (0,A5,D1.w),D7
            ext.w   D7
            asr.w   #1,D7
            move.w  D7,(A4)+
            add.w   D4,D5
            andi.w  #$1F,D5
            bne.b   .L3
            move.l  D6,(A1)+
            cmpa.l  A2,A1
            bcs.b   .L3
            move.l  A4,(-$2A4,A6)
            move.l  A0,(-$2A8,A6)
.L4:
            movem.l (SP)+,D6-D7/A3/A5
            rts
            ds.b    14
DITHER16TOGRAY:
            movem.l D6-D7/A3/A5,-(SP)
            moveq   #0,D3
            movea.l (-$290,A6),A3
            lea     ($100,A3),A5
            movea.l (-$2A4,A6),A4
            moveq   #0,D5
            move.l  D5,D0
            move.l  D5,D1
            move.l  D5,D2
            not.b   (-$2A9,A6)
            bne.b   .L3
            movea.l (-$2A8,A6),A0
            moveq   #$20,D5
.L1:
            sub.w   D4,D5
.L2:
            subq.w  #2,A4
            move.w  -(A0),D3
            lsl.l   #3,D3
            move.b  D3,D2
            lsl.w   #5,D2
            move.b  D3,D2
            lsr.w   #5,D2
            lsr.l   #5,D3
            move.b  D3,D1
            lsl.w   #5,D1
            move.b  D3,D1
            lsr.w   #5,D1
            lsr.l   #5,D3
            move.b  D3,D0
            lsl.w   #5,D0
            move.b  D3,D0
            lsr.w   #5,D0
            move.w  D0,D3
            add.w   D1,D3
            add.w   D2,D3
            add.w   D2,D3
            lsr.w   #2,D3
            add.w   D0,D3
            add.w   D1,D3
            add.w   D1,D3
            lsr.w   #2,D3
            add.w   D3,D7
            add.w   (A4),D7
            spl     D2
            cmp.w   D2,D7
            sgt     D1
            and.b   D2,D7
            or.b    D1,D7
            move.b  D7,D1
            move.b  (0,A3,D1.w),D0
            bfins   D0,D6{D5:D4}
            sub.b   (0,A5,D1.w),D7
            ext.w   D7
            asr.w   #1,D7
            move.w  D7,(A4)
            sub.w   D4,D5
            bge.b   .L2
            moveq   #$20,D5
            move.l  D6,-(A2)
            cmpa.l  A2,A1
            bcs.b   .L1
            move.l  A4,(-$2A4,A6)
            bra.b   .L4
.L3:
            move.w  (A0)+,D3
            lsl.l   #3,D3
            move.b  D3,D2
            lsl.w   #5,D2
            move.b  D3,D2
            lsr.w   #5,D2
            lsr.l   #5,D3
            move.b  D3,D1
            lsl.w   #5,D1
            move.b  D3,D1
            lsr.w   #5,D1
            lsr.l   #5,D3
            move.b  D3,D0
            lsl.w   #5,D0
            move.b  D3,D0
            lsr.w   #5,D0
            move.w  D0,D3
            add.w   D1,D3
            add.w   D2,D3
            add.w   D2,D3
            lsr.w   #2,D3
            add.w   D0,D3
            add.w   D1,D3
            add.w   D1,D3
            lsr.w   #2,D3
            add.w   D3,D7
            add.w   (A4),D7
            spl     D2
            cmp.w   D2,D7
            sgt     D1
            and.b   D2,D7
            or.b    D1,D7
            move.b  D7,D1
            move.b  (0,A3,D1.w),D0
            bfins   D0,D6{D5:D4}
            sub.b   (0,A5,D1.w),D7
            ext.w   D7
            asr.w   #1,D7
            move.w  D7,(A4)+
            add.w   D4,D5
            andi.w  #$1F,D5
            bne.b   .L3
            move.l  D6,(A1)+
            cmpa.l  A2,A1
            bcs.b   .L3
            move.l  A4,(-$2A4,A6)
            move.l  A0,(-$2A8,A6)
.L4:
            movem.l (SP)+,D6-D7/A3/A5
            rts
SCALE32TOINDEXED:
            movem.l D6-D7/A3/A5,-(SP)
            moveq   #0,D2
            movea.l (-$28C,A6),A3
            move.w  (-$29E,A6),D1
            moveq   #8,D3
            move.w  D3,D7
            sub.w   D1,D7
            move.l  (A0)+,D5
            bra.b   .L2
.L1:
            move.l  (A0)+,D5
            cmpa.l  D5,A5
            beq.b   .L3
.L2:
            movea.l D5,A5
            moveq   #0,D0
            move.w  D5,D3
            swap    D5
            move.b  D5,D0
            lsl.l   D1,D0
            lsr.l   #8,D3
            move.b  D3,D0
            lsl.l   D1,D0
            swap    D5
            move.b  D5,D0
            lsr.l   D7,D0
            move.b  (0,A3,D0.w),D0
.L3:
            bfins   D0,D6{D2:D4}
            add.w   D4,D2
            andi.w  #$1F,D2
            bne.b   .L1
            move.l  D6,(A1)+
            cmpa.l  A2,A1
            bcs.b   .L1
            movem.l (SP)+,D6-D7/A3/A5
            rts
            ds.b    14
SCALE32TOGRAY:
            movem.l D6/A3/A5,-(SP)
            moveq   #0,D5
            moveq   #0,D0
            moveq   #0,D1
            moveq   #0,D2
            movea.l (-$290,A6),A3
            move.l  (A0)+,D3
            bra.b   .L2
.L1:
            move.l  (A0)+,D3
            cmpa.l  D3,A5
            beq.b   .L3
.L2:
            movea.l D3,A5
            move.b  D3,D2
            lsr.l   #8,D3
            move.b  D3,D1
            lsr.w   #8,D3
            move.b  D3,D0
            add.w   D1,D3
            add.w   D2,D3
            add.w   D2,D3
            lsr.w   #2,D3
            add.w   D0,D3
            add.w   D1,D3
            add.w   D1,D3
            lsr.w   #2,D3
            move.b  (0,A3,D3.w),D0
.L3:
            bfins   D0,D6{D5:D4}
            add.w   D4,D5
            andi.w  #$1F,D5
            bne.b   .L1
            move.l  D6,(A1)+
            cmpa.l  A2,A1
            bcs.b   .L1
            movem.l (SP)+,D6/A3/A5
            rts
            ds.b    14
SCALE32TOBITMAP:
            movem.l D6/A3/A5,-(SP)
            moveq   #0,D5
            moveq   #0,D0
            moveq   #0,D1
            moveq   #0,D2
            move.l  (A0)+,D3
            bra.b   .L2
.L1:
            move.l  (A0)+,D3
            cmpa.l  D3,A5
            beq.b   .L3
.L2:
            movea.l D3,A5
            move.b  D3,D2
            lsr.l   #8,D3
            move.b  D3,D1
            lsr.w   #8,D3
            move.b  D3,D0
            add.w   D1,D3
            add.w   D2,D3
            add.w   D2,D3
            lsr.w   #2,D3
            add.w   D0,D3
            add.w   D1,D3
            add.w   D1,D3
            lsr.w   #2,D3
            tst.b   D3
            spl     D0
.L3:
            bfins   D0,D6{D5:D4}
            add.w   D4,D5
            andi.w  #$1F,D5
            bne.b   .L1
            move.l  D6,(A1)+
            cmpa.l  A2,A1
            bcs.b   .L1
            movem.l (SP)+,D6/A3/A5
            rts
            dc.w    0
SCALE16TOGRAY:
            movem.l D6/A3/A5,-(SP)
            moveq   #0,D5
            moveq   #0,D0
            moveq   #0,D1
            moveq   #0,D2
            movea.l (-$290,A6),A3
            move.w  (A0)+,D3
            bra.b   .L2
.L1:
            move.w  (A0)+,D3
            cmpa.w  D3,A5
            beq.b   .L3
.L2:
            movea.w D3,A5
            lsl.l   #3,D3
            move.b  D3,D2
            lsl.w   #5,D2
            move.b  D3,D2
            lsr.w   #5,D2
            lsr.l   #5,D3
            move.b  D3,D1
            lsl.w   #5,D1
            move.b  D3,D1
            lsr.w   #5,D1
            lsr.l   #5,D3
            move.b  D3,D0
            lsl.w   #5,D0
            move.b  D3,D0
            lsr.w   #5,D0
            move.w  D0,D3
            add.w   D1,D3
            add.w   D2,D3
            add.w   D2,D3
            lsr.w   #2,D3
            add.w   D0,D3
            add.w   D1,D3
            add.w   D1,D3
            lsr.w   #2,D3
            move.b  (0,A3,D3.w),D0
.L3:
            bfins   D0,D6{D5:D4}
            add.w   D4,D5
            andi.w  #$1F,D5
            bne.b   .L1
            move.l  D6,(A1)+
            cmpa.l  A2,A1
            bcs.b   .L1
            movem.l (SP)+,D6/A3/A5
            rts
            ds.b    8
SCALE16TOBITMAP:
            movem.l D6/A3/A5,-(SP)
            moveq   #0,D5
            moveq   #0,D0
            moveq   #0,D1
            moveq   #0,D2
            move.w  (A0)+,D3
            bra.b   .L2
.L1:
            move.w  (A0)+,D3
            cmpa.w  D3,A5
            beq.b   .L3
.L2:
            movea.w D3,A5
            lsl.l   #3,D3
            move.b  D3,D2
            lsl.w   #5,D2
            move.b  D3,D2
            lsr.w   #5,D2
            lsr.l   #5,D3
            move.b  D3,D1
            lsl.w   #5,D1
            move.b  D3,D1
            lsr.w   #5,D1
            lsr.l   #5,D3
            move.b  D3,D0
            lsl.w   #5,D0
            move.b  D3,D0
            lsr.w   #5,D0
            move.w  D0,D3
            add.w   D1,D3
            add.w   D2,D3
            add.w   D2,D3
            lsr.w   #2,D3
            add.w   D0,D3
            add.w   D1,D3
            add.w   D1,D3
            lsr.w   #2,D3
            tst.b   D3
            spl     D0
.L3:
            bfins   D0,D6{D5:D4}
            add.w   D4,D5
            andi.w  #$1F,D5
            bne.b   .L1
            move.l  D6,(A1)+
            cmpa.l  A2,A1
            bcs.b   .L1
            movem.l (SP)+,D6/A3/A5
            rts
            ds.b    12
SEARCH32TOINDEXED:
            movem.l D6-D7/A3-A5,-(SP)
            movea.l A0,A4
            movea.l A1,A3
            movea.l (-$1D0,A6),A5
            moveq   #0,D0
            move.l  A2,D7
            jsr     ([$574.w])
            movea.l D7,A2
            moveq   #0,D7
            clr.l   -(SP)
            clr.l   -(SP)
            clr.w   -(SP)
.L1:
            move.l  (A4)+,D5
            move.b  D5,(4,SP)
            move.b  D5,(5,SP)
            ror.l   #8,D5
            move.b  D5,(2,SP)
            move.b  D5,(3,SP)
            ror.l   #8,D5
            move.b  D5,(SP)
            move.b  D5,(1,SP)
            move.l  (-$294,A6),(-$298,A6)
.L2:
            move.l  (-$298,A6),D0
            beq.b   .L3
            movea.l D0,A0
            movea.l (A0),A0
            move.l  (A0),(-$298,A6)
            clr.b   -(SP)
            pea     (2,SP)
            pea     ($C,SP)
            movea.l (4,A0),A0
            jsr     (A0)
            tst.b   (SP)+
            beq.b   .L2
            move.l  (6,SP),D3
            bra.b   .L4
.L3:
            movea.l (-$28C,A6),A0
            move.w  (-$29E,A6),D1
            bfextu  D5{8:D1},D0
            lsl.l   D1,D0
            bfextu  D5{16:D1},D3
            or.l    D3,D0
            lsl.l   D1,D0
            bfextu  D5{24:D1},D3
            or.l    D3,D0
            move.b  (0,A0,D0.l),D3
.L4:
            bfins   D3,D6{D7:D4}
            add.w   D4,D7
            andi.w  #$1F,D7
            bne.b   .L1
            move.l  D6,(A3)+
            cmpa.l  A2,A3
            bcs.b   .L1
            moveq   #1,D0
            jsr     ([$574.w])
            lea     ($A,SP),SP
            movem.l (SP)+,D6-D7/A3-A5
            rts
            dc.w    0
SCALE32TO16:
            move.l  A2,D2
            sub.l   A1,D2
            lsr.l   #2,D2
            subq.w  #1,D2
.L1:
            move.l  (A0)+,D0
            ror.l   #8,D0
            lsr.w   #3,D0
            ror.l   #5,D0
            lsr.w   #3,D0
            ror.l   #6,D0
            move.l  (A0)+,D1
            ror.l   #8,D1
            lsr.w   #3,D1
            ror.l   #5,D1
            lsr.w   #3,D1
            ror.l   #6,D1
            swap    D1
            move.w  D1,D0
            move.l  D0,(A1)+
            dbra    D2,.L1
            rts
            ds.b    4
SEARCH32TO16:
            movem.l D7/A3-A5,-(SP)
            movea.l A0,A4
            movea.l A1,A3
            movea.l (-$1D0,A6),A5
            moveq   #0,D0
            move.l  A2,D7
            jsr     ([$574.w])
            movea.l D7,A2
            clr.l   -(SP)
            clr.l   -(SP)
            clr.w   -(SP)
            bra.b   sub_40839AB0.L3
sub_40839AB0:
            move.l  (A4)+,D5
            move.b  D5,(8,SP)
            ror.l   #8,D5
            move.b  D5,(6,SP)
            ror.l   #8,D5
            move.b  D5,(4,SP)
            move.l  (-$294,A6),(-$298,A6)
.L1:
            move.l  (-$298,A6),D0
            beq.b   .L2
            movea.l D0,A0
            movea.l (A0),A0
            move.l  (A0),(-$298,A6)
            clr.b   -(SP)
            pea     (6,SP)
            pea     ($10,SP)
            movea.l (4,A0),A0
            jsr     (A0)
            tst.b   (SP)+
            beq.b   .L1
            move.l  ($A,SP),D0
            rts
.L2:
            move.l  (-4,A4),D0
            ror.l   #8,D0
            lsr.w   #3,D0
            ror.l   #5,D0
            lsr.w   #3,D0
            ror.l   #6,D0
            swap    D0
            rts
.L3:
            bsr.b   sub_40839AB0
            move.w  D0,D7
            swap    D7
            bsr.b   sub_40839AB0
            move.w  D0,D7
            move.l  D7,(A3)+
            cmpa.l  A2,A3
            bcs.b   .L3
            moveq   #1,D0
            jsr     ([$574.w])
            lea     ($A,SP),SP
            movem.l (SP)+,D7/A3-A5
            rts
            ds.b    12
SCALE16TOINDEXED:
            movem.l D6-D7/A3/A5,-(SP)
            moveq   #0,D2
            movea.l (-$28C,A6),A3
            move.w  (-$29E,A6),D1
            move.l  (A0)+,D5
            bra.b   .L2
.L1:
            move.l  (A0)+,D5
            cmpa.l  D5,A5
            beq.b   .L3
.L2:
            movea.l D5,A5
            bfextu  D5{1:D1},D0
            lsl.l   D1,D0
            bfextu  D5{6:D1},D3
            or.l    D3,D0
            lsl.l   D1,D0
            bfextu  D5{11:D1},D3
            or.l    D3,D0
            move.b  (0,A3,D0.w),D0
            bfextu  D5{17:D1},D7
            lsl.l   D1,D7
            bfextu  D5{22:D1},D3
            or.l    D3,D7
            lsl.l   D1,D7
            bfextu  D5{27:D1},D3
            or.l    D3,D7
            move.b  (0,A3,D7.w),D7
.L3:
            bfins   D0,D6{D2:D4}
            add.w   D4,D2
            bfins   D7,D6{D2:D4}
            add.w   D4,D2
            andi.w  #$1F,D2
            bne.b   .L1
            move.l  D6,(A1)+
            cmpa.l  A2,A1
            bcs.b   .L1
            movem.l (SP)+,D6-D7/A3/A5
            rts
            ds.b    8
SEARCH16TOINDEXED:
            movem.l D6-D7/A3-A5,-(SP)
            movea.l A0,A4
            movea.l A1,A3
            movea.l (-$1D0,A6),A5
            moveq   #0,D0
            move.l  A2,D7
            jsr     ([$574.w])
            movea.l D7,A2
            moveq   #0,D7
            clr.l   -(SP)
            clr.l   -(SP)
            clr.w   -(SP)
.L1:
            move.w  (A4)+,D5
            lsl.l   #3,D5
            move.b  D5,D0
            lsl.l   #5,D0
            move.b  D5,D0
            lsl.l   #5,D0
            move.b  D5,D0
            lsl.l   #5,D0
            move.b  D5,D0
            lsr.l   #7,D0
            move.w  D0,(4,SP)
            lsr.l   #5,D5
            move.b  D5,D0
            lsl.l   #5,D0
            move.b  D5,D0
            lsl.l   #5,D0
            move.b  D5,D0
            lsl.l   #5,D0
            move.b  D5,D0
            lsr.l   #7,D0
            move.w  D0,(2,SP)
            lsr.l   #5,D5
            move.b  D5,D0
            lsl.l   #5,D0
            move.b  D5,D0
            lsl.l   #5,D0
            move.b  D5,D0
            lsl.l   #5,D0
            move.b  D5,D0
            lsr.l   #7,D0
            move.w  D0,(SP)
            move.l  (-$294,A6),(-$298,A6)
.L2:
            move.l  (-$298,A6),D0
            beq.b   .L3
            movea.l D0,A0
            movea.l (A0),A0
            move.l  (A0),(-$298,A6)
            clr.b   -(SP)
            pea     (2,SP)
            pea     ($C,SP)
            movea.l (4,A0),A0
            jsr     (A0)
            tst.b   (SP)+
            beq.b   .L2
            move.l  (6,SP),D3
            bra.b   .L4
.L3:
            movea.l (-$28C,A6),A0
            move.w  (-$29E,A6),D1
            bfextu  D5{17:D1},D0
            lsl.l   D1,D0
            bfextu  D5{22:D1},D3
            or.l    D3,D0
            lsl.l   D1,D0
            bfextu  D5{27:D1},D3
            or.l    D3,D0
            move.b  (0,A0,D0.w),D0
.L4:
            bfins   D0,D6{D7:D4}
            add.w   D4,D7
            andi.w  #$1F,D7
            bne.w   .L1
            move.l  D6,(A3)+
            cmpa.l  A2,A3
            bcs.w   .L1
            moveq   #1,D0
            jsr     ([$574.w])
            lea     ($A,SP),SP
            movem.l (SP)+,D6-D7/A3-A5
            rts
            ds.b    8
SCALE16TO32:
            move.l  A2,D4
            sub.l   A1,D4
            lsr.l   #3,D4
            subq.w  #1,D4
            bmi.b   sub_40839CF0
            move.l  (A0)+,D5
            bra.b   .L2
.L1:
            move.l  (A0)+,D5
            cmp.l   D0,D5
            beq.b   .L3
.L2:
            move.l  D5,D0
            moveq   #0,D3
            move.w  D5,D1
            lsr.w   #7,D1
            move.b  D1,D3
            lsl.l   #5,D3
            move.b  D1,D3
            lsl.l   #3,D3
            move.w  D5,D1
            lsr.w   #2,D1
            move.b  D1,D3
            lsl.l   #5,D3
            move.b  D1,D3
            lsl.l   #3,D3
            move.b  D5,D1
            lsl.b   #3,D1
            move.b  D1,D3
            lsl.l   #5,D3
            move.b  D1,D3
            lsr.l   #5,D3
            swap    D5
            moveq   #0,D2
            move.w  D5,D1
            lsr.w   #7,D1
            move.b  D1,D2
            lsl.l   #5,D2
            move.b  D1,D2
            lsl.l   #3,D2
            move.w  D5,D1
            lsr.w   #2,D1
            move.b  D1,D2
            lsl.l   #5,D2
            move.b  D1,D2
            lsl.l   #3,D2
            lsl.b   #3,D5
            move.b  D5,D2
            lsl.l   #5,D2
            move.b  D5,D2
            lsr.l   #5,D2
.L3:
            move.l  D2,(A1)+
            move.l  D3,(A1)+
            dbra    D4,.L1
            cmpa.l  A1,A2
            bne.b   sub_40839CF0
            rts
sub_40839CF0:
            move.w  (A0)+,D5
            moveq   #0,D2
            move.w  D5,D1
            lsr.w   #7,D1
            move.b  D1,D2
            lsl.l   #5,D2
            move.b  D1,D2
            lsl.l   #3,D2
            move.w  D5,D1
            lsr.w   #2,D1
            move.b  D1,D2
            lsl.l   #5,D2
            move.b  D1,D2
            lsl.l   #3,D2
            lsl.b   #3,D5
            move.b  D5,D2
            lsl.l   #5,D2
            move.b  D5,D2
            lsr.l   #5,D2
            move.l  D2,(A1)
            rts
            ds.b    6
SEARCH16TO32:
            movem.l D7/A3-A5,-(SP)
            movea.l A0,A4
            movea.l A1,A3
            movea.l (-$1D0,A6),A5
            moveq   #0,D0
            move.l  A2,D7
            jsr     ([$574.w])
            movea.l D7,A2
            clr.l   -(SP)
            clr.l   -(SP)
            clr.w   -(SP)
.L1:
            move.w  (A4)+,D5
            move.w  D5,D0
            lsl.l   #3,D0
            move.b  D0,(4,SP)
            clr.b   D0
            lsr.l   #5,D0
            move.b  D0,(2,SP)
            clr.b   D0
            lsr.l   #5,D0
            move.b  D0,(SP)
            move.l  (-$294,A6),(-$298,A6)
.L2:
            move.l  (-$298,A6),D0
            beq.b   .L3
            movea.l D0,A0
            movea.l (A0),A0
            move.l  (A0),(-$298,A6)
            clr.b   -(SP)
            pea     (2,SP)
            pea     ($C,SP)
            movea.l (4,A0),A0
            jsr     (A0)
            tst.b   (SP)+
            beq.b   .L2
            move.l  (6,SP),D3
            bra.b   .L4
.L3:
            moveq   #0,D3
            move.w  D5,D1
            lsr.w   #7,D1
            move.b  D1,D3
            lsl.l   #5,D3
            move.b  D1,D3
            lsl.l   #3,D3
            move.w  D5,D1
            lsr.w   #2,D1
            move.b  D1,D3
            lsl.l   #5,D3
            move.b  D1,D3
            lsl.l   #3,D3
            move.b  D5,D1
            lsl.b   #3,D1
            move.b  D1,D3
            lsl.l   #5,D3
            move.b  D1,D3
            lsr.l   #5,D3
.L4:
            move.l  D3,(A3)+
            cmpa.l  A2,A3
            bcs.b   .L1
            moveq   #1,D0
            jsr     ([$574.w])
            lea     ($A,SP),SP
            movem.l (SP)+,D7/A3-A5
            rts
            ds.b    14
SCALEBLT:
            move.l  SP,(-$258,A6)
            move.l  D0,(-$208,A6)
            move.l  D1,(-$20C,A6)
            movea.l ($594).w,A0
            jsr     (A0)
            lsr.l   #2,D0
            subi.l  #$640,D0
            move.l  D0,(-$84,A6)
            bpl.b   .L1
            jsr     ([$1C5C.w])
.L1:
            move.w  (-$14A,A6),D0
            beq.w   .L10
            cmpi.w  #$10,D0
            bne.w   .L26
            clr.l   (-$2A4,A6)
            move.w  D4,D5
            lsl.w   #3,D5
            cmpi.w  #4,D3
            beq.b   .L2
            bset    #2,D5
.L2:
            movea.l ([TheGDevice.w]),A2
            cmpi.w  #$10,(-$D6,A6)
            beq.w   .L9
            movea.l ([$16.w,A2]),A1
            movea.l ($2A,A1),A0
            move.l  ([A0]),D1
            movea.l ([6.w,A2]),A0
            cmp.l   (A0),D1
            beq.b   .L4
            move.l  ($2A,A1),-(SP)
            move.l  (6,A2),-(SP)
            move.w  ($A,A2),-(SP)
            jsr     ([$16E4.w])
            tst.w   QDErr
            beq.b   .L3
            addq.w  #4,SP
            bra.w   .L26
.L3:
            movea.l ([TheGDevice.w]),A2
            movea.l ([6.w,A2]),A0
.L4:
            addq.w  #6,A0
            move.l  A0,(-$28C,A6)
            subq.w  #6,A0
            move.w  (4,A0),(-$29E,A6)
            movea.l ([$16.w,A2]),A1
            move.l  ([$2A.w,A1]),(-$29C,A6)
            moveq   #1,D0
            move.w  (4,A0),D2
            lsl.l   D2,D0
            lsl.l   D2,D0
            lsl.l   D2,D0
            lea     (6,A0,D0.l),A1
            tst.w   (2,A1)
            bpl.b   .L5
            addq.w  #6,A1
            move.l  A1,(-$290,A6)
            addq.w  #2,D5
            moveq   #$28,D0
            cmp.l   (A0),D0
            beq.b   .L9
.L5:
            tst.b   (-$A5,A6)
            beq.b   .L9
            addq.w  #1,D5
            moveq   #0,D0
            move.w  (-$206,A6),D0
            lsl.l   D4,D0
            addi.l  #$80,D0
            lsr.l   D4,D0
            btst    #1,D5
            bne.b   .L6
            move.w  D0,D1
            add.w   D0,D0
            add.w   D1,D0
.L6:
            lsr.w   #1,D0
            sub.l   D0,(-$84,A6)
            bpl.b   .L7
            jsr     ([$1C5C.w])
.L7:
            clr.l   -(SP)
.L8:
            clr.l   -(SP)
            dbra    D0,.L8
            move.l  SP,(-$2A4,A6)
            clr.b   (-$2A9,A6)
.L9:
            move.w  D5,D0
            lsr.w   #3,D0
            lea     ($1CC8.w,D0.w*4),A0
            movea.l (A0),A0
            andi.w  #7,D5
            adda.l  (0,A0,D5.w*4),A0
            move.l  A0,(-$228,A6)
            bra.w   .L17
.L10:
            move.w  D4,D5
            lsl.w   #2,D5
            or.w    D3,D5
            move.w  (-$148,A6),D1
            moveq   #1,D0
            lsl.w   D1,D0
            sub.l   D0,(-$84,A6)
            bpl.b   .L11
            jsr     ([$1C5C.w])
.L11:
            moveq   #0,D7
            cmpi.w  #1,(-$D4,A6)
            bne.b   .L12
            movea.l ($28,A6),A1
            tst.w   (4,A1)
            bmi.b   .L12
            moveq   #1,D7
            pea     ONEBITPROC
            jsr     ([$16E8.w])
.L12:
            movea.l (-$1D0,A6),A5
            move.l  A4,-(SP)
            move.w  #$20,-(SP)
            jsr     ([$1A38.w])
            move.w  (-$148,A6),D1
            cmp.w   (-$D4,A6),D1
            bne.b   .L15
            moveq   #1,D0
            lsl.w   D1,D0
            move.w  D0,D1
            lsl.w   #2,D1
            subq.w  #1,D0
            movea.l SP,A0
            adda.w  D1,A0
.L13:
            cmp.l   -(A0),D0
            dbne    D0,.L13
            bne.b   .L15
            tst.w   D7
            beq.b   .L14
            pea     ONEBITPROC
            jsr     ([$1730.w])
.L14:
            lea     (-$F4,A6),A5
            move.l  (-$1C8,A6),D7
            moveq   #0,D0
            bra.w   .L27
.L15:
            move.l  SP,(-$23C,A6)
            lea     (-$F4,A6),A5
            tst.w   D7
            beq.b   .L16
            pea     ONEBITPROC
            jsr     ([$1730.w])
.L16:
            move.w  D5,D0
            lsr.w   #2,D0
            lea     ($1CB0.w,D0.w*4),A0
            movea.l (A0),A0
            andi.w  #3,D5
            adda.l  (0,A0,D5.w*4),A0
            move.l  A0,(-$228,A6)
.L17:
            moveq   #$A,D0
            movea.l ($A,A6),A0
            movea.l (A0),A0
            cmp.w   (A0),D0
            beq.w   .L18
            move.l  ($A,A6),-(SP)
            pea     (-$74,A6)
            move.w  #$FFFF,-(SP)
            jsr     ([$1AA4.w])
            blt.w   .L26
            bgt.b   .L18
            movea.l (-$1D0,A6),A1
            movea.l (A1),A1
            move.l  (-$82,A1),($A,A6)
.L18:
            movea.l ($E,A6),A0
            movea.l (A0),A0
            cmp.w   (A0),D0
            beq.b   .L19
            move.l  ($E,A6),-(SP)
            pea     (-$74,A6)
            move.w  #$FFFF,-(SP)
            jsr     ([$1AA4.w])
            blt.w   .L26
            bgt.w   .L19
            movea.l (-$1D0,A6),A1
            movea.l (A1),A1
            move.l  (-$82,A1),($E,A6)
.L19:
            movea.l ($12,A6),A0
            movea.l (A0),A0
            cmp.w   (A0),D0
            beq.b   .L20
            move.l  ($12,A6),-(SP)
            pea     (-$74,A6)
            move.w  #$FFFF,-(SP)
            jsr     ([$1AA4.w])
            blt.w   .L26
            bgt.b   .L20
            movea.l (-$1D0,A6),A1
            movea.l (A1),A1
            move.l  (-$82,A1),($12,A6)
.L20:
            move.w  (-$72,A6),D1
            sub.w   (8,A5),D1
            ext.l   D1
            lsl.l   D4,D1
            andi.w  #$FFE0,D1
            asr.l   D4,D1
            add.w   (8,A5),D1
            move.w  D1,(-$E,A6)
            moveq   #0,D0
            move.w  (-$6E,A6),D0
            sub.w   D1,D0
            move.l  D0,D1
            lsl.l   D4,D1
            subq.l  #1,D1
            lsr.l   #5,D1
            move.w  D1,(-$10,A6)
            lsr.l   #5,D0
            addq.l  #1,D0
            sub.l   D0,(-$84,A6)
            bpl.b   .L21
            jsr     ([$1C5C.w])
.L21:
            clr.l   -(SP)
            clr.l   -(SP)
.L22:
            clr.l   -(SP)
            dbra    D0,.L22
            move.l  SP,(-8,A6)
            moveq   #-1,D0
            move.l  D0,(-$C,A6)
            move.l  ($A,A6),-(SP)
            move.l  ($E,A6),-(SP)
            move.l  ($12,A6),-(SP)
            move.l  #2,-(SP)
            jsr     ([$1A34.w])
            tst.l   (-$2A4,A6)
            beq.b   .L23
            jsr     ([$1C50.w])
            move.l  A0,(-$2C0,A6)
.L23:
            moveq   #1,D0
            jsr     ([$574.w])
            move.b  D0,(-$102,A6)
            move.w  (-$1C2,A6),D3
            movea.l ($24,A6),A2
            movea.l ($1C,A6),A3
            move.l  (-$1BC,A6),D2
            move.w  (-$72,A6),D1
            sub.w   (2,A3),D1
            add.w   (2,A2),D1
            sub.w   (-$160,A6),D1
            ext.l   D1
            lsl.l   D3,D1
            moveq   #$1F,D5
            and.l   D1,D5
            move.l  D5,(-$230,A6)
            move.w  (-$74,A6),D0
            sub.w   (A3),D0
            add.w   (A2),D0
            sub.w   (-$162,A6),D0
            muls.w  D2,D0
            add.l   (-$168,A6),D0
            sub.l   D5,D1
            asr.l   #3,D1
            add.l   D1,D0
            move.l  D0,(-$1F8,A6)
            move.w  (-$76,A6),D4
            move.l  (-$7C,A6),D2
            move.w  (-$72,A6),D1
            sub.w   (8,A5),D1
            ext.l   D1
            lsl.l   D4,D1
            moveq   #$1F,D6
            and.l   D1,D6
            neg.l   D6
            move.l  D6,(-$234,A6)
            move.w  (-$74,A6),D0
            move.w  D0,(-4,A6)
            sub.w   (6,A5),D0
            muls.w  D2,D0
            add.l   (A5),D0
            asr.l   #5,D1
            lsl.l   #2,D1
            add.l   D1,D0
            move.l  D0,(-$200,A6)
            movea.l (-$200,A6),A5
            movea.l (-$1F8,A6),A4
            move.w  #4,(-$78,A6)
            move.w  (-$148,A6),D4
            move.w  (-$D4,A6),D5
.L24:
            move.w  (-$70,A6),D2
            sub.w   (-4,A6),D2
            ble.b   .L26
            move.w  D2,D3
            jsr     ([-$1C.w,A6])
            move.w  D2,D1
            cmp.w   D3,D1
            ble.b   .L25
            move.w  D3,D1
.L25:
            jsr     ([-$18.w,A6])
            movea.l (-$2BC,A6),A3
            movea.l (-$228,A6),A2
            jmp     (A2)
.L26:
            moveq   #1,D0
.L27:
            movea.l (-$258,A6),SP
            rts
            move.w  (-$1C2,A6),D7
            movea.l (-$23C,A6),A3
            lea     .L29,A0
            move.l  A3,(-$2BC,A6)
            move.l  A0,(-$228,A6)
            bra.b   .L29
.L28:
            move.l  (-$7C,A6),D2
            adda.l  D2,A5
            move.l  (-$1BC,A6),D2
            adda.l  D2,A4
            addq.w  #1,(-4,A6)
            subq.w  #1,D1
            ble.b   .L24
.L29:
            move.l  (-$230,A6),D6
            movea.l A4,A0
            movea.l A5,A2
            movea.l (-$C,A6),A1
.L30:
            move.l  (A1)+,D3
            bmi.b   .L28
            adda.w  D3,A2
            lsr.w   #2,D3
            lsl.w   D7,D3
            add.w   D3,D6
            move.w  D6,D3
            lsr.w   #5,D3
            lea     (0,A0,D3.w*4),A0
            swap    D3
.L31:
            move.l  (A0)+,D5
.L32:
            bfextu  D5{D6:D4},D0
            move.l  (0,A3,D0.w*4),(A2)+
            add.w   D4,D6
            andi.w  #$1F,D6
            dbeq    D3,.L32
            dbne    D3,.L31
            beq.b   .L30
            subq.w  #4,A0
            bra.b   .L30
            move.w  (-$29E,A6),D6
            moveq   #8,D7
            sub.w   D6,D7
            move.l  (-$234,A6),D0
            asr.l   #1,D0
            adda.l  D0,A4
            movea.l (-$28C,A6),A3
            lea     .L34,A0
            move.l  A3,(-$2BC,A6)
            move.l  A0,(-$228,A6)
            bra.b   .L34
.L33:
            move.l  (-$7C,A6),D2
            adda.l  D2,A5
            move.l  (-$1BC,A6),D2
            adda.l  D2,A4
            addq.w  #1,(-4,A6)
            swap    D1
            subq.w  #1,D1
            ble.w   .L24
.L34:
            movea.l A4,A0
            movea.l A5,A2
            movea.l (-$C,A6),A1
            swap    D1
.L35:
            move.w  #3,D1
            move.l  (A1)+,D3
            bmi.b   .L33
            adda.w  D3,A2
            lea     (0,A0,D3.w*4),A0
            swap    D3
            bclr    #$E,D3
            beq.b   .L40
            move.l  (A0)+,D5
            bra.b   .L38
.L36:
            move.w  #3,D1
.L37:
            move.l  (A0)+,D5
            cmp.l   D5,D4
            beq.b   .L39
.L38:
            moveq   #0,D2
            move.w  D5,D4
            swap    D5
            move.b  D5,D2
            lsl.l   D6,D2
            lsr.l   #8,D4
            move.b  D4,D2
            lsl.l   D6,D2
            swap    D5
            move.b  D5,D2
            lsr.l   D7,D2
            move.l  D5,D4
            move.b  (0,A3,D2.w),D2
.L39:
            lsl.l   #8,D0
            move.b  D2,D0
            dbra    D1,.L37
            move.l  (A1)+,D5
            and.l   D5,D0
            not.l   D5
            and.l   (A2),D5
            or.l    D5,D0
            move.l  D0,(A2)+
            dbra    D3,.L36
            bra.b   .L35
.L40:
            move.l  (A0)+,D5
            bra.b   .L43
.L41:
            move.w  #3,D1
.L42:
            move.l  (A0)+,D5
            cmp.l   D5,D4
            beq.b   .L44
.L43:
            moveq   #0,D2
            move.w  D5,D4
            swap    D5
            move.b  D5,D2
            lsl.l   D6,D2
            lsr.l   #8,D4
            move.b  D4,D2
            lsl.l   D6,D2
            swap    D5
            move.b  D5,D2
            lsr.l   D7,D2
            move.l  D5,D4
            move.b  (0,A3,D2.w),D2
.L44:
            lsl.l   #8,D0
            move.b  D2,D0
            dbra    D1,.L42
            move.l  D0,(A2)+
            dbra    D3,.L41
            bra.w   .L35
            moveq   #0,D4
            move.l  D4,D6
            move.l  D4,D7
            move.l  (-$234,A6),D0
            asr.l   #1,D0
            adda.l  D0,A4
            movea.l (-$290,A6),A3
            lea     .L46,A0
            move.l  A3,(-$2BC,A6)
            move.l  A0,(-$228,A6)
            bra.b   .L46
.L45:
            move.l  (-$7C,A6),D2
            adda.l  D2,A5
            move.l  (-$1BC,A6),D2
            adda.l  D2,A4
            addq.w  #1,(-4,A6)
            swap    D1
            subq.w  #1,D1
            ble.w   .L24
.L46:
            movea.l A4,A0
            movea.l A5,A2
            movea.l (-$C,A6),A1
            swap    D1
.L47:
            move.w  #3,D1
            move.l  (A1)+,D3
            bmi.b   .L45
            adda.w  D3,A2
            lsl.w   #2,D3
            adda.w  D3,A0
            swap    D3
            bclr    #$E,D3
            beq.b   .L52
            move.l  (A0)+,D5
            bra.b   .L50
.L48:
            move.w  #3,D1
.L49:
            move.l  (A0)+,D5
            cmp.l   D5,D2
            beq.b   .L51
.L50:
            move.l  D5,D2
            move.b  D5,D6
            lsr.l   #8,D5
            move.b  D5,D4
            lsr.w   #8,D5
            move.b  D5,D7
            add.w   D4,D5
            add.w   D6,D5
            add.w   D6,D5
            lsr.w   #2,D5
            add.w   D7,D5
            add.w   D4,D5
            add.w   D4,D5
            lsr.w   #2,D5
            move.b  (0,A3,D5.w),D7
.L51:
            lsl.l   #8,D0
            move.b  D7,D0
            dbra    D1,.L49
            move.l  (A1)+,D5
            and.l   D5,D0
            not.l   D5
            and.l   (A2),D5
            or.l    D5,D0
            move.l  D0,(A2)+
            dbra    D3,.L48
            bra.b   .L47
.L52:
            move.l  (A0)+,D5
            bra.b   .L55
.L53:
            move.w  #3,D1
.L54:
            move.l  (A0)+,D5
            cmp.l   D5,D2
            beq.b   .L56
.L55:
            move.l  D5,D2
            move.b  D5,D6
            lsr.l   #8,D5
            move.b  D5,D4
            lsr.w   #8,D5
            move.b  D5,D7
            add.w   D4,D5
            add.w   D6,D5
            add.w   D6,D5
            lsr.w   #2,D5
            add.w   D7,D5
            add.w   D4,D5
            add.w   D4,D5
            lsr.w   #2,D5
            move.b  (0,A3,D5.w),D7
.L56:
            lsl.l   #8,D0
            move.b  D7,D0
            dbra    D1,.L54
            move.l  D0,(A2)+
            dbra    D3,.L53
            bra.w   .L47
.L57:
            move.w  (-$70,A6),D2
            sub.w   (-4,A6),D2
            ble.w   .L26
            move.w  D2,D3
            jsr     ([-$1C.w,A6])
            move.w  D2,D1
            cmp.w   D3,D1
            ble.b   .L58
            move.w  D3,D1
.L58:
            move.l  (-$C,A6),D3
            move.w  #$FFFC,(-$78,A6)
            move.l  (-$2C0,A6),(-$C,A6)
            jsr     ([-$18.w,A6])
            move.l  D3,(-$C,A6)
            move.w  #4,(-$78,A6)
            jsr     ([-$18.w,A6])
            movea.l (-$2BC,A6),A3
            movea.l (-$228,A6),A2
            jmp     (A2)
            subq.w  #4,SP
            move.l  (-$234,A6),D0
            asr.l   #1,D0
            adda.l  D0,A4
            move.l  A4,(-$1F8,A6)
            movea.l (-$28C,A6),A3
            movea.l (-$29C,A6),A5
            moveq   #0,D4
            lea     sub_4083A430.L1,A0
            move.l  A3,(-$2BC,A6)
            move.l  A0,(-$228,A6)
            bra.b   .L57
sub_4083A430:
            move.l  (-$7C,A6),D2
            add.l   D2,(-$200,A6)
            move.l  (-$1BC,A6),D2
            add.l   D2,(-$1F8,A6)
            addq.w  #1,(-4,A6)
            subq.w  #1,(SP)
            move.w  (SP),D1
            ble.w   SCALEBLT.L57
.L1:
            movea.l (-$1F8,A6),A0
            movea.l (-$200,A6),A2
            movea.l (-$C,A6),A1
            move.w  D1,(SP)
            movea.l (-$2A4,A6),A4
            moveq   #0,D5
            move.l  D5,D6
            move.l  D5,D7
            move.w  (-$29E,A6),D7
            swap    D7
            not.b   (-$2A9,A6)
            bne.b   .L2
            movea.l (-$2C0,A6),A1
.L2:
            move.l  (A1)+,D3
            bmi.b   sub_4083A430
            adda.w  D3,A2
            add.w   D3,D3
            adda.w  D3,A4
            add.w   D3,D3
            adda.w  D3,A0
            adda.w  D3,A4
            swap    D3
            lsl.l   #2,D3
            lsr.w   #2,D3
            tst.b   (-$2A9,A6)
            bne.b   .L5
.L3:
            bsr.b   DitherCore8
            suba.w  #$30,A4
            suba.w  #$20,A0
            btst    #$10,D3
            beq.b   .L4
            move.l  (A1)+,D0
            and.l   D0,D2
            not.l   D0
            and.l   (A2),D0
            or.l    D0,D2
.L4:
            move.l  D2,(A2)
            subq.w  #4,A2
            dbra    D3,.L3
            bra.b   .L2
.L5:
            bsr.b   DitherCore8
            btst    #$10,D3
            beq.b   .L6
            move.l  (A1)+,D0
            and.l   D0,D2
            not.l   D0
            and.l   (A2),D0
            or.l    D0,D2
.L6:
            move.l  D2,(A2)+
            dbra    D3,.L5
            bra.b   .L2
DitherCore8:
            moveq   #3,D1
.L1:
            swap    D1
            move.l  (A0)+,D0
            move.b  D0,D4
            add.w   (4,A4),D7
            add.w   D4,D7
            spl     D4
            cmp.w   D4,D7
            sgt     D1
            and.w   D4,D7
            or.w    D1,D7
            lsr.w   #8,D0
            add.w   (2,A4),D6
            add.w   D0,D6
            spl     D4
            cmp.w   D4,D6
            sgt     D1
            and.w   D4,D6
            or.w    D1,D6
            swap    D0
            move.b  D0,D4
            add.w   (A4),D5
            add.w   D4,D5
            spl     D4
            cmp.w   D4,D5
            sgt     D1
            and.w   D4,D5
            or.w    D1,D5
            move.l  D7,D0
            swap    D0
            move.b  D5,D4
            lsl.l   D0,D4
            move.b  D6,D4
            lsl.l   D0,D4
            move.b  D7,D4
            neg.w   D0
            addq.w  #8,D0
            lsr.l   D0,D4
            move.b  (0,A3,D4.l),D1
            lsl.l   #8,D2
            move.b  D1,D2
            move.l  ($A,A5,D1.w*8),D0
            moveq   #0,D4
            lsr.l   #8,D0
            move.b  D0,D4
            sub.w   D4,D6
            swap    D0
            sub.w   D0,D5
            move.b  ($E,A5,D1.w*8),D4
            sub.w   D4,D7
            asr.w   #1,D5
            move.w  D5,(A4)+
            asr.w   #1,D6
            move.w  D6,(A4)+
            asr.w   #1,D7
            move.w  D7,(A4)+
            swap    D1
            dbra    D1,.L1
            rts
            dc.w    $6000,$FC40
SCDIRTAB1:
            dc.w    $FFFF,$FFFC,$FFFF,$FFFC,$FFFF,$FFFC,$FFFF,$FFFC
            dc.w    $FFFF,$FFFC,$FFFF,$FFFC,$FFFF,$FFFC,$FFFF,$FFFC
SCDIRTAB2:
            dc.w    $FFFF,$FFDC,$FFFF,$FFDC,$FFFF,$FFDC,$FFFF,$FFDC
            dc.w    $FFFF,$FFDC,$FFFF,$FFDC,$FFFF,$FFDC,$FFFF,$FFDC
SCDIRTAB4:
            dc.w    $FFFF,$FFBC,$FFFF,$FFBC,$FFFF,$FFBC,$FFFF,$FFBC
            dc.w    $FFFF,$FFBC,$FFFF,$FFBC,$FFFF,$FFBC,$FFFF,$FFBC
SCDIRTAB8:
            dc.w    $FFFF,$FF9C,$FFFF,$FF9C,$FFFF,$FF9C,$FFFF,$FF9C
            dc.w    $FFFF,$FC50,$FFFF,$FE56,$FFFF,$FD2A,$FFFF,$FD2A
SCDIRTAB16:
            dc.w    $FFFF,$FF7C,$FFFF,$FF7C,$FFFF,$FF7C,$FFFF,$FF7C
            dc.w    $FFFF,$FF7C,$FFFF,$FF7C,$FFFF,$FF7C,$FFFF,$FF7C
SCDIRTAB32:
            dc.w    $FFFF,$FF5C,$FFFF,$FF5C,$FFFF,$FF5C,$FFFF,$FF5C
            dc.w    $FFFF,$FF5C,$FFFF,$FF5C,$FFFF,$FF5C,$FFFF,$FF5C
SCINDTAB1:
            dc.w    $FFFF,$FF3C,$FFFF,$FF3C,$FFFF,$FF3C,$FFFF,$FF3C
SCINDTAB2:
            dc.w    $FFFF,$FF2C,$FFFF,$FF2C,$FFFF,$FF2C,$FFFF,$FF2C
SCINDTAB4:
            dc.w    $FFFF,$FF1C,$FFFF,$FF1C,$FFFF,$FF1C,$FFFF,$FF1C
SCINDTAB8:
            dc.w    $FFFF,$FF0C,$FFFF,$FF0C,$FFFF,$FF0C,$FFFF,$FF0C
SCINDTAB16:
            dc.w    $FFFF,$FEFC,$FFFF,$FEFC,$FFFF,$FEFC,$FFFF,$FEFC
SCINDTAB32:
            dc.w    $FFFF,$FB36,$FFFF,$FB36,$FFFF,$FB36,$FFFF,$FB36
            ds.b    12
ANDY:
CB1TO8CLIP:
            move.w  (-4,A6),D0
            cmp.w   (-$74,A6),D0
            blt.b   .L1
            jsr     ([-$1C.w,A6])
            bra.b   .L2
            move.l  (-$7C,A6),D0
            add.l   D0,(-$200,A6)
.L1:
            addq.w  #1,(-4,A6)
            move.w  (-4,A6),D0
            cmp.w   (-$70,A6),D0
            beq.w   DONESTRETCH
            move.l  (-$1BC,A6),D2
            add.l   D2,(-$1F8,A6)
            bra.b   ANDY
.L2:
            subq.w  #1,(-$10,A6)
            moveq   #0,D7
            movea.l (-$200,A6),A4
            movea.l (-8,A6),A2
.L3:
            move.l  (-$234,A6),D0
            asr.l   #3,D0
            moveq   #$F,D3
            moveq   #-1,D6
            lea     TABLE8,A1
            movea.l (-$1F8,A6),A3
            move.l  (-$230,A6),D5
            add.l   D0,D5
            bfextu  (A3){D5:16},D4
            addq.l  #4,D5
            rol.w   #4,D4
            move.l  (A2)+,D1
            move.w  D4,D0
            and.w   D3,D0
            move.l  (0,A1,D0.w*4),D0
            and.l   D1,D0
            not.l   D1
            and.l   (A4),D1
            or.l    D1,D0
            move.l  D0,(A4)+
            move.w  (-$10,A6),D2
            cmpi.w  #4,D2
            ble.w   .L10
            move.w  D2,D0
            andi.w  #3,D0
            bne.b   .L4
            subq.w  #1,D2
.L4:
            lsr.w   #2,D2
            subq.w  #1,D2
            tst.b   D7
            bne.w   .L31
            st      D7
.L5:
            bfextu  (A3){D5:16},D4
            addq.w  #2,A3
            beq.w   .L16
            rol.w   #4,D4
            lea     .L6,A5
            move.l  (A2)+,D1
            move.w  D4,D0
            and.w   D3,D0
            move.l  (0,A1,D0.w*4),D0
            cmp.l   D6,D1
            bne.w   .L14
            move.l  D0,(A4)+
.L6:
            lea     .L7,A5
            rol.w   #4,D4
            move.l  (A2)+,D1
            move.w  D4,D0
            and.w   D3,D0
            move.l  (0,A1,D0.w*4),D0
            cmp.l   D6,D1
            bne.b   .L14
            move.l  D0,(A4)+
.L7:
            lea     .L8,A5
            rol.w   #4,D4
            move.l  (A2)+,D1
            move.w  D4,D0
            and.w   D3,D0
            move.l  (0,A1,D0.w*4),D0
            cmp.l   D6,D1
            bne.b   .L14
            move.l  D0,(A4)+
.L8:
            lea     .L9,A5
            rol.w   #4,D4
            move.l  (A2)+,D1
            move.w  D4,D0
            and.w   D3,D0
            move.l  (0,A1,D0.w*4),D0
            cmp.l   D6,D1
            bne.b   .L14
            move.l  D0,(A4)+
.L9:
            dbra    D2,.L5
.L10:
            bfextu  (A3){D5:16},D4
            lea     .L12,A5
            move.w  (-$10,A6),D2
            beq.w   .L28
            andi.w  #3,D2
            bne.b   .L12
            moveq   #3,D2
.L11:
            rol.w   #4,D4
            move.l  (A2)+,D1
            move.w  D4,D0
            and.w   D3,D0
            move.l  (0,A1,D0.w*4),D0
            cmp.l   D6,D1
            bne.b   .L15
            move.l  D0,(A4)+
.L12:
            dbra    D2,.L11
            bra.b   .L28
.L13:
            addq.l  #4,A4
            RTS5
.L14:
            moveq   #0,D7
.L15:
            tst.l   D1
            beq.b   .L13
            and.l   D1,D0
            not.l   D1
            and.l   (A4),D1
            or.l    D1,D0
            move.l  D0,(A4)+
            RTS5
.L16:
            move.l  (A2)+,D1
            beq.b   .L20
            cmp.l   D6,D1
            bne.b   .L24
            clr.l   (A4)+
.L17:
            move.l  (A2)+,D1
            beq.b   .L21
            cmp.l   D6,D1
            bne.b   .L25
            clr.l   (A4)+
.L18:
            move.l  (A2)+,D1
            beq.b   .L22
            cmp.l   D6,D1
            bne.b   .L26
            clr.l   (A4)+
.L19:
            move.l  (A2)+,D1
            beq.b   .L23
            cmp.l   D6,D1
            bne.b   .L27
            clr.l   (A4)+
            bra.b   .L9
.L20:
            moveq   #0,D7
            addq.w  #4,A4
            bra.b   .L17
.L21:
            moveq   #0,D7
            addq.w  #4,A4
            bra.b   .L18
.L22:
            moveq   #0,D7
            addq.w  #4,A4
            bra.b   .L19
.L23:
            moveq   #0,D7
            addq.w  #4,A4
            bra.w   .L9
.L24:
            moveq   #0,D7
            not.l   D1
            and.l   D1,(A4)+
            bra.b   .L17
.L25:
            moveq   #0,D7
            not.l   D1
            and.l   D1,(A4)+
            bra.b   .L18
.L26:
            moveq   #0,D7
            not.l   D1
            and.l   D1,(A4)+
            bra.b   .L19
.L27:
            moveq   #0,D7
            not.l   D1
            and.l   D1,(A4)+
            bra.w   .L9
.L28:
            move.l  (-$7C,A6),D0
            add.l   D0,(-$200,A6)
            move.l  (-$1BC,A6),D0
            add.l   D0,(-$1F8,A6)
            move.w  (-4,A6),D0
            addq.w  #1,D0
            move.w  D0,(-4,A6)
            cmp.w   (-$70,A6),D0
            beq.w   DONESTRETCH
            cmp.w   (-$44,A6),D0
            bge.b   .L29
            cmp.w   (-$46,A6),D0
            blt.b   .L29
            cmp.w   (-$5C,A6),D0
            bge.b   .L29
            cmp.w   (-$5E,A6),D0
            blt.b   .L29
            cmp.w   (-$2C,A6),D0
            bge.b   .L29
            cmp.w   (-$2E,A6),D0
            bge.b   .L30
.L29:
            moveq   #0,D7
            movea.l (-$1C,A6),A0
            jsr     (A0)
.L30:
            movea.l (-8,A6),A2
            movea.l (-$200,A6),A4
            bra.w   .L3
.L31:
            move.w  D2,D7
.L32:
            bfextu  (A3){D5:16},D4
            addq.w  #2,A3
            beq.b   .L34
            cmp.w   D4,D6
            beq.b   .L35
            swap    D4
            rol.l   #4,D4
            and.w   D3,D4
            move.l  (0,A1,D4.w*4),(A4)+
            rol.l   #4,D4
            and.w   D3,D4
            move.l  (0,A1,D4.w*4),(A4)+
            rol.l   #4,D4
            and.w   D3,D4
            move.l  (0,A1,D4.w*4),(A4)+
            rol.l   #4,D4
            and.w   D3,D4
            move.l  (0,A1,D4.w*4),(A4)+
.L33:
            dbra    D2,.L32
            addq.w  #1,D7
            lsl.w   #4,D7
            adda.w  D7,A2
            bra.w   .L10
.L34:
            clr.l   (A4)+
            clr.l   (A4)+
            clr.l   (A4)+
            clr.l   (A4)+
            bra.b   .L33
.L35:
            move.l  D6,(A4)+
            move.l  D6,(A4)+
            move.l  D6,(A4)+
            move.l  D6,(A4)+
            bra.b   .L33
.L36:
            addq.w  #4,A3
            addq.w  #4,A4
            bra.w   CB8TO8CLIP.L4
CB8TO8CLIP:
            move.w  (-4,A6),D0
            cmp.w   (-$74,A6),D0
            blt.b   .L1
            jsr     ([-$1C.w,A6])
            bra.b   .L2
            move.l  (-$7C,A6),D0
            add.l   D0,(-$200,A6)
.L1:
            addq.w  #1,(-4,A6)
            move.w  (-4,A6),D0
            cmp.w   (-$70,A6),D0
            beq.w   DONESTRETCH
            move.l  (-$1BC,A6),D2
            add.l   D2,(-$1F8,A6)
            bra.b   CB8TO8CLIP
.L2:
            subq.w  #1,(-$10,A6)
            moveq   #-1,D6
            moveq   #0,D4
            moveq   #0,D3
            movea.l (-$23C,A6),A5
            suba.l  A1,A1
            move.l  (A5),D0
            move.b  D0,D7
            lsl.l   #8,D7
            move.b  D0,D7
            move.w  D7,D0
            swap    D7
            move.w  D0,D7
.L3:
            movea.l (-8,A6),A2
            movea.l (-$1F8,A6),A3
            movea.l (-$200,A6),A4
            movea.l (-$23C,A6),A5
            move.l  (-$234,A6),D0
            asr.l   #3,D0
            move.l  (-$230,A6),D1
            asr.l   #3,D1
            add.l   D1,D0
            adda.l  D0,A3
            move.w  (-$10,A6),D2
            moveq   #0,D5
            move.l  (A2)+,D1
            beq.w   CB1TO8CLIP.L36
            move.l  (A3)+,D0
            movea.l D0,A1
            move.b  D0,D5
            move.b  (3,A5,D5.w*4),D0
            rol.l   #8,D0
            move.b  D0,D5
            move.b  (3,A5,D5.w*4),D0
            rol.l   #8,D0
            move.b  D0,D5
            move.b  (3,A5,D5.w*4),D0
            rol.l   #8,D0
            move.b  D0,D5
            move.b  (3,A5,D5.w*4),D0
            rol.l   #8,D0
            move.l  D0,D7
            and.l   D1,D0
            not.l   D1
            and.l   (A4),D1
            or.l    D1,D0
            move.l  D0,(A4)+
            subq.w  #1,D2
            bmi.b   .L9
.L4:
            tst.w   D4
            bne.w   .L32
            moveq   #-1,D4
            moveq   #0,D3
            move.l  (A2)+,D1
            beq.w   .L12
            cmp.l   D6,D1
            bne.w   .L13
            bra.b   .L6
.L5:
            move.l  (A2)+,D1
            cmp.l   D6,D1
            bne.w   .L13
.L6:
            addq.w  #1,D3
            move.l  (A3)+,D0
            cmpa.l  D0,A1
            bne.b   .L7
            move.l  D7,D0
            bra.b   .L8
.L7:
            movea.l D0,A1
            move.b  D0,D5
            move.b  (3,A5,D5.w*4),D0
            rol.l   #8,D0
            move.b  D0,D5
            move.b  (3,A5,D5.w*4),D0
            rol.l   #8,D0
            move.b  D0,D5
            move.b  (3,A5,D5.w*4),D0
            rol.l   #8,D0
            move.b  D0,D5
            move.b  (3,A5,D5.w*4),D0
            rol.l   #8,D0
            move.l  D0,D7
.L8:
            move.l  D0,(A4)+
            dbra    D2,.L5
.L9:
            move.l  (-$7C,A6),D0
            add.l   D0,(-$200,A6)
            move.l  (-$1BC,A6),D0
            add.l   D0,(-$1F8,A6)
            move.w  (-4,A6),D0
            addq.w  #1,D0
            move.w  D0,(-4,A6)
            cmp.w   (-$70,A6),D0
            beq.w   DONESTRETCH
            cmp.w   (-$44,A6),D0
            bge.b   .L10
            cmp.w   (-$46,A6),D0
            blt.b   .L10
            cmp.w   (-$5C,A6),D0
            bge.b   .L10
            cmp.w   (-$5E,A6),D0
            blt.b   .L10
            cmp.w   (-$2C,A6),D0
            bge.b   .L10
            cmp.w   (-$2E,A6),D0
            bge.w   .L3
.L10:
            moveq   #0,D4
            move.l  A1,-(SP)
            movea.l (-$1C,A6),A0
            jsr     (A0)
            movea.l (SP)+,A1
            bra.w   .L3
            addq.w  #4,A4
            bra.b   .L9
.L11:
            move.l  (A2)+,D1
            bne.b   .L13
.L12:
            subq.w  #1,D3
            addq.w  #4,A3
            addq.w  #4,A4
            dbra    D2,.L11
            bra.b   .L9
.L13:
            swap    D3
            move.l  (A3)+,D0
            cmpa.l  D0,A1
            bne.b   .L14
            move.l  D7,D0
            bra.b   .L15
.L14:
            movea.l D0,A1
            move.b  D0,D5
            move.b  (3,A5,D5.w*4),D0
            rol.l   #8,D0
            move.b  D0,D5
            move.b  (3,A5,D5.w*4),D0
            rol.l   #8,D0
            move.b  D0,D5
            move.b  (3,A5,D5.w*4),D0
            rol.l   #8,D0
            move.b  D0,D5
            move.b  (3,A5,D5.w*4),D0
            rol.l   #8,D0
            move.l  D0,D7
.L15:
            and.l   D1,D0
            not.l   D1
            and.l   (A4),D1
            or.l    D1,D0
            move.l  D0,(A4)+
            subq.w  #1,D2
            bmi.b   .L20
            move.l  (A2)+,D1
            beq.b   .L22
            cmp.l   D6,D1
            bne.b   .L23
            bra.b   .L17
.L16:
            move.l  (A2)+,D1
            cmp.l   D6,D1
            bne.b   .L23
.L17:
            addq.w  #1,D3
            move.l  (A3)+,D0
            cmpa.l  D0,A1
            bne.b   .L18
            move.l  D7,D0
            bra.b   .L19
.L18:
            movea.l D0,A1
            move.b  D0,D5
            move.b  (3,A5,D5.w*4),D0
            rol.l   #8,D0
            move.b  D0,D5
            move.b  (3,A5,D5.w*4),D0
            rol.l   #8,D0
            move.b  D0,D5
            move.b  (3,A5,D5.w*4),D0
            rol.l   #8,D0
            move.b  D0,D5
            move.b  (3,A5,D5.w*4),D0
            rol.l   #8,D0
            move.l  D0,D7
.L19:
            move.l  D0,(A4)+
            dbra    D2,.L16
.L20:
            swap    D3
            bra.w   .L9
.L21:
            move.l  (A2)+,D1
            bne.b   .L23
.L22:
            subq.w  #1,D3
            addq.w  #4,A3
            addq.w  #4,A4
            dbra    D2,.L21
            bra.b   .L20
.L23:
            swap    D3
            tst.l   D1
            beq.b   .L28
            bra.b   .L25
.L24:
            move.l  (A2)+,D1
            beq.b   .L28
.L25:
            cmp.l   D6,D1
            bne.b   .L29
            move.l  (A3)+,D0
            cmpa.l  D0,A1
            bne.b   .L26
            move.l  D7,D0
            bra.b   .L27
.L26:
            movea.l D0,A1
            move.b  D0,D5
            move.b  (3,A5,D5.w*4),D0
            rol.l   #8,D0
            move.b  D0,D5
            move.b  (3,A5,D5.w*4),D0
            rol.l   #8,D0
            move.b  D0,D5
            move.b  (3,A5,D5.w*4),D0
            rol.l   #8,D0
            move.b  D0,D5
            move.b  (3,A5,D5.w*4),D0
            rol.l   #8,D0
            move.l  D0,D7
.L27:
            move.l  D0,(A4)+
            dbra    D2,.L24
            bra.w   .L9
.L28:
            addq.w  #4,A4
            addq.w  #4,A3
            dbra    D2,.L24
            bra.w   .L9
.L29:
            move.l  (A3)+,D0
            cmpa.l  D0,A1
            bne.b   .L30
            move.l  D7,D0
            bra.b   .L31
.L30:
            movea.l D0,A1
            move.b  D0,D5
            move.b  (3,A5,D5.w*4),D0
            rol.l   #8,D0
            move.b  D0,D5
            move.b  (3,A5,D5.w*4),D0
            rol.l   #8,D0
            move.b  D0,D5
            move.b  (3,A5,D5.w*4),D0
            rol.l   #8,D0
            move.b  D0,D5
            move.b  (3,A5,D5.w*4),D0
            rol.l   #8,D0
            move.l  D0,D7
.L31:
            and.l   D1,D0
            not.l   D1
            and.l   (A4),D1
            or.l    D1,D0
            move.l  D0,(A4)+
            dbra    D2,.L24
            bra.w   .L9
.L32:
            tst.w   D3
            bpl.b   sub_4083ABA4.L1
            beq.w   sub_4083ABA4.L6
            move.w  D3,D0
            neg.w   D0
            lsl.w   #2,D0
            adda.w  D0,A2
            adda.w  D0,A3
            adda.w  D0,A4
            add.w   D3,D2
            bmi.w   .L9
.L33:
            lea     sub_4083ABA4,A0
            bra.w   sub_4083ABA4.L8
sub_4083ABA4:
            move.l  D3,D0
            bpl.b   .L2
            beq.b   .L7
            swap    D0
            neg.w   D0
            sub.w   D0,D2
            lsl.w   #2,D0
            adda.w  D0,A2
            adda.w  D0,A3
            adda.w  D0,A4
            tst.w   D2
            bmi.w   CB8TO8CLIP.L9
            bra.w   CB8TO8CLIP.L24
.L1:
            move.w  D3,D0
            move.w  D0,D1
            lsl.w   #2,D1
            adda.w  D1,A2
            sub.w   D0,D2
            lea     CB8TO8CLIP.L33,A0
            bra.b   .L5
.L2:
            swap    D0
            move.w  D0,D1
            lsl.w   #2,D1
            adda.w  D1,A2
            sub.w   D0,D2
            lea     CB8TO8CLIP.L24,A0
            bra.b   .L5
.L3:
            move.l  (A3)+,D1
            cmpa.l  D1,A1
            beq.b   .L4
            movea.l D1,A1
            move.b  D1,D5
            move.b  (3,A5,D5.w*4),D1
            rol.l   #8,D1
            move.b  D1,D5
            move.b  (3,A5,D5.w*4),D1
            rol.l   #8,D1
            move.b  D1,D5
            move.b  (3,A5,D5.w*4),D1
            rol.l   #8,D1
            move.b  D1,D5
            move.b  (3,A5,D5.w*4),D1
            rol.l   #8,D1
            move.l  D1,D7
.L4:
            move.l  D7,(A4)+
.L5:
            dbra    D0,.L3
            tst.w   D2
            bmi.w   CB8TO8CLIP.L9
            jmp     (A0)
.L6:
            lea     CB8TO8CLIP.L33,A0
            bra.b   .L8
.L7:
            lea     CB8TO8CLIP.L24,A0
.L8:
            move.l  (A2)+,D1
            move.l  (A3)+,D0
            cmpa.l  D0,A1
            bne.b   .L9
            move.l  D7,D0
            bra.b   .L10
.L9:
            movea.l D0,A1
            move.b  D0,D5
            move.b  (3,A5,D5.w*4),D0
            rol.l   #8,D0
            move.b  D0,D5
            move.b  (3,A5,D5.w*4),D0
            rol.l   #8,D0
            move.b  D0,D5
            move.b  (3,A5,D5.w*4),D0
            rol.l   #8,D0
            move.b  D0,D5
            move.b  (3,A5,D5.w*4),D0
            rol.l   #8,D0
            move.l  D0,D7
.L10:
            and.l   D1,D0
            not.l   D1
            and.l   (A4),D1
            or.l    D1,D0
            move.l  D0,(A4)+
            subq.w  #1,D2
            bmi.w   CB8TO8CLIP.L9
            jmp     (A0)
.L11:
            lea     ($20,A3),A3
            addq.w  #4,A4
            bra.b   CB8TO1CLIP.L4
CB8TO1CLIP:
            move.w  (-4,A6),D0
            cmp.w   (-$74,A6),D0
            blt.b   .L1
            jsr     ([-$1C.w,A6])
            bra.b   .L2
            move.l  (-$7C,A6),D0
            add.l   D0,(-$200,A6)
.L1:
            addq.w  #1,(-4,A6)
            move.w  (-4,A6),D0
            cmp.w   (-$70,A6),D0
            beq.w   DONESTRETCH
            move.l  (-$1BC,A6),D2
            add.l   D2,(-$1F8,A6)
            bra.b   CB8TO1CLIP
.L2:
            subq.w  #1,(-$10,A6)
            moveq   #-1,D6
            moveq   #0,D4
            moveq   #0,D3
            suba.l  A1,A1
            subq.l  #1,A1
            moveq   #-1,D7
.L3:
            movea.l (-8,A6),A2
            movea.l (-$1F8,A6),A3
            movea.l (-$200,A6),A4
            movea.l (-$23C,A6),A5
            move.l  (-$234,A6),D0
            move.l  (-$230,A6),D1
            asr.l   #3,D1
            add.l   D1,D0
            adda.l  D0,A3
            move.w  (-$10,A6),D2
            moveq   #0,D5
            move.l  (A2)+,D1
            beq.b   sub_4083ABA4.L11
            bsr.w   Map8to1
            and.l   D1,D0
            not.l   D1
            and.l   (A4),D1
            or.l    D1,D0
            move.l  D0,(A4)+
            subq.w  #1,D2
            bmi.b   .L7
.L4:
            tst.w   D4
            bne.w   .L22
            moveq   #-1,D4
            moveq   #0,D3
            move.l  (A2)+,D1
            beq.b   .L10
            cmp.l   D6,D1
            bne.w   .L11
            bra.b   .L6
.L5:
            move.l  (A2)+,D1
            cmp.l   D6,D1
            bne.b   .L11
.L6:
            addq.w  #1,D3
            bsr.w   Map8to1
            move.l  D0,(A4)+
            dbra    D2,.L5
.L7:
            move.l  (-$7C,A6),D0
            add.l   D0,(-$200,A6)
            move.l  (-$1BC,A6),D0
            add.l   D0,(-$1F8,A6)
            move.w  (-4,A6),D0
            addq.w  #1,D0
            move.w  D0,(-4,A6)
            cmp.w   (-$70,A6),D0
            beq.w   DONESTRETCH
            cmp.w   (-$44,A6),D0
            bge.b   .L8
            cmp.w   (-$46,A6),D0
            blt.b   .L8
            cmp.w   (-$5C,A6),D0
            bge.b   .L8
            cmp.w   (-$5E,A6),D0
            blt.b   .L8
            cmp.w   (-$2C,A6),D0
            bge.b   .L8
            cmp.w   (-$2E,A6),D0
            bge.w   .L3
.L8:
            moveq   #0,D4
            move.l  A1,-(SP)
            movea.l (-$1C,A6),A0
            jsr     (A0)
            movea.l (SP)+,A1
            bra.w   .L3
            addq.w  #4,A4
            bra.b   .L7
.L9:
            move.l  (A2)+,D1
            bne.b   .L11
.L10:
            subq.w  #1,D3
            lea     ($20,A3),A3
            addq.w  #4,A4
            dbra    D2,.L9
            bra.b   .L7
.L11:
            swap    D3
            bsr.w   Map8to1
            and.l   D1,D0
            not.l   D1
            and.l   (A4),D1
            or.l    D1,D0
            move.l  D0,(A4)+
            subq.w  #1,D2
            bmi.b   .L14
            move.l  (A2)+,D1
            beq.b   .L16
            cmp.l   D6,D1
            bne.b   .L17
            bra.b   .L13
.L12:
            move.l  (A2)+,D1
            cmp.l   D6,D1
            bne.b   .L17
.L13:
            addq.w  #1,D3
            bsr.w   Map8to1
            move.l  D0,(A4)+
            dbra    D2,.L12
.L14:
            swap    D3
            bra.w   .L7
.L15:
            move.l  (A2)+,D1
            bne.b   .L17
.L16:
            subq.w  #1,D3
            lea     ($20,A3),A3
            addq.w  #4,A4
            dbra    D2,.L15
            bra.b   .L14
.L17:
            swap    D3
            tst.l   D1
            beq.b   .L20
            bra.b   .L19
.L18:
            move.l  (A2)+,D1
            beq.b   .L20
.L19:
            cmp.l   D6,D1
            bne.b   .L21
            bsr.w   Map8to1
            move.l  D0,(A4)+
            dbra    D2,.L18
            bra.w   .L7
.L20:
            addq.w  #4,A4
            lea     ($20,A3),A3
            dbra    D2,.L18
            bra.w   .L7
.L21:
            bsr.w   Map8to1
            and.l   D1,D0
            not.l   D1
            and.l   (A4),D1
            or.l    D1,D0
            move.l  D0,(A4)+
            dbra    D2,.L18
            bra.w   .L7
.L22:
            tst.w   D3
            bpl.b   sub_4083AE2C.L1
            beq.b   sub_4083AE2C.L5
            move.w  D3,D0
            neg.w   D0
            lsl.w   #2,D0
            adda.w  D0,A2
            adda.w  D0,A4
            lsl.w   #3,D0
            adda.w  D0,A3
            add.w   D3,D2
            bmi.w   .L7
.L23:
            lea     sub_4083AE2C,A0
            bra.b   sub_4083AE2C.L7
sub_4083AE2C:
            move.l  D3,D0
            bpl.b   .L2
            beq.b   .L6
            swap    D0
            neg.w   D0
            sub.w   D0,D2
            lsl.w   #2,D0
            adda.w  D0,A2
            adda.w  D0,A4
            lsl.w   #3,D0
            adda.w  D0,A3
            tst.w   D2
            bmi.w   CB8TO1CLIP.L7
            bra.b   CB8TO1CLIP.L18
.L1:
            move.w  D3,D0
            move.w  D0,D1
            lsl.w   #2,D1
            adda.w  D1,A2
            sub.w   D0,D2
            move.w  D0,D1
            lea     CB8TO1CLIP.L23,A0
            bra.b   .L4
.L2:
            swap    D0
            move.w  D0,D1
            lsl.w   #2,D1
            adda.w  D1,A2
            sub.w   D0,D2
            move.w  D0,D1
            lea     CB8TO1CLIP.L18,A0
            bra.b   .L4
.L3:
            bsr.b   Map8to1
            move.l  D0,(A4)+
.L4:
            dbra    D1,.L3
            tst.w   D2
            bmi.w   CB8TO1CLIP.L7
            jmp     (A0)
.L5:
            lea     CB8TO1CLIP.L23,A0
            bra.b   .L7
.L6:
            lea     CB8TO1CLIP.L18,A0
.L7:
            move.l  (A2)+,D1
            bsr.b   Map8to1
            and.l   D1,D0
            not.l   D1
            and.l   (A4),D1
            or.l    D1,D0
            move.l  D0,(A4)+
            subq.w  #1,D2
            bmi.w   CB8TO1CLIP.L7
            jmp     (A0)
Map8to1:
            move.l  (A5),D0
            beq.b   .L1
            moveq   #$F,D0
.L1:
            moveq   #7,D7
            suba.l  A1,A1
.L2:
            move.l  (A3)+,D6
            cmp.l   A1,D6
            beq.b   .L3
            movea.l D6,A1
            swap    D6
            move.b  D6,D5
            lsr.w   #8,D6
            move.b  (3,A5,D6.w*4),D6
            lsr.w   #1,D6
            addx.l  D0,D0
            move.b  (3,A5,D5.w*4),D5
            lsr.w   #1,D5
            addx.l  D0,D0
            swap    D6
            move.b  D6,D5
            lsr.w   #8,D6
            move.b  (3,A5,D6.w*4),D6
            lsr.w   #1,D6
            addx.l  D0,D0
            move.b  (3,A5,D5.w*4),D5
            lsr.w   #1,D5
            addx.l  D0,D0
            dbra    D7,.L2
            moveq   #-1,D6
            rts
.L3:
            moveq   #$F,D5
            and.b   D0,D5
            lsl.l   #4,D0
            or.b    D5,D0
            dbra    D7,.L2
            moveq   #-1,D6
            rts
            ds.b    12
XGETSEEK:
            clr.l   (-$84,A6)
sub_4083AF04:
            jmp     ([-$80.w,A6])
ALLOCRUNBUF:
            move.l  (SP)+,D2
            moveq   #0,D1
            move.w  (-$10,A6),D1
            addq.l  #2,D1
            cmpi.w  #5,(-$76,A6)
            beq.b   .L1
            move.l  D1,D0
            add.l   D1,D1
            add.l   D0,D1
.L1:
            lsr.l   #1,D1
            addq.l  #3,D1
            sub.l   D1,(-$84,A6)
            bpl.b   .L2
            bsr.b   sub_4083AF04
.L2:
            lsl.l   #2,D1
            suba.l  D1,SP
            movea.l SP,A0
            addq.w  #4,A0
            jmp     (D2.l)
            ds.b    6
GetSeek:
            move.l  (4,SP),D3
            lea     ($C,SP,D3.w*4),A3
            lea     (-$3C,A6),A1
            clr.w   D4
            tst.l   (-$C,A6)
            beq.b   .L1
            jsr     ([$1C50.w])
            move.l  A0,(-$C,A6)
.L1:
            moveq   #$A,D0
            movea.l -(A3),A0
            movea.l (A0),A0
            cmp.w   (A0),D0
            beq.b   .L4
            cmpi.w  #2,D3
            beq.b   .L2
            move.l  (A3),-(SP)
            pea     (-$74,A6)
            clr.w   -(SP)
            jsr     ([$1AA4.w])
            blt.b   XGETSEEK
            beq.b   .L4
            movea.l (A3),A0
            movea.l (A0),A0
.L2:
            addq.w  #1,D4
            add.w   D4,D4
            move.w  (-$6E,A6),D1
            move.w  (-$E,A6),D2
            moveq   #0,D0
            move.w  D1,D0
            sub.w   D2,D0
            lsr.w   #5,D0
            sub.l   D0,(-$84,A6)
            bpl.b   .L3
            bsr.w   sub_4083AF04
.L3:
            move.w  (-$72,A6),D0
            jsr     ([$1C54.w])
            suba.w  #$18,A1
.L4:
            dbra    D3,.L1
            tst.l   (-$20,A6)
            beq.b   .L6
            addq.w  #1,D4
            move.w  D4,(-2,A6)
            cmpi.w  #1,D4
            bgt.b   .L11
            move.w  (-$6E,A6),D1
            move.w  (-$E,A6),D2
            moveq   #0,D0
            move.w  D1,D0
            sub.w   D2,D0
            lsr.w   #5,D0
            sub.l   D0,(-$84,A6)
            bpl.b   .L5
            bsr.w   sub_4083AF04
.L5:
            move.w  (-$72,A6),D0
            jsr     ([$1C54.w])
            moveq   #0,D0
            movea.l (-$34,A6),A0
            bra.b   .L8
.L6:
            move.w  (-$76,A6),D0
            tst.l   (-$C,A6)
            beq.b   .L7
            moveq   #0,D0
.L7:
            move.w  D4,(-2,A6)
            bne.b   .L9
            movea.l (-8,A6),A0
.L8:
            move.w  (-$72,A6),D3
            sub.w   (-$E,A6),D3
            move.w  (-$6E,A6),D4
            sub.w   (-$E,A6),D4
            jsr     ([$1AA8.w])
            bra.b   .L11
.L9:
            tst.w   D0
            bne.b   .L10
            cmpi.w  #2,D4
            bne.b   .L11
            move.l  (-8,A6),(-$34,A6)
            bra.b   .L11
.L10:
            ori.w   #1,(-2,A6)
.L11:
            move.w  (-$76,A6),D0
            movea.l ($1C8C).w,A0
            adda.l  (0,A0,D0.w*4),A0
            move.l  A0,(-$18,A6)
            tst.l   (-$C,A6)
            beq.b   .L12
            moveq   #0,D0
.L12:
            suba.l  A0,A0
            subq.l  #8,A3
            movea.l (A3),A1
            move.w  (-2,A6),D1
            move.w  D0,D2
            or.w    D1,D2
            beq.b   .L13
            movea.l ($1C90).w,A0
            adda.l  (0,A0,D0.w*4),A0
.L13:
            move.l  A0,(-$14,A6)
            movea.l ($1C94).w,A0
            cmpi.w  #7,D1
            ble.b   .L14
            subi.w  #$A,D1
.L14:
            adda.l  (0,A0,D1.w*4),A0
            move.l  A0,(-$1C,A6)
            jmp     (A1)
GSRUNTBL:
            dc.w    0,$03AC,0,$043C,0,$04FC,0,$059C
            dc.w    0,$07DC,0,$091C
GSEXPTBL:
            dc.w    0,$02D4,0,$02E4,0,$0324,0,$0344
            dc.w    0,$0364,0,$0384
gsSeekTbl:
            dc.l    SEEKOK-gsSeekTbl
            dc.l    RECTMASK-gsSeekTbl
            dc.l    A-gsSeekTbl
            dc.l    AX-gsSeekTbl
            dc.w    0,$01EC,0,$01EC,0,$010C,0,$010C
SEEKOK:
            move.w  #$7FFF,D2
            rts
            ds.b    6
RECTMASK:
            movem.l D3-D5/A4-A6,-(SP)
            movea.l (-$34,A6),A1
            move.l  (-$20,A6),D0
            move.w  (-$30,A6),D1
            move.l  (-$24,A6),D5
            movea.l (-8,A6),A0
            movea.l (-$14,A6),A4
            lea     RETRECTM,A5
            movea.l D0,A6
            moveq   #0,D2
RECTMLOOP:
            bfextu  (A6){D5:0},D0
            addq.w  #4,A6
            and.l   (A1)+,D0
            jmp     (A4)
RETRECTM:
            dbra    D1,RECTMLOOP
            movem.l (SP)+,D3-D5/A4-A6
.L1:
            moveq   #1,D2
            rts
            ds.b    6
A:
            lea     (-$3C,A6),A1
            move.w  (-4,A6),D0
            jmp     SeekRgn
AX:
            move.w  (-4,A6),D0
            cmp.w   (-$2C,A6),D0
            bge.b   .L1
            cmp.w   (-$2E,A6),D0
            blt.b   .L2
            tst.l   (-$20,A6)
            beq.b   RETRECTM.L1
.L88:
            movea.l (-$34,A6),A1
            move.w  (-$30,A6),D1
            bra.b   .L87
.L1:
            lea     (-$3C,A6),A1
            jsr     SEEKDOWN
            bra.b   .L88
.L2:
            lea     (-$3C,A6),A1
            jsr     SEEKUP
            bra.b   .L88
.L87:
            move.l  (-$20,A6),D0
            bne.b   .L89
            movem.l D2-D4/A4-A5,-(SP)
            movea.l (-8,A6),A0
            movea.l (-$14,A6),A4
            lea     .L4,A5
            moveq   #0,D2
.L3:
            move.l  (A1)+,D0
            jmp     (A4)
.L4:
            dbra    D1,.L3
            movem.l (SP)+,D2-D4/A4-A5
            rts
.L89:
            movem.l D3-D5/A4-A6,-(SP)
            movea.l (-8,A6),A0
            movea.l (-$14,A6),A4
            lea     .L6,A5
            move.l  (-$24,A6),D5
            movea.l D0,A6
            moveq   #0,D2
.L5:
            bfextu  (A6){D5:0},D0
            addq.w  #4,A6
            and.l   (A1)+,D0
            jmp     (A4)
.L6:
            dbra    D1,.L5
            movem.l (SP)+,D3-D5/A4-A6
            moveq   #1,D2
            rts
            ds.b    12
            move.w  (-4,A6),D0
            lea     (-$3C,A6),A1
            bsr.b   .L90
            move.w  D2,-(SP)
            lea     (-$54,A6),A1
            bsr.b   .L90
            move.w  (SP)+,D1
            cmp.w   D2,D1
            bgt.b   .L91
            move.w  D1,D2
.L91:
            movea.l (-$34,A6),A2
            movea.l (-$4C,A6),A1
            move.w  (-$30,A6),D1
            movea.l (-8,A6),A0
            move.l  (-$14,A6),D0
            bne.b   .L92
.L94:
            move.l  (-$20,A6),D0
            bne.b   .L93
            move.l  (A2)+,D0
            and.l   (A1)+,D0
            move.l  D0,(A0)+
            dbra    D1,.L94
            rts
.L93:
            movem.l D5/A6,-(SP)
            move.l  (-$24,A6),D5
            movea.l D0,A6
.L7:
            bfextu  (A6){D5:0},D0
            addq.w  #4,A6
            and.l   (A2)+,D0
            and.l   (A1)+,D0
            move.l  D0,(A0)+
            dbra    D1,.L7
            movem.l (SP)+,D5/A6
            moveq   #1,D2
            rts
.L90:
            cmp.w   ($10,A1),D0
            bge.w   SEEKDOWN
            cmp.w   ($E,A1),D0
            blt.w   SEEKUP
            move.w  ($10,A1),D2
            sub.w   D0,D2
            tst.l   (-$7C,A6)
            bpl.b   .L8
            move.w  D0,D2
            sub.w   ($E,A1),D2
            addq.w  #1,D2
.L8:
            rts
.L92:
            movem.l D2-D5/A4-A6,-(SP)
            move.l  (-$20,A6),D2
            bne.b   .L11
            movea.l D0,A4
            lea     .L10,A5
            moveq   #0,D2
.L9:
            move.l  (A2)+,D0
            and.l   (A1)+,D0
            jmp     (A4)
.L10:
            dbra    D1,.L9
            movem.l (SP)+,D2-D5/A4-A6
            rts
.L11:
            movea.l D0,A4
            lea     .L13,A5
            move.l  (-$24,A6),D5
            movea.l D2,A6
            moveq   #0,D2
.L12:
            bfextu  (A6){D5:0},D0
            addq.w  #4,A6
            and.l   (A2)+,D0
            and.l   (A1)+,D0
            jmp     (A4)
.L13:
            dbra    D1,.L12
            movem.l (SP)+,D2-D5/A4-A6
            moveq   #1,D2
            rts
            ds.b    14
            move.w  (-4,A6),D0
            lea     (-$3C,A6),A1
            bsr.w   .L90
            move.w  D2,-(SP)
            lea     (-$54,A6),A1
            bsr.w   .L90
            move.w  D2,-(SP)
            lea     (-$6C,A6),A1
            bsr.w   .L90
            move.w  (SP)+,D1
            cmp.w   D2,D1
            bgt.b   .L95
            move.w  D1,D2
.L95:
            move.w  (SP)+,D1
            cmp.w   D2,D1
            bgt.b   .L96
            move.w  D1,D2
.L96:
            movea.l (-$34,A6),A3
            movea.l (-$4C,A6),A2
            movea.l (-$64,A6),A1
            movea.l (-8,A6),A0
            move.w  (-$60,A6),D1
            move.l  (-$14,A6),D0
            bne.w   .L97
            move.l  (-$20,A6),D0
            bne.b   .L98
.L99:
            move.l  (A3)+,D0
            and.l   (A2)+,D0
            and.l   (A1)+,D0
            move.l  D0,(A0)+
            dbra    D1,.L99
            rts
.L98:
            movem.l D5/A6,-(SP)
            move.l  (-$24,A6),D5
            movea.l D0,A6
.L14:
            bfextu  (A6){D5:0},D0
            addq.w  #4,A6
            and.l   (A3)+,D0
            and.l   (A2)+,D0
            and.l   (A1)+,D0
            move.l  D0,(A0)+
            dbra    D1,.L14
            movem.l (SP)+,D5/A6
            moveq   #1,D2
            rts
.L97:
            movem.l D2-D5/A4-A6,-(SP)
            move.l  (-$20,A6),D2
            bne.b   .L17
            movea.l D0,A4
            lea     .L16,A5
            moveq   #0,D2
.L15:
            move.l  (A3)+,D0
            and.l   (A2)+,D0
            and.l   (A1)+,D0
            jmp     (A4)
.L16:
            dbra    D1,.L15
            movem.l (SP)+,D2-D5/A4-A6
            rts
.L17:
            movea.l D0,A4
            lea     .L19,A5
            move.l  (-$24,A6),D5
            movea.l D2,A6
            moveq   #0,D2
.L18:
            bfextu  (A6){D5:0},D0
            addq.w  #4,A6
            and.l   (A3)+,D0
            and.l   (A2)+,D0
            and.l   (A1)+,D0
            jmp     (A4)
.L19:
            dbra    D1,.L18
            movem.l (SP)+,D2-D5/A4-A6
            moveq   #1,D2
            rts
            move.l  D0,(A0)+
            RTS5
            ds.b    12
            move.l  A5,-(SP)
            lea     TABLE2,A5
            clr.w   D2
            move.b  D0,D2
            move.w  (0,A5,D2.w*2),D4
            swap    D0
            move.b  D0,D2
            move.w  (0,A5,D2.w*2),D3
            lsr.l   #8,D0
            move.b  D0,D2
            swap    D3
            move.w  (0,A5,D2.w*2),D3
            swap    D3
            swap    D0
            move.b  D0,D2
            swap    D4
            move.w  (0,A5,D2.w*2),D4
            swap    D4
            move.l  D3,(A0)+
            move.l  D4,(A0)+
            movea.l (SP)+,A5
            RTS5
            ds.b    10
            moveq   #3,D3
.L100:
            rol.l   #8,D0
            move.b  D0,D2
            move.l  (TABLE4.w,PC,D2.w*4),(A0)+
            dbra    D3,.L100
            RTS5
            ds.b    14
            moveq   #3,D3
.L101:
            rol.l   #8,D0
            move.b  D0,D2
            lsr.w   #4,D2
            move.l  (.L79.w,PC,D2.w*4),(A0)+
            moveq   #$F,D2
            and.w   D0,D2
            move.l  (.L79.w,PC,D2.w*4),(A0)+
            dbra    D3,.L101
            RTS5
            dc.w    0
            moveq   #$F,D3
.L102:
            add.l   D0,D0
            subx.l  D2,D2
            add.l   D0,D0
            subx.w  D2,D2
            move.l  D2,(A0)+
            dbra    D3,.L102
            RTS5
            ds.b    14
            moveq   #$1F,D3
.L103:
            add.l   D0,D0
            subx.l  D2,D2
            move.l  D2,(A0)+
            dbra    D3,.L103
            RTS5
            dc.w    0
            movea.l (-8,A6),A0
            movem.l D1/D3-D6,-(SP)
            movea.l (-$C,A6),A2
            move.w  (-$10,A6),D5
            moveq   #-1,D1
            moveq   #1,D4
            swap    D4
            move.l  (A0)+,D0
            move.w  (-$78,A6),D6
            bpl.b   .L20
            moveq   #0,D0
            move.w  D5,D0
            asl.l   #2,D0
            adda.l  D0,A0
            move.l  D0,D3
            move.l  -(A0),D0
            adda.w  D6,A0
            bra.b   .L21
.L20:
            moveq   #0,D3
.L21:
            tst.l   D0
            beq.b   .L28
.L22:
            cmp.l   D1,D0
            beq.b   .L30
            movea.l A2,A1
            addq.w  #4,A2
            bra.b   .L24
.L23:
            move.l  (A0),D0
            adda.w  D6,A0
            beq.b   .L25
            cmp.l   D1,D0
            beq.b   .L25
            add.l   D4,D3
.L24:
            move.l  D0,(A2)+
            dbra    D5,.L23
            bset    #$1E,D3
            move.l  D3,(A1)
            bra.b   .L31
.L25:
            bset    #$1E,D3
            move.l  D3,(A1)
            bra.b   .L20
.L26:
            move.l  D3,(A2)+
            bra.b   .L20
.L27:
            move.l  (A0),D0
            adda.w  D6,A0
            bne.b   .L22
.L28:
            add.w   D6,D3
            dbra    D5,.L27
            bra.b   .L31
.L29:
            move.l  (A0),D0
            adda.w  D6,A0
            cmp.l   D1,D0
            bne.b   .L26
            add.l   D4,D3
.L30:
            dbra    D5,.L29
            move.l  D3,(A2)+
.L31:
            move.l  D1,(A2)
            movem.l (SP)+,D1/D3-D6
            rts
            ds.b    6
            dc.w    $206E,$FFF8
            movem.l D1-D7/A3-A5,-(SP)
            movea.l (-$C,A6),A2
            move.w  (-$10,A6),D5
            lea     TABLE2,A4
            moveq   #-1,D1
            moveq   #1,D4
            swap    D4
            movea.l D4,A5
            moveq   #$F,D4
            moveq   #0,D6
            move.w  (A0)+,D0
            move.w  (-$78,A6),D2
            movea.w D2,A3
            asr.w   #1,D2
            bpl.b   .L32
            addq.w  #2,D5
            andi.w  #$FFFE,D5
            moveq   #0,D0
            move.w  D5,D0
            add.l   D0,D0
            adda.l  D0,A0
            add.l   D0,D0
            move.l  D0,D3
            move.w  -(A0),D0
            subq.w  #2,A0
            bra.b   .L33
.L32:
            moveq   #0,D3
            tst.w   D0
.L33:
            beq.b   .L40
.L34:
            cmp.w   D1,D0
            beq.b   .L42
            movea.l A2,A1
            addq.l  #4,A2
            bra.b   .L36
.L35:
            move.w  (A0),D0
            adda.w  D2,A0
            beq.b   .L37
            cmp.w   D1,D0
            beq.b   .L37
            add.l   A5,D3
.L36:
            move.b  D0,D6
            move.w  (0,A4,D6.w*2),D7
            swap    D7
            rol.w   #8,D0
            move.b  D0,D6
            move.w  (0,A4,D6.w*2),D7
            swap    D7
            move.l  D7,(A2)+
            dbra    D5,.L35
            bset    #$1E,D3
            move.l  D3,(A1)
            bra.b   .L43
.L37:
            bset    #$1E,D3
            move.l  D3,(A1)
            bra.b   .L32
.L38:
            move.l  D3,(A2)+
            bra.b   .L32
.L39:
            move.w  (A0),D0
            adda.w  D2,A0
            bne.b   .L34
.L40:
            add.w   A3,D3
            dbra    D5,.L39
            bra.b   .L43
.L41:
            move.w  (A0),D0
            adda.w  D2,A0
            cmp.w   D1,D0
            bne.b   .L38
            add.l   A5,D3
.L42:
            dbra    D5,.L41
            move.l  D3,(A2)+
.L43:
            move.l  D1,(A2)
            movem.l (SP)+,D1-D7/A3-A5
            rts
            ds.b    14
            dc.w    $206E,$FFF8
            movem.l D1-D7/A3-A4,-(SP)
            movea.l (-$C,A6),A2
            move.w  (-$10,A6),D5
            lea     TABLE4,A4
            moveq   #-1,D1
            moveq   #1,D4
            swap    D4
            moveq   #0,D6
            move.b  (A0)+,D0
            move.w  (-$78,A6),D2
            movea.w D2,A3
            asr.w   #2,D2
            bpl.b   .L44
            addq.w  #4,D5
            andi.w  #$FFFC,D5
            moveq   #0,D0
            move.w  D5,D0
            adda.l  D0,A0
            lsl.l   #2,D0
            move.l  D0,D3
            move.b  -(A0),D0
            subq.w  #1,A0
            bra.b   .L45
.L44:
            moveq   #0,D3
            tst.b   D0
.L45:
            beq.b   .L52
.L46:
            cmp.b   D1,D0
            beq.b   .L54
            movea.l A2,A1
            addq.l  #4,A2
            bra.b   .L48
.L47:
            move.b  (A0),D0
            adda.w  D2,A0
            beq.b   .L49
            cmp.b   D1,D0
            beq.b   .L49
            add.l   D4,D3
.L48:
            move.b  D0,D6
            move.l  (0,A4,D6.w*4),(A2)+
            dbra    D5,.L47
            bset    #$1E,D3
            move.l  D3,(A1)
            bra.b   .L55
.L49:
            bset    #$1E,D3
            move.l  D3,(A1)
            bra.b   .L44
.L50:
            move.l  D3,(A2)+
            bra.b   .L44
.L51:
            move.b  (A0),D0
            adda.w  D2,A0
            bne.b   .L46
.L52:
            add.w   A3,D3
            dbra    D5,.L51
            bra.b   .L55
.L53:
            move.b  (A0),D0
            adda.w  D2,A0
            cmp.b   D1,D0
            bne.b   .L50
            add.l   D4,D3
.L54:
            dbra    D5,.L53
            move.l  D3,(A2)+
.L55:
            move.l  D1,(A2)
            movem.l (SP)+,D1-D7/A3-A4
            rts
            dc.w    0,$4A6E,$FF88,$6B00,$009A,$206E,$FFF8
            movem.l D1-D6/A4,-(SP)
            movea.l (-$C,A6),A2
            move.w  (-$10,A6),D5
            lea     .L79,A4
            lsr.w   #1,D5
            moveq   #-1,D1
            moveq   #2,D4
            swap    D4
            moveq   #0,D6
            move.l  #$10000,D2
            move.b  (A0)+,D0
.L56:
            move.l  D2,D3
            tst.b   D0
            beq.b   .L63
.L57:
            cmp.b   D1,D0
            beq.b   .L65
            movea.l A2,A1
            addq.l  #4,A2
            bra.b   .L59
.L58:
            move.b  (A0)+,D0
            beq.b   .L60
            cmp.b   D1,D0
            beq.b   .L60
            add.l   D4,D3
.L59:
            move.b  D0,D6
            lsr.w   #4,D6
            move.l  (0,A4,D6.w*4),(A2)+
            moveq   #$F,D6
            and.w   D0,D6
            move.l  (0,A4,D6.w*4),(A2)+
            dbra    D5,.L58
            bset    #$1E,D3
            move.l  D3,(A1)
            bra.b   .L66
.L60:
            bset    #$1E,D3
            move.l  D3,(A1)
            bra.b   .L56
.L61:
            move.l  D3,(A2)+
            bra.b   .L56
.L62:
            move.b  (A0)+,D0
            bne.b   .L57
.L63:
            addq.w  #8,D3
            dbra    D5,.L62
            bra.b   .L66
.L64:
            move.b  (A0)+,D0
            cmp.b   D1,D0
            bne.b   .L61
            add.l   D4,D3
.L65:
            dbra    D5,.L64
            move.l  D3,(A2)+
.L66:
            move.l  D1,(A2)
            movem.l (SP)+,D1-D6/A4
            rts
            ds.b    14
            dc.w    $206E,$FFF8
            movem.l D1-D6/A4,-(SP)
            movea.l (-$C,A6),A2
            move.w  (-$10,A6),D5
            lea     .L79,A4
            moveq   #-1,D1
            moveq   #2,D4
            swap    D4
            moveq   #0,D6
            move.l  #$10000,D2
            move.l  D2,D3
            addq.w  #8,D5
            andi.w  #$FFF8,D5
            move.w  D5,D3
            asr.w   #1,D3
            adda.w  D3,A0
            lsl.w   #3,D3
            subq.w  #1,D5
            subq.w  #4,D3
            lsr.w   #1,D5
            move.b  -(A0),D0
            bra.b   .L68
.L67:
            move.l  D2,D3
.L68:
            tst.b   D0
            beq.b   .L75
.L69:
            cmp.b   D1,D0
            beq.b   .L77
            movea.l A2,A1
            addq.l  #4,A2
            bra.b   .L71
.L70:
            move.b  -(A0),D0
            beq.b   .L72
            cmp.b   D1,D0
            beq.b   .L72
            add.l   D4,D3
.L71:
            moveq   #$F,D6
            and.w   D0,D6
            move.l  (0,A4,D6.w*4),(A2)+
            move.b  D0,D6
            lsr.w   #4,D6
            move.l  (0,A4,D6.w*4),(A2)+
            dbra    D5,.L70
            bset    #$1E,D3
            move.l  D3,(A1)
            bra.b   .L78
.L72:
            bset    #$1E,D3
            move.l  D3,(A1)
            bra.b   .L67
.L73:
            move.l  D3,(A2)+
            bra.b   .L67
.L74:
            move.b  -(A0),D0
            bne.b   .L69
.L75:
            subq.w  #8,D3
            dbra    D5,.L74
            bra.b   .L78
.L76:
            move.b  -(A0),D0
            cmp.b   D1,D0
            bne.b   .L73
            add.l   D4,D3
.L77:
            dbra    D5,.L76
            move.l  D3,(A2)+
.L78:
            move.l  D1,(A2)
            movem.l (SP)+,D1-D6/A4
            rts
.L79:
            ds.b    7
            dc.b    $FF,$00,$00,$FF,$00,$00,$00,$FF,$FF,$00,$FF,$00,$00,$00,$FF,$00
            dc.b    $FF,$00,$FF,$FF,$00,$00,$FF,$FF,$FF,$FF,$00,$00,$00,$FF,$00,$00
            dc.b    $FF,$FF,$00,$FF,$00,$FF,$00,$FF,$FF,$FF,$FF,$00,$00,$FF,$FF,$00
            dc.b    $FF,$FF,$FF,$FF,$00,$FF,$FF,$FF,$FF
.L104:
            movea.l (-8,A6),A0
            movem.l D3-D5,-(SP)
            movea.l (-$C,A6),A2
            move.w  (-$10,A6),D5
            moveq   #1,D4
            swap    D4
            moveq   #1,D0
            ror.l   #1,D0
            moveq   #0,D3
.L80:
            add.l   D0,D0
            bcc.b   .L81
            bne.b   .L83
            move.l  (A0)+,D0
            addx.l  D0,D0
            bcs.b   .L83
.L81:
            add.l   D0,D0
            bcc.b   .L82
            movea.l A2,A1
            addq.l  #4,A2
            bra.b   .dump01
.L82:
            addq.w  #4,D3
            dbra    D5,.L80
            bra.b   endRun16
.L83:
            add.l   D0,D0
            bcs.b   .goBlit
.L84:
            movea.l A2,A1
            addq.l  #4,A2
            bra.b   .dump10
.L85:
            bset    #$1E,D3
            move.l  D3,(A1)
            moveq   #0,D3
            bra.b   .L82
.L86:
            bset    #$1E,D3
            move.l  D3,(A1)
            moveq   #0,D3
            bra.b   .goBlit
.chkMask0:
            add.l   D0,D0
            bcc.b   .L85
            add.l   D4,D3
.dump01:
            move.l  #$FFFF,(A2)+
            bra.b   .nextMask
.mask1:
            add.l   D0,D0
            bcc.b   .chkMask0
            bne.b   .chkMask1
            move.l  (A0)+,D0
            addx.l  D0,D0
            bcc.b   .chkMask0
.chkMask1:
            add.l   D0,D0
            bcs.b   .L86
            add.l   D4,D3
.dump10:
            move.l  #$FFFF0000,(A2)+
.nextMask:
            dbra    D5,.mask1
            bset    #$1E,D3
            move.l  D3,(A1)
            bra.b   endRun16
.dumpBlitS:
            move.l  D3,(A2)+
            moveq   #0,D3
            bra.b   .L81
.dumpBlitM:
            move.l  D3,(A2)+
            moveq   #0,D3
            bra.b   .L84
.blit1:
            add.l   D0,D0
            bcc.b   .dumpBlitS
            bne.b   .chkBlit
            move.l  (A0)+,D0
            addx.l  D0,D0
            bcc.b   .dumpBlitS
.chkBlit:
            add.l   D0,D0
            bcc.b   .dumpBlitM
            add.l   D4,D3
.goBlit:
            dbra    D5,.blit1
            move.l  D3,(A2)+
endRun16:
            moveq   #-1,D3
            move.l  D3,(A2)
            movem.l (SP)+,D3-D5
            rts
            ds.b    10
RUN16:
            lea     AX.L104(PC),A0
            move.l  A0,(-$18,A6)
            tst.w   (-$78,A6)
            bpl.w   AX.L104
            lea     .L1,A0
            move.l  A0,(-$18,A6)
.L1:
            movea.l (-8,A6),A0
            movem.l D3-D5,-(SP)
            movea.l (-$C,A6),A2
            move.w  (-$10,A6),D5
            addi.w  #$10,D5
            andi.w  #$FFF0,D5
            moveq   #1,D4
            swap    D4
            move.w  D5,D3
            ext.l   D3
            asr.w   #2,D3
            adda.w  D3,A0
            lsl.w   #4,D3
            subq.w  #1,D5
            subq.w  #4,D3
            moveq   #1,D0
.skip1:
            lsr.l   #1,D0
            bcc.b   .chkSkip
            bne.b   .BlitOrMask
            move.l  -(A0),D0
            roxr.l  #1,D0
            bcs.b   .BlitOrMask
.chkSkip:
            lsr.l   #1,D0
            bcc.b   .cntSkip
            movea.l A2,A1
            addq.l  #4,A2
            bra.b   .dump01
.cntSkip:
            subq.w  #4,D3
            dbra    D5,.skip1
            bra.b   endRun16
.BlitOrMask:
            lsr.l   #1,D0
            bcs.b   .goBlit
.first10:
            movea.l A2,A1
            addq.l  #4,A2
            bra.b   .dump10
.dumpMaskS:
            bset    #$1E,D3
            move.l  D3,(A1)
            moveq   #0,D3
            bra.b   .cntSkip
.dumpMaskB:
            bset    #$1E,D3
            move.l  D3,(A1)
            moveq   #0,D3
            bra.b   .goBlit
.chkMask0:
            lsr.l   #1,D0
            bcc.b   .dumpMaskS
            add.l   D4,D3
.dump01:
            move.l  #$FFFF0000,(A2)+
            bra.b   .nextMask
.mask1:
            lsr.l   #1,D0
            bcc.b   .chkMask0
            bne.b   .chkMask1
            move.l  -(A0),D0
            roxr.l  #1,D0
            bcc.b   .chkMask0
.chkMask1:
            lsr.l   #1,D0
            bcs.b   .dumpMaskB
            add.l   D4,D3
.dump10:
            move.l  #$FFFF,(A2)+
.nextMask:
            dbra    D5,.mask1
            bset    #$1E,D3
            move.l  D3,(A1)
            bra.w   endRun16
.dumpBlitS:
            move.l  D3,(A2)+
            moveq   #0,D3
            bra.b   .chkSkip
.dumpBlitM:
            move.l  D3,(A2)+
            moveq   #0,D3
            bra.b   .first10
.blit1:
            lsr.l   #1,D0
            bcc.b   .dumpBlitS
            bne.b   .chkBlit
            move.l  -(A0),D0
            roxr.l  #1,D0
            bcc.b   .dumpBlitS
.chkBlit:
            lsr.l   #1,D0
            bcc.b   .dumpBlitM
            add.l   D4,D3
.goBlit:
            dbra    D5,.blit1
            move.l  D3,(A2)+
            bra.w   endRun16
            ds.b    4
Forwards32:
            dc.w    $206E,$FFF8
            movem.l D3-D5,-(SP)
            movea.l (-$C,A6),A2
            move.w  (-$10,A6),D5
            moveq   #1,D4
            swap    D4
            moveq   #1,D0
            ror.l   #1,D0
            moveq   #0,D3
.skip1:
            add.l   D0,D0
            bcc.b   .cntSkip
            bne.b   .cntBlit
            move.l  (A0)+,D0
            addx.l  D0,D0
            bcs.b   .cntBlit
.cntSkip:
            addq.w  #4,D3
            dbra    D5,.skip1
            bra.b   endRun32
.goSkip:
            move.l  D3,(A2)+
            moveq   #0,D3
            bra.b   .cntSkip
.blit1:
            add.l   D0,D0
            bcc.b   .goSkip
            bne.b   .goBlit
            move.l  (A0)+,D0
            addx.l  D0,D0
            bcc.b   .goSkip
.goBlit:
            add.l   D4,D3
.cntBlit:
            dbra    D5,.blit1
            move.l  D3,(A2)+
endRun32:
            moveq   #-1,D3
            move.l  D3,(A2)
            movem.l (SP)+,D3-D5
            rts
            ds.b    14
RUN32:
            lea     Forwards32,A0
            move.l  A0,(-$18,A6)
            tst.w   (-$78,A6)
            bpl.b   Forwards32
            lea     .L1,A0
            move.l  A0,(-$18,A6)
.L1:
            movea.l (-8,A6),A0
            movem.l D3-D5,-(SP)
            movea.l (-$C,A6),A2
            move.w  (-$10,A6),D5
            addi.w  #$20,D5
            andi.w  #$FFE0,D5
            moveq   #1,D4
            swap    D4
            move.w  D5,D3
            ext.l   D3
            asr.w   #3,D3
            adda.w  D3,A0
            lsl.w   #5,D3
            subq.w  #1,D5
            subq.w  #4,D3
            moveq   #1,D0
.skip1:
            lsr.l   #1,D0
            bcc.b   .cntSkip
            bne.b   .cntBlit
            move.l  -(A0),D0
            roxr.l  #1,D0
            bcs.b   .cntBlit
.cntSkip:
            subq.w  #4,D3
            dbra    D5,.skip1
            bra.b   endRun32
.goSkip:
            move.l  D3,(A2)+
            moveq   #0,D3
            bra.b   .cntSkip
.blit1:
            lsr.l   #1,D0
            bcc.b   .goSkip
            bne.b   .goBlit
            move.l  -(A0),D0
            roxr.l  #1,D0
            bcc.b   .goSkip
.goBlit:
            add.l   D4,D3
.cntBlit:
            dbra    D5,.blit1
            move.l  D3,(A2)+
            bra.w   endRun32
            ds.b    12
StdOval:
            link.w  A6,#-4
            movem.l D7/A3-A4,-(SP)
            move.b  ($C,A6),D7
            jsr     ([$1A3C.w])
            ble.b   .L1
            move.b  D7,-(SP)
            bsr.l   PutPicVerb
            moveq   #$50,D0
            add.w   D7,D0
            move.b  D0,-(SP)
            move.l  (8,A6),-(SP)
            bsr.l   PutPicRect
.L1:
            pea     StdDraw_Ovals
            pea     GetRect_Ovals
            jsr     ([$1AA0.w])
            movem.l (SP)+,D7/A3-A4
            unlk    A6
            rtd     #6
GetRect_Ovals:
            move.l  (SP)+,D0
            movea.l (SP)+,A1
            movea.l (8,A6),A0
            move.l  (A0)+,(A1)+
            move.l  (A0),(A1)
            movea.l D0,A0
            jmp     (A0)
StdDraw_Ovals:
            movea.l (8,A6),A0
            move.w  (6,A0),D0
            sub.w   (2,A0),D0
            move.w  D0,(-2,A6)
            move.w  (4,A0),D0
            sub.w   (A0),D0
            move.w  D0,(-4,A6)
            move.l  A0,-(SP)
            tst.b   D7
            bne.b   .L2
            tst.l   ($60,A3)
            beq.b   .L1
            move.l  A0,-(SP)
            move.l  (-4,A6),-(SP)
            move.l  (-$94,A4),-(SP)
            pea     (-$96,A4)
            pea     (-$98,A4)
            jsr     ([$1A68.w])
.L1:
            move.b  #1,-(SP)
            bra.b   .L3
.L2:
            clr.b   -(SP)
.L3:
            move.l  (-4,A6),-(SP)
            jsr     ([$1A60.w])
            clr.w   -(SP)
            move.w  #$168,-(SP)
            jsr     ([$1A24.w])
            rts
            ds.b    14
FrameOval:
            moveq   #0,D0
            bra.b   CallOval
PaintOval:
            moveq   #1,D0
            bra.b   CallOval
EraseOval:
            moveq   #2,D0
            bra.b   CallOval
InvertOval:
            moveq   #3,D0
            bra.b   CallOval
FillOval:
            moveq   #0,D0
            bra.b   FillCOval.L1
FillCOval:
            moveq   #1,D0
.L1:
            movea.l (SP)+,A0
            movea.l (SP)+,A1
            move.l  A0,-(SP)
            move.l  A1,-(SP)
            jsr     ([$1A8C.w])
            moveq   #4,D0
CallOval:
            movea.l (SP)+,A0
            movea.l (SP)+,A1
            move.b  D0,-(SP)
            move.l  A1,-(SP)
            move.l  A0,-(SP)
            movea.l (A5),A0
            movea.l (A0),A0
            move.l  ($68,A0),D0
            movea.l ($10D8).w,A0
            beq.b   .L1
            movea.l D0,A0
            movea.l ($10,A0),A0
.L1:
            jmp     (A0)
            ds.b    10
StdArc:
            link.w  A6,#-4
            movem.l D4/D7/A3-A4,-(SP)
            move.b  ($10,A6),D7
            jsr     ([$1A3C.w])
            ble.b   .L1
            move.b  D7,-(SP)
            bsr.l   PutPicVerb
            moveq   #$60,D0
            add.w   D7,D0
            move.b  D0,-(SP)
            move.l  ($C,A6),-(SP)
            bsr.l   PutPicRect
            move.w  ($A,A6),-(SP)
            bsr.l   PutPicWord
            move.w  (8,A6),-(SP)
            bsr.l   PutPicWord
.L1:
            pea     sub_4083BB98
            pea     GetRect_Arcs
            jsr     ([$1AA0.w])
            movem.l (SP)+,D4/D7/A3-A4
            unlk    A6
            rtd     #$A
GetRect_Arcs:
            move.l  (SP)+,D0
            movea.l (SP)+,A1
            movea.l ($C,A6),A0
            move.l  (A0)+,(A1)+
            move.l  (A0),(A1)
            movea.l D0,A0
            jmp     (A0)
sub_4083BB98:
            movea.l ($C,A6),A0
            move.w  (6,A0),D0
            sub.w   (2,A0),D0
            move.w  D0,(-2,A6)
            move.w  (4,A0),D0
            sub.w   (A0),D0
            move.w  D0,(-4,A6)
            move.l  A0,-(SP)
            clr.b   -(SP)
            tst.b   D7
            bne.b   .L1
            move.b  #1,(SP)
.L1:
            move.l  (-4,A6),-(SP)
            jsr     ([$1A60.w])
            move.w  ($A,A6),-(SP)
            move.w  (8,A6),-(SP)
            jsr     ([$1A24.w])
            rts
            ds.b    8
FrameArc:
            moveq   #0,D0
            bra.b   CallArc
PaintArc:
            moveq   #1,D0
            bra.b   CallArc
EraseArc:
            moveq   #2,D0
            bra.b   CallArc
InvertArc:
            moveq   #3,D0
            bra.b   CallArc
FillArc:
            moveq   #0,D0
            bra.b   FillCArc.L1
FillCArc:
            moveq   #1,D0
.L1:
            movea.l (SP)+,A0
            movea.l (SP)+,A1
            move.l  A0,-(SP)
            move.l  A1,-(SP)
            jsr     ([$1A8C.w])
            moveq   #4,D0
CallArc:
            movea.l (SP)+,A0
            move.l  (SP)+,D1
            movea.l (SP)+,A1
            move.b  D0,-(SP)
            move.l  A1,-(SP)
            move.l  D1,-(SP)
            move.l  A0,-(SP)
            movea.l (A5),A0
            movea.l (A0),A0
            move.l  ($68,A0),D0
            movea.l ($10F4).w,A0
            beq.b   .L1
            movea.l D0,A0
            movea.l ($14,A0),A0
.L1:
            jmp     (A0)
            ds.b    6
SortPoints:
            link.w  A6,#0
            movem.l D3-D4/A2-A4,-(SP)
            movea.l ($A,A6),A3
            move.w  A3,D3
            andi.w  #3,D3
            moveq   #0,D0
            move.w  (8,A6),D0
            ble.b   .L12
            lsl.l   #2,D0
            movea.l A3,A4
            adda.l  D0,A4
            subq.w  #4,A4
            move.l  SP,D4
            movem.l A3-A4,-(SP)
.L1:
            movem.l (SP)+,A3-A4
.L2:
            movea.l A3,A1
            movea.l A4,A2
            move.l  A3,D0
            add.l   A4,D0
            roxr.l  #1,D0
            andi.w  #$FFFC,D0
            or.w    D3,D0
            movea.l D0,A0
            move.w  (2,A0),D1
            move.w  (A0),D2
.L3:
            bra.b   .L5
.L4:
            addq.w  #4,A1
.L5:
            cmp.w   (A1),D2
            bgt.b   .L4
            blt.b   .L6
            cmp.w   (2,A1),D1
            bgt.b   .L4
.L6:
            bra.b   .L8
.L7:
            subq.w  #4,A2
.L8:
            cmp.w   (A2),D2
            blt.b   .L7
            bgt.b   .L9
            cmp.w   (2,A2),D1
            blt.b   .L7
.L9:
            cmpa.l  A2,A1
            bgt.b   .L10
            move.l  (A1),D0
            move.l  (A2),(A1)+
            move.l  D0,(A2)
            subq.w  #4,A2
.L10:
            cmpa.l  A2,A1
            bls.b   .L3
            cmpa.l  A4,A1
            bcc.b   .L11
            movem.l A1/A4,-(SP)
.L11:
            movea.l A2,A4
            cmpa.l  A4,A3
            bcs.b   .L2
            cmpa.l  D4,SP
            bne.b   .L1
.L12:
            movem.l (SP)+,D3-D4/A2-A4
            unlk    A6
            rtd     #6
CullPoints:
            link.w  A6,#0
            movem.l D0-D7/A1-A5,-(SP)
            movea.l (8,A6),A0
            move.w  (A0),D0
            ble.b   .L5
            movea.l ($C,A6),A1
            movea.l A1,A3
            ext.l   D0
            lsl.l   #2,D0
            adda.l  D0,A3
            subq.w  #4,A3
            move.l  A1,D5
            movea.l A1,A2
            bra.b   .L3
.L1:
            addq.w  #4,A1
            bra.b   .L3
.L2:
            move.l  (A1)+,D0
            cmp.l   (A1),D0
            beq.b   .L1
            move.l  D0,(A2)+
.L3:
            cmpa.l  A3,A1
            blt.b   .L2
            bgt.b   .L4
            move.l  (A1)+,(A2)+
.L4:
            move.l  A2,D0
            sub.l   D5,D0
            lsr.w   #2,D0
            movea.l (8,A6),A0
            move.w  D0,(A0)
.L5:
            movem.l (SP)+,D0-D7/A1-A5
            unlk    A6
            rtd     #8
            dc.w    0
PutRgn:
            link.w  A6,#0
            movem.l D7/A2-A4,-(SP)
            movea.l ($10,A6),A4
            movea.l ($14,A6),A3
            movea.l ($C,A6),A2
            movea.l (A3),A0
            moveq   #0,D7
            move.w  (A0),D7
            add.l   D7,D7
            moveq   #0,D0
            move.w  (A2),D0
            add.l   D0,D7
            cmpi.l  #$FF00,D7
            blt.b   .L1
            move.w  #$FF6D,QDErr
            bra.w   .L7
.L1:
            movea.l (8,A6),A1
            cmp.w   (A1),D7
            bls.b   .L2
            addi.w  #$100,D7
            move.w  D7,(A1)
            move.l  A4,-(SP)
            move.w  D7,-(SP)
            bsr.l   SetHSize
            movea.l (A3),A0
            movea.l ($C,A6),A2
.L2:
            movea.l (A4),A1
            moveq   #0,D0
            move.w  (A2),D0
            adda.l  D0,A1
            cmpi.w  #$A,(A0)
            bne.b   .L3
            addq.w  #2,A0
            move.l  (A0),(A1)+
            move.w  (A0)+,(A1)+
            move.w  (A0)+,D0
            move.l  (A0),D1
            move.w  D1,(A1)+
            move.w  (A0),(A1)+
            move.w  D0,(A1)+
            move.l  D1,(A1)+
            bra.b   .L6
.L3:
            lea     ($A,A0),A0
.L4:
            move.l  (A0)+,D7
.L5:
            move.l  D7,(A1)+
            move.w  (A0)+,D7
            move.l  D7,(A1)+
            move.w  (A0)+,D7
            cmpi.w  #$7FFF,D7
            bne.b   .L5
            cmpi.w  #$7FFF,(A0)
            bne.b   .L4
.L6:
            suba.l  (A4),A1
            move.w  A1,(A2)
.L7:
            movem.l (SP)+,D7/A2-A4
            unlk    A6
            rtd     #$10
            ds.b    4
UpdatePixMap:
            rts
            ds.b    14
MakeITable:
            link.w  A6,#-$16
            movem.l D3-D7/A2-A5,-(SP)
            clr.w   QDErr
            move.w  (8,A6),D7
            cmpi.l  #-1,TheGDevice
            beq.b   .ResCheck
            movea.l ([TheGDevice.w]),A0
            tst.l   ($A,A6)
            bne.b   .DoCTabH
            move.l  (6,A0),($A,A6)
.DoCTabH:
            tst.l   ($E,A6)
            bne.b   .DoITabRes
            movea.l ([$16.w,A0]),A1
            move.l  ($2A,A1),($E,A6)
.DoITabRes:
            tst.w   D7
            bne.b   .ResCheck
            move.w  ($A,A0),D7
            bne.b   .ResSubst
            moveq   #4,D7
.ResSubst:
            move.w  D7,(8,A6)
.ResCheck:
            cmpi.w  #2,D7
            ble.b   .BadRes
            cmpi.w  #6,D7
            blt.b   .ResOK
.BadRes:
            move.w  #$FF64,QDErr
            bra.w   sub_4083BFBE.L25
.ResOK:
            move.w  D7,D1
            moveq   #1,D0
            lsl.l   D1,D0
            lsl.l   D1,D0
            lsl.l   D1,D0
            addq.l  #6,D0
            move.l  D0,(-$14,A6)
            addi.l  #$206,D0
            movea.l ($A,A6),A0
            tst.l   (A0)
            beq.b   .L7
            _SetHandleSize
            bra.b   .L8
.L7:
            _ReallocHandle
.L8:
            beq.b   .L9
            move.w  #$FF68,QDErr
            bra.w   sub_4083BFBE.L25
.L9:
            movea.l ($E,A6),A0
            movea.l (A0),A0
            move.w  (6,A0),D0
            lea     (8,A0),A1
.nextEntry:
            move.l  (A1)+,D1
            move.l  (A1)+,D2
            cmp.w   D1,D2
            bne.b   .notGray
            swap    D2
            cmp.w   D1,D2
            bne.b   .notGray
.skippy:
            dbra    D0,.nextEntry
            jsr     ([$1C6C.w])
            bra.w   sub_4083BFBE.L25
.notGray:
            btst    #$1E,D1
            bne.b   .skippy
            move.l  TheZone,(-8,A6)
            move.l  ApplZone,TheZone
            subq.w  #4,SP
            move.l  #'mitq',-(SP)
            clr.w   -(SP)
            _RGetResource
            movea.l (SP)+,A0
            movea.l (A0),A0
            move.l  (-$C,A0,D7.w*4),D0
            move.l  D0,D3
            _NewPtr
            bne.w   sub_4083BFBE.L27
            move.l  A0,(-4,A6)
            adda.l  D3,A0
            movea.l A0,A5
            moveq   #1,D6
            lsl.l   D7,D6
            move.l  D6,D5
            addq.w  #2,D6
            move.l  D6,D0
            mulu.w  D6,D0
            mulu.w  D6,D0
            add.l   D0,D0
            move.l  D0,(-$10,A6)
            clr.b   (-$16,A6)
            _NewHandle
            beq.b   .notTemp2
            move.l  (-$10,A6),D0
            jsr     ([$1AB4.w])
            st      (-$16,A6)
            move.l  A0,D0
            beq.w   sub_4083BFBE.L26
.notTemp2:
            move.l  A0,(-$C,A6)
            movea.l (A0),A0
            movea.l A0,A3
            move.l  #$7FFF7FFF,D1
            move.l  #$80008000,D0
            move.w  D6,D4
            mulu.w  D6,D4
            sub.w   D6,D4
            subq.w  #1,D4
            lsr.w   #1,D4
.L14:
            move.l  D1,(A0)+
            dbra    D4,.L14
            subq.l  #2,A0
            move.w  D5,D4
            subq.w  #1,D4
.L15:
            move.l  D6,D3
            subq.w  #1,D3
.L16:
            move.l  D1,(A0)+
            dbra    D3,.L16
            move.l  D5,D2
            subq.w  #1,D2
.L17:
            move.l  D1,(A0)+
            move.w  D5,D3
            lsr.w   #1,D3
            subq.w  #1,D3
.L18:
            move.l  D0,(A0)+
            dbra    D3,.L18
            dbra    D2,.L17
            dbra    D4,.L15
            move.w  D1,(A0)+
            move.w  D6,D4
            mulu.w  D6,D4
            add.l   D6,D4
            subq.w  #1,D4
            lsr.w   #1,D4
.L19:
            move.l  D1,(A0)+
            dbra    D4,.L19
            move.l  D6,D4
            subq.w  #3,D4
            moveq   #8,D3
            sub.w   (8,A6),D3
            moveq   #1,D5
            lsl.w   D3,D5
            subq.w  #1,D5
            move.l  D6,D7
            mulu.w  D6,D7
            move.l  D7,D0
            add.l   D6,D0
            addq.w  #1,D0
            moveq   #0,D1
            moveq   #0,D2
            movea.l A5,A0
            suba.w  #$800,A0
            movea.l A0,A2
.L20:
            move.l  D5,D3
.L21:
            move.w  D0,(A0)+
            move.w  D1,(A0)+
            move.w  D2,(A0)+
            addq.w  #2,A0
            dbra    D3,.L21
            add.w   D7,D0
            add.w   D6,D1
            addq.w  #1,D2
            dbra    D4,.L20
            movea.l (-4,A6),A4
            addq.w  #2,A4
            movea.l ([$A.w,A6]),A1
            adda.l  (-$14,A6),A1
            clr.w   (A1)
            clr.w   (4,A1)
            clr.w   (2,A1)
            movea.l ([$E.w,A6]),A0
            moveq   #0,D5
            bsr.b   sub_4083BFBE
            move.w  (6,A0),D5
            bsr.b   sub_4083BFBE
            move.l  D5,D4
            subq.w  #2,D4
            ble.b   sub_4083BFBE.L4
            moveq   #1,D5
.L22:
            bsr.b   sub_4083BFBE
            addq.w  #1,D5
            dbra    D4,.L22
            bra.b   sub_4083BFBE.L4
sub_4083BFBE:
            btst    #6,(8,A0,D5.w*8)
            bne.b   .L3
            moveq   #0,D0
            moveq   #0,D1
            move.b  ($A,A0,D5.w*8),D0
            move.w  (0,A2,D0.w*8),D1
            move.b  ($C,A0,D5.w*8),D0
            add.w   (2,A2,D0.w*8),D1
            move.b  ($E,A0,D5.w*8),D0
            add.w   (4,A2,D0.w*8),D1
            move.w  (0,A3,D1.l*2),D2
            bmi.b   .L1
            move.b  (6,A1,D2.w),(6,A1,D5.w)
            move.b  D5,(6,A1,D2.w)
            addq.w  #1,(A1)
            bra.b   .L3
.L1:
            move.b  D5,(6,A1,D5.w)
            move.w  D5,(0,A3,D1.l*2)
            cmpa.l  A4,A5
            bne.b   .L2
            movea.l (-4,A6),A4
.L2:
            move.l  D1,D0
            addi.l  #0,D0
            move.w  D0,(A4)+
.L3:
            rts
.L4:
            movea.l (-4,A6),A1
            addq.l  #2,A1
            moveq   #1,D5
            bra.w   .L17
.L5:
            lea     (0,A3,D1.l*2),A0
            move.w  (A0),D4
            btst    #7,(0,A0,D5.l*2)
            beq.b   .L7
            move.w  D4,(0,A0,D5.l*2)
            cmpa.l  A4,A5
            bne.b   .L6
            movea.l (-4,A6),A4
.L6:
            move.l  D1,D0
            add.l   D5,D0
            move.w  D0,(A4)+
.L7:
            neg.l   D5
            btst    #7,(0,A0,D5.l*2)
            beq.b   .L9
            move.w  D4,(0,A0,D5.l*2)
            cmpa.l  A4,A5
            bne.b   .L8
            movea.l (-4,A6),A4
.L8:
            move.l  D1,D0
            add.l   D5,D0
            move.w  D0,(A4)+
.L9:
            btst    #7,(0,A0,D6.l*2)
            beq.b   .L11
            move.w  D4,(0,A0,D6.l*2)
            cmpa.l  A4,A5
            bne.b   .L10
            movea.l (-4,A6),A4
.L10:
            move.l  D1,D0
            add.l   D6,D0
            move.w  D0,(A4)+
.L11:
            neg.l   D6
            btst    #7,(0,A0,D6.l*2)
            beq.b   .L13
            move.w  D4,(0,A0,D6.l*2)
            cmpa.l  A4,A5
            bne.b   .L12
            movea.l (-4,A6),A4
.L12:
            move.l  D1,D0
            add.l   D6,D0
            move.w  D0,(A4)+
.L13:
            btst    #7,(0,A0,D7.l*2)
            beq.b   .L15
            move.w  D4,(0,A0,D7.l*2)
            cmpa.l  A4,A5
            bne.b   .L14
            movea.l (-4,A6),A4
.L14:
            move.l  D1,D0
            add.l   D7,D0
            move.w  D0,(A4)+
.L15:
            neg.l   D7
            btst    #7,(0,A0,D7.l*2)
            beq.b   .L17
            move.w  D4,(0,A0,D7.l*2)
            cmpa.l  A4,A5
            bne.b   .L16
            movea.l (-4,A6),A4
.L16:
            move.l  D1,D0
            add.l   D7,D0
            move.w  D0,(A4)+
            moveq   #0,D1
.L17:
            cmpa.l  A1,A5
            bne.b   .L18
            movea.l (-4,A6),A1
.L18:
            cmpa.l  A4,A1
            bne.b   .L19
            moveq   #0,D1
            bra.b   .L20
.L19:
            move.w  (A1)+,D1
.L20:
            bne.w   .L5
            movea.l ($A,A6),A0
            movea.l (A0),A0
            movea.l ([$E.w,A6]),A2
            move.l  (A2),(A0)+
            move.w  (8,A6),(A0)+
            move.l  (-$10,A6),D0
            lsr.l   #1,D0
            subq.w  #1,D0
            movea.l (-$C,A6),A2
            movea.l (A2),A2
.L21:
            move.w  (A2)+,D1
            cmpi.w  #$7FFF,D1
            beq.b   .L22
            move.b  D1,(A0)+
.L22:
            dbra    D0,.L21
            movea.l (-$C,A6),A0
            tst.b   (-$16,A6)
            beq.b   .QnotTmp
            jsr     ([$1A78.w])
            bra.b   .QallGone
.QnotTmp:
            _DisposHandle
.QallGone:
            movea.l (-4,A6),A0
            _DisposPtr
            move.l  (-8,A6),TheZone
.L25:
            movem.l (SP)+,D3-D7/A2-A5
            unlk    A6
            rtd     #$A
.L26:
            movea.l (-4,A6),A0
            _DisposPtr
.L27:
            move.w  #$FF69,QDErr
            bra.b   .L25
MAKEGRAYITAB:
            moveq   #-1,D0
            moveq   #$3F,D1
.L1:
            move.l  D0,-(SP)
            move.l  D0,-(SP)
            dbra    D1,.L1
            clr.w   ($1FE,SP)
            move.w  #$FF,(SP)
            movea.l ($E,A6),A0
            movea.l (A0),A0
            move.w  (6,A0),D0
            moveq   #0,D2
.L2:
            move.w  D0,D1
            btst    #6,(8,A0,D0.w*8)
            bne.b   .L3
            move.b  ($A,A0,D0.w*8),D2
            move.w  D1,(0,SP,D2.w*2)
.L3:
            dbra    D0,.L2
            movea.l SP,A1
            lea     ($200,A1),A1
.L4:
            moveq   #0,D1
            lea     (2,SP),A0
.L5:
            cmpa.l  A0,A1
            ble.b   .L6
            tst.w   (A0)+
            bpl.b   .L5
            move.w  (-4,A0),(-2,A0)
            addq.w  #2,A0
            st      D1
            bra.b   .L5
.L6:
            subq.w  #2,A0
.L7:
            cmpa.l  A0,SP
            bge.b   .L8
            tst.w   -(A0)
            bpl.b   .L7
            move.w  (2,A0),(A0)
            subq.w  #2,A0
            st      D1
            bra.b   .L7
.L8:
            tst.w   D1
            bne.b   .L4
            movea.l ($A,A6),A1
            movea.l (A1),A1
            movea.l ([$E.w,A6]),A2
            move.l  (A2),(A1)
            move.w  (8,A6),(4,A1)
            adda.l  (-$14,A6),A1
            bset    #$F,(2,A1)
            move.w  #$FF,D0
            lea     ($106,A1),A3
.L9:
            move.b  (1,SP,D0.w*2),D1
            move.b  D1,(6,A1,D0.w)
            move.b  ($A,A2,D1.w*8),(0,A3,D0.w)
            dbra    D0,.L9
            lea     ($200,SP),SP
            movea.l ([$A.w,A6]),A0
            moveq   #1,D0
            move.w  (4,A0),D2
            lsl.l   D2,D0
            subq.w  #1,D0
            lea     (6,A0),A0
            lea     (6,A1),A1
            move.w  #$200,D4
            lsr.w   D2,D4
            move.w  #$900,D5
            lsr.w   D2,D5
            subi.w  #$200,D5
            move.w  #$500,D6
            lsr.w   D2,D6
            subi.w  #$900,D6
            suba.l  A2,A2
            move.w  D0,D1
.L10:
            move.w  D0,D2
.L11:
            move.w  D0,D3
.L12:
            move.w  A2,D7
            lsr.w   #4,D7
            move.b  (0,A1,D7.w),(A0)+
            adda.w  D4,A2
            dbra    D3,.L12
            adda.w  D5,A2
            dbra    D2,.L11
            adda.w  D6,A2
            dbra    D1,.L10
            rts
            ds.b    12
ITabMatch:
            link.w  A6,#-$A
            move.l  A2,-(SP)
            clr.b   ($10,A6)
            movea.l ([TheGDevice.w]),A2
            movea.l ([$16.w,A2]),A1
            movea.l ($2A,A1),A0
            move.l  ([A0]),D1
            move.l  ([6.w,A2]),D0
            cmp.l   (D0.l),D1
            beq.b   .L1
            move.l  A0,-(SP)
            move.l  (6,A2),-(SP)
            move.w  ($A,A2),-(SP)
            jsr     ([$16E4.w])
            movea.l ([TheGDevice.w]),A2
            move.l  ([6.w,A2]),D0
.L1:
            movea.l D0,A0
            moveq   #1,D0
            move.w  (4,A0),D2
            lsl.l   D2,D0
            lsl.l   D2,D0
            lsl.l   D2,D0
            lea     (6,A0,D0.l),A1
            move.l  A1,(-$A,A6)
            tst.w   (2,A1)
            bpl.b   .L2
            movea.l ($C,A6),A0
            lea     (A0),A0
            moveq   #0,D0
            moveq   #0,D1
            moveq   #0,D2
            move.w  (A0)+,D0
            move.w  (A0)+,D1
            move.w  (A0),D2
            movea.l D1,A0
            add.l   D0,D1
            lsr.l   #1,D1
            add.l   D2,D1
            lsr.l   #1,D1
            add.l   D0,D1
            lsr.l   #1,D1
            add.l   A0,D1
            lsr.l   #1,D1
            lsr.l   #8,D1
            move.b  (6,A1,D1.w),D1
            bra.w   .L10
.L2:
            move.w  (4,A0),D2
            movea.l ($C,A6),A1
            bfextu  (A1){0:D2},D0
            lsl.l   D2,D0
            bfextu  (2,A1){0:D2},D1
            or.l    D1,D0
            lsl.l   D2,D0
            bfextu  (4,A1){0:D2},D1
            or.l    D1,D0
            move.b  (6,A0,D0.w),D1
            movea.l (-$A,A6),A1
            cmp.b   (6,A1,D1.w),D1
            beq.b   .L10
            movea.l ($C,A6),A0
            movea.l ([TheGDevice.w]),A2
            movea.l ([$16.w,A2]),A2
            movea.l ([$2A.w,A2]),A2
            move.w  D1,(-2,A6)
            move.w  D1,(-6,A6)
            move.w  #$7FFF,(-4,A6)
.L3:
            move.w  ($A,A2,D1.w*8),D0
            sub.w   (A0),D0
            bpl.b   .L4
            neg.w   D0
.L4:
            move.w  ($C,A2,D1.w*8),D2
            sub.w   (2,A0),D2
            bpl.b   .L5
            neg.w   D2
.L5:
            cmp.w   D2,D0
            bge.b   .L6
            move.w  D2,D0
.L6:
            move.w  ($E,A2,D1.w*8),D2
            sub.w   (4,A0),D2
            bpl.b   .L7
            neg.w   D2
.L7:
            cmp.w   D2,D0
            bge.b   .L8
            move.w  D2,D0
.L8:
            tst.w   D0
            beq.b   .L10
            cmp.w   (-4,A6),D0
            bge.b   .L9
            move.w  D0,(-4,A6)
            move.w  D1,(-2,A6)
.L9:
            move.b  (6,A1,D1.w),D1
            cmp.w   (-6,A6),D1
            bne.b   .L3
            move.w  (-2,A6),D1
.L10:
            movea.l (8,A6),A0
            ext.l   D1
            move.l  D1,(A0)
            move.b  #1,($10,A6)
            movea.l (SP)+,A2
            unlk    A6
            rtd     #8
            ds.b    10
COLORTHING2INDEX:
            link.w  A6,#-4
            clr.l   -(SP)
            movea.l (8,A6),A0
            move.w  (A0)+,-(SP)
            move.l  A0,(8,A6)
            moveq   #0,D0
            jsr     ([$1888.w])
            move.l  (SP)+,($C,A6)
            move.w  QDErr,D0
            bne.b   Color2Index.L1
            unlk    A6
            rtd     #4
Color2Index:
            link.w  A6,#-4
.L1:
            move.l  A2,-(SP)
            movea.l ([TheGDevice.w]),A2
            move.l  ($C,A2),D0
.L2:
            beq.b   .L4
            movea.l D0,A2
            movea.l D0,A0
            _HLock
            subq.w  #2,SP
            move.l  (8,A6),-(SP)
            pea     (-4,A6)
            movea.l (A2),A0
            movea.l (4,A0),A0
            jsr     (A0)
            movea.l A2,A0
            _HUnlock
            tst.b   (SP)+
            bne.b   .L3
            movea.l (A2),A0
            move.l  (A0),D0
            bra.b   .L2
.L3:
            move.l  (-4,A6),D0
            move.l  D0,($C,A6)
            movea.l (SP)+,A2
            unlk    A6
            rtd     #4
.L4:
            movea.l ([TheGDevice.w]),A0
            cmpi.w  #2,(4,A0)
            beq.b   .L5
            clr.b   -(SP)
            move.l  (8,A6),-(SP)
            pea     (-4,A6)
            jsr     ([$1C44.w])
            tst.b   (SP)+
            bra.b   .L7
.L5:
            movea.l ([$16.w,A0]),A1
            move.w  ($24,A1),D1
            movea.l (8,A6),A0
            moveq   #0,D0
            move.b  (A0),D0
            lsl.l   D1,D0
            move.b  (2,A0),D0
            lsl.l   D1,D0
            move.b  (4,A0),D0
            neg.w   D1
            addq.w  #8,D1
            ble.b   .L6
            lsr.l   D1,D0
.L6:
            move.l  D0,(-4,A6)
.L7:
            bra.b   .L3
            dc.w    0
Index2Color:
            move.l  (8,SP),D0
            movea.l (4,SP),A0
            movea.l ([TheGDevice.w]),A1
            movea.l ([$16.w,A1]),A1
            cmpi.w  #$10,($1E,A1)
            beq.b   .L3
            movea.l ([$2A.w,A1]),A1
            move.w  (6,A1),D1
            cmp.w   D1,D0
            bgt.b   .L2
            move.w  ($A,A1,D0.l*8),(A0)
            move.l  ($C,A1,D0.l*8),(2,A0)
.L1:
            rtd     #8
.L2:
            move.w  #$FF67,QDErr
            bra.b   .L1
.L3:
            moveq   #8,D1
            sub.w   ($24,A1),D1
            beq.b   .L4
            lsl.l   D1,D0
            move.w  ($24,A1),D1
            move.b  D0,D2
            lsl.w   D1,D2
            move.b  D0,D2
            lsr.w   D1,D2
            move.b  D2,(4,A0)
            move.b  D2,(5,A0)
            move.w  D0,D2
            lsr.l   D1,D0
            move.b  D0,D2
            lsr.w   D1,D2
            move.b  D2,(2,A0)
            move.b  D2,(3,A0)
            move.w  D0,D2
            lsr.l   D1,D0
            move.b  D0,D2
            lsr.w   D1,D2
            move.b  D2,(A0)
            move.b  D2,(1,A0)
            bra.b   .L1
.L4:
            move.b  D0,(4,A0)
            move.b  D0,(5,A0)
            lsr.w   #8,D0
            move.b  D0,(2,A0)
            move.b  D0,(3,A0)
            swap    D0
            move.b  D0,(A0)
            move.b  D0,(1,A0)
            bra.b   .L1
            ds.b    6
InvertColor:
            move.l  A2,-(SP)
            movea.l ([TheGDevice.w]),A2
            move.l  ($10,A2),D0
.L1:
            beq.b   .L3
            movea.l D0,A2
            movea.l D0,A0
            _HLock
            clr.b   -(SP)
            move.l  (8,SP),-(SP)
            movea.l (A0),A0
            movea.l (4,A0),A0
            jsr     (A0)
            movea.l A2,A0
            _HUnlock
            tst.b   (SP)+
            bne.b   .L2
            movea.l (A2),A0
            move.l  (A0),D0
            bra.b   .L1
.L2:
            movea.l (SP)+,A2
            rtd     #4
.L3:
            movea.l (8,SP),A0
            not.w   (A0)+
            not.w   (A0)+
            not.w   (A0)
            bra.b   .L2
            ds.b    14
RGBForeColor:
            moveq   #$50,D0
            moveq   #$24,D1
.L1:
            movea.l (4,SP),A1
            movea.l (A5),A0
            movea.l (A0),A0
            pea     (0,A0,D0.w)
            tst.w   (6,A0)
            bmi.b   .L2
            jsr     RGB2Old
            bra.b   .L6
.L2:
            move.l  (8,A0),D2
            beq.b   .L5
            movea.l D2,A1
            movea.l (A1),A1
            move.w  ($18,A1),D2
            cmpi.w  #$50,D0
            bne.b   .L3
            bclr    #0,D2
            bra.b   .L4
.L3:
            bclr    #1,D2
.L4:
            move.w  D2,($18,A1)
            movea.l (8,SP),A1
.L5:
            move.l  (A1),(0,A0,D1.w)
            move.w  (4,A1),(4,A0,D1.w)
            move.l  (2,A1),-(SP)
            move.w  (A1),-(SP)
            subq.w  #4,SP
            pea     (4,SP)
            jsr     ([$16CC.w])
            move.l  (SP)+,D0
            addq.w  #6,SP
.L6:
            movea.l (SP)+,A0
            move.l  D0,(A0)
            rtd     #4
RGB2Old:
            moveq   #0,D1
            move.w  (A1)+,D1
            add.l   D1,D1
            move.w  (A1)+,D1
            add.l   D1,D1
            move.w  (A1)+,D1
            add.l   D1,D1
            swap    D1
            lea     .L1,A0
            moveq   #0,D0
            move.w  (0,A0,D1.w*2),D0
            rts
.L1:
            dc.w    $0021,$0199,$0155,$0111,$00CD,$0089,$0045,$001E
RGBBackColor:
            moveq   #$54,D0
            moveq   #$2A,D1
            bra.w   RGBForeColor.L1
            dc.w    0
GetForeColor:
            moveq   #$50,D0
            moveq   #$24,D1
.L1:
            movea.l (4,SP),A1
            movea.l (A5),A0
            movea.l (A0),A0
            tst.w   (6,A0)
            bpl.b   .L3
            move.l  (0,A0,D1.w),(A1)
            move.w  (4,A0,D1.w),(4,A1)
.L2:
            movea.l (SP)+,A0
            addq.w  #4,SP
            jmp     (A0)
.L3:
            move.l  (0,A0,D0.w),D0
            lsr.w   #1,D0
            bcs.b   .L4
            ori.w   #$E0,D0
.L4:
            lsr.w   #5,D0
            andi.w  #7,D0
            movea.l QDColors,A0
            lea     (2,A0,D0.w*8),A0
            move.l  (A0)+,(A1)+
            move.w  (A0)+,(A1)+
            bra.b   .L2
GetBackColor:
            moveq   #$54,D0
            moveq   #$2A,D1
            bra.b   GetForeColor.L1
            ds.b    8
RealColor:
            link.w  A6,#-6
            clr.b   ($C,A6)
            subq.w  #4,SP
            move.l  (8,A6),-(SP)
            jsr     ([$16CC.w])
            pea     (-6,A6)
            jsr     ([$16D0.w])
            movea.l ([TheGDevice.w]),A0
            movea.l ([6.w,A0]),A0
            move.w  (4,A0),D2
            bfextu  ([8.w,A6]){0:D2},D0
            bfextu  (-6,A6){0:D2},D1
            cmp.w   D0,D1
            bne.b   .L1
            bfextu  ([8.w,A6],2.w){0:D2},D0
            bfextu  (-4,A6){0:D2},D1
            cmp.w   D0,D1
            bne.b   .L1
            bfextu  ([8.w,A6],4.w){0:D2},D0
            bfextu  (-2,A6){0:D2},D1
            cmp.w   D0,D1
            bne.b   .L1
            move.b  #1,($C,A6)
.L1:
            unlk    A6
            rtd     #4
            ds.b    12
SetEntries:
            link.w  A6,#-$28
            movem.l D3/A2,-(SP)
            movea.l ([TheGDevice.w]),A0
            move.w  (2,A0),D2
            cmpi.w  #0,(4,A0)
            bne.w   .L13
            movea.l ([$16.w,A0]),A0
            movea.l ([$2A.w,A0]),A2
            bset    #$D,(4,A2)
            bne.b   .L4
            move.w  ($C,A6),D1
            move.w  ($E,A6),D0
            bmi.b   .L5
            add.w   D1,D0
            cmp.w   (6,A2),D0
            bgt.b   .L3
.L1:
            btst    #7,(8,A2,D0.w*8)
            bne.b   .L4
            btst    #6,(8,A2,D0.w*8)
            beq.b   .L2
            cmp.b   (9,A2,D0.w*8),D2
            bne.b   .L4
.L2:
            subq.w  #1,D0
            dbra    D1,.L1
            bra.b   .L8
.L3:
            move.w  #$FF67,D0
            bra.w   .L14
.L4:
            move.w  #$FF66,D0
            bra.w   .L14
.L5:
            movea.l (8,A6),A0
.L6:
            move.w  (A0),D0
            andi.w  #$FF,D0
            cmp.w   (6,A2),D0
            bgt.b   .L3
            btst    #7,(8,A2,D0.w*8)
            bne.b   .L4
            btst    #6,(8,A2,D0.w*8)
            beq.b   .L7
            cmp.b   (9,A2,D0.w*8),D2
            bne.b   .L4
.L7:
            addq.w  #8,A0
            dbra    D1,.L6
.L8:
            move.w  ($E,A6),(-$24,A6)
            move.w  ($C,A6),(-$22,A6)
            move.l  (8,A6),(-$28,A6)
            clr.l   (-$14,A6)
            clr.w   (-$A,A6)
            movea.l ([TheGDevice.w]),A1
            move.w  (A1),(-8,A6)
            move.w  #3,(-6,A6)
            lea     (-$28,A6),A1
            move.l  A1,(-4,A6)
            lea     (-$20,A6),A0
            _Control immed
            tst.w   D0
            bne.b   .L14
            movea.l (8,A6),A0
            move.w  ($C,A6),D0
            move.w  ($E,A6),D1
            bmi.b   .L10
            lea     (8,A2,D1.w*8),A1
.L9:
            addq.w  #1,A1
            move.b  D2,(A1)+
            move.l  (A0)+,D3
            move.w  D3,(A1)+
            move.l  (A0)+,(A1)+
            dbra    D0,.L9
            bra.b   .L11
.L10:
            move.w  (A0)+,D3
            move.b  D2,(9,A2,D3.w*8)
            move.w  (A0)+,($A,A2,D3.w*8)
            move.l  (A0)+,($C,A2,D3.w*8)
            dbra    D0,.L10
.L11:
            clr.l   -(SP)
            jsr     ([$16A0.w])
            move.l  (SP)+,(A2)
            bclr    #$D,(4,A2)
            move.l  MinusOne,LastSPExtra
.L12:
            movem.l (SP)+,D3/A2
            unlk    A6
            rtd     #8
.L13:
            move.w  #$FF65,D0
.L14:
            move.w  D0,QDErr
            bra.b   .L12
            ds.b    10
RestoreEntries:
            link.w  A6,#-$28
            movem.l D3/A2-A3,-(SP)
            clr.w   QDErr
            movea.l ([$10.w,A6]),A2
            movea.l (8,A6),A1
            move.w  (A1),D2
            movea.l ([TheGDevice.w]),A0
            cmpi.w  #0,(4,A0)
            bne.w   .L11
            movea.l ([$16.w,A0]),A0
            movea.l ([$2A.w,A0]),A0
            movea.l ([$C.w,A6]),A3
            cmpa.l  A0,A3
            beq.b   .L1
            tst.l   ($C,A6)
            bne.b   .L6
            movea.l A0,A3
.L1:
            moveq   #0,D1
            move.w  D2,D1
            addq.w  #1,D1
            asl.w   #1,D1
            suba.w  D1,SP
            move.w  D2,D0
.L2:
            move.w  (8,A2,D0.w*8),(0,SP,D0.w*2)
            dbra    D0,.L2
            move.w  D2,D0
.L3:
            move.w  (2,A1,D0.w*2),D3
            cmp.w   (6,A3),D3
            bgt.w   .L12
            move.w  D3,(8,A2,D0.w*8)
            dbra    D0,.L3
            clr.l   (-$14,A6)
            clr.w   (-$A,A6)
            movea.l ([TheGDevice.w]),A0
            move.w  (A0),(-8,A6)
            move.w  #3,(-6,A6)
            lea     (-$28,A6),A0
            move.l  A0,(-4,A6)
            lea     (8,A2),A0
            move.l  A0,(-$28,A6)
            move.w  #$FFFF,(-$24,A6)
            move.w  D2,(-$22,A6)
            lea     (-$20,A6),A0
            _Control immed
            beq.b   .L4
            move.w  D0,QDErr
.L4:
            move.w  D2,D0
.L5:
            move.w  (0,SP,D0.w*2),(8,A2,D0.w*8)
            dbra    D0,.L5
            adda.w  D1,SP
.L6:
            move.w  (2,A1,D2.w*2),D0
            cmpi.w  #$FFFF,D0
            beq.b   .L7
            cmp.w   (6,A3),D0
            bgt.b   .L10
            move.l  (8,A2,D2.w*8),(8,A3,D0.w*8)
            move.l  ($C,A2,D2.w*8),($C,A3,D0.w*8)
.L7:
            dbra    D2,.L6
.L8:
            tst.l   ($C,A6)
            bne.b   .L9
            move.l  (8,A6),-(SP)
            move.w  #$12,D0
            _PaletteDispatch
.L9:
            movem.l (SP)+,D3/A2-A3
            unlk    A6
            rtd     #$C
.L10:
            move.w  #$FF67,QDErr
            bra.b   .L7
.L11:
            move.w  #$FF65,QDErr
            bra.b   .L9
.L12:
            move.w  #$FF67,QDErr
            move.w  D2,D0
.L13:
            move.w  (0,SP,D0.w*2),(8,A2,D0.w*8)
            dbra    D0,.L13
            adda.w  D1,SP
            bra.b   .L8
            dc.w    0
SaveEntries:
            link.w  A6,#0
            move.l  A2,-(SP)
            clr.w   QDErr
            tst.l   ($10,A6)
            bne.b   .L1
            movea.l ([TheGDevice.w]),A0
            cmpi.w  #0,(4,A0)
            bne.b   .L11
            movea.l ([$16.w,A0]),A0
            movea.l ([$2A.w,A0]),A2
            bra.b   .L2
.L1:
            movea.l ([$10.w,A6]),A2
.L2:
            movea.l (8,A6),A1
            move.w  (A1),D2
            move.w  D2,D0
            addq.w  #1,D0
            mulu.w  #8,D0
            addq.w  #8,D0
            movea.l ($C,A6),A0
            tst.l   (A0)
            beq.b   .L3
            _SetHandleSize
            bra.b   .L4
.L3:
            _ReallocHandle
.L4:
            beq.b   .L5
            move.w  #$FF68,QDErr
            bra.b   .L8
.L5:
            movea.l (A0),A0
            clr.l   (A0)
            clr.w   (4,A0)
            move.w  D2,(6,A0)
.L6:
            move.w  (2,A1,D2.w*2),D0
            cmp.w   (6,A2),D0
            bgt.b   .L10
            move.l  (8,A2,D0.w*8),(8,A0,D2.w*8)
            move.l  ($C,A2,D0.w*8),($C,A0,D2.w*8)
.L7:
            dbra    D2,.L6
.L8:
            movea.l (SP)+,A2
            unlk    A6
.L9:
            rtd     #$C
.L10:
            move.w  #$FFFF,(2,A1,D2.w*2)
            move.w  #$FF67,QDErr
            bra.b   .L7
.L11:
            move.w  #$FF65,QDErr
            bra.b   .L9
            dc.w    0
ProtectEntry:
            moveq   #7,D2
            bsr.b   CTCommon
.L1:
            rtd     #4
.L2:
            move.w  #$FF66,QDErr
            bra.b   .L4
.L3:
            move.w  #$FF67,QDErr
.L4:
            addq.w  #4,SP
            bra.b   .L1
CTCommon:
            clr.w   QDErr
            movea.l ([TheGDevice.w]),A0
            movea.l ([$16.w,A0]),A0
            movea.l ([$2A.w,A0]),A0
            move.w  ($A,SP),D0
            cmp.w   (6,A0),D0
            bgt.b   ProtectEntry.L3
            tst.b   (8,SP)
            beq.b   .L1
            btst    D2,(8,A0,D0.w*8)
            bne.b   ProtectEntry.L2
            bset    D2,(8,A0,D0.w*8)
            bra.b   .L2
.L1:
            bclr    D2,(8,A0,D0.w*8)
.L2:
            rts
ReserveEntry:
            moveq   #6,D2
            bsr.b   CTCommon
            tst.b   (4,SP)
            beq.b   .L1
            move.w  (8,A0,D0.w*8),D1
            movea.l ([TheGDevice.w]),A1
            move.b  (3,A1),(9,A0,D0.w*8)
.L1:
            clr.l   -(SP)
            jsr     ([$16A0.w])
            move.l  (SP)+,(A0)
            rtd     #4
            ds.b    6
SetClientID:
            movea.l ([TheGDevice.w]),A0
            move.w  (4,SP),(2,A0)
            rtd     #2
AddSearch:
            clr.w   QDErr
            move.l  (SP)+,D2
            move.l  (SP)+,D1
            beq.b   .L1
            moveq   #8,D0
            _NewHandle
            bne.b   .L2
            move.l  D1,D0
            jsr     ([$644.w])
            movea.l ([TheGDevice.w]),A1
            move.l  ($C,A1),D1
            move.l  A0,($C,A1)
            movea.l (A0),A0
            move.l  D0,(4,A0)
            move.l  D1,(A0)
.L1:
            jmp     (D2.l)
.L2:
            move.w  #$FF68,QDErr
            bra.b   .L1
AddComp:
            clr.w   QDErr
            move.l  (SP)+,D2
            move.l  (SP)+,D1
            beq.b   .L1
            moveq   #8,D0
            _NewHandle
            bne.b   AddSearch.L2
            move.l  D1,D0
            jsr     ([$644.w])
            movea.l ([TheGDevice.w]),A1
            move.l  ($10,A1),D1
            move.l  A0,($10,A1)
            movea.l (A0),A0
            move.l  D0,(4,A0)
            move.l  D1,(A0)
.L1:
            jmp     (D2.l)
            ds.b    4
DelSearch:
            move.l  (4,SP),D1
            movea.l ([TheGDevice.w]),A1
            lea     ($C,A1),A1
            move.l  (A1),D2
.L1:
            beq.b   .L3
            movea.l D2,A0
            movea.l (A0),A0
            cmp.l   (4,A0),D1
            beq.b   .L2
            lea     (A0),A1
            move.l  (A0),D2
            bra.b   .L1
.L2:
            move.l  (A0),(A1)
            movea.l D2,A0
            _DisposHandle
.L3:
            rtd     #4
            ds.b    4
DelComp:
            move.l  (4,SP),D1
            movea.l ([TheGDevice.w]),A1
            lea     ($10,A1),A1
            move.l  (A1),D2
.L1:
            beq.b   .L3
            movea.l D2,A0
            movea.l (A0),A0
            cmp.l   (4,A0),D1
            beq.b   .L2
            lea     (A0),A1
            move.l  (A0),D2
            bra.b   .L1
.L2:
            move.l  (A0),(A1)
            movea.l D2,A0
            _DisposHandle
.L3:
            rtd     #4
            ds.b    4
GetSubTable:
            link.w  A6,#-$C
            movem.l D3/A2,-(SP)
            tst.l   (8,A6)
            beq.b   .L1
            _NewEmptyHandle
            move.l  A0,(-4,A6)
            move.l  (8,A6),-(SP)
            move.l  A0,-(SP)
            move.w  ($C,A6),-(SP)
            jsr     ([$16E4.w])
            tst.w   QDErr
            bne.b   .L3
            movea.l ([TheGDevice.w]),A1
            move.l  (6,A1),(-8,A6)
            move.l  (-4,A6),(6,A1)
            movea.l ([$16.w,A1]),A1
            move.l  ($2A,A1),(-$C,A6)
            move.l  ($E,A6),($2A,A1)
            movea.l ([$2A.w,A1]),A1
            move.l  (A1),D0
            movea.l ([-4.w,A6]),A1
            move.l  D0,(A1)
.L1:
            movea.l ($E,A6),A0
            _HLock
            movea.l (A0),A2
            move.w  (6,A2),D3
.L2:
            subq.w  #4,SP
            pea     ($A,A2,D3.w*8)
            jsr     ([$16CC.w])
            addq.w  #2,SP
            move.w  (SP)+,(8,A2,D3.w*8)
            dbra    D3,.L2
            movea.l ($E,A6),A0
            _HUnlock
            tst.l   (8,A6)
            beq.b   .L4
            movea.l ([TheGDevice.w]),A1
            move.l  (-8,A6),(6,A1)
            movea.l ([$16.w,A1]),A1
            move.l  (-$C,A6),($2A,A1)
.L3:
            movea.l (-4,A6),A0
            _DisposHandle
.L4:
            movem.l (SP)+,D3/A2
            unlk    A6
            rtd     #$A
            ds.b    12
QDError:
            move.w  QDErr,(4,SP)
            clr.w   QDErr
            rts
            ds.b    4
DELTARGB:
            link.w  A6,#0
            movem.l D0-D1/A0-A1,-(SP)
            movea.l ($C,A6),A0
            movea.l (8,A6),A1
            move.w  (A1)+,D0
            sub.w   (A0)+,D0
            bcc.b   .L1
            neg.w   D0
.L1:
            move.w  (A1)+,D1
            sub.w   (A0)+,D1
            bcc.b   .L2
            neg.w   D1
.L2:
            cmp.w   D0,D1
            bcs.b   .L3
            move.w  D1,D0
.L3:
            move.w  (A1),D1
            sub.w   (A0),D1
            bcc.b   .L4
            neg.w   D1
.L4:
            cmp.w   D0,D1
            bcs.b   .L5
            move.w  D1,D0
.L5:
            move.w  D0,($10,A6)
            movem.l (SP)+,D0-D1/A0-A1
            unlk    A6
            rtd     #8
            ds.b    12
.L6:
            dc.w    0,$FFFF,$5555,0,$1111
            ds.b    6
            dc.w    $0101
.L7:
            andi.w  #$F,D0
            move.w  D0,(4,SP)
            moveq   #0,D1
            addq.w  #3,D0
            bset    D0,D1
            addq.l  #8,D1
            move.l  D1,D0
            _NewHandle
            beq.b   .L8
            clr.l   (6,SP)
            rtd     #2
.L8:
            move.w  (4,SP),D0
            lea     .L6,A1
            move.w  (0,A1,D0.w*2),D1
            move.w  D1,D2
            swap    D2
            move.w  D1,D2
            movea.l (A0),A1
            move.w  #$8000,(4,A1)
            clr.w   D1
            bset    D0,D1
            subq.w  #1,D1
            move.w  D1,(6,A1)
            cmpi.w  #3,D0
            blt.b   .L9
            addi.w  #$20,D0
.L9:
            move.l  D0,(A1)
            lea     (8,A1),A1
            moveq   #-1,D0
            moveq   #0,D1
.L10:
            move.w  D1,(A1)+
            addq.w  #1,D1
            move.l  D0,(A1)+
            move.w  D0,(A1)+
            sub.l   D2,D0
            bcc.b   .L10
            bra.w   GETCTABLE.L1
.L11:
            andi.w  #$F,D0
            move.w  D0,-(SP)
            bsr.w   sub_4083CDBE
            move.l  A0,D0
            beq.w   GETCTABLE.L1
            movea.l (A0),A1
            subq.w  #4,SP
            jsr     ([$16A0.w])
            move.l  (SP)+,(A1)
            move.w  (4,SP),D0
            btst    #1,D0
            beq.b   .L13
            lea     ($DA0).w,A1
            move.b  (A1),D1
            cmp.b   (2,A1),D1
            bne.b   .L12
            cmp.b   (4,A1),D1
            beq.w   GETCTABLE.L1
.L12:
            movea.l (A0),A1
            lea     ($12,A1),A1
            move.l  #$7FFF7FFF,(A1)+
            move.w  #$7FFF,(A1)+
            addq.w  #2,A1
            move.l  ($DA0).w,(A1)+
            move.w  ($DA4).w,(A1)
            bra.w   GETCTABLE.L1
.L13:
            btst    #2,D0
            beq.w   GETCTABLE.L1
            move.w  #$E,D2
            move.l  #$1FFFF,D1
.L14:
            subq.w  #2,SP
            pea     ($DA0).w
            pea     ($A,A1,D2.w*8)
            jsr     DELTARGB
            move.w  (SP)+,D0
            cmp.w   D0,D1
            bls.b   .L15
            move.w  D0,D1
            swap    D1
            move.w  D2,D1
            swap    D1
.L15:
            subq.w  #1,D2
            bne.b   .L14
            cmpi.w  #$3000,D1
            bls.b   GETCTABLE.L1
            swap    D1
            lea     ($A,A1,D1.w*8),A1
.L16:
            move.l  ($DA0).w,D0
            swap    D0
            add.w   (A1),D0
            roxr.w  #1,D0
            move.w  D0,(A1)
            swap    D0
            add.w   (2,A1),D0
            roxr.w  #1,D0
            move.w  D0,(2,A1)
            move.w  ($DA4).w,D0
            add.w   (4,A1),D0
            roxr.w  #1,D0
            move.w  D0,(4,A1)
            subq.w  #2,SP
            pea     ($DA0).w
            pea     (A1)
            jsr     DELTARGB
            cmpi.w  #$3000,(SP)+
            bhi.b   .L16
            bra.b   GETCTABLE.L1
GETCTABLE:
            move.w  (4,SP),-(SP)
            bsr.b   sub_4083CDBE
            move.l  A0,D0
            beq.b   .L3
.L1:
            move.l  A0,(6,SP)
.L2:
            rtd     #2
.L3:
            move.w  (4,SP),D0
            cmpi.w  #$48,D0
            bhi.b   .L2
            move.l  #$116,D1
            btst    D0,D1
            beq.b   .L2
            btst    #5,D0
            bne.w   DELTARGB.L7
            btst    #6,D0
            bne.w   DELTARGB.L11
            bra.b   .L2
sub_4083CDBE:
            subq.w  #4,SP
            move.l  #'clut',-(SP)
            move.w  ($C,SP),-(SP)
            jsr     ([$1480.w])
            move.l  (SP)+,D0
            beq.b   .L1
            move.l  D0,-(SP)
            move.l  D0,-(SP)
            jsr     ([$1448.w])
            movea.l (SP)+,A0
            _HNoPurge
            movea.l (A0),A1
            subq.w  #4,SP
            jsr     ([$16A0.w])
            move.l  (SP)+,(A1)
            bra.b   .L3
.L1:
            move.w  #$FFFF,ROMMapInsert
            subq.w  #4,SP
            move.l  #'clut',-(SP)
            move.w  ($C,SP),-(SP)
            jsr     ([$1480.w])
            move.l  (SP)+,D0
            beq.b   .L2
            movea.l D0,A0
            jsr     ([$1584.w])
            beq.b   .L3
.L2:
            suba.l  A0,A0
.L3:
            rtd     #2
            ds.b    4
AngleFromSlope:
            move.l  (4,SP),D0
            smi     D2
            bpl.b   .L1
            neg.l   D0
.L1:
            subi.l  #$1F4,D0
            move.l  D0,(4,SP)
            lea     CONTINUE_Angles,A0
            moveq   #-1,D1
.L2:
            addq.w  #1,D1
            move.w  D1,D0
            clr.l   -(SP)
            bra.b   SlopeFromAngle.L3
CONTINUE_Angles:
            move.l  (8,SP),D0
            cmp.l   (SP)+,D0
            bgt.b   AngleFromSlope.L2
            move.w  #$B4,D0
            sub.w   D1,D0
            tst.b   D2
            bpl.b   .L1
            move.w  D1,D0
.L1:
            move.l  (SP)+,(SP)
            move.w  D0,(4,SP)
            rts
SlopeFromAngle:
            movea.l (SP)+,A0
            move.w  (SP)+,D0
            ext.l   D0
            divs.w  #$B4,D0
            swap    D0
            tst.w   D0
            bpl.b   .L2
.L1:
            addi.w  #$B4,D0
.L2:
            move.w  #$8000,(SP)
.L3:
            cmpi.w  #$5A,D0
            ble.b   .L4
            clr.w   (SP)
            subi.w  #$B4,D0
            neg.w   D0
.L4:
            cmpi.w  #$2D,D0
            blt.b   .L5
            addq.w  #1,(SP)
            cmpi.w  #$40,D0
            blt.b   .L5
            move.b  .L1+3(PC,D0.w),(1,SP)
            bpl.b   .L5
            ori.b   #$7F,(SP)
.L5:
            add.w   D0,D0
            move.w  .L7(PC,D0.w),(2,SP)
            bclr    #7,(SP)
            beq.b   .L6
            neg.l   (SP)
.L6:
            jmp     (A0)
            dc.w    $0102,$0202,$0202,$0202,$0203,$0303,$0304,$0404
            dc.w    $0505,$0607,$0809,$0B0E,$131C,$39FF
.L7:
            dc.w    0,$0478,$08F1,$0D6B,$11E7,$1666,$1AE8,$1F6F
            dc.w    $23FA,$288C,$2D24,$31C3,$366A,$3B1A,$3FD4,$4498
            dc.b    'IhNDS.X&]-bEgnl'
            dc.b    $AA,$71,$FB,$77,$60,$7C,$DC,$82,$70,$88,$1E,$8D,$E7,$93,$CD,$99
            dc.b    $D2,$9F,$F7,$A6,$40,$AC,$AD,$B3,$41,$B9,$FF,$C0,$E9,$C8,$02,$CF
            dc.b    $4E,$D6,$CF,$DE,$8A,$E6,$81,$EE,$B9,$F7,$37,$00,$00,$09,$19,$12
            dc.b    $87,$1C,$51,$26,$7F,$31,$17,$3C,$22,$47,$AA,$53,$B9,$60,$5B,$6D
            dc.b    $9B,$7B,$89,$8A,$35,$99,$AF,$AA,$0E,$BB,$68,$CD,$D6,$E1,$77,$F6
            dc.b    $6E,$0C,$E1,$24,$FE,$3E,$FC,$5B,$19,$79,$9F,$9A,$E7,$BF,$5B,$E7
            dc.b    $7A,$13,$E3,$45,$56,$7C,$C7,$BB,$68,$02,$C2,$54,$DB,$B4,$62,$25
            dc.b    $01,$AB,$D9,$50,$51,$1D,$88,$24,$F3,$83,$AD,$6E,$17,$4C,$F5,$14
            dc.b    $BD,$A2,$D7,$4A,$30,$FF,$FF
            ds.b    14
PtToAngle:
            link.w  A6,#0
            movem.l D6-D7/A4,-(SP)
            movea.l ($10,A6),A4
            move.w  (4,A4),D0
            add.w   (A4),D0
            asr.w   #1,D0
            move.w  ($C,A6),D1
            sub.w   D0,D1
            move.w  (6,A4),D0
            add.w   (2,A4),D0
            asr.w   #1,D0
            move.w  ($E,A6),D7
            sub.w   D0,D7
            bne.b   .L1
            tst.w   D1
            ble.b   .L2
            move.w  #$B4,D0
            bra.b   .L3
.L1:
            clr.l   -(SP)
            move.w  D7,-(SP)
            move.w  D1,-(SP)
            jsr     ([$FA4.w])
            move.l  (SP)+,D6
            clr.l   -(SP)
            move.w  (4,A4),D0
            sub.w   (A4),D0
            move.w  D0,-(SP)
            move.w  (6,A4),D0
            sub.w   (2,A4),D0
            move.w  D0,-(SP)
            jsr     ([$FA4.w])
            move.l  (SP)+,D0
            clr.l   -(SP)
            move.l  D6,-(SP)
            move.l  D0,-(SP)
            jsr     ([$FA0.w])
            move.l  (SP)+,D0
            clr.w   -(SP)
            move.l  D0,-(SP)
            jsr     ([$1110.w])
            move.w  (SP)+,D0
            tst.w   D7
            bpl.b   .L3
            addi.w  #$B4,D0
            cmpi.w  #$168,D0
            bne.b   .L3
.L2:
            clr.w   D0
.L3:
            movea.l (8,A6),A0
            move.w  D0,(A0)
            movem.l (SP)+,D6-D7/A4
            unlk    A6
            rtd     #$C
            ds.b    6
PutOval:
            link.w  A6,#-$36
            movem.l D0-D7/A1-A5,-(SP)
            movea.l ($18,A6),A0
            lea     (-$2E,A6),A1
            move.w  ($16,A6),D2
            move.w  ($14,A6),D1
            bsr.l   InitOval
            move.w  (-$C,A6),(-$34,A6)
            move.w  (-8,A6),(-$36,A6)
            move.w  ($14,A6),D0
            asr.w   #1,D0
            add.w   (-$2E,A6),D0
            move.w  D0,(-$30,A6)
            movea.l ($18,A6),A0
            add.w   (4,A0),D0
            sub.w   (A0),D0
            sub.w   ($14,A6),D0
            move.w  D0,(-$32,A6)
            movea.l ($10,A6),A3
            movea.l (A3),A3
            movea.l A3,A2
            movea.l ($C,A6),A0
            adda.w  (A0),A3
            movea.l A2,A1
            movea.l (8,A6),A0
            adda.w  (A0),A1
            move.w  (-$2E,A6),D6
            move.w  (-$34,A6),D5
            bsr.w   PUTPT
            move.w  (-$36,A6),D5
            bsr.b   PUTPT
.L1:
            cmp.w   (-$30,A6),D6
            blt.b   .L2
            cmp.w   (-$32,A6),D6
            blt.b   .L4
.L2:
            movem.l D6/A1-A3,-(SP)
            lea     (-$2E,A6),A3
            move.w  D6,D0
            bsr.l   BumpOval
            movem.l (SP)+,D6/A1-A3
            move.w  (-$C,A6),D5
            cmp.w   (-$34,A6),D5
            beq.b   .L3
            bsr.b   PUTPT
            move.w  (-$34,A6),D5
            bsr.b   PUTPT
            move.w  (-$C,A6),(-$34,A6)
.L3:
            move.w  (-8,A6),D5
            cmp.w   (-$36,A6),D5
            beq.b   .L4
            bsr.b   PUTPT
            move.w  (-$36,A6),D5
            bsr.b   PUTPT
            move.w  (-8,A6),(-$36,A6)
.L4:
            addq.w  #1,D6
            cmp.w   (-$2C,A6),D6
            blt.b   .L1
            move.w  (-$34,A6),D5
            bsr.b   PUTPT
            move.w  (-$36,A6),D5
            bsr.b   PUTPT
            suba.l  A2,A3
            movea.l ($C,A6),A0
            move.w  A3,(A0)
            movem.l (SP)+,D0-D7/A1-A5
            unlk    A6
            rtd     #$14
PUTPT:
            cmpa.l  A1,A3
            blt.b   .L2
            suba.l  A2,A3
            suba.l  A2,A1
            cmpa.l  #$FC00,A1
            blt.b   .L1
            adda.l  A2,A3
            adda.l  A2,A1
            move.w  #$FF6D,QDErr
            rts
.L1:
            lea     ($400,A1),A1
            movem.l D0-D7/A0-A3,-(SP)
            movea.l (8,A6),A0
            move.w  A1,(A0)
            move.l  ($10,A6),-(SP)
            move.w  A1,-(SP)
            bsr.l   SetHSize
            movem.l (SP)+,D0-D7/A0-A3
            movea.l ($10,A6),A2
            movea.l (A2),A2
            adda.l  A2,A3
            adda.l  A2,A1
.L2:
            cmpa.l  A2,A3
            beq.b   .L3
            cmp.w   (-2,A3),D5
            bne.b   .L3
            cmp.w   (-4,A3),D6
            bne.b   .L3
            subq.w  #4,A3
            rts
.L3:
            move.w  D6,(A3)+
            move.w  D5,(A3)+
            rts
            ds.b    10
PackRgn:
            link.w  A6,#-8
            movem.l D0-D7/A1-A4,-(SP)
            movea.l ($E,A6),A4
            movea.l (8,A6),A3
            move.w  ($C,A6),D6
            movea.l (A3),A1
            move.w  (A1),D5
            movea.l (A4),A0
            moveq   #$A,D7
            clr.l   (-8,A6)
            clr.l   (-4,A6)
            cmpi.w  #4,D6
            bgt.b   .L1
            blt.b   .L8
            move.l  (A0),(-8,A6)
            move.l  ($C,A0),(-4,A6)
            bra.b   .L8
.L1:
            move.w  (A0),(-8,A6)
            move.w  (2,A0),D1
            move.w  D1,D2
            move.w  D6,D3
.L2:
            subq.w  #1,D3
            blt.b   .L4
            move.l  (A0)+,D0
            cmp.w   D1,D0
            bge.b   .L3
            move.w  D0,D1
            bra.b   .L2
.L3:
            cmp.w   D2,D0
            ble.b   .L2
            move.w  D0,D2
            bra.b   .L2
.L4:
            move.w  D1,(-6,A6)
            move.w  D2,(-2,A6)
            move.w  (-4,A0),(-4,A6)
            moveq   #3,D5
            add.w   D6,D5
            lsl.w   #2,D5
            move.l  A3,-(SP)
            move.w  D5,-(SP)
            bsr.l   SetHSize
            movea.l (A4),A0
            movea.l (A3),A1
            adda.w  D7,A1
            subq.w  #1,D6
            move.w  (A0)+,D0
            move.w  #$7FFF,D1
            bra.b   .L6
.L5:
            cmp.w   (A0)+,D0
            beq.b   .L7
            move.w  D1,(A1)+
            move.w  (-2,A0),D0
.L6:
            move.w  D0,(A1)+
.L7:
            move.w  (A0)+,(A1)+
            dbra    D6,.L5
            move.w  D1,(A1)+
            move.w  D1,(A1)+
            movea.l (A3),A0
            suba.l  A0,A1
            move.w  A1,D7
.L8:
            movea.l (A3),A0
            move.w  D7,(A0)+
            move.l  (-8,A6),(A0)+
            move.l  (-4,A6),(A0)+
            cmp.w   D7,D5
            beq.b   .L9
            move.l  A3,-(SP)
            move.w  D7,-(SP)
            bsr.l   SetHSize
.L9:
            movem.l (SP)+,D0-D7/A1-A4
            unlk    A6
            rtd     #$A
            ds.b    8
RgnOp:
            link.w  A6,#-$56
            movem.l D3-D7/A2-A4,-(SP)
            move.l  SP,(-$56,A6)
            lea     (-$4E,A6),A2
            lea     ($18,A6),A0
            bsr.w   EXPAND
            movea.l A0,A3
            lea     ($14,A6),A0
            bsr.w   EXPAND
            movea.l A0,A4
            lea     SectScan,A0
            move.w  ($C,A6),D0
            beq.b   .L1
            lea     DiffScan,A0
            subq.w  #2,D0
            beq.b   .L1
            lea     UnionScan,A0
            subq.w  #2,D0
            beq.b   .L1
            lea     XorScan,A0
            subq.w  #2,D0
            beq.b   .L1
            lea     InsetScan,A0
.L1:
            move.l  A0,(-$52,A6)
            movea.l ($594).w,A0
            jsr     (A0)
            subi.l  #$640,D0
            cmpi.l  #$C8,D0
            bge.b   .L2
            move.w  #$28,D0
            bra.b   .L4
.L2:
            divs.w  #5,D0
            bvc.b   .L3
            move.w  #$7530,D0
.L3:
            bclr    #0,D0
.L4:
            suba.w  D0,SP
            move.l  SP,(-4,A6)
            suba.w  D0,SP
            move.l  SP,(-8,A6)
            suba.w  D0,SP
            move.l  SP,(-$C,A6)
            suba.w  D0,SP
            move.l  SP,(-$10,A6)
            suba.w  D0,SP
            move.l  SP,(-$14,A6)
            movea.l ($10,A6),A0
            movea.l (A0),A0
            move.l  A0,(-$1E,A6)
            andi.w  #$FFF8,($E,A6)
            moveq   #0,D4
            move.w  ($E,A6),D4
            adda.l  D4,A0
            move.l  A0,(-$22,A6)
            movea.l (-4,A6),A0
            move.l  A0,D4
            move.w  #$7FFF,D0
            move.w  D0,(A0)
            movea.l (-8,A6),A0
            move.l  A0,D5
            move.w  D0,(A0)
            movea.l (-$C,A6),A0
            move.l  A0,D6
            move.w  D0,(A0)
            movea.l (-$10,A6),A0
            move.l  A0,D7
            move.w  (A3)+,(-$16,A6)
            move.w  (A4)+,(-$18,A6)
            cmpi.w  #8,($C,A6)
            bne.b   .L5
            move.w  D0,(-$18,A6)
.L5:
            move.w  (-$16,A6),D0
            cmp.w   (-$18,A6),D0
            beq.b   UPDATEA.L1
            bgt.b   UPDATEA.L2
            bsr.b   UPDATEA
            bra.b   UPDATEA.L3
UPDATEA:
            move.w  (-$16,A6),(-$1A,A6)
            movea.l A3,A0
            movea.l D4,A1
            movea.l D7,A2
            jsr     XorScan
            movea.l A0,A3
            move.w  (A3)+,(-$16,A6)
            exg     D4,D7
            rts
.L1:
            cmpi.w  #$7FFF,D0
            beq.w   EXPAND.L5
            bsr.b   UPDATEA
.L2:
            move.w  (-$18,A6),(-$1A,A6)
            movea.l A4,A0
            movea.l D5,A1
            movea.l D7,A2
            jsr     XorScan
            movea.l A0,A4
            move.w  (A4)+,(-$18,A6)
            exg     D7,D5
.L3:
            movea.l D4,A0
            movea.l D5,A1
            movea.l D7,A2
            move.w  ($A,A6),D2
            pea     CHANGES
            move.l  (-$52,A6),-(SP)
            rts
CHANGES:
            movea.l D7,A0
            movea.l D6,A1
            movea.l (-$14,A6),A2
            jsr     XorScan
            exg     D7,D6
            movea.l (-$14,A6),A0
            movea.l (-$1E,A6),A1
            movea.l (-$22,A6),A2
            move.l  (-$1A,A6),D0
            bra.b   .L2
.L1:
            move.w  (A0)+,D0
            move.l  D0,(A1)+
            move.w  (A0)+,D0
            move.l  D0,(A1)+
.L2:
            cmpa.l  A2,A1
            bcs.b   .L3
            tst.b   (8,A6)
            beq.w   EXPAND.L4
            move.l  A0,D1
            movea.l ($18,A6),A0
            suba.l  (A0),A3
            movea.l ($14,A6),A0
            suba.l  (A0),A4
            movea.l ($10,A6),A0
            suba.l  (A0),A1
            suba.l  (A0),A2
            lea     ($100,A2),A2
            movem.l D0-D2/A0-A2,-(SP)
            move.l  A0,-(SP)
            move.w  A2,-(SP)
            bsr.l   SetHSize
            movem.l (SP)+,D0-D2/A0-A2
            movea.l ($18,A6),A0
            adda.l  (A0),A3
            movea.l ($14,A6),A0
            adda.l  (A0),A4
            movea.l ($10,A6),A0
            adda.l  (A0),A1
            adda.l  (A0),A2
            move.l  A2,(-$22,A6)
            movea.l D1,A0
.L3:
            cmpi.w  #$7FFF,(A0)
            bne.b   .L1
            move.l  A1,(-$1E,A6)
            bra.w   RgnOp.L5
EXPAND:
            movea.l (A0),A1
            movea.l (A1),A1
            cmpi.w  #$A,(A1)
            bne.b   .L3
            move.l  A2,(A0)
            lea     (-6,A2),A0
            move.l  A0,(A2)+
            move.l  (2,A1),(A2)+
            move.w  (8,A1),(A2)
            move.w  #$7FFF,D0
            cmp.w   (A2)+,D0
            bne.b   .L1
            subq.w  #1,(-2,A2)
.L1:
            move.w  D0,(A2)+
            move.w  (6,A1),(A2)
            cmp.w   (A2)+,D0
            bne.b   .L2
            subq.w  #1,(-2,A2)
.L2:
            move.w  (4,A1),(A2)+
            move.w  (8,A1),(A2)+
            move.w  D0,(A2)+
            move.w  D0,(A2)+
            movea.l A0,A1
.L3:
            lea     ($A,A1),A0
            rts
.L4:
            move.l  A1,(-$1E,A6)
.L5:
            move.l  (-$1E,A6),D0
            movea.l ($10,A6),A0
            sub.l   (A0),D0
            lsr.w   #2,D0
            move.w  D0,($1C,A6)
            movea.l (-$56,A6),SP
            movem.l (SP)+,D3-D7/A2-A4
            unlk    A6
            rtd     #$14
            ds.b    8
SectScan:
            clr.w   D2
            clr.w   D3
            bra.b   UnionScan.L2
DiffScan:
            clr.w   D2
            bra.b   UnionScan.L1
UnionScan:
            moveq   #-1,D2
.L1:
            moveq   #-1,D3
.L2:
            move.w  (A0)+,D0
            move.w  (A1)+,D1
.L3:
            cmp.w   D1,D0
            blt.b   .L5
            bgt.b   .L7
            cmpi.w  #$7FFF,D0
            beq.b   .L9
            cmp.w   D3,D2
            bne.b   .L4
            move.w  D0,(A2)+
.L4:
            move.w  (A0)+,D0
            not.w   D2
            move.w  (A1)+,D1
            not.w   D3
            bra.b   .L3
.L5:
            tst.w   D3
            beq.b   .L6
            move.w  D0,(A2)+
.L6:
            move.w  (A0)+,D0
            not.w   D2
            bra.b   .L3
.L7:
            tst.w   D2
            beq.b   .L8
            move.w  D1,(A2)+
.L8:
            move.w  (A1)+,D1
            not.w   D3
            bra.b   .L3
.L9:
            move.w  #$7FFF,(A2)+
            rts
            ds.b    4
InsetScan:
            tst.w   D2
            blt.b   .L2
.L1:
            cmpi.w  #$7FFF,(A0)
            beq.b   .L7
            move.w  (A0)+,D0
            move.w  (A0)+,D1
            add.w   D2,D0
            sub.w   D2,D1
            cmp.w   D1,D0
            bge.b   .L1
            move.w  D0,(A2)+
            move.w  D1,(A2)+
            bra.b   .L1
.L2:
            movea.w #$8001,A1
            bra.b   .L6
.L3:
            move.w  (A0)+,D0
            move.w  (A0)+,D1
            add.w   D2,D0
            sub.w   D2,D1
            cmp.w   A1,D0
            bgt.b   .L4
            subq.w  #2,A2
            bra.b   .L5
.L4:
            move.w  D0,(A2)+
.L5:
            move.w  D1,(A2)+
            movea.w D1,A1
.L6:
            cmpi.w  #$7FFF,(A0)
            bne.b   .L3
.L7:
            move.w  #$7FFF,(A2)+
            rts
.L8:
            cmpi.w  #$7FFF,D0
            beq.b   .L7
XorScan:
            move.w  (A0)+,D0
            move.w  (A1)+,D1
.L1:
            cmp.w   D1,D0
            beq.b   InsetScan.L8
            blt.b   .L2
            move.w  D1,(A2)+
            move.w  (A1)+,D1
            bra.b   .L1
.L2:
            move.w  D0,(A2)+
            move.w  (A0)+,D0
            bra.b   .L1
SEEDCFILL:
            link.w  A6,#-$1E
            move.l  ($10,A6),-(SP)
            pea     (-$A,A6)
            jsr     ([$165C.w])
            lea     sub_4083D6FC,A0
            moveq   #-1,D0
            bra.b   CALCCMASK.L1
CALCCMASK:
            link.w  A6,#-$1E
            movea.l ($10,A6),A0
            lea     (-$A,A6),A1
            move.l  (A0)+,(A1)+
            move.w  (A0)+,(A1)+
            lea     sub_4083D728,A0
            moveq   #0,D0
.L1:
            movem.l D3-D5/A2-A4,-(SP)
            move.l  D0,D5
            move.l  ($C,A6),D0
            bne.b   .L2
            move.l  A0,($C,A6)
.L2:
            pea     (-$18,A6)
            jsr     ([$1664.w])
            move.l  #$21,-(SP)
            jsr     ([$F88.w])
            pea     (-$1E,A6)
            jsr     ([$1668.w])
            move.l  #$1E,-(SP)
            jsr     ([$F8C.w])
            clr.l   -(SP)
            jsr     GETTEMPDEVICE
            movea.l (SP)+,A4
            move.l  TheGDevice,(-$12,A6)
            move.l  A4,TheGDevice
            movea.l (A4),A0
            movea.l ($16,A0),A0
            _HLock
            movea.l (A0),A3
            movea.l (A4),A1
            lea     (-$A,A6),A0
            move.l  A0,($1A,A1)
            move.l  (8,A6),(-4,A6)
            move.l  ($C,A6),-(SP)
            jsr     ([$16E8.w])
            movea.l ($18,A6),A0
            move.l  (A0)+,D1
            move.l  (A0)+,D0
            move.w  D0,D4
            sub.w   D1,D4
            ext.l   D4
            moveq   #$F,D2
            add.l   D2,D4
            asr.l   #4,D4
            ble.w   .L6
            add.w   D4,D4
            lea     (4,A3),A0
            move.w  D4,(A0)
            ori.w   #$8000,(A0)+
            move.l  D1,(A0)+
            move.l  D0,(A0)+
            swap    D1
            swap    D0
            sub.w   D1,D0
            mulu.w  D0,D4
            move.l  D4,D0
            moveq   #$F,D1
            add.l   D1,D0
            _NewHandle
            bne.w   .L6
            movea.l (A0),A1
            lsr.l   #4,D4
            move.l  D4,D0
            swap    D0
.L3:
            move.l  D5,(A1)+
            move.l  D5,(A1)+
            move.l  D5,(A1)+
            move.l  D5,(A1)+
            dbra    D4,.L3
            dbra    D0,.L3
            move.l  A0,(-$E,A6)
            _HLock
            move.l  (A0),(A3)
            move.l  ($20,A6),-(SP)
            move.l  A3,-(SP)
            move.l  ($18,A6),-(SP)
            move.l  (SP),-(SP)
            clr.w   -(SP)
            clr.l   -(SP)
            jsr     ([$11B0.w])
            movea.l ($1C,A6),A0
            move.l  (A0)+,D0
            _StripAddress
            movea.l D0,A1
            move.w  (A0)+,D0
            move.l  (A0)+,D1
            movea.l ($14,A6),A0
            move.l  (A0)+,D2
            move.l  (A0),D3
            move.l  ($10,A6),D4
            sub.w   D2,D3
            addi.w  #$F,D3
            asr.w   #4,D3
            ble.b   .L5
            sub.w   D1,D4
            sub.w   D1,D2
            add.w   D2,D4
            asr.w   #3,D2
            adda.w  D2,A1
            swap    D1
            swap    D2
            swap    D3
            swap    D4
            sub.w   D2,D3
            ble.b   .L5
            sub.w   D1,D4
            sub.w   D1,D2
            add.w   D2,D4
            swap    D4
            muls.w  D0,D2
            adda.l  D2,A1
            move.l  (A3),-(SP)
            move.l  A1,-(SP)
            move.w  (4,A3),D1
            andi.w  #$7FFF,D1
            move.w  D1,-(SP)
            move.w  D0,-(SP)
            move.l  D3,-(SP)
            tst.w   D5
            beq.b   .L4
            move.l  D4,-(SP)
            jsr     ([$EE4.w])
            bra.b   .L5
.L4:
            jsr     ([$EE0.w])
.L5:
            movea.l (-$E,A6),A0
            _DisposHandle
.L6:
            move.l  ($C,A6),-(SP)
            jsr     ([$1730.w])
            move.l  (-$12,A6),TheGDevice
            move.l  A4,-(SP)
            jsr     ([$16C0.w])
            pea     (-$18,A6)
            jsr     ([$1650.w])
            pea     (-$1E,A6)
            jsr     ([$1654.w])
            movem.l (SP)+,D3-D5/A2-A4
            unlk    A6
            rtd     #$1C
sub_4083D6FC:
            moveq   #0,D1
            moveq   #1,D0
.L1:
            move.w  #$100,($C,SP)
            movea.l (8,SP),A0
            movea.l TheGDevice,A1
            movea.l (A1),A1
            movea.l ($1A,A1),A1
            cmpm.l  (A0)+,(A1)+
            bne.b   .L2
            cmpm.w  (A0)+,(A1)+
            bne.b   .L2
            exg     D0,D1
.L2:
            movea.l (4,SP),A0
            move.l  D0,(A0)
            rtd     #8
sub_4083D728:
            moveq   #1,D1
            moveq   #0,D0
            bra.b   sub_4083D6FC.L1
            dc.w    0
GETTEMPDEVICE:
            move.l  A4,-(SP)
            clr.l   -(SP)
            clr.w   -(SP)
            move.l  MinusOne,-(SP)
            jsr     ([$16BC.w])
            movea.l (SP)+,A4
            movea.l A4,A0
            _HUnlock
            movea.l (A4),A0
            movea.l ($16,A0),A0
            movea.l (A0),A0
            clr.w   ($1E,A0)
            move.w  #1,($20,A0)
            move.w  #1,($24,A0)
            movea.l ($2A,A0),A0
            movea.l (A0),A0
            clr.l   -(SP)
            jsr     ([$16A0.w])
            move.l  (SP),(A0)
            movea.l (A4),A0
            movea.l ([6.w,A0]),A0
            move.l  (SP)+,(A0)
            move.l  A4,(8,SP)
            movea.l (SP)+,A4
            rts
MASKEND:
XPALETTES:
SYSCOLORS:
            dc.w    0,$0003,0,$000F,0,$FFFF,$FFFF,$FFFF
            dc.w    $0001
            ds.b    6
SYSCOLOREND:
            ds.b    8
UPDATEPALETTE:
            link.w  A6,#-$74
            movem.l D3-D4/A2-A4,-(SP)
            moveq   #1,D3
            clr.l   (-4,A6)
            movea.l ($DC8).w,A2
            movea.l (8,A6),A3
            bra.b   ACTIVATEPALETTE.L2
ACTIVATEPALETTE:
            link.w  A6,#-$74
            movem.l D3-D4/A2-A4,-(SP)
            moveq   #1,D3
            movea.l ($DC8).w,A2
            cmpa.w  #$FFFF,A2
            beq.w   .L16
            movea.l (A2),A0
            move.w  (A0),D0
            beq.w   .L16
            movea.l (8,A6),A3
            cmpa.w  #0,A3
            beq.w   .L16
            move.l  A3,(-4,A6)
            tst.w   (6,A3)
            bpl.b   .L1
            movea.l (8,A3),A0
            movea.l (A0),A0
            movea.l ($C,A0),A3
            cmpa.w  #0,A3
            bne.b   .L2
.L1:
            movea.l ($DCC).w,A3
            move.l  A3,D0
            bne.b   .L2
            movea.l (A2),A0
            movea.l ($C,A0),A3
            move.l  A3,D0
            beq.w   .L16
.L2:
            movea.l A2,A0
            _HLock
            movea.l A3,A0
            move.l  A3,(-8,A6)
            _HLock
            movea.l (A2),A4
            move.l  A4,(-$12,A6)
            movea.l (4,A4),A0
            _HLock
            move.l  (A0),(-$1A,A6)
            move.w  (A4),(-$22,A6)
            lea     ($38,A4),A0
            move.l  A0,(-$16,A6)
            move.l  TheGDevice,(-$44,A6)
            clr.l   (-$3C,A6)
            movea.l (A3),A4
            move.l  A4,(-$C,A6)
            move.w  (A4),D4
            move.w  D4,(-$E,A6)
            clr.w   (-$48,A6)
            clr.w   (-$4A,A6)
            jsr     CALCDEVS
            clr.w   -(SP)
            jsr     SCATTERDEVICES
            tst.l   (-$30,A6)
            beq.w   .L10
            lea     ($10,A4),A4
            move.w  (-$E,A6),D4
            bra.b   .L7
.L3:
            move.w  (6,A4),D1
            btst    #2,D1
            beq.b   .L4
            addq.w  #1,(-$48,A6)
            bra.b   .L6
.L4:
            btst    #1,D1
            beq.b   .L5
            move.l  (A4),D0
            move.b  (4,A4),D0
            tst.l   D0
            beq.b   .L5
            addq.l  #1,D0
            beq.b   .L5
            addq.w  #1,(-$4A,A6)
            bra.b   .L6
.L5:
            bset    #$F,(6,A4)
.L6:
            lea     ($10,A4),A4
.L7:
            dbra    D4,.L3
            move.w  (-$48,A6),D0
            or.w    (-$4A,A6),D0
            beq.w   .L10
            move.l  #$200,D0
            _NewHandleClear
            bne.w   .L12
            move.l  A0,(-$3C,A6)
            _HLock
            movea.l (A0),A0
            move.l  A0,(-$40,A6)
            moveq   #0,D4
.L8:
            move.l  (-$30,A6),D0
            btst    D4,D0
            beq.b   .L9
            move.w  (-$48,A6),(-$4C,A6)
            move.w  (-$4A,A6),(-$4E,A6)
            move.w  D4,(-$1C,A6)
            jsr     SETDEV
            beq.b   .L9
            addq.w  #1,D3
.L9:
            addq.w  #1,D4
            cmp.w   (-$22,A6),D4
            bmi.b   .L8
            move.l  (-$44,A6),TheGDevice
.L10:
            movea.l (-$12,A6),A0
            movea.l (4,A0),A0
            movea.l (A0),A0
            movea.l (-$C,A6),A1
            move.w  (6,A1),D0
            andi.w  #$FFF,D0
            move.w  (4,A0,D0.w*8),D0
            beq.b   .L11
            movea.l (-$12,A6),A0
            move.l  (8,A1),D0
            move.l  (-$2C,A6),D1
            not.l   D1
            and.l   D1,D0
            beq.b   .L11
            jsr     UNRESERVEDEVICES
.L11:
            clr.w   -(SP)
            jsr     SCATTERDEVICES
            jsr     UPDATEDEVICES
            move.l  (-$2C,A6),(8,A1)
            subq.w  #1,D3
.L12:
            movea.l (-$12,A6),A0
            movea.l (4,A0),A0
            _HUnlock
            movea.l A2,A0
            _HUnlock
            movea.l (-$C,A6),A0
            bclr    #$D,(6,A0)
            move.w  (A0),D0
            lea     ($10,A0),A0
            bra.b   .L14
.L13:
            move.w  (6,A0),D1
            andi.w  #$3F0F,D1
            move.w  D1,(6,A0)
            adda.w  #$10,A0
.L14:
            dbra    D0,.L13
            movea.l A3,A0
            _HUnlock
            movea.l (-$3C,A6),A0
            cmpa.w  #0,A0
            beq.b   .L15
            _DisposHandle
.L15:
            moveq   #0,D3
.L16:
            move.l  D3,D0
            movem.l (SP)+,D3-D4/A2-A4
            unlk    A6
            rtd     #4
            ds.b    12
Allocate:
            movem.l D3-D4/A2-A3,-(SP)
            tst.w   (-$4C,A6)
            beq.w   .L7
            movea.l (-$C,A6),A3
            moveq   #0,D4
            moveq   #0,D2
            moveq   #0,D3
            lea     ($10,A3),A2
            bra.b   .L6
.L1:
            move.w  ($A,A2),D0
            bmi.b   .L5
            btst    #2,D0
            beq.b   .L5
            btst    #3,($B,A2)
            beq.b   .L2
            move.w  D4,D3
            and.w   (-$46,A6),D3
            beq.b   .L5
            cmp.w   (-$46,A6),D3
            beq.b   .L5
            bftst   (-$74,A6){D3:1}
            bne.b   .L5
            bfset   (-$74,A6){D3:1}
            clr.w   -(SP)
            move.w  ($C,A2),-(SP)
            jsr     FINDLINK
            move.w  (SP)+,D2
            bne.b   .L4
            move.w  D3,-(SP)
            jsr     PILLAGE
            move.w  D3,D2
            bra.b   .L3
.L2:
            clr.w   -(SP)
            move.w  ($C,A2),-(SP)
            jsr     FINDLINK
            move.w  (SP)+,D2
            bne.b   .L4
            subq.w  #2,SP
            bsr.w   GIMMEINDEX
            move.w  (SP)+,D2
            beq.b   .L5
.L3:
            move.w  D2,-(SP)
            jsr     PILLAGE
            move.w  D4,D0
            movea.l A2,A0
            bsr.w   CLAIMINDEX
.L4:
            bset    #$F,($A,A2)
.L5:
            adda.w  #$10,A2
            addq.w  #1,D4
.L6:
            cmp.w   (A3),D4
            blt.b   .L1
.L7:
            movem.l (SP)+,D3-D4/A2-A3
            rts
CHECKALLDEVICECLUTS:
            movem.l D3-D4/A0-A3,-(SP)
            movea.l ($DC8).w,A2
            movea.l A2,A0
            _HLock
            movea.l (A2),A3
            move.w  (A3),D3
            subq.w  #1,D3
            moveq   #0,D4
.L1:
            subq.w  #2,SP
            move.l  ($38,A3,D3.w*8),-(SP)
            jsr     CHECKDEVICECOLORS
            tst.w   (SP)+
            beq.b   .L2
            bset    D3,D4
.L2:
            dbra    D3,.L1
            or.l    D4,($10,A3)
            movea.l A2,A0
            _HUnlock
            movem.l (SP)+,D3-D4/A0-A3
            rts
            ds.b    10
CHECKFORJUGGLER:
            move.l  A0,-(SP)
            move.w  #$A88F,D0
            _GetTrapAddress
            move.l  A0,-(SP)
            move.w  #$A89F,D0
            _GetTrapAddress
            cmpa.l  (SP)+,A0
            seq     D0
            extb.l  D0
            movea.l (SP)+,A0
            rts
            ds.b    6
PMGREXIT:
            cmpi.l  #$FFFFFFFF,($DC8).w
            beq.b   .L1
            clr.l   ($DCC).w
            jsr     DISPOSEAPPPALETTES
            jsr     CHECKALLDEVICECLUTS
            clr.w   -(SP)
            jsr     SCATTERDEVICES
            bsr.b   CHECKFORJUGGLER
            bne.b   .L1
            jsr     UPDATEDEVICES
            move.l  MainDevice,TheGDevice
.L1:
            rts
            ds.b    4
INSTALLMYEXITTOSHELL:
            jsr     CHECKFORJUGGLER
            movea.l ($DC8).w,A0
            movea.l (A0),A0
            lea     ($18,A0),A0
            or.l    (A0),D0
            bne.b   .L1
            move.l  ($15D0).w,(A0)
            lea     MYEXITTOSHELL,A0
            move.l  A0,($15D0).w
.L1:
            rts
MYEXITTOSHELL:
            moveq   #$C,D0
            _PaletteDispatch
            movea.l ($DC8).w,A0
            movea.l (A0),A0
            movea.l ($18,A0),A0
            jmp     (A0)
RECORDPALETTE:
            link.w  A6,#0
            movem.l D3/A2-A4,-(SP)
            movea.l (8,A6),A4
            movea.l ($DC8).w,A2
            cmpa.w  #$FFFF,A2
            beq.w   .L8
            movea.l (A2),A0
            movea.l (4,A0),A3
            moveq   #0,D0
            move.w  (2,A0),D0
            _NewHandleClear
            bne.w   .L8
            movea.l (A4),A1
            move.l  A0,($C,A1)
            movea.l (A2),A1
            move.w  ($A,A1),D0
            bne.b   .L3
            moveq   #0,D3
            move.w  (8,A1),D3
            move.l  D3,D0
            addi.w  #$10,D0
            bmi.b   .L8
            lsl.l   #3,D0
            movea.l A3,A0
            _SetHandleSize
            bne.b   .L8
            movea.l A3,A0
            movea.l (A0),A0
            lea     (0,A0,D3.w*8),A0
            moveq   #$10,D0
            bra.b   .L2
.L1:
            clr.l   (A0)+
            clr.l   (A0)+
.L2:
            dbra    D0,.L1
            addq.w  #1,D3
            movea.l (A3),A0
            lea     (0,A0,D3.w*8),A0
            movea.l (A2),A1
            move.w  #$F,($A,A1)
            bra.b   .L7
.L3:
            move.w  (8,A1),D0
            add.w   ($A,A1),D0
            moveq   #0,D3
            movea.l (A3),A0
            bra.b   .L5
.L4:
            move.l  (A0),D1
            beq.b   .L6
            addq.w  #8,A0
            addq.w  #1,D3
.L5:
            dbra    D0,.L4
            bra.b   .L8
.L6:
            subq.w  #1,($A,A1)
.L7:
            addq.w  #1,(8,A1)
            move.l  A4,(A0)
            clr.l   (4,A0)
            movea.l (A4),A0
            move.w  (6,A0),D0
            andi.w  #$E000,D0
            or.w    D0,D3
            move.w  D3,(6,A0)
            moveq   #0,D0
            bra.b   .L9
.L8:
            movea.l A4,A0
            _DisposHandle
            moveq   #1,D0
.L9:
            tst.l   D0
            movem.l (SP)+,D3/A2-A4
            unlk    A6
            rtd     #4
            ds.b    12
NewPalette:
            link.w  A6,#0
            movem.l D3/A2,-(SP)
            clr.l   ($12,A6)
            move.w  ($10,A6),D3
            moveq   #0,D0
            move.w  D3,D0
            addq.w  #1,D0
            lsl.l   #4,D0
            _NewHandleClear
            bne.b   .L7
            movea.l A0,A2
            move.l  A2,-(SP)
            jsr     RECORDPALETTE
            bne.b   .L7
            move.l  A2,($12,A6)
            movea.l (A2),A0
            move.w  D3,(A0)
            clr.l   (2,A0)
            move.w  D3,D0
            move.w  ($A,A6),D1
            swap    D1
            move.w  (8,A6),D1
            lea     ($16,A0),A0
            bra.b   .L2
.L1:
            move.l  D1,(A0)
            lea     ($10,A0),A0
.L2:
            dbra    D0,.L1
            movea.l ($C,A6),A1
            cmpa.w  #0,A1
            beq.b   .L6
            movea.l (A1),A1
            move.w  (6,A1),D0
            addq.w  #1,D0
            ble.b   .L6
            movea.l (A2),A0
            adda.w  #$10,A0
            adda.w  #$A,A1
            cmp.w   D0,D3
            bge.b   .L3
            move.w  D3,D0
.L3:
            moveq   #0,D1
            bra.b   .L5
.L4:
            move.l  (A1),(A0)
            move.b  (A1),(1,A0)
            move.b  (2,A1),(3,A0)
            move.w  (4,A1),(4,A0)
            move.b  (4,A1),(5,A0)
            addq.l  #8,A1
            adda.w  #$10,A0
.L5:
            dbra    D0,.L4
.L6:
            moveq   #0,D0
.L7:
            movem.l (SP)+,D3/A2
            unlk    A6
            rtd     #$A
            ds.b    12
GetNewPalette:
            link.w  A6,#0
            move.l  A2,-(SP)
            clr.l   ($A,A6)
            clr.l   -(SP)
            move.l  #'pltt',-(SP)
            move.w  (8,A6),-(SP)
            jsr     ([$1480.w])
            move.l  (SP)+,D1
            beq.b   .L2
            movea.l D1,A2
            move.l  D1,-(SP)
            jsr     ([$1448.w])
            movea.l A2,A0
            _HNoPurge
            tst.w   D0
            bne.b   .L2
            movea.l (A2),A0
            move.w  #$C000,D1
            move.w  (2,A0),D0
            bpl.b   .L1
            add.w   D0,D0
            move.w  D0,D1
.L1:
            move.w  D1,(6,A0)
            move.l  A2,-(SP)
            jsr     RECORDPALETTE
            bne.b   .L2
            move.l  A2,($A,A6)
            movea.l (A2),A2
            clr.l   (8,A2)
.L2:
            movea.l (SP)+,A2
            unlk    A6
            rtd     #2
CLAIMINDEX:
            movea.l (-$28,A6),A1
            movea.l (A1),A1
            subq.w  #4,SP
            jsr     ([$16A0.w])
            move.l  (SP)+,(A1)
            bset    #$F,($A,A0)
            move.l  (A0),($A,A1,D2.w*8)
            move.w  (4,A0),($E,A1,D2.w*8)
            addq.w  #1,(-$52,A6)
            bset    #6,(8,A1,D2.w*8)
            movea.l (-$20,A6),A1
            andi.w  #$7FFF,D0
            ori.w   #$6000,D0
            move.w  D0,(2,A1,D2.w*4)
            move.w  (-$1C,A6),D0
            lsl.w   #8,D0
            or.w    D2,D0
            bset    #$F,D0
            move.w  ($C,A0),D1
            move.w  D0,($C,A0)
            tst.w   D1
            bne.b   .L1
            movea.l (-$C,A6),A0
            move.w  (6,A0),D0
            andi.w  #$FFF,D0
            ori.w   #$6000,D0
            move.w  D0,(0,A1,D2.w*4)
            bra.b   .L2
.L1:
            move.w  D1,(0,A1,D2.w*4)
            bfextu  D1{24:8},D2
            bfextu  D1{19:5},D1
            lsl.w   #8,D1
            add.w   D2,D1
            movea.l (-$12,A6),A1
            adda.w  #$138,A1
            move.w  D0,(2,A1,D1.l*4)
.L2:
            movea.l (-$1A,A6),A0
            movea.l (-$C,A6),A1
            move.w  (6,A1),D0
            andi.w  #$FFF,D0
            addq.w  #1,(4,A0,D0.w*8)
            addq.w  #1,(-$52,A6)
            rts
            dc.w    0
CLEARPALETTE:
            link.w  A6,#0
            movem.l D2-D4/A2-A4,-(SP)
            movea.l ($DC8).w,A3
            cmpa.w  #$FFFF,A3
            beq.b   .L6
            movea.l (A3),A3
            movea.l (8,A6),A1
            movea.l (A1),A2
            move.w  (6,A2),D0
            andi.w  #$FFF,D0
            movea.l (4,A3),A0
            movea.l (A0),A0
            cmpa.l  (0,A0,D0.w*8),A1
            bne.b   .L7
            move.w  (4,A0,D0.w*8),D3
            clr.l   (4,A0,D0.w*8)
            clr.l   (8,A2)
            movea.l ($C,A2),A0
            movea.l (A0),A0
            move.w  (2,A3),D0
            lsr.w   #2,D0
            bra.b   .L2
.L1:
            clr.l   (A0)+
.L2:
            dbra    D0,.L1
            tst.w   D3
            beq.b   .L6
            move.w  (A2),D0
            adda.w  #$10,A2
            lea     ($38,A3),A4
            adda.w  #$138,A3
            bra.b   .L5
.L3:
            move.w  ($C,A2),D3
            bpl.b   .L4
            jsr     CLEARSTRAND
            or.l    D4,(-$128,A3)
.L4:
            clr.w   ($A,A2)
            clr.l   ($C,A2)
            adda.w  #$10,A2
.L5:
            dbra    D0,.L3
.L6:
            moveq   #0,D0
.L7:
            movem.l (SP)+,D2-D4/A2-A4
            unlk    A6
            rtd     #4
            ds.b    4
CLEARSTRAND:
            moveq   #0,D4
.L1:
            bfextu  D3{19:5},D1
            bfextu  D3{24:8},D2
            movea.l (0,A4,D1.w*8),A0
            movea.l (A0),A0
            movea.l ($16,A0),A0
            movea.l (A0),A0
            movea.l ($2A,A0),A0
            movea.l (A0),A0
            cmp.w   (6,A0),D2
            bhi.b   .L2
            move.w  #$1000,(8,A0,D2.w*8)
            bset    D1,D4
.L2:
            lsl.w   #8,D1
            add.w   D2,D1
            lea     (0,A3,D1.l*4),A0
            move.w  (A0),D3
            clr.l   (A0)
            tst.w   D3
            bmi.b   .L1
            rts
            ds.b    4
ERASEPALETTE:
            link.w  A6,#0
            movem.l A2-A3,-(SP)
            movea.l (8,A6),A3
            movea.l (A3),A2
            movea.l ($C,A2),A0
            cmpa.w  #0,A0
            beq.b   .L1
            _DisposHandle
.L1:
            movea.l WindowList,A0
            bra.b   .L4
.L2:
            tst.w   (6,A0)
            bpl.b   .L3
            movea.l (8,A0),A1
            movea.l (A1),A1
            move.l  ($C,A1),D0
            cmp.l   (8,A6),D0
            bne.b   .L3
            clr.l   ($C,A1)
.L3:
            movea.l ($90,A0),A0
.L4:
            move.l  A0,D0
            bne.b   .L2
            cmpa.l  ($DCC).w,A3
            bne.b   .L5
            clr.l   ($DCC).w
.L5:
            move.w  (6,A2),D0
            andi.w  #$FFF,D0
            movea.l ($DC8).w,A2
            cmpa.w  #$FFFF,A2
            beq.b   .L6
            movea.l (A2),A2
            move.w  (8,A2),D1
            add.w   ($A,A2),D1
            cmp.w   D1,D0
            bpl.b   .L6
            movea.l (4,A2),A1
            movea.l (A1),A1
            cmpa.l  (0,A1,D0.w*8),A3
            bne.b   .L6
            clr.l   (0,A1,D0.w*8)
            addq.w  #1,($A,A2)
            subq.w  #1,(8,A2)
.L6:
            movem.l (SP)+,A2-A3
            unlk    A6
            rtd     #4
            dc.w    0
CORRELATE:
            movem.l D3-D7/A2-A3,-(SP)
            tst.w   (-$4E,A6)
            beq.w   .L11
            moveq   #0,D4
            movea.l (-$C,A6),A2
            lea     ($10,A2),A2
            movea.l (-$28,A6),A3
            movea.l A3,A0
            _HLock
            movea.l (A3),A3
            moveq   #0,D3
.L1:
            move.w  (6,A2),D7
            btst    #1,D7
            beq.b   .L3
            btst    #3,D7
            beq.b   .L3
            move.w  D4,D3
            and.w   (-$46,A6),D3
            beq.b   .L3
            cmp.w   (-$46,A6),D3
            beq.b   .L3
            bftst   (-$74,A6){D3:1}
            bne.b   .L3
            bfset   (-$74,A6){D3:1}
            move.w  D3,-(SP)
            jsr     PILLAGE
            subq.w  #2,SP
            pea     (A2)
            pea     ($A,A3,D3.w*8)
            bsr.l   DELTARGB
            move.w  (SP)+,D1
            cmp.w   (8,A2),D1
            bls.b   .L2
            lea     (8,A3,D3.w*8),A0
            move.l  (A2),(2,A0)
            move.w  (4,A2),(6,A0)
            bset    #5,(A0)
            subq.w  #4,SP
            jsr     ([$16A0.w])
            move.l  (SP)+,(A3)
            addq.w  #1,(-$52,A6)
.L2:
            bset    #$F,($A,A2)
.L3:
            lea     ($10,A2),A2
            addq.w  #1,D4
            cmp.w   (-$E,A6),D4
            blt.b   .L1
            movea.l (-$C,A6),A2
            lea     ($10,A2),A2
            moveq   #0,D7
            moveq   #0,D4
            move.w  (-$46,A6),D5
.L4:
            tst.w   ($A,A2)
            bmi.w   .L9
            btst    #1,(7,A2)
            beq.w   .L9
            move.w  (8,A2),D6
            cmpi.w  #$21,(-$4E,A6)
            blt.b   .L5
            btst    #$1F,D4
            beq.b   .L5
            cmpi.w  #$400,D6
            bls.b   .L6
.L5:
            subq.w  #4,SP
            pea     (A2)
            jsr     ([$16CC.w])
            move.l  (SP)+,D7
            subq.w  #2,SP
            pea     (A2)
            pea     ($A,A3,D7.w*8)
            bsr.l   DELTARGB
            cmp.w   (SP)+,D6
            bcc.b   .L8
            bftst   (-$74,A6){D7:1}
            beq.b   .L7
.L6:
            subq.w  #2,SP
            bsr.w   GIMMEINDEX
            move.w  (SP)+,D7
            beq.b   .L10
            bftst   (-$74,A6){D7:1}
            bne.b   .L6
            move.w  D7,-(SP)
            jsr     PILLAGE
.L7:
            lea     (8,A3,D7.w*8),A0
            move.l  (A2),(2,A0)
            move.w  (4,A2),(6,A0)
            bset    #5,(A0)
            subq.w  #4,SP
            jsr     ([$16A0.w])
            move.l  (SP)+,(A3)
            addq.w  #1,(-$52,A6)
            bset    #$1F,D4
.L8:
            bfset   (-$74,A6){D7:1}
.L9:
            lea     ($10,A2),A2
            addq.w  #1,D4
            cmp.w   (-$E,A6),D4
            bne.w   .L4
.L10:
            movea.l (-$28,A6),A0
            _HUnlock
.L11:
            movem.l (SP)+,D3-D7/A2-A3
            rts
            ds.b    8
DISPOSEAPPPALETTES:
            movem.l D0-D3/A0-A3,-(SP)
            movea.l ($DC8).w,A2
            cmpa.l  MinusOne,A2
            beq.w   .L5
            movea.l (A2),A1
            movea.l (4,A1),A0
            _HLock
            movea.l (A0),A3
            move.w  (8,A1),D3
            beq.b   .L4
            add.w   ($A,A1),D3
            clr.l   WindowList
            bra.b   .L3
.L1:
            move.l  (A3),D1
            beq.b   .L2
            cmp.l   ApplZone,D1
            bcs.b   .L2
            cmp.l   HeapEnd,D1
            bcc.b   .L2
            move.l  D1,-(SP)
            jsr     ([$184C.w])
.L2:
            addq.w  #8,A3
.L3:
            dbra    D3,.L1
.L4:
            movea.l (A2),A1
            movea.l (4,A1),A0
            _HUnlock
.L5:
            clr.l   ($DCC).w
            movem.l (SP)+,D0-D3/A0-A3
            rts
            ds.b    6
DEVSETENTRIES:
            move.l  A2,-(SP)
            move.l  TheGDevice,-(SP)
            movea.l (A0),A2
            movea.l ($16,A2),A2
            movea.l (A2),A2
            movea.l ($2A,A2),A2
            movea.l (A2),A2
            move.l  (A2),-(SP)
            move.l  A0,TheGDevice
            clr.w   -(SP)
            move.w  (6,A2),-(SP)
            pea     (8,A2)
            jsr     ([$16FC.w])
            move.l  (SP)+,(A2)
            move.l  (SP)+,TheGDevice
            movea.l (SP)+,A2
            rts
            ds.b    12
DisposePalette:
            link.w  A6,#0
            move.l  A2,-(SP)
            movea.l (8,A6),A2
            cmpa.w  #0,A2
            beq.b   .L1
            move.l  A2,-(SP)
            jsr     CLEARPALETTE
            bne.b   .L1
            move.l  A2,-(SP)
            jsr     ERASEPALETTE
            movea.l A2,A0
            _DisposHandle
.L1:
            movea.l (SP)+,A2
            unlk    A6
            rtd     #4
            ds.b    5
.L2:
            dc.b    $00,$00,$01,$02,$03,$04,$00,$00,$05,$06
.L3:
            dc.b    $01,$22,$42,$24,$44,$28,$08
GETCLUT:
            link.w  A6,#-6
            movem.l D0-D3/A0-A1,-(SP)
            _GetZone
            move.l  A0,(-4,A6)
            movea.l SysZone,A0
            _SetZone
            movea.l (8,A6),A0
            movea.l (A0),A0
            movea.l ($16,A0),A1
            movea.l (A1),A1
            move.w  ($20,A1),D0
            cmpi.w  #1,D0
            beq.b   .L1
            btst    #0,($15,A0)
            beq.b   .L1
            addq.w  #1,D0
.L1:
            lea     DisposePalette.L2,A1
            move.b  (0,A1,D0.w),D0
            move.w  D0,(-6,A6)
            movea.l ($DC8).w,A0
            movea.l (A0),A0
            movea.l ($1C,A0,D0.w*4),A0
            move.l  A0,D1
            beq.b   .L3
            move.l  (A0),D1
            beq.b   .L2
            move.l  A0,($C,A6)
            bra.b   .L7
.L2:
            _DisposHandle
            move.w  (-6,A6),D0
.L3:
            lea     DisposePalette.L3,A0
            moveq   #0,D3
            move.b  (0,A0,D0.w),D3
            subq.w  #4,SP
            move.w  D3,-(SP)
            jsr     ([$1660.w])
            movea.l (SP)+,A0
            move.l  A0,($C,A6)
            beq.b   .L7
            movea.l (A0),A1
            cmp.l   (A1),D3
            bne.b   .L5
            subq.w  #4,SP
            move.l  #'clut',-(SP)
            move.w  D3,-(SP)
            move.l  A0,D3
            move.w  #$FFFF,ROMMapInsert
            jsr     ([$E7C.w])
            move.l  (SP)+,D2
            beq.b   .L4
            move.l  D2,($C,A6)
            movea.l D3,A0
            _DisposHandle
            bra.b   .L6
.L4:
            movea.l D3,A0
.L5:
            _HPurge
.L6:
            movea.l ($DC8).w,A0
            movea.l (A0),A0
            move.w  (-6,A6),D0
            move.l  ($C,A6),($1C,A0,D0.w*4)
.L7:
            movea.l (-4,A6),A0
            _SetZone
            movem.l (SP)+,D0-D3/A0-A1
            unlk    A6
            rtd     #4
            ds.b    6
InitPalettes:
            link.w  A6,#0
            movem.l D3-D4/A2-A4,-(SP)
            move.l  ($DC8).w,D0
            cmpi.l  #$FFFFFFFF,D0
            bne.w   .L13
            move.l  #$138,D4
            move.l  D4,D0
            _NewHandleClear async
            bne.w   .L19
            movea.l A0,A3
            move.l  A0,($DC8).w
            moveq   #0,D3
            movea.l (A3),A4
            clr.l   ($10,A4)
            clr.l   ($14,A4)
            lea     ($38,A4),A4
            clr.l   -(SP)
            jsr     ([$16A4.w])
            movea.l (SP)+,A2
            bra.b   .L3
.L1:
            movea.l (A2),A0
            move.w  ($14,A0),D0
            btst    #$D,D0
            beq.b   .L2
            addq.w  #1,D3
            move.l  A2,(A4)
            clr.l   (4,A4)
            addq.w  #8,A4
            addi.l  #$400,D4
            cmpi.w  #$20,D3
            bpl.b   .L4
.L2:
            movea.l ($1E,A0),A2
.L3:
            move.l  A2,D0
            bne.b   .L1
.L4:
            movea.l (A3),A4
            move.w  D3,(A4)
            move.w  D3,D0
            bne.b   .L5
            addq.w  #1,D0
.L5:
            lsl.w   #2,D0
            move.w  D0,(2,A4)
            clr.w   (8,A4)
            move.w  #$10,($A,A4)
            move.l  D4,D0
            movea.l A3,A0
            _SetHandleSize
            bne.b   .L6
            moveq   #$10,D0
            lsl.w   #3,D0
            _NewHandleClear async
            beq.b   .L7
            movea.l A3,A0
            _DisposHandle
.L6:
            move.l  #$FFFFFFFF,($DC8).w
            bra.w   .L19
.L7:
            movea.l (A3),A4
            move.l  A0,(4,A4)
            movea.l A3,A0
            _HLock
            movea.l (A3),A4
            lea     ($1C,A4),A0
            moveq   #6,D0
.L8:
            clr.l   (A0)+
            dbra    D0,.L8
            move.w  D3,D0
            lsl.w   #8,D0
            lea     ($138,A4),A0
            bra.b   .L10
.L9:
            clr.l   (A0)+
.L10:
            dbra    D0,.L9
            move.l  TheZone,-(SP)
            move.l  SysZone,TheZone
            clr.l   -(SP)
            clr.w   -(SP)
            jsr     ([$1848.w])
            move.l  (SP)+,($C,A4)
            bne.b   .L11
            lea     MASKEND,A0
            moveq   #$18,D0
            jsr     ([$158C.w])
            move.l  A0,D3
            clr.l   -(SP)
            move.w  #2,-(SP)
            move.l  A0,-(SP)
            clr.w   -(SP)
            clr.w   -(SP)
            jsr     ([$1844.w])
            move.l  (SP)+,($C,A4)
            movea.l D3,A0
            _DisposHandle
.L11:
            movea.l ($C,A4),A0
            cmpa.w  #0,A0
            beq.b   .L12
            movea.l (A0),A0
            bset    #$F,(6,A0)
            bset    #$E,(6,A0)
.L12:
            move.l  (SP)+,TheZone
            movea.l A3,A0
            _HUnlock
            jsr     CHECKALLDEVICECLUTS
            move.w  #1,-(SP)
            jsr     SCATTERDEVICES
            clr.l   ($DCC).w
            bra.b   .L14
.L13:
            move.l  ($DCC).w,D0
            beq.b   .L14
            addq.l  #1,D0
            bne.w   .L18
            clr.l   ($DCC).w
.L14:
            tst.w   CurApRefNum
            beq.b   .L18
            clr.w   -(SP)
            jsr     ([$1450.w])
            move.w  (SP)+,D3
            cmp.w   CurApRefNum,D3
            beq.b   .L15
            move.w  CurApRefNum,-(SP)
            jsr     ([$1460.w])
            clr.w   -(SP)
            jsr     ([$14BC.w])
            move.w  (SP)+,D0
            bne.b   .L18
.L15:
            clr.l   -(SP)
            move.l  #'pltt',-(SP)
            clr.w   -(SP)
            jsr     ([$E7C.w])
            movea.l (SP)+,A2
            move.l  A2,D0
            beq.b   .L17
            move.l  A2,-(SP)
            jsr     ([$1448.w])
            movea.l (A2),A0
            move.w  #$C000,D1
            move.w  (2,A0),D0
            bpl.b   .L16
            add.w   D0,D0
            move.w  D0,D1
.L16:
            move.w  D1,(6,A0)
            move.l  A2,-(SP)
            jsr     RECORDPALETTE
            bne.b   .L17
            move.l  A2,($DCC).w
            movea.l (A2),A0
            bset    #$C,(6,A0)
            clr.l   (8,A0)
.L17:
            cmp.w   CurApRefNum,D3
            beq.b   .L18
            move.w  D3,-(SP)
            jsr     ([$1460.w])
.L18:
            jsr     INSTALLMYEXITTOSHELL
            jsr     UPDATEDEVICES
.L19:
            movem.l (SP)+,D3-D4/A2-A4
            unlk    A6
            rts
            ds.b    6
CHECKDEVICECOLORS:
            link.w  A6,#0
            movem.l D0-D2/A0-A3,-(SP)
            clr.w   D2
            movea.l (8,A6),A2
            movea.l (A2),A3
            tst.w   (4,A3)
            bne.b   .L4
            tst.w   ($14,A3)
            bpl.b   .L4
            subq.w  #4,SP
            move.l  A2,-(SP)
            jsr     GETCLUT
            movea.l (SP)+,A0
            movea.l (A0),A0
            lea     ($A,A0),A0
            movea.l ($16,A3),A1
            movea.l (A1),A1
            movea.l ($2A,A1),A1
            movea.l (A1),A1
            move.w  (6,A1),D0
            lea     (8,A1),A1
.L1:
            btst    #6,(A1)
            bne.b   .L3
            bset    #3,(A1)
            move.l  (A0),D1
            cmp.l   (2,A1),D1
            bne.b   .L2
            move.w  (4,A0),D1
            cmp.w   (6,A1),D1
            beq.b   .L3
.L2:
            bset    #4,(A1)
            moveq   #-1,D2
.L3:
            addq.w  #8,A0
            addq.w  #8,A1
            dbra    D0,.L1
.L4:
            move.w  D2,($C,A6)
            movem.l (SP)+,D0-D2/A0-A3
            unlk    A6
            rtd     #4
            ds.b    8
FINDLINK:
            link.w  A4,#0
            move.l  D3,-(SP)
            clr.w   ($A,A4)
            move.w  (8,A4),D0
            bfextu  D0{16:3},D1
            cmpi.w  #4,D1
            bne.b   .L4
            move.w  (-$22,A6),D3
            movea.l (-$12,A6),A0
            adda.w  #$138,A0
            bra.b   .L2
.L1:
            bfextu  D0{19:5},D1
            bfextu  D0{24:8},D2
            cmp.w   (-$1C,A6),D1
            beq.b   .L3
            lsl.w   #8,D1
            add.w   D2,D1
            move.w  (0,A0,D1.l*4),D0
            bpl.b   .L4
.L2:
            dbra    D3,.L1
            bra.b   .L4
.L3:
            andi.w  #$FF,D2
            move.w  D2,($A,A4)
.L4:
            move.l  (SP)+,D3
            unlk    A4
            rtd     #2
            ds.b    12
ANALYZEDEV:
            movem.l D3-D5/A2-A3,-(SP)
            lea     (-$74,A6),A2
            movea.l (-$28,A6),A3
            movea.l (A3),A3
            moveq   #0,D3
            move.w  (-$46,A6),D3
            clr.w   D4
            bsr.w   ClearAvailBits
            movea.l (-$C,A6),A0
            moveq   #0,D0
            moveq   #0,D2
            lea     ($10,A0),A1
            bra.b   .L3
.L1:
            move.w  ($A,A1),D1
            bmi.b   .L2
            btst    #3,D1
            beq.b   .L2
            move.w  D0,D2
            and.w   D3,D2
            bfset   (A2){D2:1}
.L2:
            lea     ($10,A1),A1
            addq.w  #1,D0
.L3:
            cmp.w   (A0),D0
            bcs.b   .L1
            movea.l (-$40,A6),A1
            move.w  D3,D0
            moveq   #0,D1
.L4:
            move.w  D0,D1
            btst    #4,D3
            beq.b   .L5
            ror.b   #4,D1
.L5:
            bftst   (A2){D1:1}
            bne.b   .L6
            move.w  (8,A3,D1.w*8),D2
            andi.w  #$6000,D2
            bne.b   .L6
            bfset   (A2){D1:1}
            move.w  D1,(0,A1,D4.w*2)
            addq.w  #1,D4
.L6:
            dbra    D0,.L4
            move.w  D3,D0
.L7:
            move.w  D0,D1
            btst    #4,D3
            beq.b   .L8
            ror.b   #4,D1
.L8:
            bftst   (A2){D1:1}
            bne.b   .L9
            btst    #6,(8,A3,D1.w*8)
            bne.b   .L9
            bfset   (A2){D1:1}
            move.w  D1,(0,A1,D4.w*2)
            addq.w  #1,D4
.L9:
            dbra    D0,.L7
            move.w  (6,A0),D5
            andi.w  #$FFF,D5
            movea.l (-$12,A6),A0
            adda.w  #$138,A0
            move.w  D3,D0
.L10:
            move.w  D0,D1
            btst    #4,D3
            beq.b   .L11
            ror.b   #4,D1
.L11:
            bftst   (A2){D1:1}
            bne.b   .L13
            move.w  (-$1C,A6),D2
            lsl.w   #8,D2
            move.b  D1,D2
.L12:
            andi.w  #$1FFF,D2
            move.w  (0,A0,D2.w*4),D2
            beq.b   .L13
            bmi.b   .L12
            andi.w  #$1FFF,D2
            cmp.w   D2,D5
            beq.b   .L13
            bfset   (A2){D1:1}
            move.w  D1,(0,A1,D4.w*2)
            addq.w  #1,D4
.L13:
            dbra    D0,.L10
            move.w  D4,(-$50,A6)
            clr.w   (-$54,A6)
            bsr.b   ClearAvailBits
            movem.l (SP)+,D3-D5/A2-A3
            rts
ClearAvailBits:
            moveq   #7,D0
.L1:
            clr.l   (-$74,A6,D0.w*4)
            dbra    D0,.L1
            bfset   (-$74,A6){0:1}
            bfset   (-$74,A6){D3:1}
            rts
            ds.b    14
PILLAGE:
            link.w  A4,#0
            movem.l D3-D4,-(SP)
            move.w  (8,A4),D3
            move.w  (-$1C,A6),D4
            lsl.w   #8,D4
            move.b  D3,D4
            move.w  D4,-(SP)
            bsr.w   ZAPLINKS
            movea.l (-$28,A6),A0
            movea.l (A0),A0
            clr.w   (8,A0,D3.w*8)
            movem.l (SP)+,D3-D4
            unlk    A4
            rtd     #2
            dc.w    0
GIMMEINDEX:
            clr.w   D1
            move.w  (-$54,A6),D0
            cmp.w   (-$50,A6),D0
            beq.b   .L1
            movea.l (-$40,A6),A0
            move.w  (0,A0,D0.w*2),D1
            addq.w  #1,(-$54,A6)
.L1:
            move.w  D1,(4,SP)
            rts
            dc.w    0
MARKDEVUBIT:
            move.w  (-$1C,A6),D0
            movea.l (-$12,A6),A0
            move.l  ($14,A0),D1
            bset    D0,D1
            move.l  D1,($14,A0)
            rts
            ds.b    12
REDRAWDESKTOP:
            subq.w  #4,SP
            jsr     ([$1160.w])
            movea.l (SP),A3
            move.l  A2,-(SP)
            jsr     ([$117C.w])
            clr.l   -(SP)
            move.l  A3,-(SP)
            jsr     ([$1230.w])
            move.l  A3,-(SP)
            jsr     ([$1164.w])
            rts
            ds.b    10
DIRTYSEEDS:
            link.w  A6,#0
            movea.l ($DC8).w,A0
            movea.l (A0),A0
            move.w  (2,A0),D0
            lsr.w   #2,D0
            subq.w  #1,D0
            movea.l (8,A6),A0
            movea.l (A0),A0
            bset    #$D,(6,A0)
            movea.l ($C,A0),A0
            movea.l (A0),A0
.L1:
            clr.l   (A0)+
            dbra    D0,.L1
            unlk    A6
            rtd     #4
SetPalette:
            link.w  A6,#0
            move.l  D3,-(SP)
            movea.l ($DC8).w,A1
            cmpa.w  #$FFFF,A1
            beq.w   .L9
            movea.l ($E,A6),A0
            cmpa.w  #$FFFF,A0
            bne.b   .L4
            move.l  ($DCC).w,D0
            beq.b   .L1
            movea.l D0,A0
            movea.l (A0),A0
            btst    #$C,(6,A0)
            beq.b   .L1
            move.l  D0,-(SP)
            jsr     ([$184C.w])
.L1:
            movea.l ($A,A6),A0
            move.l  A0,($DCC).w
            beq.b   .L2
            movea.l (A0),A0
            bset    #$E,(6,A0)
            bset    #$F,(6,A0)
            movea.l ($A,A6),A0
            bra.b   .L3
.L2:
            movea.l (A1),A0
            movea.l ($C,A0),A0
            move.l  A0,D0
            beq.w   .L9
.L3:
            move.l  A0,-(SP)
            bsr.w   DIRTYSEEDS
            clr.l   -(SP)
            jsr     ([$1290.w])
            bra.b   .L8
.L4:
            tst.w   (6,A0)
            bpl.b   .L9
            move.l  ($A,A6),D0
            movea.l (8,A0),A1
            movea.l (A1),A1
            move.l  ($C,A1),D3
            move.l  D0,($C,A1)
            beq.b   .L7
            movea.l D0,A1
            movea.l (A1),A1
            bclr    #$E,(6,A1)
            bset    #$F,(6,A1)
            tst.b   (8,A6)
            beq.b   .L7
            bpl.b   .L6
            btst    #$E,(8,A6)
            bne.b   .L5
            bclr    #$F,(6,A1)
.L5:
            btst    #$D,(8,A6)
            beq.b   .L7
.L6:
            bset    #$E,(6,A1)
.L7:
            cmp.l   D0,D3
            beq.b   .L9
            move.l  A0,-(SP)
            tst.l   D3
            beq.b   .L8
            move.l  D3,-(SP)
            jsr     UPDATEPALETTE
            movea.l D3,A0
            movea.l (A0),A0
            btst    #$C,(6,A0)
            beq.b   .L8
            move.l  D3,-(SP)
            jsr     ([$184C.w])
.L8:
            jsr     ([$1850.w])
.L9:
            move.l  (SP)+,D3
            unlk    A6
            rtd     #$A
GetPalette:
            link.w  A6,#0
            clr.l   ($C,A6)
            movea.l ($DC8).w,A1
            cmpa.w  #$FFFF,A1
            beq.b   .L2
            movea.l (8,A6),A0
            cmpa.w  #0,A0
            beq.b   .L2
            cmpa.w  #$FFFF,A0
            bne.b   .L1
            move.l  ($DCC).w,($C,A6)
            bne.b   .L2
            movea.l (A1),A1
            movea.l ($C,A1),A0
            move.l  A0,D0
            beq.b   .L2
            jsr     ([$1584.w])
            tst.w   D0
            bne.b   .L2
            move.l  A0,($DCC).w
            move.l  A0,($C,A6)
            move.l  A0,-(SP)
            movea.l (A0),A0
            clr.l   ($C,A0)
            bclr    #$C,(6,A0)
            jsr     RECORDPALETTE
            beq.b   .L2
            clr.l   ($DCC).w
            clr.l   ($C,A6)
            bra.b   .L2
.L1:
            tst.w   (6,A0)
            bpl.b   .L2
            movea.l (8,A0),A0
            movea.l (A0),A0
            movea.l ($C,A0),A0
            move.l  A0,($C,A6)
            beq.b   .L2
            movea.l (A0),A0
            bclr    #$C,(6,A0)
.L2:
            unlk    A6
            rtd     #4
            ds.b    8
FINDINDEX:
            movem.l D3-D4,-(SP)
            move.w  ($C,A3),D0
            bfextu  D0{16:3},D1
            cmpi.w  #4,D1
            bne.b   .L6
            movea.l ($DC8).w,A0
            cmpa.w  #$FFFF,A0
            beq.b   .L6
            movea.l (A0),A0
            move.w  (A0),D3
            beq.b   .L6
            lea     ($38,A0),A1
            bra.b   .L2
.L1:
            move.l  (0,A1,D3.w*8),D4
            cmp.l   TheGDevice,D4
            beq.b   .L3
.L2:
            dbra    D3,.L1
            bra.b   .L6
.L3:
            move.w  (A0),D4
            adda.w  #$138,A0
            bra.b   .L5
.L4:
            bfextu  D0{19:5},D1
            bfextu  D0{24:8},D2
            cmp.w   D3,D1
            beq.b   .L7
            lsl.w   #8,D1
            add.w   D2,D1
            move.w  (0,A0,D1.l*4),D0
            bpl.b   .L6
.L5:
            dbra    D4,.L4
.L6:
            bra.b   .L8
.L7:
            andi.w  #$FF,D2
            move.w  D2,D0
            movea.l TheGDevice,A0
            movea.l (A0),A0
            movea.l ($16,A0),A0
            movea.l (A0),A0
            movea.l ($2A,A0),A0
            movea.l (A0),A0
            cmp.w   (6,A0),D0
            blt.b   .L9
.L8:
            moveq   #0,D0
.L9:
            movem.l (SP)+,D3-D4
            rts
            ds.b    14
ENTRY2INDEX:
            link.w  A6,#-4
            movem.l A2-A3,-(SP)
            move.w  #1,QDErr
            clr.l   ($A,A6)
            movea.l ($DC8).w,A1
            cmpa.w  #$FFFF,A1
            beq.w   .L7
            movea.l (A5),A0
            movea.l (A0),A0
            tst.w   (6,A0)
            bpl.w   .L7
            movea.l (8,A0),A0
            movea.l (A0),A0
            movea.l ($C,A0),A2
            move.l  A2,D0
            bne.b   .L1
            movea.l ($DCC).w,A2
            move.l  A2,D0
            beq.w   .L7
.L1:
            move.l  A2,(-4,A6)
            movea.l A2,A0
            _HLock
            movea.l (A2),A2
            moveq   #0,D0
            move.w  (8,A6),D0
            cmp.w   (A2),D0
            bcc.w   .L6
            asl.l   #4,D0
            lea     ($10,A2,D0.l),A3
            clr.l   -(SP)
            pea     (A3)
            btst    #2,(7,A3)
            beq.b   .L2
            addq.l  #1,(SP)
.L2:
            jsr     ([$16CC.w])
            move.l  (SP)+,($A,A6)
            clr.w   QDErr
            movea.l TheGDevice,A0
            movea.l (A0),A0
            move.w  (4,A0),D1
            beq.b   .L3
            subq.w  #1,D1
            bne.b   .L6
.L3:
            tst.w   ($14,A0)
            bpl.b   .L6
            move.w  (6,A3),D1
            moveq   #0,D0
            move.w  (8,A6),D0
            btst    #2,D1
            beq.b   .L4
            jsr     FINDINDEX
            tst.w   D0
            beq.b   .L6
            bra.b   .L5
.L4:
            btst    #3,D1
            beq.b   .L6
            btst    #1,D1
            bne.b   .L6
            movea.l ($16,A0),A0
            movea.l (A0),A0
            movea.l ($2A,A0),A0
            movea.l (A0),A0
            and.w   (6,A0),D0
.L5:
            move.l  D0,($A,A6)
.L6:
            movea.l (-4,A6),A0
            _HUnlock
.L7:
            movem.l (SP)+,A2-A3
            unlk    A6
            rtd     #2
            ds.b    6
INDEX2ENTRIES:
            link.w  A6,#0
            movem.l D3-D7/A2,-(SP)
            movea.l (A5),A0
            move.l  (A0),D0
            beq.b   .L3
            subq.w  #4,SP
            move.l  D0,-(SP)
            jsr     ([$1858.w])
            move.l  (SP)+,D0
            beq.b   .L3
            movea.l D0,A0
            movea.l (A0),A0
            move.w  (A0),D4
            move.l  (8,A6),D0
            beq.b   .L3
            movea.l D0,A0
            _HGetState
            move.b  D0,D3
            _HNoPurge
            _HUnlock
            move.w  D4,D0
            add.w   D0,D0
            addq.w  #2,D0
            ext.l   D0
            _SetHandleSize
            _HLock
            movea.l (A0),A2
            moveq   #0,D5
            move.l  ($C,A6),D6
            bra.b   .L2
.L1:
            subq.w  #4,SP
            move.w  D4,-(SP)
            moveq   #0,D0
            _PaletteDispatch
            cmp.l   (SP)+,D6
            bne.b   .L2
            addq.w  #1,D5
            move.w  D4,(0,A2,D5.w*2)
.L2:
            dbra    D4,.L1
            movea.l (8,A6),A0
            move.l  D5,D0
            add.l   D0,D0
            addq.l  #2,D0
            _SetHandleSize
            move.b  D3,D0
            _HSetState
.L3:
            movem.l (SP)+,D3-D6/A2
            unlk    A6
            rtd     #6
            ds.b    8
PmForeColor:
            moveq   #1,D0
            bra.b   PmBackColor.L1
PmBackColor:
            moveq   #0,D0
.L1:
            link.w  A6,#-2
            move.w  D0,(-2,A6)
            clr.l   -(SP)
            move.w  (8,A6),-(SP)
            moveq   #0,D0
            _PaletteDispatch
            move.l  (SP)+,D0
            tst.w   QDErr
            bne.b   .L4
            movea.l (A5),A0
            movea.l (A0),A0
            movea.l (8,A0),A1
            movea.l (A1),A1
            move.l  D0,-(SP)
            tst.w   (-2,A6)
            beq.b   .L2
            move.l  D0,($50,A0)
            move.w  (8,A6),($10,A1)
            bset    #0,($19,A1)
            pea     ($24,A0)
            bra.b   .L3
.L2:
            move.l  D0,($54,A0)
            move.w  (8,A6),($16,A1)
            bset    #1,($19,A1)
            pea     ($2A,A0)
.L3:
            jsr     ([$16D0.w])
.L4:
            unlk    A6
            rtd     #2
            ds.b    8
AnimateEntry:
            link.w  A6,#-$E
            movem.l D3-D5/A2-A4,-(SP)
            movea.l ($DC8).w,A3
            cmpa.w  #$FFFF,A3
            beq.w   .L5
            movea.l ($E,A6),A0
            cmpa.w  #0,A0
            beq.w   .L5
            tst.w   (6,A0)
            bpl.w   .L5
            movea.l (8,A0),A0
            movea.l (A0),A0
            movea.l ($C,A0),A2
            move.l  A2,D0
            bne.b   .L1
            movea.l ($DCC).w,A2
            move.l  A2,D0
            beq.w   .L5
.L1:
            movea.l (A2),A0
            move.w  (A0),D0
            moveq   #0,D1
            move.w  ($C,A6),D1
            cmp.w   D0,D1
            bcc.w   .L5
            lsl.w   #4,D1
            lea     ($10,A0,D1.l),A2
            btst    #2,(7,A2)
            beq.w   .L5
            movea.l (8,A6),A0
            move.l  (A0),D0
            move.l  D0,(-$A,A6)
            ror.l   #8,D0
            move.b  D0,(2,A2)
            swap    D0
            move.b  D0,(A2)
            move.w  (4,A0),D0
            move.w  D0,(-6,A6)
            ror.w   #8,D0
            move.b  D0,(4,A2)
            move.w  ($C,A2),D3
            bfextu  D3{16:3},D1
            cmpi.w  #4,D1
            bne.w   .L5
            movea.l A3,A0
            _HLock
            move.l  TheGDevice,(-4,A6)
            movea.l (A3),A2
            move.w  (A2),D5
            lea     ($38,A2),A4
            adda.w  #$138,A2
            move.w  D3,D0
            bra.b   .L4
.L2:
            bfextu  D0{19:5},D3
            bfextu  D0{24:8},D4
            movea.l (0,A4,D3.w*8),A0
            move.l  A0,TheGDevice
            movea.l (A0),A0
            clr.w   (2,A0)
            movea.l ($16,A0),A0
            movea.l (A0),A0
            movea.l ($2A,A0),A0
            movea.l (A0),A0
            move.w  (6,A0),D0
            cmp.w   D4,D0
            ble.b   .L3
            move.l  (A0),(-$E,A6)
            move.l  (-$A,A6),($A,A0,D4.w*8)
            move.w  (-6,A6),($E,A0,D4.w*8)
            move.w  D4,-(SP)
            clr.w   -(SP)
            pea     (8,A0,D4.w*8)
            jsr     ([$16FC.w])
            movea.l TheGDevice,A0
            movea.l (A0),A0
            movea.l ($16,A0),A0
            movea.l (A0),A0
            movea.l ($2A,A0),A0
            movea.l (A0),A0
            move.l  (-$E,A6),(A0)
.L3:
            lsl.w   #8,D3
            add.w   D4,D3
            move.w  (0,A2,D3.l*4),D0
.L4:
            dbpl    D5,.L2
            move.l  (-4,A6),TheGDevice
            movea.l A3,A0
            _HUnlock
.L5:
            moveq   #0,D0
            movem.l (SP)+,D3-D5/A2-A4
            unlk    A6
            rtd     #$A
            ds.b    4
AnimatePalette:
            link.w  A6,#-$8A
            movem.l D3-D6/A2-A4,-(SP)
            movea.l ($DC8).w,A4
            cmpa.w  #$FFFF,A4
            beq.w   .L15
            movea.l ($12,A6),A0
            cmpa.w  #0,A0
            beq.w   .L15
            tst.w   (6,A0)
            bpl.w   .L15
            movea.l (8,A0),A0
            movea.l (A0),A0
            movea.l ($C,A0),A2
            move.l  A2,D0
            bne.b   .L1
            movea.l ($DCC).w,A2
            move.l  A2,D0
            beq.w   .L15
.L1:
            movea.l ($E,A6),A3
            move.l  A3,D0
            beq.w   .L15
            movea.l (A2),A2
            move.w  (A2),D0
            beq.w   .L15
            moveq   #0,D3
            move.w  ($A,A6),D3
            cmp.w   D0,D3
            bcc.w   .L15
            movea.l (A3),A3
            move.w  ($C,A6),D4
            cmp.w   (6,A3),D4
            bhi.w   .L15
            sub.w   D3,D0
            move.w  D0,D5
            move.w  (6,A3),D0
            addq.w  #1,D0
            sub.w   D4,D0
            cmp.w   D0,D5
            bls.b   .L2
            move.w  D0,D5
.L2:
            cmp.w   (8,A6),D5
            bls.b   .L3
            move.w  (8,A6),D5
.L3:
            movea.l (A4),A1
            move.w  (A1),D0
            move.w  D0,(-$A,A6)
            lea     ($38,A1),A4
            lea     (-$8A,A6),A0
            bra.b   .L5
.L4:
            clr.l   (A0)+
.L5:
            dbra    D0,.L4
            adda.w  #$138,A1
            lsl.l   #4,D3
            lea     ($10,A2,D3.l),A2
            lea     (8,A3,D4.w*8),A3
            bra.w   .L11
.L6:
            btst    #2,(7,A2)
            beq.w   .L10
            move.b  (2,A3),(A2)
            move.b  (4,A3),(2,A2)
            move.b  (6,A3),(4,A2)
            move.w  ($C,A2),D0
            bfextu  D0{16:3},D1
            cmpi.w  #4,D1
            bne.b   .L10
            move.w  (-$A,A6),D6
            subq.w  #1,D6
.L7:
            bfextu  D0{19:5},D3
            bfextu  D0{24:8},D4
            lea     (-$8A,A6),A0
            movea.l (0,A0,D3.w*4),A0
            cmpa.w  #0,A0
            bne.b   .L8
            movea.l (0,A4,D3.w*8),A0
            movea.l (A0),A0
            clr.w   (2,A0)
            movea.l ($16,A0),A0
            movea.l (A0),A0
            move.l  ($2A,A0),D0
            lea     (-$8A,A6),A0
            move.l  D0,(0,A0,D3.w*4)
            movea.l D0,A0
.L8:
            movea.l (A0),A0
            move.w  (6,A0),D0
            cmp.w   D4,D0
            ble.b   .L9
            move.w  (A2),($A,A0,D4.w*8)
            move.w  (2,A2),($C,A0,D4.w*8)
            move.w  (4,A2),($E,A0,D4.w*8)
.L9:
            lsl.w   #8,D3
            add.w   D4,D3
            move.w  (0,A1,D3.l*4),D0
            dbpl    D6,.L7
.L10:
            adda.w  #$10,A2
            addq.l  #8,A3
.L11:
            dbra    D5,.L6
            move.l  TheGDevice,(-4,A6)
            move.w  (-$A,A6),D6
            lea     (-$8A,A6),A2
            bra.b   .L14
.L12:
            movea.l (A2)+,A3
            cmpa.w  #0,A3
            beq.b   .L13
            move.l  (A4),TheGDevice
            movea.l (A3),A0
            move.l  (A0),(-8,A6)
            clr.w   -(SP)
            move.w  (6,A0),-(SP)
            pea     (8,A0)
            jsr     ([$16FC.w])
            movea.l (A3),A0
            move.l  (-8,A6),(A0)
.L13:
            addq.l  #8,A4
.L14:
            dbra    D6,.L12
            move.l  (-4,A6),TheGDevice
.L15:
            moveq   #0,D0
            movem.l (SP)+,D3-D6/A2-A4
            unlk    A6
            rtd     #$E
            ds.b    12
GetEntryColor:
            link.w  A6,#0
            movea.l ($E,A6),A0
            cmpa.w  #0,A0
            beq.b   .L1
            movea.l (A0),A0
            move.w  (A0),D0
            moveq   #0,D1
            move.w  ($C,A6),D1
            cmp.w   D0,D1
            bcc.b   .L1
            lsl.l   #4,D1
            lea     ($10,A0,D1.l),A0
            movea.l (8,A6),A1
            move.l  (A0),(A1)
            move.w  (4,A0),(4,A1)
.L1:
            moveq   #0,D0
            unlk    A6
            rtd     #$A
            ds.b    10
SCATTERDEVICES:
            link.w  A6,#0
            movem.l D1-D5/A0/A2-A4,-(SP)
            movea.l ($DC8).w,A0
            movea.l (A0),A0
            move.l  ($10,A0),D4
            beq.w   .L8
            clr.l   ($10,A0)
            or.l    D4,($14,A0)
            move.w  (A0),D3
            subq.w  #1,D3
            lea     ($38,A0),A2
.L1:
            btst    D3,D4
            beq.w   .L7
            subq.w  #4,SP
            movea.l (0,A2,D3.w*8),A3
            move.l  A3,-(SP)
            jsr     GETCLUT
            movea.l (SP)+,A4
            movea.l (A4),A4
            move.l  (A4),D2
            lea     ($A,A4),A4
            movea.l (A3),A3
            movea.l ($16,A3),A3
            movea.l (A3),A3
            movea.l ($2A,A3),A3
            movea.l (A3),A3
            move.w  (6,A3),D1
            lea     (8,A3),A0
            clr.w   D5
.L2:
            btst    #3,(A0)
            beq.b   .L3
            addq.w  #1,D5
.L3:
            btst    #4,(A0)
            beq.b   .L4
            clr.w   (A0)
            move.l  (A4),(2,A0)
            move.w  (4,A4),(6,A0)
.L4:
            addq.w  #8,A0
            addq.w  #8,A4
            dbra    D1,.L2
            movea.l (0,A2,D3.w*8),A4
            cmp.w   (6,A3),D5
            ble.b   .L5
            move.l  D2,(A3)
            movea.l (A4),A0
            movea.l (6,A0),A0
            movea.l (A0),A0
            clr.l   (A0)
            bra.b   .L6
.L5:
            subq.w  #4,SP
            jsr     ([$16A0.w])
            move.l  (SP)+,(A3)
.L6:
            tst.w   (8,A6)
            beq.b   .L7
            movea.l A4,A0
            jsr     DEVSETENTRIES
.L7:
            dbra    D3,.L1
.L8:
            movem.l (SP)+,D1-D5/A0/A2-A4
            unlk    A6
            rtd     #2
            ds.b    6
.L9:
            dc.w    0,$0809,$0A0B,0,$0C0D
SETDEV:
            link.w  A4,#-$C
            movem.l D3-D5/A2-A3,-(SP)
            move.w  (-$1C,A6),D3
            movea.l (-$16,A6),A0
            movea.l (0,A0,D3.w*8),A0
            move.l  A0,TheGDevice
            movea.l (A0),A0
            tst.w   (4,A0)
            bne.w   .L6
            tst.w   ($14,A0)
            bpl.w   .L6
            movea.l ($16,A0),A0
            movea.l (A0),A0
            movea.l ($2A,A0),A0
            move.l  A0,(-$28,A6)
            movea.l (A0),A0
            move.w  (6,A0),D0
            move.w  D0,(-$46,A6)
            addq.w  #1,D0
            move.w  D0,(-$24,A6)
            move.l  (A0),D0
            movea.l (-$C,A6),A0
            btst    #$D,(6,A0)
            bne.b   .L1
            movea.l ($C,A0),A0
            movea.l (A0),A0
            cmp.l   (0,A0,D3.w*4),D0
            beq.w   .L6
.L1:
            movea.l (-$16,A6),A0
            lea     (0,A0,D3.w*8),A0
            movea.l (-$12,A6),A0
            adda.w  #$138,A0
            move.w  D3,D0
            lsl.w   #8,D0
            lea     (0,A0,D0.w*4),A0
            move.l  A0,(-$20,A6)
            clr.w   (-$52,A6)
            movea.l TheGDevice,A0
            movea.l (A0),A0
            move.w  ($14,A0),D3
            andi.w  #1,D3
            movea.l ($16,A0),A0
            movea.l (A0),A0
            add.w   ($20,A0),D3
            lea     SCATTERDEVICES.L9,A0
            move.b  (0,A0,D3.w),D3
            move.w  (-$E,A6),D0
            movea.l (-$C,A6),A0
            lea     ($10,A0),A0
            bra.b   .L4
.L2:
            move.w  (6,A0),D1
            btst    D3,D1
            beq.b   .L3
            bset    #$F,D1
.L3:
            move.w  D1,($A,A0)
            adda.w  #$10,A0
.L4:
            dbra    D0,.L2
            jsr     ANALYZEDEV
            jsr     Allocate
            jsr     CORRELATE
            tst.w   (-$52,A6)
            beq.b   .L5
            jsr     MARKDEVUBIT
.L5:
            movea.l (-$28,A6),A0
            movea.l (A0),A0
            move.l  (A0),D0
            movea.l (-$C,A6),A0
            movea.l ($C,A0),A1
            movea.l (A1),A1
            move.w  (-$1C,A6),D3
            move.l  D0,(0,A1,D3.w*4)
.L6:
            moveq   #0,D0
            movem.l (SP)+,D3-D5/A2-A3
            unlk    A4
            rts
            ds.b    4
SetEntryColor:
            link.w  A6,#0
            movea.l ($E,A6),A0
            cmpa.w  #0,A0
            beq.b   .L2
            movea.l (A0),A0
            move.w  (A0),D0
            moveq   #0,D1
            move.w  ($C,A6),D1
            cmp.w   D0,D1
            bcc.b   .L2
            lsl.l   #4,D1
            lea     ($10,A0,D1.l),A0
            movea.l (8,A6),A1
            move.l  (A1),(A0)
            move.w  (4,A1),(4,A0)
            btst    #2,(7,A0)
            beq.b   .L1
            lea     (A0),A0
            move.b  (A0)+,(A0)+
            move.b  (A0)+,(A0)+
            move.b  (A0)+,(A0)+
.L1:
            move.l  ($E,A6),-(SP)
            bsr.w   DIRTYSEEDS
.L2:
            moveq   #0,D0
            unlk    A6
            rtd     #$A
            dc.w    0
GetEntryUsage:
            link.w  A6,#0
            movea.l ($12,A6),A0
            cmpa.w  #0,A0
            beq.b   .L1
            movea.l (A0),A0
            move.w  (A0),D0
            moveq   #0,D1
            move.w  ($10,A6),D1
            cmp.w   D0,D1
            bcc.b   .L1
            lsl.l   #4,D1
            lea     ($10,A0,D1.l),A0
            movea.l ($C,A6),A1
            move.w  (6,A0),(A1)
            movea.l (8,A6),A1
            move.w  (8,A0),(A1)
.L1:
            moveq   #0,D0
            unlk    A6
            rtd     #$E
            ds.b    6
SetEntryUsage:
            link.w  A6,#0
            movem.l D3-D4/A2-A4,-(SP)
            movea.l ($E,A6),A0
            cmpa.w  #0,A0
            beq.b   .L3
            movea.l (A0),A0
            move.w  (A0),D0
            moveq   #0,D1
            move.w  ($C,A6),D1
            cmp.w   D0,D1
            bcc.b   .L3
            lsl.l   #4,D1
            lea     ($10,A0,D1.l),A2
            move.w  (6,A2),D0
            btst    #2,D0
            beq.b   .L1
            move.w  ($A,A6),D3
            eor.w   D3,D0
            andi.w  #$3F0C,D0
            beq.b   .L1
            move.w  ($C,A2),D3
            bpl.b   .L1
            movea.l ($DC8).w,A0
            movea.l (A0),A0
            lea     ($138,A0),A3
            lea     ($38,A0),A4
            moveq   #0,D4
            jsr     CLEARSTRAND
            movea.l ($DC8).w,A0
            movea.l (A0),A0
            or.l    D4,($10,A0)
            clr.w   ($C,A2)
.L1:
            move.w  ($A,A6),D0
            btst    #2,D0
            beq.b   .L2
            lea     (A2),A0
            move.b  (A0)+,(A0)+
            move.b  (A0)+,(A0)+
            move.b  (A0)+,(A0)+
.L2:
            move.w  D0,(6,A2)
            move.w  (8,A6),(8,A2)
            move.l  ($E,A6),-(SP)
            bsr.w   DIRTYSEEDS
.L3:
            moveq   #0,D0
            movem.l (SP)+,D3-D4/A2-A4
            unlk    A6
            rtd     #$A
            ds.b    12
CTab2Palette:
            link.w  A6,#0
            movem.l D3/A2-A3,-(SP)
            movea.l ($C,A6),A2
            cmpa.w  #0,A2
            beq.w   .L4
            move.l  ($C,A6),-(SP)
            jsr     CLEARPALETTE
            bne.b   .L4
            movea.l ($10,A6),A3
            cmpa.w  #0,A3
            beq.b   .L4
            movea.l (A3),A1
            moveq   #0,D3
            move.w  (6,A1),D3
            addq.w  #1,D3
            movea.l A2,A0
            move.l  D3,D0
            addq.w  #1,D0
            asl.w   #4,D0
            _SetHandleSize
            bne.b   .L4
            move.l  A2,-(SP)
            bsr.w   DIRTYSEEDS
            movea.l (A2),A0
            move.w  D3,(A0)
            adda.w  #$10,A0
            movea.l (A3),A1
            addq.l  #8,A1
            move.w  ($A,A6),D1
            swap    D1
            move.w  (8,A6),D1
            bra.b   .L3
.L1:
            move.l  (2,A1),(A0)
            move.w  (6,A1),(4,A0)
            btst    #$12,D1
            beq.b   .L2
            move.b  (2,A1),(1,A0)
            move.b  (4,A1),(3,A0)
            move.b  (6,A1),(5,A0)
.L2:
            move.l  D1,(6,A0)
            clr.w   ($A,A0)
            clr.l   ($C,A0)
            adda.w  #$10,A0
            addq.l  #8,A1
.L3:
            dbra    D3,.L1
.L4:
            moveq   #0,D0
            movem.l (SP)+,D3/A2-A3
            unlk    A6
            rtd     #$C
Palette2CTab:
            link.w  A6,#0
            movem.l D3/A2-A3,-(SP)
            movea.l ($C,A6),A2
            cmpa.w  #0,A2
            beq.b   .L3
            movea.l (8,A6),A3
            cmpa.w  #0,A3
            beq.b   .L3
            movea.l (A2),A0
            moveq   #0,D3
            move.w  (A0),D3
            move.l  D3,D0
            addq.l  #1,D0
            lsl.l   #3,D0
            movea.l A3,A0
            _SetHandleSize
            bne.b   .L3
            movea.l (A2),A0
            movea.l (A3),A1
            move.w  D3,D0
            subq.w  #1,D0
            clr.l   (A1)
            move.w  D0,(6,A1)
            clr.w   (4,A1)
            addq.w  #8,A1
            lea     ($10,A0),A0
            moveq   #0,D1
            bra.b   .L2
.L1:
            move.w  D1,(A1)
            move.l  (A0),(2,A1)
            move.w  (4,A0),(6,A1)
            adda.w  #$10,A0
            addq.l  #8,A1
            addq.w  #1,D1
.L2:
            dbra    D3,.L1
.L3:
            moveq   #0,D0
            movem.l (SP)+,D3/A2-A3
            unlk    A6
            rtd     #8
            dc.w    0
CLEARONE:
            link.w  A6,#0
            move.l  A2,-(SP)
            movea.l (8,A6),A0
            move.l  ($C,A0),D0
            clr.w   ($A,A0)
            clr.l   ($C,A0)
            movea.l (4,A6),A1
            lea     ($38,A1),A2
            adda.w  #$138,A1
.L1:
            bfextu  D0{19:5},D1
            bfextu  D0{24:8},D2
            movea.l (0,A2,D1.w*8),A0
            movea.l (A0),A0
            movea.l ($16,A0),A0
            movea.l (A0),A0
            movea.l ($2A,A0),A0
            movea.l (A0),A0
            cmp.w   (6,A0),D2
            bhi.b   .L2
            clr.w   (8,A0,D2.w*8)
.L2:
            lsl.w   #8,D1
            add.w   D2,D1
            lea     (0,A1,D1.l*4),A0
            move.w  (A0),D0
            clr.l   (A0)
            tst.w   D0
            bmi.b   .L1
            movea.l (SP)+,A2
            unlk    A6
            rtd     #4
            dc.w    0
CopyPalette:
            link.w  A6,#-2
            movem.l D3-D4/A2-A4,-(SP)
            movea.l ($DC8).w,A4
            cmpa.w  #$FFFF,A4
            beq.w   .L8
            movea.l ($E,A6),A2
            cmpa.w  #0,A2
            beq.w   .L8
            movea.l ($12,A6),A3
            cmpa.w  #0,A3
            beq.w   .L8
            cmpa.l  A2,A3
            beq.w   .L8
            moveq   #0,D0
            move.w  (8,A6),D0
            ble.w   .L8
            move.l  D0,D3
            add.w   ($C,A6),D0
            movea.l (A3),A1
            move.w  (A1),D1
            sub.w   D0,D1
            bpl.b   .L1
            add.w   D1,D3
.L1:
            movea.l (A2),A0
            move.w  (A0),D4
            move.w  ($A,A6),D0
            add.w   D3,D0
            cmp.w   D4,D0
            ble.b   .L4
            move.w  D0,D4
            movea.l A2,A0
            addq.w  #1,D0
            asl.w   #4,D0
            _SetHandleSize
            bne.w   .L8
            movea.l (A2),A0
            move.w  D4,D2
            moveq   #0,D1
            move.w  (A0),D1
            sub.w   D1,D2
            move.w  D4,(A0)
            lea     ($10,A0),A1
            asl.w   #4,D1
            adda.l  D1,A1
            bra.b   .L3
.L2:
            clr.l   (A1)+
            clr.l   (A1)+
            clr.l   (A1)+
            clr.l   (A1)+
.L3:
            dbra    D2,.L2
.L4:
            cmpa.l  A2,A3
            beq.b   .L8
            move.l  A3,-(SP)
            bsr.w   DIRTYSEEDS
            movea.l (A3),A1
            moveq   #0,D0
            move.w  ($A,A6),D0
            asl.l   #4,D0
            movea.l (A2),A0
            lea     ($10,A0,D0.w),A0
            moveq   #0,D1
            move.w  ($C,A6),D0
            asl.l   #4,D0
            lea     ($10,A1,D0.w),A1
            bra.b   .L7
.L5:
            move.l  ($C,A0),D0
            beq.b   .L6
            movem.l A0-A1,-(SP)
            move.l  A0,-(SP)
            move.l  (A4),-(SP)
            jsr     CLEARONE
            movem.l (SP)+,A0-A1
.L6:
            move.l  (A1),(A0)
            move.l  (4,A1),(4,A0)
            move.w  (8,A1),(8,A0)
            clr.w   ($A,A0)
            clr.l   ($C,A0)
            adda.w  #$10,A0
            adda.w  #$10,A1
.L7:
            dbra    D3,.L5
.L8:
            moveq   #0,D0
            movem.l (SP)+,D3-D4/A2-A4
            unlk    A6
            rtd     #$E
            ds.b    10
UPDATEDEVICE:
            link.w  A6,#-$E
            movem.l D0-D3/A0-A3,-(SP)
            subq.w  #4,SP
            jsr     ([$1290.w])
            move.l  (SP)+,D3
            pea     (-4,A6)
            jsr     ([$FD0.w])
            movea.l ($DC8).w,A1
            movea.l (A1),A1
            move.w  (8,A6),D0
            movea.l ($38,A1,D0.w*8),A2
            movea.l A2,A0
            jsr     DEVSETENTRIES
            movea.l (A2),A0
            lea     ($22,A0),A2
            move.w  ($14,A0),D0
            btst    #$B,D0
            beq.b   .L1
            move.l  MenuList,D0
            beq.b   .L1
            movea.l D0,A0
            tst.l   (A0)
            beq.b   .L1
            jsr     ([$12DC.w])
.L1:
            moveq   #0,D0
            movea.l ($DCC).w,A0
            move.l  A0,D1
            bne.b   .L2
            movea.l ($DC8).w,A0
            movea.l (A0),A0
            movea.l ($C,A0),A0
            move.l  A0,D1
            beq.b   .L3
.L2:
            movea.l (A0),A0
            move.w  (6,A0),D0
            andi.w  #$C000,D0
.L3:
            move.w  D0,(-$E,A6)
            jsr     CHECKFORJUGGLER
            bne.b   .L4
            move.l  A2,-(SP)
            move.w  (8,A6),-(SP)
            move.w  (-$E,A6),-(SP)
            move.w  #$25,-(SP)
            _OSDispatch
            bra.w   .L11
.L4:
            movea.l WindowList,A3
            cmpa.w  #$FFFF,A3
            beq.w   .L11
            bra.w   .L10
.L5:
            move.w  (-$E,A6),D1
            move.w  #$E,D0
            cmpa.l  D3,A3
            bne.b   .L6
            move.w  #$F,D0
.L6:
            tst.b   ($6E,A3)
            beq.w   .L9
            tst.w   (6,A3)
            bpl.b   .L7
            movea.l (8,A3),A0
            movea.l (A0),A0
            movea.l ($C,A0),A0
            cmpa.w  #0,A0
            beq.b   .L7
            movea.l (A0),A0
            move.w  (6,A0),D1
.L7:
            btst    D0,D1
            beq.b   .L9
            lea     (2,A3),A0
            tst.w   (4,A0)
            bpl.b   .L8
            movea.l (A0),A0
            movea.l (A0),A0
.L8:
            lea     (6,A0),A0
            move.w  (A2),D0
            add.w   (A0),D0
            cmp.w   ($14,A3),D0
            bge.b   .L9
            move.w  D0,(-$C,A6)
            move.w  (2,A2),D0
            add.w   (2,A0),D0
            cmp.w   ($16,A3),D0
            bge.b   .L9
            move.w  D0,(-$A,A6)
            move.w  (4,A2),D0
            add.w   (A0),D0
            cmp.w   ($10,A3),D0
            ble.b   .L9
            move.w  D0,(-8,A6)
            move.w  (6,A2),D0
            add.w   (2,A0),D0
            cmp.w   ($12,A3),D0
            ble.b   .L9
            move.w  D0,(-6,A6)
            move.l  A3,-(SP)
            jsr     ([$FCC.w])
            pea     (-$C,A6)
            jsr     ([$12A0.w])
.L9:
            movea.l ($90,A3),A3
.L10:
            cmpa.w  #0,A3
            bne.w   .L5
            bsr.w   REDRAWDESKTOP
.L11:
            move.l  (-4,A6),-(SP)
            jsr     ([$FCC.w])
            moveq   #0,D0
            movem.l (SP)+,D0-D3/A0-A3
            unlk    A6
            rtd     #2
            ds.b    10
UPDATEDEVICES:
            movem.l D0-D1/A0,-(SP)
            cmpi.l  #$FFFFFFFF,WindowList
            beq.b   .L3
            cmpi.l  #$FFFFFFFF,($910).w
            beq.b   .L3
            movea.l ($DC8).w,A0
            movea.l (A0),A0
            move.w  (A0),D0
            subq.w  #1,D0
            move.l  ($14,A0),D1
            beq.b   .L3
            clr.l   ($14,A0)
.L1:
            btst    D0,D1
            beq.b   .L2
            move.w  D0,-(SP)
            jsr     UPDATEDEVICE
.L2:
            dbra    D0,.L1
            moveq   #$11,D0
            _PaletteDispatch
.L3:
            movem.l (SP)+,D0-D1/A0
            rts
            ds.b    12
WHATPAL:
            tst.w   (6,A2)
            bpl.b   .L1
            movea.l (8,A2),A0
            movea.l (A0),A0
            move.l  ($C,A0),D0
            bne.b   .L2
.L1:
            move.l  ($DCC).w,D0
            bne.b   .L2
            movea.l ($DC8).w,A0
            movea.l (A0),A0
            move.l  ($C,A0),D0
.L2:
            movea.l D0,A0
            tst.l   D0
            rts
            ds.b    8
CALCDEVS:
            movem.l D3-D7/A2-A3,-(SP)
            subq.w  #8,SP
            movea.l WindowList,A2
            moveq   #0,D3
            moveq   #0,D4
            clr.l   -(SP)
            jsr     ([$1290.w])
            move.l  (SP)+,D6
            bra.w   .L8
.L1:
            tst.b   ($6E,A2)
            bsr.w   WHATPAL
            cmpa.l  (-8,A6),A0
            bne.w   .L7
            lea     (2,A2),A0
            tst.w   (4,A0)
            bpl.w   .L2
            movea.l (A0),A0
            movea.l (A0),A0
.L2:
            move.l  (6,A0),D0
            move.l  ($10,A2),D1
            sub.w   D0,D1
            swap    D0
            swap    D1
            sub.w   D0,D1
            swap    D0
            swap    D1
            move.l  D1,(-$38,A6)
            move.l  ($14,A2),D1
            sub.w   D0,D1
            swap    D0
            swap    D1
            sub.w   D0,D1
            swap    D1
            move.l  D1,(-$34,A6)
            movea.l (-$12,A6),A0
            move.w  (A0),D5
            subq.w  #1,D5
            lea     ($38,A0),A3
.L3:
            movea.l (0,A3,D5.w*8),A0
            movea.l (A0),A0
            clr.w   -(SP)
            pea     ($22,A0)
            pea     (-$38,A6)
            pea     ($A,SP)
            jsr     ([$10A8.w])
            tst.w   (SP)+
            beq.b   .L6
            bset    D5,D3
            tst.b   ($6F,A2)
            beq.b   .L6
            cmp.l   A2,D6
            bne.b   .L4
            move.l  A2,(4,A3,D5.w*8)
            bra.b   .L5
.L4:
            cmpa.l  (4,A3,D5.w*8),A2
            bne.b   .L6
.L5:
            bset    D5,D4
.L6:
            dbra    D5,.L3
.L7:
            movea.l ($90,A2),A2
.L8:
            move.l  A2,D0
            bne.w   .L1
            move.l  D3,(-$2C,A6)
            move.l  D4,(-$30,A6)
            addq.l  #8,SP
            movem.l (SP)+,D3-D7/A2-A3
            rts
            ds.b    8
UNHOOKDEVICE:
            link.w  A6,#-$74
            movem.l D2-D4/A2,-(SP)
            movea.l ($DC8).w,A0
            cmpa.w  #$FFFF,A0
            beq.b   .L4
            movea.l (A0),A0
            move.w  (A0),D3
            lea     ($38,A0),A1
            move.l  (8,A6),D1
            subq.w  #1,D3
.L1:
            cmp.l   (0,A1,D3.w*8),D1
            beq.b   .L2
            dbra    D3,.L1
            bra.b   .L4
.L2:
            lsl.w   #8,D3
            movea.l D1,A2
            movea.l (A2),A2
            movea.l ($16,A2),A2
            movea.l (A2),A2
            movea.l ($2A,A2),A2
            movea.l (A2),A2
            move.w  #$FF,D4
.L3:
            move.b  D4,D3
            move.w  D3,-(SP)
            bsr.w   ZAPLINKS
            dbra    D4,.L3
            subq.w  #2,SP
            move.l  D1,-(SP)
            jsr     CHECKDEVICECOLORS
            tst.w   (SP)+
            beq.b   .L4
            moveq   #0,D0
            lsr.w   #8,D3
            bset    D3,D0
            or.l    D0,($10,A0)
            move.w  #1,-(SP)
            jsr     SCATTERDEVICES
            move.w  D3,-(SP)
            jsr     UPDATEDEVICE
.L4:
            movem.l (SP)+,D2-D4/A2
            unlk    A6
            rtd     #4
            ds.b    4
UNRESERVEDEVICES:
            movem.l D1-D4/A2-A4,-(SP)
            lea     ($138,A0),A2
            move.w  (A1),D1
            lea     ($10,A1),A3
            moveq   #0,D4
            bra.b   .L5
.L1:
            move.w  ($C,A3),D2
            bpl.b   .L4
.L2:
            bfextu  D2{19:5},D3
            btst    D3,D0
            beq.b   .L3
            bset    D3,D4
            move.w  D2,-(SP)
            jsr     ZAPLINKS
            movea.l ($38,A0,D3.w*8),A4
            bfextu  D2{24:8},D3
            movea.l (A4),A4
            movea.l ($16,A4),A4
            movea.l (A4),A4
            movea.l ($2A,A4),A4
            movea.l (A4),A4
            cmp.w   (6,A4),D3
            bhi.b   .L3
            move.w  #$1000,(8,A4,D3.w*8)
.L3:
            andi.w  #$1FFF,D2
            move.w  (0,A2,D2.w*4),D2
            bmi.b   .L2
.L4:
            lea     ($10,A3),A3
.L5:
            dbra    D1,.L1
            or.l    D4,($10,A0)
            movem.l (SP)+,D1-D4/A2-A4
            rts
            ds.b    10
ZAPLINKS:
            link.w  A6,#0
            movem.l D0-D4/A0-A2,-(SP)
            movea.l ($DC8).w,A1
            movea.l (A1),A1
            lea     ($138,A1),A0
            movea.l (4,A1),A2
            movea.l (A2),A2
            move.w  (8,A6),D0
            andi.w  #$1FFF,D0
            move.w  D0,D1
            lsr.w   #8,D1
            movea.l ($38,A1,D1.w*8),A1
            movea.l (A1),A1
            movea.l ($16,A1),A1
            movea.l (A1),A1
            move.l  ($2A,A1),D1
            beq.b   .L1
            movea.l D1,A1
            movea.l (A1),A1
            clr.w   D1
            move.b  D0,D1
            cmp.w   (6,A1),D0
            bhi.b   .L1
            bclr    #6,(8,A1,D1.w*8)
.L1:
            move.w  (0,A0,D0.w*4),D3
            beq.w   .L10
            move.w  (2,A0,D0.w*4),D4
            clr.l   (0,A0,D0.w*4)
            tst.w   D3
            bmi.b   .L2
            tst.w   D4
            bmi.b   .L5
            andi.w  #$1FFF,D3
            subq.w  #1,(4,A2,D3.w*8)
            movea.l (0,A2,D3.w*8),A0
            movea.l (A0),A0
            andi.l  #$1FFF,D4
            lsl.l   #4,D4
            clr.l   ($1C,A0,D4.l)
            bra.w   .L10
.L2:
            tst.w   D4
            bmi.b   .L7
            move.w  D3,D0
            bfextu  D3{19:5},D1
            bfextu  D3{24:8},D2
            lsl.w   #8,D1
            add.w   D2,D1
            lea     (0,A0,D1.l*4),A1
            move.w  D4,(2,A1)
            move.w  (A1),D3
            bpl.b   .L4
.L3:
            bfextu  D3{19:5},D1
            bfextu  D3{24:8},D2
            lsl.w   #8,D1
            add.w   D2,D1
            move.w  (0,A0,D1.l*4),D3
            bmi.b   .L3
.L4:
            andi.w  #$1FFF,D3
            subq.w  #1,(4,A2,D3.w*8)
            movea.l (0,A2,D3.w*8),A0
            movea.l (A0),A0
            andi.l  #$1FFF,D4
            lsl.l   #4,D4
            move.w  D0,($1C,A0,D4.l)
            bra.b   .L10
.L5:
            bfextu  D4{19:5},D1
            bfextu  D4{24:8},D2
            lsl.w   #8,D1
            add.w   D2,D1
            lea     (0,A0,D1.l*4),A1
            move.w  D3,(A1)
            move.w  (2,A1),D4
            bpl.b   .L9
.L6:
            bfextu  D4{19:5},D1
            bfextu  D4{24:8},D2
            lsl.w   #8,D1
            add.w   D2,D1
            move.w  (2,A0,D1.l*4),D4
            bmi.b   .L6
            bra.b   .L9
.L7:
            bfextu  D4{19:5},D1
            bfextu  D4{24:8},D2
            lsl.w   #8,D1
            add.w   D2,D1
            lea     (0,A0,D1.l*4),A1
            move.w  D3,(A1)
            bfextu  D3{19:5},D1
            bfextu  D3{24:8},D2
            lsl.w   #8,D1
            add.w   D2,D1
            lea     (0,A0,D1.l*4),A1
            move.w  D4,(2,A1)
            move.w  (A1),D3
            bpl.b   .L9
.L8:
            bfextu  D3{19:5},D1
            bfextu  D3{24:8},D2
            lsl.w   #8,D1
            add.w   D2,D1
            move.w  (0,A0,D1.l*4),D3
            bmi.b   .L8
.L9:
            andi.w  #$1FFF,D3
            subq.w  #1,(4,A2,D3.w*8)
.L10:
            movem.l (SP)+,D0-D4/A0-A2
            unlk    A6
            rtd     #2
            ds.b    10
RESIZEPALETTE:
            link.w  A6,#0
            movem.l D3-D4/A2,-(SP)
            movea.l ($A,A6),A0
            move.l  A0,D0
            addq.l  #1,D0
            bne.b   .L1
            movea.l ($DCC).w,A0
.L1:
            movea.l (A0),A2
            move.w  (8,A6),D3
            move.w  (A2),D4
            cmp.w   D4,D3
            beq.b   .L6
            bhi.b   .L4
            _HLock
            movea.l (A0),A2
            move.w  D4,D0
            lsl.w   #4,D0
            lea     ($10,A2,D0.w),A2
.L2:
            suba.w  #$10,A2
            subq.w  #1,D4
            move.w  (6,A2),D0
            andi.w  #6,D0
            beq.b   .L3
            move.l  ($A,A6),-(SP)
            move.w  D4,-(SP)
            clr.l   -(SP)
            jsr     ([$1878.w])
.L3:
            cmp.w   D4,D3
            bne.b   .L2
            movea.l ($A,A6),A0
            _HUnlock
.L4:
            move.w  D3,D0
            ext.l   D0
            lsl.l   #4,D0
            addi.l  #$10,D0
            _SetHandleSize
            bne.b   .L6
            movea.l (A0),A2
            move.w  D3,(A2)
            cmp.l   D3,D4
            bcc.b   .L6
            sub.l   D4,D3
            lsl.w   #4,D4
            lea     ($10,A2,D4.w),A0
            lsl.w   #2,D3
            subq.w  #1,D3
.L5:
            clr.l   (A0)+
            dbra    D3,.L5
.L6:
            movem.l (SP)+,D3-D4/A2
            unlk    A6
            rtd     #6
            ds.b    4
RESTOREDEVICECLUT:
            tst.l   (4,SP)
            bne.w   UNHOOKDEVICE
            move.l  A3,-(SP)
            move.l  DeviceList,D0
            bra.b   .L2
.L1:
            movea.l D0,A3
            move.l  A3,-(SP)
            jsr     UNHOOKDEVICE
            movea.l (A3),A3
            move.l  ($1E,A3),D0
.L2:
            bne.b   .L1
            movea.l (SP)+,A3
            rtd     #4
            ds.b    10
NEWHILITECOLOR:
            move.l  ($DC8).w,D1
            beq.b   .L3
            movea.l D1,A1
            movea.l (A1),A1
            move.l  ($24,A1),D0
            beq.b   .L1
            clr.l   ($24,A1)
            movea.l D0,A0
            _DisposHandle
.L1:
            movea.l D1,A1
            movea.l (A1),A1
            move.l  ($2C,A1),D0
            beq.b   .L2
            clr.l   ($2C,A1)
            movea.l D0,A0
            _DisposHandle
.L2:
            jsr     CHECKALLDEVICECLUTS
            clr.w   -(SP)
            jsr     SCATTERDEVICES
            jsr     UPDATEDEVICES
.L3:
            rts
            ds.b    6
SAVEFORE:
            moveq   #0,D0
            bra.b   SAVEBACK.L1
SAVEBACK:
            moveq   #1,D0
.L1:
            movea.l (4,SP),A1
            movea.l (A5),A0
            movea.l (A0),A0
            tst.w   (6,A0)
            bpl.b   .L4
            move.l  (8,A0),D1
            beq.b   .L4
            movea.l D1,A0
            movea.l (A0),A0
            btst    D0,($19,A0)
            beq.b   .L4
            move.w  #1,(A1)
            tst.w   D0
            beq.b   .L2
            move.w  ($16,A0),(2,A1)
            bra.b   .L3
.L2:
            move.w  ($10,A0),(2,A1)
.L3:
            rtd     #4
.L4:
            clr.w   (A1)
            pea     (2,A1)
            tst.w   D0
            beq.b   .L5
            jsr     ([$1668.w])
            bra.b   .L3
.L5:
            jsr     ([$1664.w])
            bra.b   .L3
            ds.b    8
RESTOREFORE:
            movea.l (4,SP),A1
            tst.w   (A1)+
            bne.b   .L2
            pea     (A1)
            jsr     ([$1650.w])
.L1:
            rtd     #4
.L2:
            move.w  (A1),-(SP)
            jsr     ([$185C.w])
            bra.b   .L1
RESTOREBACK:
            movea.l (4,SP),A1
            tst.w   (A1)+
            bne.b   .L1
            pea     (A1)
            jsr     ([$1654.w])
            bra.b   RESTOREFORE.L1
.L1:
            move.w  (A1),-(SP)
            jsr     ([$1860.w])
            bra.b   RESTOREFORE.L1
            ds.b    6
REINSTANTIATECOLORS:
            movem.l D3-D4/A2-A4,-(SP)
            movem.l (SP)+,D3-D4/A2-A4
            rts
            ds.b    6
RELEASELIST:
            tst.l   ($DC8).w
            beq.b   .L5
            movem.l D3-D4/A2,-(SP)
            movea.l ($10,SP),A2
            movea.l ($DC8).w,A0
            movea.l (A0),A0
            move.w  (A0),D0
            lea     ($38,A0),A0
            clr.w   D3
            move.l  TheGDevice,D1
.L1:
            cmp.l   (0,A0,D3.w*8),D1
            beq.b   .L2
            addq.w  #1,D3
            cmp.w   D0,D3
            bcs.b   .L1
            bra.b   .L4
.L2:
            lsl.w   #8,D3
            move.w  (A2)+,D4
.L3:
            move.w  (A2)+,D0
            move.b  D0,D3
            move.w  D3,-(SP)
            bsr.w   ZAPLINKS
            dbra    D4,.L3
.L4:
            movem.l (SP)+,D3-D4/A2
.L5:
            rtd     #4
            ds.b    8
.L6:
            dc.b    $EE,$B0,$EF,$90,$FE,$90,$FE
            ds.b    13
            dc.w    $D1E0,$FEC0,$E090,$FF00,$FF04,$FF60,$FF7E,$FFA0
            dc.w    $FFB0
PMgrDispatch:
            cmpi.b  #$13,D0
            bcc.b   .L1
            lea     RELEASELIST.L6,A0
            move.w  (0,A0,D0.w*2),D0
            beq.b   .L1
            adda.w  D0,A0
            jmp     (A0)
.L1:
            lsr.w   #8,D0
            movea.l (SP)+,A0
            adda.w  D0,SP
            moveq   #-1,D0
            jmp     (A0)
            ds.b    12
QDEXTDISPATCHER:
            cmpi.w  #$15,D0
            bhi.b   .L2
            jmp     .L1(PC,D0.w*4)
.L1:
            jmp     NEWGWORLD
            dc.w    $4EFA,$1080,$4EFA,$10BC,$4EFA,$0618,$4EFA,$0574
            dc.w    $4EFA,$0510,$4EFA,$052C,$4EFA,$10F8,$4EFA,$10E4
            dc.w    $4EFA,$10D0,$4EFA,$110C,$4EFA,$1118,$4EFA,$1134
            dc.w    $4EFA,$1150,$4EFA,$117C,$4EFA,$11D8,$4EFA,$1224
            dc.w    $4EFA,$1400,$4EFA,$05AC,$4EFA,$1028,$4EFA,$1424
            dc.w    $4EFA,$1214
.L2:
            movea.l (SP)+,A0
            swap    D0
            ext.l   D0
            adda.l  D0,SP
            move.w  #$FFCE,D0
            move.w  D0,QDErr
            jmp     (A0)
            ds.b    12
NEWGWORLD:
            link.w  A6,#-$3E
            movem.l D3-D7/A2-A4,-(SP)
            clr.w   ($1E,A6)
            clr.l   (-$A,A6)
            clr.l   (-$E,A6)
            clr.l   (-$12,A6)
            clr.l   (-$16,A6)
            clr.l   (-$1A,A6)
            clr.l   (-$1E,A6)
            clr.b   -(SP)
            move.l  ($14,A6),-(SP)
            jsr     ([$10B8.w])
            move.b  (SP)+,D0
            bne.w   .L23
            move.l  TheGDevice,(-$26,A6)
            moveq   #$6C,D0
            _ResrvMem
            bne.w   .L24
            moveq   #$6C,D0
            _NewHandle
            bne.w   .L24
            move.l  A0,(-$1E,A6)
            _HLock
            move.l  (A0),D0
            _StripAddress
            move.l  D0,(-$22,A6)
            movea.l D0,A0
            clr.w   (6,A0)
            move.l  (8,A6),D3
            move.w  ($18,A6),D7
            bmi.w   .L22
            beq.b   .L2
            cmpi.w  #$20,D7
            bgt.w   .L22
            clr.w   (-$2E,A6)
            movea.l ($14,A6),A0
            move.l  (A0),(-$3E,A6)
            move.l  (4,A0),(-$3A,A6)
            btst    #1,D3
            beq.b   .L1
            move.l  ($C,A6),D0
            beq.w   .L23
            move.l  D0,(-$26,A6)
.L1:
            bra.b   .L3
.L2:
            clr.l   -(SP)
            move.l  ($14,A6),-(SP)
            jsr     ([$169C.w])
            movea.l (SP)+,A0
            move.l  A0,(-$26,A6)
            movea.l (A0),A0
            movea.l ($14,A6),A1
            move.w  (2,A1),D0
            sub.w   ($24,A0),D0
            move.w  D0,(-$2E,A6)
            move.w  (6,A1),D0
            sub.w   (2,A1),D0
            move.w  D0,(-$38,A6)
            move.w  (4,A1),D0
            sub.w   (A1),D0
            move.w  D0,(-$3A,A6)
            clr.l   (-$3E,A6)
            movea.l ([-$26.w,A6]),A0
            movea.l ([$16.w,A0]),A1
            move.w  ($20,A1),D7
.L3:
            lea     SHIFTTABLE,A0
            moveq   #0,D0
            move.b  (0,A0,D7.w),D0
            bmi.w   .L22
            move.w  D0,(-2,A6)
            move.w  (-$3E,A6),(-$36,A6)
            move.w  (-$2E,A6),D1
            lsl.w   D0,D1
            andi.w  #$1F,D1
            lsr.w   D0,D1
            move.w  (-$3C,A6),D0
            sub.w   D1,D0
            move.w  D0,(-$34,A6)
            move.l  (-$3A,A6),(-$32,A6)
            move.w  (-$38,A6),D0
            sub.w   (-$3C,A6),D0
            ext.l   D0
            move.w  (-2,A6),D1
            lsl.l   D1,D0
            addi.l  #$1E,D0
            lsr.l   #5,D0
            addq.w  #1,D0
            lsl.l   #2,D0
            move.w  D0,(-6,A6)
            move.w  (-$3A,A6),D1
            sub.w   (-$3E,A6),D1
            mulu.w  D1,D0
            btst    #2,D3
            beq.b   .L4
            jsr     ([$1AB4.w])
            tst.l   D0
            bne.b   .L5
            move.w  #$FF69,D0
            bra.w   .L24
.L4:
            _NewHandle
            bne.w   .L24
.L5:
            move.l  A0,(-$A,A6)
            _MoveHHi
            btst    #0,D3
            beq.b   .L6
            _HPurge
.L6:
            movea.l ([-$26.w,A6]),A0
            move.w  ($A,A0),(-4,A6)
            moveq   #$32,D0
            _NewHandleClear
            bne.w   .L24
            move.l  A0,(-$E,A6)
            movea.l (A0),A1
            move.l  (-$A,A6),(A1)
            move.w  (-6,A6),D0
            ori.w   #$8000,D0
            move.w  D0,(4,A1)
            move.l  (-$36,A6),(6,A1)
            move.l  (-$32,A6),($A,A1)
            move.w  #2,($E,A1)
            move.w  #$48,($16,A1)
            move.w  #$48,($1A,A1)
            move.w  D7,($20,A1)
            cmpi.w  #$10,D7
            blt.b   .L9
            move.w  #2,(-$2C,A6)
            move.w  #$10,($1E,A1)
            move.w  #3,($22,A1)
            moveq   #8,D0
            cmpi.w  #$20,D7
            beq.b   .L7
            moveq   #5,D0
.L7:
            move.w  D0,($24,A1)
            move.w  #8,D0
            _NewHandleClear
            bne.w   .L24
            move.l  A0,(-$12,A6)
            movea.l ([-$E.w,A6]),A1
            move.l  A0,($2A,A1)
            movea.l (A0),A0
            moveq   #$18,D0
            cmpi.w  #$20,D7
            beq.b   .L8
            moveq   #$F,D0
.L8:
            move.l  D0,(A0)
            moveq   #2,D0
            _NewHandleClear
            bne.w   .L24
            move.l  A0,(-$1A,A6)
            bra.w   .L15
.L9:
            clr.w   (-$2C,A6)
            clr.w   ($1E,A1)
            move.w  #1,($22,A1)
            move.w  D7,($24,A1)
            movea.l ($10,A6),A0
            suba.l  A4,A4
            btst    #1,D3
            beq.b   .L10
            movea.l ([-$26.w,A6]),A0
            movea.l ([$16.w,A0]),A0
            movea.l ($2A,A0),A0
            move.l  A0,(-$12,A6)
            movea.l ([-$E.w,A6]),A1
            move.l  A0,($2A,A1)
            bra.w   .L17
.L10:
            tst.w   ($18,A6)
            beq.b   .L11
            cmpa.w  #0,A0
            bne.b   .L12
            clr.l   -(SP)
            move.w  ($18,A6),-(SP)
            jsr     ([$1660.w])
            movea.l (SP)+,A0
            tst.l   A0
            bne.b   .L13
.L11:
            movea.l ([-$26.w,A6]),A0
            movea.l (6,A0),A4
            movea.l ([$16.w,A0]),A0
            movea.l ($2A,A0),A0
.L12:
            jsr     ([$1584.w])
            bne.w   .L24
.L13:
            move.l  A0,(-$12,A6)
            movea.l ([-$E.w,A6]),A1
            move.l  A0,($2A,A1)
            movea.l A4,A0
            tst.l   A0
            bne.b   .L14
            clr.l   -(SP)
            move.l  (-$12,A6),-(SP)
            jsr     FINDINVERSETABLE
            movea.l (SP)+,A0
            tst.l   A0
            bne.b   .L14
            moveq   #2,D0
            _NewHandleClear
            bne.w   .L24
            move.l  A0,(-$1A,A6)
            move.l  (-$12,A6),-(SP)
            move.l  A0,-(SP)
            move.w  (-4,A6),-(SP)
            jsr     ([$16E4.w])
            move.w  QDErr,D0
            bne.w   .L24
            bra.b   .L15
.L14:
            jsr     ([$1584.w])
            bne.w   .L24
            move.l  A0,(-$1A,A6)
.L15:
            btst    #1,D3
            bne.b   .L17
            moveq   #$3E,D0
            _NewHandleClear
            bne.w   .L24
            move.l  A0,(-$16,A6)
            movea.l (A0),A0
            move.w  (-$2C,A6),(4,A0)
            move.l  (-$1A,A6),(6,A0)
            move.w  (-4,A6),($A,A0)
            move.w  #$4000,D0
            cmpi.w  #1,D7
            beq.b   .L16
            ori.w   #1,D0
.L16:
            move.w  D0,($14,A0)
            move.l  (-$E,A6),($16,A0)
            move.l  (-$36,A6),($22,A0)
            move.l  (-$32,A6),($26,A0)
            move.l  #$FFFFFFFF,($2A,A0)
            move.l  (-$16,A6),(-$26,A6)
.L17:
            move.l  TheGDevice,(-$2A,A6)
            move.l  (-$26,A6),TheGDevice
            move.l  (-$22,A6),-(SP)
            jsr     ([$1600.w])
            move.l  (-$2A,A6),TheGDevice
            btst    #1,D3
            beq.b   .L18
            movea.l (-$22,A6),A0
            movea.l (2,A0),A0
            _DisposHandle
            movea.l (-$E,A6),A0
            movea.l (-$22,A6),A1
            move.l  A0,(2,A1)
.L18:
            movea.l (-$22,A6),A1
            move.l  (-$3E,A6),($10,A1)
            move.l  (-$3A,A6),($14,A1)
            move.l  ($18,A1),-(SP)
            pea     ($10,A1)
            jsr     ([$117C.w])
            movea.l (-$22,A6),A0
            movea.l (8,A0),A0
            moveq   #$20,D0
            _SetHandleSize
            bne.b   .L24
            movea.l (-$22,A6),A0
            movea.l ([8.w,A0]),A0
            move.l  (-$26,A6),($1A,A0)
            moveq   #1,D0
            btst    #1,D3
            beq.b   .L19
            moveq   #0,D0
.L19:
            move.b  D0,($1E,A0)
            moveq   #0,D0
            btst    #2,D3
            beq.b   .L20
            moveq   #1,D0
.L20:
            move.b  D0,($1F,A0)
            movea.l (-$22,A6),A0
            ori.w   #1,(6,A0)
            movea.l ($1A,A6),A0
            move.l  (-$22,A6),(A0)
.L21:
            move.w  ($1E,A6),D0
            ext.l   D0
            move.w  D0,QDErr
            movem.l (SP)+,D3-D7/A2-A4
            unlk    A6
            rtd     #$16
.L22:
            move.w  #$FF63,($1E,A6)
            bra.b   .L25
.L23:
            move.w  #$FFCE,($1E,A6)
            bra.b   .L25
.L24:
            move.w  D0,($1E,A6)
            nop
.L25:
            movea.l (-$A,A6),A0
            _DisposHandle
            movea.l (-$E,A6),A0
            _DisposHandle
            movea.l (-$12,A6),A0
            _DisposHandle
            movea.l (-$16,A6),A0
            _DisposHandle
            movea.l (-$1A,A6),A0
            _DisposHandle
            move.l  (-$1E,A6),D7
            beq.b   .L21
            movea.l D7,A0
            movea.l (A0),A0
            move.w  (6,A0),D0
            andi.w  #$C000,D0
            cmpi.w  #$C000,D0
            bne.w   .L26
            move.l  (A0),-(SP)
            jsr     ([$1608.w])
.L26:
            movea.l D7,A0
            _DisposHandle
            bra.b   .L21
SHIFTTABLE:
            dc.w    $FF00,$01FF,$02FF,$FFFF,$03FF,$FFFF,$FFFF,$FFFF
            dc.w    $04FF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF
            dc.b    $05
            ds.b    5
FINDINVERSETABLE:
            movea.l ([4.w,SP]),A0
            move.l  (A0),D0
            movea.l DeviceList,A0
            tst.l   A0
            beq.b   .L2
.L1:
            movea.l (A0),A0
            movea.l (6,A0),A2
            movea.l (A2),A1
            cmp.l   (A1),D0
            beq.b   .L2
            movea.l ($1E,A0),A0
            tst.l   A0
            bne.b   .L1
            suba.l  A2,A2
.L2:
            move.l  A2,(8,SP)
            rtd     #4
            dc.w    0
GETGWORLD:
            movea.l (8,SP),A0
            movea.l (A5),A1
            move.l  (A1),(A0)
            movea.l (4,SP),A0
            move.l  TheGDevice,(A0)
            rtd     #8
            ds.b    12
SETGWORLD:
            movea.l (A5),A0
            move.l  (8,SP),(A0)
            movea.l (4,SP),A1
            movea.l (8,SP),A0
            move.w  (6,A0),D0
            andi.w  #$C001,D0
            cmpi.w  #$C001,D0
            bne.b   .L1
            movea.l ([8.w,A0]),A0
            movea.l ($1A,A0),A1
.L1:
            tst.l   A1
            bne.b   .L2
            movea.l MainDevice,A1
.L2:
            move.l  A1,TheGDevice
            rtd     #8
            ds.b    10
DISPOSEGWORLD:
            movea.l (4,SP),A0
            move.w  (6,A0),D0
            andi.w  #$C001,D0
            cmpi.w  #$C001,D0
            bne.b   .L5
            movea.l ([2.w,A0]),A1
            movea.l (A1),A0
            move.w  ($E,A1),D0
            cmpi.w  #2,D0
            beq.b   .L1
            cmpi.w  #1,D0
            bne.b   .L2
            _RecoverHandle
.L1:
            _DisposHandle
.L2:
            movea.l (4,SP),A0
            movea.l ([8.w,A0]),A0
            move.b  ($1E,A0),D0
            beq.b   .L4
            movea.l ($1A,A0),A0
            cmpa.l  TheGDevice,A0
            bne.b   .L3
            move.l  MainDevice,TheGDevice
.L3:
            move.l  A0,-(SP)
            jsr     ([$16C0.w])
.L4:
            move.l  (4,SP),-(SP)
            jsr     ([$1608.w])
            movea.l (4,SP),A0
            _RecoverHandle
            _DisposHandle
.L5:
            rtd     #4
            ds.b    4
GETGWORLDDEVICE:
            movea.l (4,SP),A0
            move.w  (6,A0),D0
            andi.w  #$C001,D0
            cmpi.w  #$C001,D0
            beq.b   .L1
            move.l  TheGDevice,(8,SP)
            bra.b   .L2
.L1:
            movea.l ([8.w,A0]),A0
            move.l  ($1A,A0),(8,SP)
.L2:
            rtd     #4
            ds.b    6
UPDATEGWORLD:
            link.w  A6,#-$66
            movem.l D5-D7/A2-A4,-(SP)
            move.l  SP,(-$40,A6)
            clr.l   ($1E,A6)
            clr.l   (-$18,A6)
            move.l  (8,A6),D0
            andi.l  #$8FFFFFFF,D0
            tst.l   D0
            bne.w   .L67
            move.l  (8,A6),D0
            andi.l  #$30000000,D0
            cmpi.l  #$30000000,D0
            beq.w   .L67
            move.l  (8,A6),D0
            btst    #$1E,D0
            beq.w   .L1
            andi.l  #$30000000,D0
            beq.w   .L67
.L1:
            movea.l ([$1A.w,A6]),A3
            pea     (-$24,A6)
            pea     (-$28,A6)
            moveq   #5,D0
            jsr     ([$1A74.w])
            move.l  ($C,A6),D0
            beq.b   .L2
            movea.l D0,A0
            movea.l (A0),A0
            movea.l ([$16.w,A0]),A0
            move.w  ($20,A0),($18,A6)
            move.l  ($2A,A0),($10,A6)
.L2:
            movea.l ($14,A6),A0
            move.w  ($18,A6),D7
            blt.w   .L64
            beq.b   .L3
            cmpi.w  #$20,D7
            bgt.w   .L64
            bra.b   .L4
.L3:
            clr.l   (-$30,A6)
            move.w  (4,A0),D0
            sub.w   (A0),D0
            move.w  D0,(-$2C,A6)
            move.w  (6,A0),D0
            sub.w   (2,A0),D0
            move.w  D0,(-$2A,A6)
            clr.l   -(SP)
            move.l  ($14,A6),-(SP)
            jsr     ([$169C.w])
            movea.l (SP)+,A0
            move.l  A0,(-$44,A6)
            movea.l (A0),A1
            movea.l ([$16.w,A1]),A0
            move.w  ($20,A0),(-$32,A6)
            movea.l ([$2A.w,A0]),A0
            move.l  (A0),(-$36,A6)
            movea.l ($14,A6),A0
            move.w  (2,A0),D0
            sub.w   ($24,A1),D0
            move.w  D0,(-$38,A6)
            bra.b   .L8
.L4:
            move.l  (A0),(-$30,A6)
            move.l  (4,A0),(-$2C,A6)
            clr.w   (-$38,A6)
            move.w  ($18,A6),(-$32,A6)
            move.l  ($10,A6),D0
            beq.b   .L5
            movea.l D0,A0
            movea.l (A0),A0
            move.l  (A0),(-$36,A6)
            bra.b   .L8
.L5:
            move.w  ($18,A6),D0
            cmpi.w  #$10,D0
            bne.b   .L6
            move.w  #$F,D0
            bra.b   .L7
.L6:
            cmpi.w  #$20,D0
            bne.b   .L7
            move.w  #$18,D0
.L7:
            ext.l   D0
            move.l  D0,(-$36,A6)
.L8:
            move.w  (-$32,A6),D7
            lea     SHIFTTABLE,A0
            moveq   #0,D0
            move.b  (0,A0,D7.w),D7
            bmi.w   .L64
            move.w  (-$38,A6),D0
            lsl.w   D7,D0
            andi.w  #$1F,D0
            lsr.w   D7,D0
            move.w  D0,(-$38,A6)
            movea.l ([2.w,A3]),A0
            move.w  (4,A0),D0
            andi.w  #$7FFF,D0
            move.w  D0,(-$3A,A6)
            clr.b   (-$1E,A6)
            move.l  ($10,A3),D0
            cmp.l   (-$30,A6),D0
            bne.b   .L9
            move.l  ($14,A3),D0
            cmp.l   (-$2C,A6),D0
            bne.b   .L9
            move.b  #1,(-$1E,A6)
            bra.w   .L13
.L9:
            move.w  ($16,A3),D0
            sub.w   ($12,A3),D0
            move.w  (-$2A,A6),D1
            sub.w   (-$2E,A6),D1
            cmp.w   D0,D1
            bne.b   .L10
            move.w  ($14,A3),D0
            sub.w   ($10,A3),D0
            move.w  (-$2C,A6),D1
            sub.w   (-$30,A6),D1
            cmp.w   D0,D1
            beq.b   .L13
.L10:
            move.w  (-$2A,A6),D0
            sub.w   (-$2E,A6),D0
            ext.l   D0
            lsl.l   D7,D0
            addi.l  #$1E,D0
            lsr.l   #5,D0
            addq.w  #1,D0
            lsl.l   #2,D0
            move.w  D0,(-$3A,A6)
            movea.l ([2.w,A3]),A0
            move.w  (4,A0),D1
            andi.w  #$7FFF,D1
            move.w  D1,(-$3C,A6)
            cmp.w   D1,D0
            beq.b   .L11
            ori.l   #$80000,($1E,A6)
.L11:
            move.l  (8,A6),D0
            andi.l  #$10000000,D0
            bne.b   .L12
            move.l  #$20000000,D0
.L12:
            move.l  D0,($1E,A6)
.L13:
            movea.l ([2.w,A3]),A0
            move.w  (8,A0),D0
            move.w  (-$38,A6),D1
            neg.w   D1
            cmp.w   D1,D0
            beq.b   .L14
            ori.l   #$40000,($1E,A6)
.L14:
            clr.w   (-$20,A6)
            movea.l ([2.w,A3]),A0
            move.w  ($20,A0),D0
            cmp.w   (-$32,A6),D0
            beq.b   .L15
            ori.l   #$20000,($1E,A6)
            move.l  (8,A6),D0
            andi.l  #$40000000,D0
            beq.b   .L15
            move.w  #$40,(-$20,A6)
            ori.l   #$40000000,($1E,A6)
.L15:
            movea.l ([$2A.w,A0]),A0
            move.l  (A0),D0
            cmp.l   (-$36,A6),D0
            beq.b   .L16
            ori.l   #$10000,($1E,A6)
.L16:
            clr.l   -(SP)
            move.l  (2,A3),-(SP)
            moveq   #$D,D0
            jsr     ([$1A74.w])
            move.l  (SP)+,D0
            move.l  D0,(-$1C,A6)
            move.l  (2,A3),-(SP)
            moveq   #$C,D0
            jsr     ([$1A74.w])
            clr.b   (-$1D,A6)
            clr.l   -(SP)
            move.l  (2,A3),-(SP)
            moveq   #$F,D0
            jsr     ([$1A74.w])
            move.l  (SP)+,D0
            bne.b   .L17
            ori.l   #1,(-$18,A6)
            ori.l   #$100000,($1E,A6)
            move.b  #1,(-$1D,A6)
            move.l  #$40,(-$1C,A6)
            bra.b   .L18
.L17:
            move.l  (-$1C,A6),D0
            btst    #6,D0
            beq.b   .L18
            ori.l   #1,(-$18,A6)
.L18:
            movea.l ([8.w,A3]),A0
            move.b  ($1E,A0),D0
            bne.b   .L19
            ori.l   #2,(-$18,A6)
.L19:
            tst.b   ($1F,A0)
            beq.b   .L20
            ori.l   #4,(-$18,A6)
.L20:
            move.l  ($1E,A6),D0
            beq.b   .L22
            cmpi.l  #$100000,D0
            beq.b   .L23
            tst.l   (8,A6)
            beq.w   .L41
            cmpi.l  #$10000,D0
            bne.b   .L21
            tst.b   (-$1E,A6)
            beq.b   .L21
            cmpi.w  #4,D7
            blt.w   .L29
.L21:
            cmpi.l  #$40000,D0
            beq.b   .L24
            bra.w   .L41
.L22:
            move.l  A3,(-4,A6)
            bra.w   .L57
.L23:
            move.w  (-$2C,A6),D0
            sub.w   (-$30,A6),D0
            mulu.w  (-$3A,A6),D0
            movea.l ([2.w,A3]),A1
            movea.l (A1),A0
            _ReallocHandle
            bne.w   .L63
            _MoveHHi
            move.l  A3,(-4,A6)
            bra.w   .L57
.L24:
            clr.l   -(SP)
            move.l  (2,A3),-(SP)
            moveq   #$F,D0
            jsr     ([$1A74.w])
            movea.l (SP)+,A1
            move.w  (-$2C,A6),D0
            sub.w   (-$30,A6),D0
            move.w  (-$3A,A6),D1
            mulu.w  D1,D0
            movea.l A1,A4
            adda.l  D0,A4
            movea.l ([2.w,A3]),A0
            move.w  (8,A0),D6
            neg.w   D6
            sub.w   (-$38,A6),D6
            ext.l   D6
            lsl.l   D7,D6
            blt.b   .L26
.L25:
            bfextu  (A1){D6:0},D0
            move.l  D0,(A1)+
            cmpa.l  A4,A1
            blt.b   .L25
            bra.b   .L28
.L26:
            subi.l  #$20,D6
.L27:
            bfextu  (A4){D6:0},D0
            move.l  D0,-(A4)
            cmpa.l  A4,A1
            blt.b   .L27
.L28:
            movea.l ([2.w,A3]),A0
            move.w  (-$30,A6),(6,A0)
            move.w  (-$2E,A6),D0
            sub.w   (-$38,A6),D0
            move.w  D0,(8,A0)
            move.l  (-$2C,A6),($A,A0)
            move.l  (-$30,A6),($10,A3)
            move.l  (-$2C,A6),($14,A3)
            move.l  ($18,A3),-(SP)
            pea     ($10,A3)
            jsr     ([$117C.w])
            move.l  A3,(-4,A6)
            movea.l ([8.w,A3]),A1
            move.b  ($1E,A1),D0
            beq.w   .L57
            movea.l ([$1A.w,A1]),A1
            move.l  (6,A0),($22,A1)
            move.l  ($A,A0),($26,A1)
            movea.l ([$16.w,A1]),A1
            move.l  (6,A0),(6,A1)
            move.l  ($A,A0),($A,A1)
            bra.w   .L57
.L29:
            move.l  TheGDevice,(-$28,A6)
            move.l  A3,(-4,A6)
            movea.l ([8.w,A3]),A4
            move.l  A3,-(SP)
            clr.l   -(SP)
            moveq   #6,D0
            jsr     ([$1A74.w])
            pea     (-$5A,A6)
            moveq   #$D,D0
            _PaletteDispatch
            pea     (-$62,A6)
            moveq   #$E,D0
            _PaletteDispatch
            move.l  (-$18,A6),D0
            andi.l  #2,D0
            beq.b   .L31
            move.l  ($C,A6),TheGDevice
            move.l  ([2.w,A3]),-(SP)
            move.w  #$20,-(SP)
            jsr     ([$1A38.w])
            movea.l ($1A,A4),A0
            movea.l (-$28,A6),A1
            cmpa.l  A0,A1
            bne.b   .L30
            move.l  ($C,A6),(-$28,A6)
.L30:
            move.l  A0,-(SP)
            jsr     ([$16C0.w])
            movea.l ($C,A6),A0
            move.l  A0,($1A,A4)
            movea.l (A0),A0
            movea.l ([$16.w,A0]),A0
            movea.l ([2.w,A3]),A1
            move.l  ($2A,A0),($2A,A1)
            move.l  (-$28,A6),TheGDevice
            bra.w   .L37
.L31:
            movea.l ([$1A.w,A4]),A0
            move.w  ($A,A0),(-$4E,A6)
            movea.l ($10,A6),A0
            clr.l   (-$4C,A6)
            tst.w   ($18,A6)
            beq.b   .L32
            cmpa.w  #0,A0
            bne.b   .L33
            clr.l   -(SP)
            move.w  ($18,A6),-(SP)
            jsr     ([$1660.w])
            movea.l (SP)+,A0
            tst.l   A0
            beq.w   .L65
            bra.b   .L34
.L32:
            movea.l ([-$44.w,A6]),A0
            move.l  (6,A0),(-$4C,A6)
            movea.l ([$16.w,A0]),A0
            movea.l ($2A,A0),A0
.L33:
            jsr     ([$1584.w])
            bne.w   .L63
.L34:
            move.l  A0,(-$48,A6)
            movea.l (-$4C,A6),A0
            tst.l   A0
            bne.b   .L35
            clr.l   -(SP)
            move.l  (-$48,A6),-(SP)
            jsr     FINDINVERSETABLE
            movea.l (SP)+,A0
            tst.l   A0
            bne.b   .L35
            moveq   #2,D0
            _NewHandleClear
            bne.w   .L63
            move.l  A0,(-$4C,A6)
            move.l  (-$48,A6),-(SP)
            move.l  A0,-(SP)
            move.w  (-$4E,A6),-(SP)
            jsr     ([$16E4.w])
            move.w  QDErr,D0
            bne.w   .L68
            bra.b   .L36
.L35:
            jsr     ([$1584.w])
            bne.w   .L63
            move.l  A0,(-$4C,A6)
.L36:
            movea.l ([8.w,A3]),A4
            movea.l ([$1A.w,A4]),A0
            movea.l (6,A0),A0
            _DisposHandle
            movea.l ([$1A.w,A4]),A0
            move.l  (-$4C,A6),(6,A0)
            movea.l ([$16.w,A0]),A0
            move.l  (-$48,A6),($2A,A0)
            move.l  ($1A,A4),TheGDevice
            move.l  ([2.w,A3]),-(SP)
            move.w  #$20,-(SP)
            jsr     ([$1A38.w])
            move.l  (-$28,A6),TheGDevice
            movea.l ([2.w,A3]),A4
            movea.l ($2A,A4),A0
            _DisposHandle
            move.l  (-$48,A6),($2A,A4)
.L37:
            moveq   #1,D0
            move.w  (-$32,A6),D7
            lsl.w   D7,D0
            moveq   #0,D1
            move.w  D0,D1
            lsl.w   #2,D1
            subq.w  #1,D0
            movea.l SP,A0
            adda.l  D1,A0
.L38:
            cmp.l   -(A0),D0
            dbne    D0,.L38
            beq.w   .L57
            clr.l   -(SP)
            move.l  (2,A3),-(SP)
            moveq   #$F,D0
            jsr     ([$1A74.w])
            movea.l (SP)+,A1
            movea.l ([2.w,A3]),A0
            move.w  (4,A0),D1
            andi.w  #$7FFF,D1
            move.w  ($A,A0),D0
            sub.w   (6,A0),D0
            mulu.w  D1,D0
            movea.l A1,A4
            adda.l  D0,A4
            moveq   #0,D6
            moveq   #$1F,D1
.L39:
            move.l  (A1),D5
.L40:
            bfextu  D5{D6:D7},D0
            move.l  (0,SP,D0.w*4),D0
            bfins   D0,D5{D6:D7}
            add.w   D7,D6
            and.w   D1,D6
            bne.b   .L40
            move.l  D5,(A1)+
            cmpa.l  A4,A1
            blt.b   .L39
            pea     (-$5A,A6)
            moveq   #$F,D0
            _PaletteDispatch
            pea     (-$62,A6)
            moveq   #$10,D0
            _PaletteDispatch
            bra.w   .L57
.L41:
            move.l  (8,A6),D0
            bne.b   .L42
            andi.l  #$100000,($1E,A6)
.L42:
            move.l  (-$18,A6),D0
            andi.l  #2,D0
            bne.b   .L43
            clr.l   ($C,A6)
.L43:
            clr.l   (-$52,A6)
            tst.b   (-$1D,A6)
            bne.b   .L44
            move.l  (8,A6),D0
            bne.b   .L45
.L44:
            movea.l (2,A3),A4
            move.l  A4,-(SP)
            moveq   #2,D0
            jsr     ([$1A74.w])
            movea.l (A4),A1
            movea.l (A1),A4
            clr.l   (A1)
            movea.l A4,A0
            _GetHandleSize
            move.l  D0,(-$52,A6)
            movea.l A4,A0
            _DisposHandle
.L45:
            clr.w   -(SP)
            pea     (-4,A6)
            move.w  ($18,A6),-(SP)
            move.l  ($14,A6),-(SP)
            move.l  ($10,A6),-(SP)
            move.l  ($C,A6),-(SP)
            move.l  (-$18,A6),-(SP)
            moveq   #0,D0
            jsr     ([$1A74.w])
            move.w  (SP)+,D0
            bne.w   .L69
            movea.l (-4,A6),A4
            move.w  ($C,A3),($C,A4)
            move.w  ($E,A3),($E,A4)
            move.l  ($1C,A3),-(SP)
            move.l  ($1C,A4),-(SP)
            jsr     ([$1170.w])
            move.l  (8,A6),D0
            andi.l  #$10000000,D0
            bne.w   .L46
            move.l  ($1C,A4),-(SP)
            pea     ($10,A3)
            pea     ($10,A4)
            jsr     ([$11EC.w])
            bra.w   .L47
.L46:
            move.l  ($1C,A4),-(SP)
            move.w  ($12,A4),D0
            sub.w   ($12,A3),D0
            move.w  D0,-(SP)
            move.w  ($10,A4),D0
            sub.w   ($10,A3),D0
            move.w  D0,-(SP)
            jsr     ([$1180.w])
.L47:
            move.l  ($20,A3),D0
            beq.w   .L48
            move.l  D0,-(SP)
            move.l  ($20,A4),-(SP)
            jsr     ([$1624.w])
.L48:
            move.l  ($24,A3),($24,A4)
            move.l  ($28,A3),($28,A4)
            move.l  ($2C,A3),($2C,A4)
            move.l  ($30,A3),($30,A4)
            move.l  ($34,A3),($34,A4)
            move.w  ($38,A3),($38,A4)
            move.l  ($3A,A3),D0
            beq.w   .L49
            move.l  D0,-(SP)
            move.l  ($3A,A4),-(SP)
            jsr     ([$1624.w])
.L49:
            move.l  ($3E,A3),D0
            beq.w   .L50
            move.l  D0,-(SP)
            move.l  ($3E,A4),-(SP)
            jsr     ([$1624.w])
.L50:
            lea     ($42,A3),A0
            lea     ($42,A4),A1
            moveq   #$14,D0
.L51:
            move.w  (A0)+,(A1)+
            dbra    D0,.L51
            movea.l ([2.w,A3]),A0
            movea.l ([2.w,A4]),A1
            move.w  ($10,A0),($10,A1)
            move.l  ($12,A0),($12,A1)
            move.l  ($16,A0),($16,A1)
            move.l  ($1A,A0),($1A,A1)
            movea.l ([8.w,A3]),A0
            movea.l ([8.w,A4]),A1
            moveq   #$C,D0
.L52:
            move.w  (A0)+,(A1)+
            dbra    D0,.L52
            move.l  ($68,A3),($68,A4)
            movea.l ([8.w,A3]),A0
            movea.l ([$1A.w,A0]),A0
            movea.l ([8.w,A4]),A1
            movea.l ([$1A.w,A1]),A1
            move.l  ($C,A0),($C,A1)
            move.l  ($10,A0),($10,A1)
            move.l  ($1A,A0),($1A,A1)
            movea.l ([$16.w,A0]),A0
            movea.l ([$16.w,A1]),A1
            move.w  ($10,A0),($10,A1)
            move.l  ($12,A0),($12,A1)
            move.l  ($16,A0),($16,A1)
            move.l  ($1A,A0),($1A,A1)
            move.l  A3,-(SP)
            clr.l   -(SP)
            moveq   #6,D0
            jsr     ([$1A74.w])
            pea     (-$5A,A6)
            moveq   #$D,D0
            _PaletteDispatch
            pea     (-$62,A6)
            moveq   #$E,D0
            _PaletteDispatch
            move.l  A4,-(SP)
            clr.l   -(SP)
            moveq   #6,D0
            jsr     ([$1A74.w])
            pea     (-$5A,A6)
            moveq   #$F,D0
            _PaletteDispatch
            pea     (-$62,A6)
            moveq   #$10,D0
            _PaletteDispatch
            tst.b   (-$1D,A6)
            bne.w   .L56
            move.l  (8,A6),D0
            beq.w   .L56
            clr.b   -(SP)
            move.l  (2,A3),-(SP)
            moveq   #1,D0
            jsr     ([$1A74.w])
            move.b  (SP)+,D0
            clr.b   -(SP)
            movea.l (-4,A6),A0
            move.l  (2,A0),-(SP)
            moveq   #1,D0
            jsr     ([$1A74.w])
            move.b  (SP)+,D0
            beq.w   .L66
            move.l  (-4,A6),-(SP)
            clr.l   -(SP)
            moveq   #6,D0
            jsr     ([$1A74.w])
            clr.l   -(SP)
            jsr     ([$1160.w])
            move.l  (SP),(-$66,A6)
            jsr     ([$FE8.w])
            movea.l (-4,A6),A0
            pea     ($10,A0)
            jsr     ([$FEC.w])
            move.l  ([2.w,A3]),-(SP)
            movea.l (-4,A6),A1
            move.l  ([2.w,A1]),-(SP)
            lea     ($10,A3),A0
            lea     ($10,A1),A1
            move.l  (8,A6),D0
            btst    #$1D,D0
            bne.b   .L55
            move.l  (A0),(-$C,A6)
            move.l  (A1),(-$14,A6)
            move.w  (4,A0),D0
            sub.w   (A0),D0
            move.w  (4,A1),D1
            sub.w   (A1),D1
            cmp.w   D0,D1
            blt.b   .L53
            move.w  D0,D1
.L53:
            move.w  (A0),D0
            add.w   D1,D0
            move.w  D0,(-8,A6)
            move.w  (A1),D0
            add.w   D1,D0
            move.w  D0,(-$10,A6)
            move.w  (6,A0),D0
            sub.w   (2,A0),D0
            move.w  (6,A1),D1
            sub.w   (2,A1),D1
            cmp.w   D0,D1
            blt.b   .L54
            move.w  D0,D1
.L54:
            move.w  (2,A0),D0
            add.w   D1,D0
            move.w  D0,(-6,A6)
            move.w  (2,A1),D0
            add.w   D1,D0
            move.w  D0,(-$E,A6)
            lea     (-$C,A6),A0
            lea     (-$14,A6),A1
.L55:
            move.l  A0,-(SP)
            move.l  A1,-(SP)
            move.w  (-$20,A6),-(SP)
            clr.l   -(SP)
            jsr     ([$11B0.w])
            move.l  (-$66,A6),-(SP)
            jsr     ([$FE4.w])
            move.l  (-$66,A6),-(SP)
            jsr     ([$1164.w])
            movea.l (-4,A6),A0
            move.l  (2,A0),-(SP)
            moveq   #2,D0
            jsr     ([$1A74.w])
.L56:
            move.l  A3,-(SP)
            moveq   #4,D0
            jsr     ([$1A74.w])
.L57:
            movea.l (-4,A6),A3
.L58:
            move.l  (2,A3),-(SP)
            move.l  (-$1C,A6),-(SP)
            moveq   #$E,D0
            jsr     ([$1A74.w])
            movea.l ($1A,A6),A0
            movea.l (A0),A0
            cmpa.l  (-$24,A6),A0
            bne.b   .L59
            move.l  A3,(-$24,A6)
.L59:
            movea.l ([8.w,A0]),A0
            movea.l ($1A,A0),A0
            cmpa.l  (-$28,A6),A0
            bne.b   .L60
            movea.l ([8.w,A3]),A0
            move.l  ($1A,A0),(-$28,A6)
.L60:
            move.l  (-$24,A6),-(SP)
            move.l  (-$28,A6),-(SP)
            moveq   #6,D0
            jsr     ([$1A74.w])
            movea.l ($1A,A6),A0
            move.l  A3,(A0)
.L61:
            clr.w   QDErr
            move.l  ($1E,A6),D0
            bpl.b   .L62
            move.w  D0,QDErr
.L62:
            movea.l (-$40,A6),SP
            movem.l (SP)+,D5-D7/A2-A4
            unlk    A6
            rtd     #$16
.L63:
            ext.l   D0
            move.l  D0,($1E,A6)
            bra.b   .L58
.L64:
            move.l  #$FFFFFF63,($1E,A6)
            bra.b   .L61
.L65:
            move.w  QDErr,D0
            bne.b   .L63
            move.w  MemErr,D0
            bne.b   .L63
            clr.w   -(SP)
            jsr     ([$14BC.w])
            move.w  (SP)+,D0
            bra.w   .L58
.L66:
            move.l  #$FFFFFF68,($1E,A6)
            bra.w   .L58
.L67:
            move.l  #$FFFFFFCE,($1E,A6)
            bra.b   .L61
.L68:
            ext.l   D0
            move.l  D0,($1E,A6)
            movea.l (-$48,A6),A0
            _DisposHandle
            movea.l (-$4C,A6),A0
            _DisposHandle
            bra.w   .L58
.L69:
            move.l  (-$52,A6),D1
            beq.b   .L63
            move.w  D0,D7
            move.l  D1,D0
            movea.l ([8.w,A3]),A0
            tst.b   ($1F,A0)
            beq.b   .L70
            jsr     ([$1AB4.w])
            tst.l   D0
            bne.b   .L71
            move.w  D7,D0
            bra.b   .L63
.L70:
            _NewHandle
            bne.b   .L63
.L71:
            movea.l ([2.w,A3]),A1
            move.l  A0,(A1)
            move.w  D7,D0
            bra.w   .L63
QDDONE:
            move.b  #1,(8,SP)
            rtd     #4
            ds.b    6
LOCKPIXELS:
            move.b  #1,(8,SP)
            movea.l ([4.w,SP]),A1
            move.w  ($E,A1),D0
            cmpi.w  #2,D0
            bne.b   .L2
            movea.l (A1),A0
            move.l  (A0),D0
            jsr     ([$644.w])
            tst.l   D0
            bne.b   .L1
            clr.b   (8,SP)
            bra.b   .L2
.L1:
            move.l  D0,(A1)
            move.w  #1,($E,A1)
            _HLock
.L2:
            rtd     #4
            ds.b    8
UNLOCKPIXELS:
            movea.l ([4.w,SP]),A1
            move.w  ($E,A1),D0
            cmpi.w  #1,D0
            bne.b   .L1
            movea.l (A1),A0
            _RecoverHandle
            _HUnlock
            movea.l ([4.w,SP]),A1
            move.l  A0,(A1)
            move.w  #2,($E,A1)
.L1:
            rtd     #4
            ds.b    8
PORTCHANGED:
            dc.w    $4E74,$0004
            ds.b    12
PIXPATCHANGED:
            movea.l (4,SP),A0
            movea.l (A0),A0
            move.w  #$FFFF,($E,A0)
            rtd     #4
CTABCHANGED:
            clr.l   -(SP)
            jsr     ([$16A0.w])
            move.l  (SP)+,D0
            movea.l ([4.w,SP]),A0
            move.l  D0,(A0)
            rtd     #4
            ds.b    10
GDEVICECHANGED:
            dc.w    $4E74,$0004
            ds.b    12
ALLOWPURGEPIXELS:
            movea.l ([4.w,SP]),A1
            movea.l (A1),A0
            move.w  ($E,A1),D0
            cmpi.w  #2,D0
            beq.b   .L1
            cmpi.w  #1,D0
            bne.b   .L2
            _RecoverHandle
.L1:
            _HPurge
.L2:
            rtd     #4
NOPURGEPIXELS:
            movea.l ([4.w,SP]),A1
            movea.l (A1),A0
            move.w  ($E,A1),D0
            cmpi.w  #2,D0
            beq.b   .L1
            cmpi.w  #1,D0
            bne.b   .L2
            _RecoverHandle
.L1:
            _HNoPurge
.L2:
            rtd     #4
GETPIXELSSTATE:
            clr.l   (8,SP)
            movea.l ([4.w,SP]),A1
            movea.l (A1),A0
            move.w  ($E,A1),D0
            cmpi.w  #2,D0
            beq.b   .L1
            cmpi.w  #1,D0
            bne.b   .L2
            _RecoverHandle
.L1:
            _HGetState
            move.l  D0,(8,SP)
.L2:
            rtd     #4
            ds.b    8
SETPIXELSSTATE:
            move.l  (4,SP),D0
            btst    #6,D0
            bne.b   .L1
            move.l  (8,SP),-(SP)
            moveq   #$C,D0
            jsr     ([$1A74.w])
            bra.w   .L2
.L1:
            move.l  (8,SP),-(SP)
            moveq   #$B,D0
            jsr     ([$1A74.w])
.L2:
            move.l  (4,SP),D0
            btst    #7,D0
            bne.b   .L3
            move.l  (8,SP),-(SP)
            moveq   #2,D0
            jsr     ([$1A74.w])
            bra.b   .L4
.L3:
            movea.l (8,SP),A0
            clr.b   -(SP)
            move.l  A0,-(SP)
            moveq   #1,D0
            jsr     ([$1A74.w])
            move.b  (SP)+,D0
.L4:
            rtd     #8
            ds.b    12
GETPIXBASEADDR:
            movea.l ([4.w,SP]),A1
            movea.l (A1),A0
            move.l  A0,(8,SP)
            move.w  ($E,A1),D0
            beq.b   .L3
            btst    #1,D0
            beq.b   .L2
            move.l  (A0),D0
.L1:
            jsr     ([$644.w])
            move.l  D0,(8,SP)
.L2:
            rtd     #4
.L3:
            move.l  A0,D0
            movea.l DeviceList,A1
.L4:
            movea.l (A1),A0
            movea.l ($16,A0),A0
            movea.l (A0),A0
            cmp.l   (A0),D0
            beq.b   .L2
            movea.l (A1),A0
            move.l  ($1E,A0),D1
            movea.l D1,A1
            bne.b   .L4
            bra.b   .L1
            ds.b    10
NEWSCREENBUFFER:
            clr.b   D0
            bra.b   NewTempScreenBuffer.L1
NewTempScreenBuffer:
            move.b  #1,D0
.L1:
            link.w  A6,#-$2A
            movem.l D3-D7/A2-A4,-(SP)
            move.b  D0,(-$2A,A6)
            clr.w   ($16,A6)
            clr.l   (-8,A6)
            clr.l   (-$C,A6)
            clr.b   -(SP)
            move.l  ($12,A6),-(SP)
            jsr     ([$10B8.w])
            move.b  (SP)+,D0
            bne.w   .L10
            clr.l   -(SP)
            move.l  ($12,A6),-(SP)
            jsr     ([$169C.w])
            movea.l (SP)+,A0
            move.l  A0,(-$10,A6)
            movea.l (A0),A0
            movea.l ($12,A6),A1
            move.w  (2,A1),D0
            sub.w   ($24,A0),D0
            move.w  D0,(-$18,A6)
            move.w  (6,A1),D0
            sub.w   (2,A1),D0
            move.w  D0,(-$22,A6)
            move.w  (4,A1),D0
            sub.w   (A1),D0
            move.w  D0,(-$24,A6)
            clr.l   (-$28,A6)
            movea.l ([-$10.w,A6]),A0
            movea.l ([$16.w,A0]),A1
            move.w  ($20,A1),D7
            lea     SHIFTTABLE,A0
            moveq   #0,D0
            move.b  (0,A0,D7.w),D0
            bmi.w   .L9
            move.w  D0,(-2,A6)
            move.w  (-$28,A6),(-$20,A6)
            move.w  (-$18,A6),D1
            lsl.w   D0,D1
            andi.w  #$1F,D1
            lsr.w   D0,D1
            move.w  (-$26,A6),D0
            sub.w   D1,D0
            move.w  D0,(-$1E,A6)
            move.l  (-$24,A6),(-$1C,A6)
            move.w  (-$22,A6),D0
            sub.w   (-$26,A6),D0
            ext.l   D0
            move.w  (-2,A6),D1
            lsl.l   D1,D0
            addi.l  #$1E,D0
            lsr.l   #5,D0
            addq.w  #1,D0
            lsl.l   #2,D0
            move.w  D0,(-4,A6)
            move.w  (-$24,A6),D1
            sub.w   (-$28,A6),D1
            mulu.w  D1,D0
            tst.b   (-$2A,A6)
            beq.b   .L2
            jsr     ([$1AB4.w])
            tst.l   D0
            bne.b   .L3
            move.w  #$FF69,D0
            bra.w   .L11
.L2:
            _NewHandle
            bne.w   .L11
.L3:
            move.l  A0,(-8,A6)
            _MoveHHi
            tst.b   ($10,A6)
            beq.b   .L4
            _HPurge
.L4:
            moveq   #$32,D0
            _NewHandleClear
            bne.w   .L11
            move.l  A0,(-$C,A6)
            movea.l (A0),A1
            move.l  (-8,A6),(A1)
            move.w  (-4,A6),D0
            ori.w   #$8000,D0
            move.w  D0,(4,A1)
            move.l  (-$20,A6),(6,A1)
            move.l  (-$1C,A6),($A,A1)
            move.w  #2,($E,A1)
            move.w  #$48,($16,A1)
            move.w  #$48,($1A,A1)
            move.w  D7,($20,A1)
            cmpi.w  #$10,D7
            blt.b   .L6
            move.w  #$10,($1E,A1)
            move.w  #3,($22,A1)
            moveq   #8,D0
            cmpi.w  #$20,D7
            beq.b   .L5
            moveq   #5,D0
.L5:
            move.w  D0,($24,A1)
            bra.b   .L7
.L6:
            clr.w   ($1E,A1)
            move.w  #1,($22,A1)
            move.w  D7,($24,A1)
.L7:
            movea.l ([-$10.w,A6]),A0
            movea.l ([$16.w,A0]),A0
            move.l  ($2A,A0),($2A,A1)
            movea.l (8,A6),A0
            move.l  (-$C,A6),(A0)
            movea.l ($C,A6),A0
            move.l  (-$10,A6),(A0)
.L8:
            move.w  ($16,A6),D0
            ext.l   D0
            move.w  D0,QDErr
            movem.l (SP)+,D3-D7/A2-A4
            unlk    A6
            rtd     #$E
.L9:
            move.w  #$FF63,($16,A6)
            bra.b   .L12
.L10:
            move.w  #$FFCE,($16,A6)
            bra.b   .L12
.L11:
            move.w  D0,($16,A6)
            bra.b   .L12
            move.w  QDErr,($16,A6)
            nop
.L12:
            move.l  (-8,A6),D0
            _DisposHandle
            move.l  (-$C,A6),D0
            _DisposHandle
            bra.b   .L8
            ds.b    4
DISPOSESCREENBUFFER:
            movea.l ([4.w,SP]),A1
            movea.l (A1),A0
            move.w  ($E,A1),D0
            cmpi.w  #2,D0
            beq.b   .L1
            cmpi.w  #1,D0
            bne.b   .L2
            _RecoverHandle
.L1:
            _DisposHandle
            movea.l (4,SP),A0
            _DisposHandle
.L2:
            rtd     #4
            ds.b    10
OFFSCREENVERSION:
            move.l  #$101,(4,SP)
            rts
            ds.b    6
QDEXTEND:

            EVEN
