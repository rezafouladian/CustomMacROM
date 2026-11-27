            include "Include/ROMHeader.s"

            EXPORT  DispTable

            IMPORT  __NMINSTALL,__NMREMOVE,ACTIVATEPALETTE,ADBOp,ADBReInit,AddComp
            IMPORT  AddDrive,AddPt,AddReference,AddResMenu,AddResource,AddSearch
            IMPORT  Alert,AllocCursor,ALLOCRUNBUF,AngleFromSlope,AnimateEntry,AnimatePalette
            IMPORT  AppendMenu,AttachVBL,BackColor,BackPat,BackPixPat,bAddOver
            IMPORT  bAddPin,BARITH16SETUP,bArith16Tab,BARITH32SETUP,bArith32Tab,BaseOfROM
            IMPORT  bAvg,bcEnd0,bcEnd1,bcEnd3,bcMain0,bcMain1
            IMPORT  bcMain3,BeginUpdate,bEND0,bEND1,bEND10,bEND11
            IMPORT  bEND2,bEND3,bEND9,bHilite,bHiliteTab,BitAnd
            IMPORT  BITBLT,BitClr,BITMAPRGN,BitNot,BitOr,BitsDevLoop
            IMPORT  BitSet,BitShift,BitsToMap,BitsToPix,BitTst,BitXOr
            IMPORT  bLeft0,BLITCASE,BlockMove68020,bLONG8,bMAIN0,bMAIN1
            IMPORT  bMAIN11,bMAIN2,bMAIN3,bMAIN9,bMax,bMin
            IMPORT  BringToFront,bSetup0,bSETUP10,bSETUP8,bSloHilite,bSubOver
            IMPORT  bSubPin,bTransparent,Button,bXEND10,bXEND11,bXEND9
            IMPORT  bXLONG8,bXMAIN10,bXMAIN11,bXMAIN8,bXMAIN9,CacheTrap
            IMPORT  CALCCMASK,CalcMask,CalcMenuSize,CalcVis,CALCVISBEHIND,CautionAlert
            IMPORT  Chain,ChangedResource,CharExtra,CharWidth,CheckItem,CheckPic
            IMPORT  CheckUpdate,ClearMenuBar,ClipAbove,ClipRect,ClkNoMem,Close
            IMPORT  CloseCPort,CloseDeskAcc,CloseDialog,ClosePicture,ClosePoly,CloseResFile
            IMPORT  CloseRgn,CloseWindow,CmpString,Color2Index,ColorBit,ColorMap
            IMPORT  COLORTHING2INDEX,CompactMem,Control,CopyBits,CopyHandle,CopyMask
            IMPORT  CopyPalette,CopyPixMap,CopyPixPat,CopyRgn,CouldAlert,CouldDialog
            IMPORT  Count1Resources,Count1Types,CountMItems,CountResources,CountTypes,CreateResFile
            IMPORT  CTab2Palette,CullPoints,CurResFile,Date2Secs,DebugUtil,Delay
            IMPORT  DelComp,DeleteMenu,DelMCEntries,DelMenuItem,DelSearch,DeltaPoint
            IMPORT  DequeueTrap,DeskMgr,DetachResource,DialogSelect,DiffRgn,DisableItem
            IMPORT  DispMCInfo,DisposCCursor,DisposCIcon,DisposCTable,DisposDialog,DisposeControl
            IMPORT  DisposeMenu,DisposePalette,DisposePtr,DisposeRgn,DisposeTempBuffer,DisposeWindow
            IMPORT  DisposGDevice,DisposPixMap,DoEject,DoLine,DoVBLTask,DPutPicByte
            IMPORT  DPutPicOp,DragControl,DragGrayRgn,DragTheRgn,DragWindow,DrawArc
            IMPORT  DrawChar,DrawControls,DrawDialog,DrawGrowIcon,DrawLine,DrawMenuBar
            IMPORT  DrawNew,DrawOneControl,DrawPicture,DrawSlab,DrawString,DrawText2
            IMPORT  DrvrInstall,DrvrRemove,DsposeHandle,DTCore,EgretDispatch,Eject_2
            IMPORT  EmptyHandle,EmptyRect,EmptyRgn,EnableItem,EndUpdate,EqualPt
            IMPORT  EqualRect,EqualRgn,EraseArc,EraseOval,ErasePoly,EraseRect
            IMPORT  EraseRgn,EraseRoundRect,ErrorSound,EventAvail,Events,ExitToShell
            IMPORT  EXTBL,FASTLINE,FASTSLABMODE,FASTSLANT,FileAlloc,FileCreate
            IMPORT  FileDelete,FillArc,FillCArc,FillCOval,FillCPoly,FillCRect
            IMPORT  FillCRgn,FillCRoundRect,FillOval,FillPoly,FillRect,FillRgn
            IMPORT  FillRoundRect,FindControl,FindDItem,FindWindow,FInitQueue,Fix2Frac
            IMPORT  Fix2Long,Fix2X,FixATan2,FixDiv,FixMul,FixRatio
            IMPORT  FixRound,FlashMenuBar,FlushEvents,FlushFile,FlushVol,FMSwapFont
            IMPORT  FontManager,FontMetrics,ForeColor,Frac2Fix,Frac2X,FracCos
            IMPORT  FracDiv,FracMul,FracSin,FracSqrt,FrameArc,FrameOval
            IMPORT  FramePoly,FrameRect,FrameRgn,FrameRoundRect,FreeAlert,FreeDialog
            IMPORT  FreeMem,FrontWindow,GestaltTrap_,Get1IndResource,Get1IndType,Get1NamedResource
            IMPORT  Get1Resource,GetADBInfo,GetAppParms,GetAuxCtl,GetAuxWin,GetBackColor
            IMPORT  GETCCURSOR,GetCIcon,GetClip,GetCPixel,GetCRefCon,GETCTABLE
            IMPORT  GetCTitle,GetCtlAction,GetCtlMax,GetCtlMin,GetCtlValue,GETCTSEED
            IMPORT  GetCursor,GetCVariant,GetCWMgrPort,GetDefaultStartup,GetDeviceList,GetDItem
            IMPORT  GetEntryColor,GetEntryUsage,GetEOF,GetFileInfo,GetFNum,GetFontInfo
            IMPORT  GetFontName,GetForeColor,GetFPos,GetGDevice,GetHandleSize,GetIcon
            IMPORT  GetIndADB,GetIndResource,GetIndType,GetItem,GETITEMCMD,GetItemIcon
            IMPORT  GetItemMark,GetItemStyle,GetIText,GetKeys,GetMainDevice,GetMaskTab
            IMPORT  GetMaxDevice,GetMCEntry,GetMCInfo,GetMenu,GetMenuBar,GetMHandle
            IMPORT  GetMouse,GetNamedResource,GetNewControl,GetNewCWindow,GetNewDialog,GetNewMBar
            IMPORT  GetNewPalette,GetNewWindow,GetNextDevice,GetNextEvent,GetOSDefault,GetOSEvent
            IMPORT  GetPalette,GetPattern,GetPen,GetPenState,GetPicture,GetPixel
            IMPORT  GETPIXPAT,GetPort,GetPtrSize,GetResAttrs,GetResFileAttrs,GetResInfo
            IMPORT  GetResource,GetScrap,GetSeek,GetString,GetSubTable,GetTrapAddress
            IMPORT  GetVideoDefault,GetVol,GetVolInfo,GetWindowPic,GetWMgrPort,GetWRefCon
            IMPORT  GetWTitle,GetWVariant,GetZone,GlobalToLocal,GoToSleep,GrafDevice
            IMPORT  GrowWindow,GSEXPTBL,GSRUNTBL,gsSeekTbl,HandAndHand,HandleZone
            IMPORT  HandToHand,HGetFlags,HideControl,HideCursor,HideDItem,HidePen
            IMPORT  HideWindow,HiliteColor,HiliteControl,HiliteMenu,HiliteWindow,HiWord
            IMPORT  HLock,HNoPurge,HNoRSRC,HomeResFile,HPurge,HRSRC
            IMPORT  HSetFlags,HUnlock,HWPRIV,Index2Color,InfoScrap,InitAllPacks
            IMPORT  InitApplZone,InitCPort,InitCursor,InitDialogs,InitEvents,InitFS
            IMPORT  InitGDevice,InitGraf,InitMenus,InitPalettes,InitPort,InitProcMenu
            IMPORT  InitResources,InitRgn,InitUtil,InitWindows,InitZone,InsertMenu
            IMPORT  InsetRect,InsetRgn,InsMenuItem,InsrtResMenu,InstallRDrivers,InsTime
            IMPORT  InternalWait,InvalRect,InvalRgn,InvertArc,InvertColor,InvertOval
            IMPORT  InvertPoly,InvertRect,InvertRgn,InvertRoundRect,IOPMGR,IOPMOVEDATA
            IMPORT  IOPMsgRequest,IsDialogEvent,ITabMatch,JACKSONPOLLOCK,KBDMngr,KeyTrans
            IMPORT  KillControls,KillIO,KillPicture,KillPoly,Launch,Line
            IMPORT  LineTo,Loader,LoadResource,LoadScrap,LocalToGlobal,Long2Fix
            IMPORT  LongMul,LoWord,LWRSTRING,MAKEGRAYITAB,MakeITable,MAKERGBPAT
            IMPORT  MAKESCALETBL,MapPoly,MapPt,MapRect,MapRgn,MaxApplZone
            IMPORT  MaxBlock,MaxMem,MaxSizeRsrc,MeasureText,MEMORYDISPATCH,MenuChoice
            IMPORT  MenuKey,MenuSelect,MethodDispatch,ModalDialog,MoreMasters,MountVol
            IMPORT  Move_,MoveControl,MoveHHi,MovePortTo,MoveTo,MoveWindow
            IMPORT  Munger,NewCDialog,NewControl,NewCWindow,NewDialog,NewEmptyHandle
            IMPORT  NewGDevice,NewMenu,NewPalette,NewPixMap,NewPixPat,NewPtr
            IMPORT  NewRgn,NewString,NewTempBuffer,NEWTEMPHANDLE,NewWindow,NoteAlert
            IMPORT  NwHandle,ObscureCursor,Offline,OffsetPoly,OffsetRect,OffsetRgn
            IMPORT  OLDPATTONEW,OPCOLOR,Open,OpenCPicture,OpenCPort,OpenDeskAcc
            IMPORT  OpenPicture,OpenPoly,OpenPort,OpenResFile,OpenRF,OpenRFPerm
            IMPORT  OpenRgn,OSEventAvail,Pack0,Pack1,Pack10,Pack11
            IMPORT  Pack12,Pack13,Pack14,Pack15,Pack2,Pack3
            IMPORT  Pack4,Pack5,Pack6,Pack7,Pack8,Pack9
            IMPORT  PackBits,PackDispatcher,PackRgn,PaintArc,PaintBehind,PaintOne
            IMPORT  PaintOval,PaintPoly,PaintRect,PaintRgn,PaintRoundRect,Palette2CTab
            IMPORT  ParamText,PATCONVERT,PATDITHER,PATEXPAND,PATEXTBL,PenMode
            IMPORT  PenNormal,PenPat,PenPixPat,PenSize,PicComment,PicItem1
            IMPORT  PINIT,PinRect,PlotCIcon,PlotIcon,PmBackColor,PmForeColor
            IMPORT  PMgrDispatch,PmgrOp,PopUpMenuSelect,PortSize,PortToMap,PowerDispatch
            IMPORT  PowerOff,PrGlue,PrimeTime,ProtectEntry,Pt2Rect,PtInRect
            IMPORT  PtInRgn,PtrAndHand,PtrToHand,PtrToXHand,PtrZone,PtToAngle
            IMPORT  PurgeMem,PurgeSpace,PUSHVERB,PutIcon,PutLine,PutOval
            IMPORT  PutRgn,PutScrap,QDError,QDEXTDISPATCHER,QStuff,rAddOver
            IMPORT  rAddPin,Random,RARITH16TAB,RARITH32TAB,rAvg,rcMask0
            IMPORT  rcMask1,rcMask3,Read,ReadDateTime,ReadParam,ReadXPRam
            IMPORT  RealColor,RealFont,ReAllocHandle,RecoverHandle,RectInRgn,RectRgn
            IMPORT  ReleaseResource,RelStringTrap,ReName,ResError,ReserveEntry,ResrvMem
            IMPORT  RestoreEntries,RGBBackColor,RGBForeColor,RGETRESOURCE,RgnBlt,RgnOp
            IMPORT  rHilite,RHILITETAB,rMASK0,rMASK1,rMASK10,rMASK11
            IMPORT  rMASK2,rMASK3,rMASK8,rMASK9,rMax,rMin
            IMPORT  RmveReference,RmveResource,RSECT,rslowHilite,RSRCMAPENTRY,RsrcZoneInit
            IMPORT  RstFilLock,rSubOver,rSubPin,rTransparent,rXMASK10,rXMASK11
            IMPORT  rXMASK8,rXMASK9,SaveEntries,SaveOld,SCALEBLT,SCALEINDEXEDTOINDEXED
            IMPORT  ScalePt,SCDIRTAB1,SCDIRTAB16,SCDIRTAB2,SCDIRTAB32,SCDIRTAB4
            IMPORT  SCDIRTAB8,SCINDTAB1,SCINDTAB16,SCINDTAB2,SCINDTAB32,SCINDTAB4
            IMPORT  SCINDTAB8,ScrnBitMap,ScrollRect,SCSIMgr,SectRect,SectRgn
            IMPORT  SEEDCFILL,SeedFill,SeekRgn,SelectWindow,SelIText,SendBehind
            IMPORT  SetADBInfo,SetApplBase,SetApplLimit,SetCCursor,SetClientID,SetClip
            IMPORT  SetCPixel,SETCPORTPIX,SetCRefCon,SetCTitle,SetCtlAction,SetCtlColor
            IMPORT  SetCtlMax,SetCtlMin,SetCtlValue,SetCursor,SetDateTimeTrap,SetDefaultStartup
            IMPORT  SetDeskCPat,SetDeviceAttribute,SetDItem,SetEmptyRgn,SetEntries,SetEntryColor
            IMPORT  SetEntryUsage,SetEOF,SetFileInfo,SetFilLock,SetFillPat,SetFilType
            IMPORT  SetFontLock,SetFPos,SetFractEnable,SetFScaleDisable,SetGDevice,SetGrowZone
            IMPORT  SetHandleSize,SetItem,SETITEMCMD,SetItemIcon,SetItemMark,SetItemStyle
            IMPORT  SetIText,SetMCEntries,SetMCInfo,SetMenuBar,SetMenuFlash,SetOrigin
            IMPORT  SetOSDefault,SetPalette,SetPenState,SetPort,SetPortBits,SetPt
            IMPORT  SetPtrSize,SetRect,SetRectRgn,SetResAttrs,SetResFileAttrs,SetResInfo
            IMPORT  SetResLoad,SetResPurge,SetStdCProcs,SetStdProcs,SetString,SetTrapAddress
            IMPORT  SETUPSTRETCH,SetVideoDefault,SetVol,SetWinColor,SetWindowPic,SetWRefCon
            IMPORT  SetWTitle,SetZone,SexyDate,ShieldCursor,ShowControl,ShowCursor
            IMPORT  ShowDItem,ShowHide,ShowPen,ShowWindow,ShutDownDisp,SIntInstall
            IMPORT  SIntRemove,SizeControl,SizeResource,SizeWindow,SLABMODE,SLADDOVER
            IMPORT  SLADDPIN,SLARITH16TAB,SLARITH32TAB,SLAVG,SLHILITE,SLMASK10
            IMPORT  SLMASK11,SLMASK8,SLMASK9,SLMAX,SLMIN,SlopeFromAngle
            IMPORT  SlotManager,SlotVInstall,SlotVRemove,SLSUBOVER,SLSUBPIN,SLTRANSPARENT
            IMPORT  SLXMASK10,SLXMASK11,SLXMASK8,SLXMASK9,SndAddModifier,SndAppDead
            IMPORT  SndControl,SndDisposeChannel,SndDoCommand,SndDoImmediate,SndNewChannel,SndPlay
            IMPORT  SortPoints,SpaceExtra,StackSpace,stAddOver,stAddPin,STARITH16TAB
            IMPORT  STARITH32TAB,Status,stAvg,STCOLORTAB,StdArc,StdBits
            IMPORT  StdComment,STDDEVLOOP,StdGetPic,StdLine,StdOpcodeProc,StdOval
            IMPORT  StdPoly,StdPutPic,StdRect,StdRgn,StdRRect,StdText
            IMPORT  StdTxMeas,STGRAYTAB,stHilite,StillDown,stMASK0,stMASK1
            IMPORT  stMASK2,stMASK3,stMax,stMin,STNOSTACK,StopAlert
            IMPORT  StretchBits,StringWidth,StripAddress,STSCANLOOP,STSEARCHTAB,stSubOver
            IMPORT  stSubPin,stTransparent,StuffHex,SubPt,SYSENVIRONS,SystemBeep
            IMPORT  SystemClick,SystemEdit,SystemError,SystemMenu,SystemTask,SYSUTIL
            IMPORT  TEActivate,TEAutoView,TECalText,TEClick,TECopy,TECut
            IMPORT  TEDeactivate,TEDelete,TEDispatch,TEDispose,TEGetOffset,TEGetText
            IMPORT  TEIdle,TEInit,TEInsert,TEKey,TENew,TEPaste
            IMPORT  TEPinScroll,TEScroll,TESelView,TESetJust,TESetSelect,TESetText
            IMPORT  TestControl,TestDeviceAttribute,TESTYLNEW,TEUpdate,TextBox,TextFace
            IMPORT  TextFont,TextMode,TextSize,TextWidth,TickCount,TimeMgr
            IMPORT  TMProc,TrackBox,TrackControl,TrackGoAway,Translate24To32,TrimRect
            IMPORT  TurboFS,UnionRect,UnionRgn,Unique1ID,UniqueID,UnloadScrap
            IMPORT  UnloadSeg,UnmountVol,UnpackBits,UpdatePixMap,UpdateResFile,UpdtControls
            IMPORT  UpdtDialog,uprstring,UseResFile,vAdjEOF,ValidRect,ValidRgn
            IMPORT  vAllocNode,VBASICIO,VBLCore,vBlkAlloc,VBLKDEALLOC,vBMChk
            IMPORT  vBTClose,vBTDelete,VBTFLUSH,vBTGetRecord,VBTINSERT,VBTOPEN
            IMPORT  vBTSearch,vBTUpdate,vCacheFlush,vCacheRdIP,vCacheWrIP,vChar2Pixel
            IMPORT  vCheckLoad,vCheckRemount,vCkExtFS,vCmpFrm,vCMSetUp,vDeAllocFile
            IMPORT  vDisptch,vDtrmV1,vDtrmV2,vDtrmV3,vExtBTFile,vExtendFile
            IMPORT  vFClose,vFileClose,vFileOpen,vFileRead,vFileWrite,vFindDrive
            IMPORT  vFlushCache,vFlushMDB,vFndFilName,vFreeNode,vGetBlock,vGetNode
            IMPORT  vGoDriver,vIAZInit,vIAZPostInit,vLaunchInit,VLG2PHYS,VLOCCREC
            IMPORT  vMapFBlock,vMarkBlock,VMTCHECK,vNewMap,vPermssnChk,vPixel2Char
            IMPORT  VRDBLOCKS,vReadBM,vRelBlock,vRelNode,VRemove,vRfNCall
            IMPORT  vRMgrStdEntry,VRMGRSTDEXIT,vSegStack,VSETUPTAGS,vSuperLoad,vSyncWait
            IMPORT  vTrashBlocks,vTrashVBlks,vTreeSearch,vTruncateFile,vTstMod,VUPDALTMDB
            IMPORT  vWaitUntil,VWRBLOCKS,vXFSearch,WaitMouseUp,WaitNextEvent,Write
            IMPORT  WriteParam,WriteResource,WriteXPRam,X2Fix,X2Frac,XFINDLINE
            IMPORT  XFINDWORD,XMunger,XorRgn,XorSlab,XSCRIPTUTIL,XTrimMeasure
            IMPORT  ZeroScrap,ZoomWindow

            SECTION "DispTable",CODE

DispTable:
            DispBad                                 ; $A800 _SoundDispatch
            DispAbs SndDisposeChannel               ; $A801 _SndDisposeChannel
            DispFar SndAddModifier,SndDisposeChannel ; $A802 _SndAddModifier
            DispFar SndDoCommand,SndAddModifier     ; $A803 _SndDoCommand
            DispNear SndDoImmediate,SndDoCommand    ; $A804 _SndDoImmediate
            DispFar SndPlay,SndDoImmediate          ; $A805 _SndPlay
            DispFar SndControl,SndPlay              ; $A806 _SndControl
            DispFar SndNewChannel,SndControl        ; $A807 _SndNewChannel
            DispAbs InitProcMenu                    ; $A808 _InitProcMenu
            DispFar GetCVariant,InitProcMenu        ; $A809 _GetCVariant
            DispFar GetWVariant,GetCVariant         ; $A80A _GetWVariant
            DispFar PopUpMenuSelect,GetWVariant     ; $A80B _PopUpMenuSelect
            DispFar RGETRESOURCE,PopUpMenuSelect    ; $A80C _RGetResource
            DispFar Count1Resources,RGETRESOURCE    ; $A80D _Count1Resources
            DispNear Get1IndResource,Count1Resources ; $A80E _Get1IxResource
            DispNear Get1IndType,Get1IndResource    ; $A80F _Get1IxType
            DispNear Unique1ID,Get1IndType          ; $A810 _Unique1ID
            DispAbs TESelView                       ; $A811 _TESelView
            DispFar TEPinScroll,TESelView           ; $A812 _TEPinScroll
            DispFar TEAutoView,TEPinScroll          ; $A813 _TEAutoView
            DispFar SetFractEnable,TEAutoView       ; $A814 _SetFractEnable
            DispAbs SCSIMgr                         ; $A815 _SCSIDispatch
            DispAbs Pack8                           ; $A816 _Pack8
            DispAbs CopyMask                        ; $A817 _CopyMask
            DispAbs FixATan2                        ; $A818 _FixATan2
            DispFar XMunger,FixATan2                ; $A819 _XMunger
            DispBad                                 ; $A81A _HOpenResFile
            DispBad                                 ; $A81B _HCreateResFile
            DispFar Count1Types,XMunger             ; $A81C _Count1Types
            DispBad                                 ; $A81D _InvalMenuBar
            DispBad                                 ; $A81E
            DispNear Get1Resource,Count1Types       ; $A81F _Get1Resource
            DispNear Get1NamedResource,Get1Resource ; $A820 _Get1NamedResource
            DispFar MaxSizeRsrc,Get1NamedResource   ; $A821 _MaxSizeRsrc
            DispBad                                 ; $A822 _ResourceDispatch
            DispBad                                 ; $A823 _AliasDispatch
            DispBad                                 ; $A824
            DispBad                                 ; $A825
            DispFar InsMenuItem,MaxSizeRsrc         ; $A826 _InsMenuItem
            DispFar HideDItem,InsMenuItem           ; $A827 _HideDItem
            DispNear ShowDItem,HideDItem            ; $A828 _ShowDItem
            DispBad                                 ; $A829 _LayerDispatch
            DispBad                                 ; $A82A _ComponentDispatch
            DispAbs Pack9                           ; $A82B _Pack9
            DispNear Pack10,Pack9                   ; $A82C _Pack10
            DispNear Pack11,Pack10                  ; $A82D _Pack11
            DispNear Pack12,Pack11                  ; $A82E _Pack12
            DispNear Pack13,Pack12                  ; $A82F _Pack13
            DispNear Pack14,Pack13                  ; $A830 _Pack14
            DispNear Pack15,Pack14                  ; $A831 _Pack15
            DispBad                                 ; $A832
            DispAbs ScrnBitMap                      ; $A833 _ScrnBitMap
            DispFar SetFScaleDisable,ScrnBitMap     ; $A834 _SetFScaleDisable
            DispNear FontMetrics,SetFScaleDisable   ; $A835 _FontMetrics
            DispFar GetMaskTab,FontMetrics          ; $A836 _GetMaskTable
            DispFar MeasureText,GetMaskTab          ; $A837 _MeasureText
            DispAbs CalcMask                        ; $A838 _CalcMask
            DispFar SeedFill,CalcMask               ; $A839 _SeedFill
            DispAbs ZoomWindow                      ; $A83A _ZoomWindow
            DispNear TrackBox,ZoomWindow            ; $A83B _TrackBox
            DispAbs TEGetOffset                     ; $A83C _TEGetOffset
            DispFar TEDispatch,TEGetOffset          ; $A83D _TEDispatch
            DispFar TESTYLNEW,TEDispatch            ; $A83E _TEStyleNew
            DispFar Long2Fix,TESTYLNEW              ; $A83F _Long2Fix
            DispFar Fix2Long,Long2Fix               ; $A840 _Fix2Long
            DispNear Fix2Frac,Fix2Long              ; $A841 _Fix2Frac
            DispFar Frac2Fix,Fix2Frac               ; $A842 _Frac2Fix
            DispFar Fix2X,Frac2Fix                  ; $A843 _Fix2X
            DispNear X2Fix,Fix2X                    ; $A844 _X2Fix
            DispFar Frac2X,X2Fix                    ; $A845 _Frac2X
            DispNear X2Frac,Frac2X                  ; $A846 _X2Frac
            DispFar FracCos,X2Frac                  ; $A847
            DispNear FracSin,FracCos                ; $A848
            DispFar FracSqrt,FracSin                ; $A849
            DispFar FracMul,FracSqrt                ; $A84A
            DispNear FracDiv,FracMul                ; $A84B
            DispBad                                 ; $A84C _UserDelay
            DispNear FixDiv,FracDiv                 ; $A84D
            DispFar GETITEMCMD,FixDiv               ; $A84E _GetItemCmd
            DispNear SETITEMCMD,GETITEMCMD          ; $A84F _SetItemCmd
            DispAbs InitCursor                      ; $A850 _InitCursor
            DispNear SetCursor,InitCursor           ; $A851 _SetCursor
            DispNear HideCursor,SetCursor           ; $A852 _HideCursor
            DispNear ShowCursor,HideCursor          ; $A853 _ShowCursor
            DispBad                                 ; $A854 _FontDispatch
            DispNear ShieldCursor,ShowCursor        ; $A855 _ShieldCursor
            DispNear ObscureCursor,ShieldCursor     ; $A856 _ObscureCursor
            DispBad                                 ; $A857
            DispFar BitAnd,ObscureCursor            ; $A858 _BitAnd
            DispNear BitXOr,BitAnd                  ; $A859 _BitXOr
            DispFar BitNot,BitXOr                   ; $A85A _BitNot
            DispNear BitOr,BitNot                   ; $A85B _BitOr
            DispNear BitShift,BitOr                 ; $A85C _BitShift
            DispNear BitTst,BitShift                ; $A85D _BitTst
            DispNear BitSet,BitTst                  ; $A85E _BitSet
            DispNear BitClr,BitSet                  ; $A85F _BitClr
            DispAbs WaitNextEvent                   ; $A860 _WaitNextEvent
            DispAbs Random                          ; $A861 _Random
            DispNear ForeColor,Random               ; $A862 _ForeColor
            DispNear BackColor,ForeColor            ; $A863 _BackColor
            DispNear ColorBit,BackColor             ; $A864 _ColorBit
            DispFar GetPixel,ColorBit               ; $A865 _GetPixel
            DispFar StuffHex,GetPixel               ; $A866 _StuffHex
            DispAbs LongMul                         ; $A867 _LongMul
            DispNear FixMul,LongMul                 ; $A868 _FixMul
            DispFar FixRatio,FixMul                 ; $A869 _FixRatio
            DispNear HiWord,FixRatio                ; $A86A _HiWord
            DispFar LoWord,HiWord                   ; $A86B _LoWord
            DispNear FixRound,LoWord                ; $A86C _FixRound
            DispAbs InitPort                        ; $A86D _InitPort
            DispFar InitGraf,InitPort               ; $A86E _InitGraf
            DispFar OpenPort,InitGraf               ; $A86F _OpenPort
            DispFar LocalToGlobal,OpenPort          ; $A870 _LocalToGlobal
            DispNear GlobalToLocal,LocalToGlobal    ; $A871 _GlobalToLocal
            DispNear GrafDevice,GlobalToLocal       ; $A872 _GrafDevice
            DispFar SetPort,GrafDevice              ; $A873 _SetPort
            DispNear GetPort,SetPort                ; $A874 _GetPort
            DispNear SetPortBits,GetPort            ; $A875 _SetPBits
            DispNear PortSize,SetPortBits           ; $A876 _PortSize
            DispNear MovePortTo,PortSize            ; $A877 _MovePortTo
            DispNear SetOrigin,MovePortTo           ; $A878 _SetOrigin
            DispNear SetClip,SetOrigin              ; $A879 _SetClip
            DispNear GetClip,SetClip                ; $A87A _GetClip
            DispFar ClipRect,GetClip                ; $A87B _ClipRect
            DispFar BackPat,ClipRect                ; $A87C _BackPat
            DispFar CloseCPort,BackPat              ; $A87D _CloseCPort
            DispFar AddPt,CloseCPort                ; $A87E _AddPt
            DispNear SubPt,AddPt                    ; $A87F _SubPt
            DispFar SetPt,SubPt                     ; $A880 _SetPt
            DispNear EqualPt,SetPt                  ; $A881 _EqualPt
            DispAbs StdText                         ; $A882 _StdText
            DispFar DrawChar,StdText                ; $A883 _DrawChar
            DispNear DrawString,DrawChar            ; $A884 _DrawString
            DispNear DrawText2,DrawString           ; $A885 _DrawText
            DispNear TextWidth,DrawText2            ; $A886 _TextWidth
            DispFar TextFont,TextWidth              ; $A887 _TextFont
            DispFar TextFace,TextFont               ; $A888 _TextFace
            DispNear TextMode,TextFace              ; $A889 _TextMode
            DispNear TextSize,TextMode              ; $A88A _TextSize
            DispFar GetFontInfo,TextSize            ; $A88B _GetFontInfo
            DispFar StringWidth,GetFontInfo         ; $A88C _StringWidth
            DispFar CharWidth,StringWidth           ; $A88D _CharWidth
            DispNear SpaceExtra,CharWidth           ; $A88E _SpaceExtra
            DispBad                                 ; $A88F _OSDispatch
            DispFar StdLine,SpaceExtra              ; $A890 _StdLine
            DispNear LineTo,StdLine                 ; $A891 _LineTo
            DispNear Line,LineTo                    ; $A892 _Line
            DispNear MoveTo,Line                    ; $A893 _MoveTo
            DispNear Move_,MoveTo                   ; $A894 _Move
            DispAbs ShutDownDisp                    ; $A895 _ShutDown
            DispAbs HidePen                         ; $A896 _HidePen
            DispNear ShowPen,HidePen                ; $A897 _ShowPen
            DispNear GetPenState,ShowPen            ; $A898 _GetPenState
            DispNear SetPenState,GetPenState        ; $A899 _SetPenState
            DispNear GetPen,SetPenState             ; $A89A _GetPen
            DispNear PenSize,GetPen                 ; $A89B _PenSize
            DispNear PenMode,PenSize                ; $A89C _PenMode
            DispNear PenPat,PenMode                 ; $A89D _PenPat
            DispNear PenNormal,PenPat               ; $A89E _PenNormal
            DispBad                                 ; $A89F _DisableDogCow
            DispFar StdRect,PenNormal               ; $A8A0 _StdRect
            DispFar FrameRect,StdRect               ; $A8A1 _FrameRect
            DispNear PaintRect,FrameRect            ; $A8A2 _PaintRect
            DispNear EraseRect,PaintRect            ; $A8A3 _EraseRect
            DispNear InvertRect,EraseRect           ; $A8A4 _InverRect
            DispFar FillRect,InvertRect             ; $A8A5 _FillRect
            DispFar EqualRect,FillRect              ; $A8A6 _EqualRect
            DispFar SetRect,EqualRect               ; $A8A7 _SetRect
            DispNear OffsetRect,SetRect             ; $A8A8 _OffsetRect
            DispNear InsetRect,OffsetRect           ; $A8A9 _InsetRect
            DispNear SectRect,InsetRect             ; $A8AA _SectRect
            DispNear UnionRect,SectRect             ; $A8AB _UnionRect
            DispNear Pt2Rect,UnionRect              ; $A8AC _Pt2Rect
            DispNear PtInRect,Pt2Rect               ; $A8AD _PtInRect
            DispFar EmptyRect,PtInRect              ; $A8AE _EmptyRect
            DispFar StdRRect,EmptyRect              ; $A8AF _StdRRect
            DispNear FrameRoundRect,StdRRect        ; $A8B0 _FrameRoundRect
            DispNear PaintRoundRect,FrameRoundRect  ; $A8B1 _PaintRoundRect
            DispNear EraseRoundRect,PaintRoundRect  ; $A8B2 _EraseRoundRect
            DispNear InvertRoundRect,EraseRoundRect ; $A8B3 _InverRoundRect
            DispNear FillRoundRect,InvertRoundRect  ; $A8B4 _FillRoundRect
            DispAbs XSCRIPTUTIL                     ; $A8B5 _ScriptUtil
            DispAbs StdOval                         ; $A8B6 _StdOval
            DispNear FrameOval,StdOval              ; $A8B7 _FrameOval
            DispNear PaintOval,FrameOval            ; $A8B8 _PaintOval
            DispNear EraseOval,PaintOval            ; $A8B9 _EraseOval
            DispNear InvertOval,EraseOval           ; $A8BA _InvertOval
            DispNear FillOval,InvertOval            ; $A8BB _FillOval
            DispFar SlopeFromAngle,FillOval         ; $A8BC _SlopeFromAngle
            DispFar StdArc,SlopeFromAngle           ; $A8BD _StdArc
            DispNear FrameArc,StdArc                ; $A8BE _FrameArc
            DispNear PaintArc,FrameArc              ; $A8BF _PaintArc
            DispNear EraseArc,PaintArc              ; $A8C0 _EraseArc
            DispNear InvertArc,EraseArc             ; $A8C1 _InvertArc
            DispNear FillArc,InvertArc              ; $A8C2 _FillArc
            DispFar PtToAngle,FillArc               ; $A8C3 _PtToAngle
            DispFar AngleFromSlope,PtToAngle        ; $A8C4 _AngleFromSlope
            DispAbs StdPoly                         ; $A8C5 _StdPoly
            DispNear FramePoly,StdPoly              ; $A8C6 _FramePoly
            DispNear PaintPoly,FramePoly            ; $A8C7 _PaintPoly
            DispNear ErasePoly,PaintPoly            ; $A8C8 _ErasePoly
            DispNear InvertPoly,ErasePoly           ; $A8C9 _InvertPoly
            DispNear FillPoly,InvertPoly            ; $A8CA _FillPoly
            DispNear OpenPoly,FillPoly              ; $A8CB _OpenPoly
            DispNear ClosePoly,OpenPoly             ; $A8CC _ClosePgon
            DispNear KillPoly,ClosePoly             ; $A8CD _KillPoly
            DispNear OffsetPoly,KillPoly            ; $A8CE _OffsetPoly
            DispFar PackBits,OffsetPoly             ; $A8CF _PackBits
            DispNear UnpackBits,PackBits            ; $A8D0 _UnpackBits
            DispFar StdRgn,UnpackBits               ; $A8D1 _StdRgn
            DispNear FrameRgn,StdRgn                ; $A8D2 _FrameRgn
            DispNear PaintRgn,FrameRgn              ; $A8D3 _PaintRgn
            DispNear EraseRgn,PaintRgn              ; $A8D4 _EraseRgn
            DispNear InvertRgn,EraseRgn             ; $A8D5 _InverRgn
            DispNear FillRgn,InvertRgn              ; $A8D6 _FillRgn
            DispFar BITMAPRGN,FillRgn               ; $A8D7 _BitMapRgn
            DispFar NewRgn,BITMAPRGN                ; $A8D8 _NewRgn
            DispNear DisposeRgn,NewRgn              ; $A8D9 _DisposRgn
            DispNear OpenRgn,DisposeRgn             ; $A8DA _OpenRgn
            DispNear CloseRgn,OpenRgn               ; $A8DB _CloseRgn
            DispNear CopyRgn,CloseRgn               ; $A8DC _CopyRgn
            DispNear SetEmptyRgn,CopyRgn            ; $A8DD _SetEmptyRgn
            DispNear SetRectRgn,SetEmptyRgn         ; $A8DE _SetRecRgn
            DispNear RectRgn,SetRectRgn             ; $A8DF _RectRgn
            DispNear OffsetRgn,RectRgn              ; $A8E0 _OffsetRgn
            DispNear InsetRgn,OffsetRgn             ; $A8E1 _InsetRgn
            DispNear EmptyRgn,InsetRgn              ; $A8E2 _EmptyRgn
            DispNear EqualRgn,EmptyRgn              ; $A8E3 _EqualRgn
            DispNear SectRgn,EqualRgn               ; $A8E4 _SectRgn
            DispNear UnionRgn,SectRgn               ; $A8E5 _UnionRgn
            DispNear DiffRgn,UnionRgn               ; $A8E6 _DiffRgn
            DispNear XorRgn,DiffRgn                 ; $A8E7 _XOrRgn
            DispNear PtInRgn,XorRgn                 ; $A8E8 _PtInRgn
            DispNear RectInRgn,PtInRgn              ; $A8E9 _RectInRgn
            DispFar SetStdProcs,RectInRgn           ; $A8EA _SetStdProcs
            DispFar StdBits,SetStdProcs             ; $A8EB _StdBits
            DispFar CopyBits,StdBits                ; $A8EC _CopyBits
            DispAbs StdTxMeas                       ; $A8ED _StdTxMeas
            DispAbs StdGetPic                       ; $A8EE _StdGetPic
            DispFar ScrollRect,StdGetPic            ; $A8EF _ScrollRect
            DispFar StdPutPic,ScrollRect            ; $A8F0 _StdPutPic
            DispFar StdComment,StdPutPic            ; $A8F1 _StdComment
            DispFar PicComment,StdComment           ; $A8F2 _PicComment
            DispNear OpenPicture,PicComment         ; $A8F3 _OpenPicture
            DispFar ClosePicture,OpenPicture        ; $A8F4 _ClosePicture
            DispNear KillPicture,ClosePicture       ; $A8F5 _KillPicture
            DispNear DrawPicture,KillPicture        ; $A8F6 _DrawPicture
            DispBad                                 ; $A8F7 _Layout
            DispFar ScalePt,DrawPicture             ; $A8F8 _ScalePt
            DispNear MapPt,ScalePt                  ; $A8F9 _MapPt
            DispNear MapRect,MapPt                  ; $A8FA _MapRect
            DispFar MapRgn,MapRect                  ; $A8FB _MapRgn
            DispFar MapPoly,MapRgn                  ; $A8FC _MapPoly
            DispAbs PrGlue                          ; $A8FD _PrGlue
            DispFar FontManager,PrGlue              ; $A8FE _InitFonts
            DispFar GetFontName,FontManager         ; $A8FF _GetFName
            DispNear GetFNum,GetFontName            ; $A900 _GetFNum
            DispFar FMSwapFont,GetFNum              ; $A901 _FMSwapFont
            DispFar RealFont,FMSwapFont             ; $A902 _RealFont
            DispNear SetFontLock,RealFont           ; $A903 _SetFontLock
            DispAbs DrawGrowIcon                    ; $A904 _DrawGrowIcon
            DispFar DragGrayRgn,DrawGrowIcon        ; $A905 _DragGrayRgn
            DispFar NewString,DragGrayRgn           ; $A906 _NewString
            DispNear SetString,NewString            ; $A907 _SetString
            DispFar ShowHide,SetString              ; $A908 _ShowHide
            DispFar CalcVis,ShowHide                ; $A909 _CalcVis
            DispNear CALCVISBEHIND,CalcVis          ; $A90A _CalcVBehind
            DispNear ClipAbove,CALCVISBEHIND        ; $A90B _ClipAbove
            DispNear PaintOne,ClipAbove             ; $A90C _PaintOne
            DispFar PaintBehind,PaintOne            ; $A90D _PaintBehind
            DispNear SaveOld,PaintBehind            ; $A90E _SaveOld
            DispNear DrawNew,SaveOld                ; $A90F _DrawNew
            DispNear GetWMgrPort,DrawNew            ; $A910 _GetWMgrPort
            DispNear CheckUpdate,GetWMgrPort        ; $A911 _CheckUpDate
            DispNear InitWindows,CheckUpdate        ; $A912 _InitWindows
            DispFar NewWindow,InitWindows           ; $A913 _NewWindow
            DispFar DisposeWindow,NewWindow         ; $A914 _DisposWindow
            DispNear ShowWindow,DisposeWindow       ; $A915 _ShowWindow
            DispNear HideWindow,ShowWindow          ; $A916 _HideWindow
            DispNear GetWRefCon,HideWindow          ; $A917 _GetWRefCon
            DispNear SetWRefCon,GetWRefCon          ; $A918 _SetWRefCon
            DispNear GetWTitle,SetWRefCon           ; $A919 _GetWTitle
            DispNear SetWTitle,GetWTitle            ; $A91A _SetWTitle
            DispNear MoveWindow,SetWTitle           ; $A91B _MoveWindow
            DispFar HiliteWindow,MoveWindow         ; $A91C _HiliteWindow
            DispNear SizeWindow,HiliteWindow        ; $A91D _SizeWindow
            DispNear TrackGoAway,SizeWindow         ; $A91E _TrackGoAway
            DispNear SelectWindow,TrackGoAway       ; $A91F _SelectWindow
            DispNear BringToFront,SelectWindow      ; $A920 _BringToFront
            DispNear SendBehind,BringToFront        ; $A921 _SendBehind
            DispNear BeginUpdate,SendBehind         ; $A922 _BeginUpDate
            DispNear EndUpdate,BeginUpdate          ; $A923 _EndUpDate
            DispNear FrontWindow,EndUpdate          ; $A924 _FrontWindow
            DispNear DragWindow,FrontWindow         ; $A925 _DragWindow
            DispNear DragTheRgn,DragWindow          ; $A926 _DragTheRgn
            DispFar InvalRgn,DragTheRgn             ; $A927 _InvalRgn
            DispNear InvalRect,InvalRgn             ; $A928 _InvalRect
            DispNear ValidRgn,InvalRect             ; $A929 _ValidRgn
            DispNear ValidRect,ValidRgn             ; $A92A _ValidRect
            DispNear GrowWindow,ValidRect           ; $A92B _GrowWindow
            DispFar FindWindow,GrowWindow           ; $A92C _FindWindow
            DispFar CloseWindow,FindWindow          ; $A92D _CloseWindow
            DispFar SetWindowPic,CloseWindow        ; $A92E _SetWindowPic
            DispNear GetWindowPic,SetWindowPic      ; $A92F _GetWindowPic
            DispFar InitMenus,GetWindowPic          ; $A930 _InitMenus
            DispFar NewMenu,InitMenus               ; $A931 _NewMenu
            DispFar DisposeMenu,NewMenu             ; $A932 _DisposMenu
            DispFar AppendMenu,DisposeMenu          ; $A933 _AppendMenu
            DispFar ClearMenuBar,AppendMenu         ; $A934 _ClearMenuBar
            DispNear InsertMenu,ClearMenuBar        ; $A935 _InsertMenu
            DispNear DeleteMenu,InsertMenu          ; $A936 _DeleteMenu
            DispNear DrawMenuBar,DeleteMenu         ; $A937 _DrawMenuBar
            DispNear HiliteMenu,DrawMenuBar         ; $A938 _HiliteMenu
            DispNear EnableItem,HiliteMenu          ; $A939 _EnableItem
            DispNear DisableItem,EnableItem         ; $A93A _DisableItem
            DispFar GetMenuBar,DisableItem          ; $A93B _GetMenuBar
            DispNear SetMenuBar,GetMenuBar          ; $A93C _SetMenuBar
            DispFar MenuSelect,SetMenuBar           ; $A93D _MenuSelect
            DispFar MenuKey,MenuSelect              ; $A93E _MenuKey
            DispFar GetItemIcon,MenuKey             ; $A93F _GetItmIcon
            DispNear SetItemIcon,GetItemIcon        ; $A940 _SetItmIcon
            DispNear GetItemStyle,SetItemIcon       ; $A941 _GetItmStyle
            DispNear SetItemStyle,GetItemStyle      ; $A942 _SetItmStyle
            DispNear GetItemMark,SetItemStyle       ; $A943 _GetItmMark
            DispNear SetItemMark,GetItemMark        ; $A944 _SetItmMark
            DispNear CheckItem,SetItemMark          ; $A945 _CheckItem
            DispFar GetItem,CheckItem               ; $A946 _GetItem
            DispFar SetItem,GetItem                 ; $A947 _SetItem
            DispFar CalcMenuSize,SetItem            ; $A948 _CalcMenuSize
            DispFar GetMHandle,CalcMenuSize         ; $A949 _GetMHandle
            DispNear SetMenuFlash,GetMHandle        ; $A94A _SetMFlash
            DispFar PlotIcon,SetMenuFlash           ; $A94B _PlotIcon
            DispFar FlashMenuBar,PlotIcon           ; $A94C _FlashMenuBar
            DispFar AddResMenu,FlashMenuBar         ; $A94D _AddResMenu
            DispAbs PinRect                         ; $A94E _PinRect
            DispAbs DeltaPoint                      ; $A94F _DeltaPoint
            DispFar CountMItems,DeltaPoint          ; $A950 _CountMItems
            DispFar InsrtResMenu,CountMItems        ; $A951 _InsertResMenu
            DispFar DelMenuItem,InsrtResMenu        ; $A952 _DelMenuItem
            DispFar UpdtControls,DelMenuItem        ; $A953 _UpdtControl
            DispFar NewControl,UpdtControls         ; $A954 _NewControl
            DispFar DisposeControl,NewControl       ; $A955 _DisposControl
            DispNear KillControls,DisposeControl    ; $A956 _KillControls
            DispNear ShowControl,KillControls       ; $A957 _ShowControl
            DispNear HideControl,ShowControl        ; $A958 _HideControl
            DispNear MoveControl,HideControl        ; $A959 _MoveControl
            DispNear GetCRefCon,MoveControl         ; $A95A _GetCRefCon
            DispNear SetCRefCon,GetCRefCon          ; $A95B _SetCRefCon
            DispNear SizeControl,SetCRefCon         ; $A95C _SizeControl
            DispNear HiliteControl,SizeControl      ; $A95D _HiliteControl
            DispNear GetCTitle,HiliteControl        ; $A95E _GetCTitle
            DispNear SetCTitle,GetCTitle            ; $A95F _SetCTitle
            DispNear GetCtlValue,SetCTitle          ; $A960 _GetCtlValue
            DispNear GetCtlMin,GetCtlValue          ; $A961 _GetMinCtl
            DispNear GetCtlMax,GetCtlMin            ; $A962 _GetMaxCtl
            DispNear SetCtlValue,GetCtlMax          ; $A963 _SetCtlValue
            DispNear SetCtlMin,SetCtlValue          ; $A964 _SetMinCtl
            DispNear SetCtlMax,SetCtlMin            ; $A965 _SetMaxCtl
            DispNear TestControl,SetCtlMax          ; $A966 _TestControl
            DispNear DragControl,TestControl        ; $A967 _DragControl
            DispNear TrackControl,DragControl       ; $A968 _TrackControl
            DispFar DrawControls,TrackControl       ; $A969 _DrawControls
            DispFar GetCtlAction,DrawControls       ; $A96A _GetCtlAction
            DispNear SetCtlAction,GetCtlAction      ; $A96B _SetCtlAction
            DispFar FindControl,SetCtlAction        ; $A96C _FindControl
            DispFar DrawOneControl,FindControl      ; $A96D _Draw1Control
            DispAbs DequeueTrap                     ; $A96E _Dequeue
            DispFar QStuff,DequeueTrap              ; $A96F _Enqueue
            DispAbs GetNextEvent                    ; $A970 _GetNextEvent
            DispFar EventAvail,GetNextEvent         ; $A971 _EventAvail
            DispFar GetMouse,EventAvail             ; $A972 _GetMouse
            DispNear StillDown,GetMouse             ; $A973 _StillDown
            DispFar Button,StillDown                ; $A974 _Button
            DispNear TickCount,Button               ; $A975 _TickCount
            DispFar GetKeys,TickCount               ; $A976 _GetKeys
            DispNear WaitMouseUp,GetKeys            ; $A977 _WaitMouseUp
            DispFar UpdtDialog,WaitMouseUp          ; $A978 _UpdtDialog
            DispFar CouldDialog,UpdtDialog          ; $A979 _CouldDialog
            DispNear FreeDialog,CouldDialog         ; $A97A _FreeDialog
            DispFar InitDialogs,FreeDialog          ; $A97B _InitDialogs
            DispFar GetNewDialog,InitDialogs        ; $A97C _GetNewDialog
            DispNear NewDialog,GetNewDialog         ; $A97D _NewDialog
            DispFar SelIText,NewDialog              ; $A97E _SelIText
            DispFar IsDialogEvent,SelIText          ; $A97F _IsDialogEvent
            DispNear DialogSelect,IsDialogEvent     ; $A980 _DialogSelect
            DispNear DrawDialog,DialogSelect        ; $A981 _DrawDialog
            DispNear CloseDialog,DrawDialog         ; $A982 _CloseDialog
            DispNear DisposDialog,CloseDialog       ; $A983 _DisposDialog
            DispFar FindDItem,DisposDialog          ; $A984 _FindDItem
            DispFar Alert,FindDItem                 ; $A985 _Alert
            DispFar StopAlert,Alert                 ; $A986 _StopAlert
            DispNear NoteAlert,StopAlert            ; $A987 _NoteAlert
            DispNear CautionAlert,NoteAlert         ; $A988 _CautionAlert
            DispFar CouldAlert,CautionAlert         ; $A989 _CouldAlert
            DispNear FreeAlert,CouldAlert           ; $A98A _FreeAlert
            DispNear ParamText,FreeAlert            ; $A98B _ParamText
            DispNear ErrorSound,ParamText           ; $A98C _ErrorSound
            DispNear GetDItem,ErrorSound            ; $A98D _GetDItem
            DispNear SetDItem,GetDItem              ; $A98E _SetDItem
            DispNear SetIText,SetDItem              ; $A98F _SetIText
            DispFar GetIText,SetIText               ; $A990 _GetIText
            DispFar ModalDialog,GetIText            ; $A991 _ModalDialog
            DispFar DetachResource,ModalDialog      ; $A992 _DetachResource
            DispNear SetResPurge,DetachResource     ; $A993 _SetResPurge
            DispNear CurResFile,SetResPurge         ; $A994 _CurResFile
            DispFar InitResources,CurResFile        ; $A995 _InitResources
            DispFar RsrcZoneInit,InitResources      ; $A996 _RsrcZoneInit
            DispNear OpenResFile,RsrcZoneInit       ; $A997 _OpenResFile
            DispNear UseResFile,OpenResFile         ; $A998 _UseResFile
            DispNear UpdateResFile,UseResFile       ; $A999 _UpdateResFile
            DispFar CloseResFile,UpdateResFile      ; $A99A _CloseResFile
            DispFar SetResLoad,CloseResFile         ; $A99B _SetResLoad
            DispFar CountResources,SetResLoad       ; $A99C _CountResources
            DispNear GetIndResource,CountResources  ; $A99D _GetIndResource
            DispNear CountTypes,GetIndResource      ; $A99E _CountTypes
            DispNear GetIndType,CountTypes          ; $A99F _GetIndType
            DispNear GetResource,GetIndType         ; $A9A0 _GetResource
            DispNear GetNamedResource,GetResource   ; $A9A1 _GetNamedResource
            DispFar LoadResource,GetNamedResource   ; $A9A2 _LoadResource
            DispNear ReleaseResource,LoadResource   ; $A9A3 _ReleaseResource
            DispNear HomeResFile,ReleaseResource    ; $A9A4 _HomeResFile
            DispFar SizeResource,HomeResFile        ; $A9A5 _SizeRsrc
            DispFar GetResAttrs,SizeResource        ; $A9A6 _GetResAttrs
            DispNear SetResAttrs,GetResAttrs        ; $A9A7 _SetResAttrs
            DispNear GetResInfo,SetResAttrs         ; $A9A8 _GetResInfo
            DispNear SetResInfo,GetResInfo          ; $A9A9 _SetResInfo
            DispFar ChangedResource,SetResInfo      ; $A9AA _ChangedResource
            DispFar AddResource,ChangedResource     ; $A9AB _AddResource
            DispFar AddReference,AddResource        ; $A9AC _AddReference
            DispFar RmveResource,AddReference       ; $A9AD _RmveResource
            DispFar RmveReference,RmveResource      ; $A9AE _RmveReference
            DispFar ResError,RmveReference          ; $A9AF _ResError
            DispFar WriteResource,ResError          ; $A9B0 _WriteResource
            DispFar CreateResFile,WriteResource     ; $A9B1 _CreateResFile
            DispFar DeskMgr,CreateResFile           ; $A9B2 _SystemEvent
            DispNear SystemClick,DeskMgr            ; $A9B3 _SystemClick
            DispNear SystemTask,SystemClick         ; $A9B4 _SystemTask
            DispNear SystemMenu,SystemTask          ; $A9B5 _SystemMenu
            DispNear OpenDeskAcc,SystemMenu         ; $A9B6 _OpenDeskAcc
            DispNear CloseDeskAcc,OpenDeskAcc       ; $A9B7 _CloseDeskAcc
            DispFar GetPattern,CloseDeskAcc         ; $A9B8 _GetPattern
            DispNear GetCursor,GetPattern           ; $A9B9 _GetCursor
            DispNear GetString,GetCursor            ; $A9BA _GetString
            DispNear GetIcon,GetString              ; $A9BB _GetIcon
            DispNear GetPicture,GetIcon             ; $A9BC _GetPicture
            DispNear GetNewWindow,GetPicture        ; $A9BD _GetNewWindow
            DispNear GetNewControl,GetNewWindow     ; $A9BE _GetNewControl
            DispNear GetMenu,GetNewControl          ; $A9BF _GetRMenu
            DispNear GetNewMBar,GetMenu             ; $A9C0 _GetNewMBar
            DispFar UniqueID,GetNewMBar             ; $A9C1 _UniqueID
            DispFar SystemEdit,UniqueID             ; $A9C2 _SysEdit
            DispAbs KeyTrans                        ; $A9C3 _KeyTrans
            DispAbs OpenRFPerm                      ; $A9C4 _OpenRFPerm
            DispFar RSRCMAPENTRY,OpenRFPerm         ; $A9C5 _RsrcMapEntry
            DispAbs SexyDate                        ; $A9C6 _SecondsToDate
            DispNear Date2Secs,SexyDate             ; $A9C7 _Date2Secs
            DispAbs SystemBeep                      ; $A9C8 _SysBeep
            DispFar SystemError,SystemBeep          ; $A9C9 _SysError
            DispFar PutIcon,SystemError             ; $A9CA _PutIcon
            DispAbs TEGetText                       ; $A9CB _TEGetText
            DispFar TEInit,TEGetText                ; $A9CC _TEInit
            DispNear TEDispose,TEInit               ; $A9CD _TEDispose
            DispNear TextBox,TEDispose              ; $A9CE _TETextBox
            DispNear TESetText,TextBox              ; $A9CF _TESetText
            DispFar TECalText,TESetText             ; $A9D0 _TECalText
            DispNear TESetSelect,TECalText          ; $A9D1 _TESetSelect
            DispNear TENew,TESetSelect              ; $A9D2 _TENew
            DispFar TEUpdate,TENew                  ; $A9D3 _TEUpdate
            DispNear TEClick,TEUpdate               ; $A9D4 _TEClick
            DispFar TECopy,TEClick                  ; $A9D5 _TECopy
            DispNear TECut,TECopy                   ; $A9D6 _TECut
            DispNear TEDelete,TECut                 ; $A9D7 _TEDelete
            DispFar TEActivate,TEDelete             ; $A9D8 _TEActivate
            DispNear TEDeactivate,TEActivate        ; $A9D9 _TEDeactivate
            DispNear TEIdle,TEDeactivate            ; $A9DA _TEIdle
            DispNear TEPaste,TEIdle                 ; $A9DB _TEPaste
            DispFar TEKey,TEPaste                   ; $A9DC _TEKey
            DispFar TEScroll,TEKey                  ; $A9DD _TEScroll
            DispFar TEInsert,TEScroll               ; $A9DE _TEInsert
            DispFar TESetJust,TEInsert              ; $A9DF _TESetAlignment
            DispAbs Munger                          ; $A9E0 _Munger
            DispFar HandToHand,Munger               ; $A9E1 _HandToHand
            DispNear PtrToXHand,HandToHand          ; $A9E2 _PtrToXHand
            DispNear PtrToHand,PtrToXHand           ; $A9E3 _PtrToHand
            DispNear HandAndHand,PtrToHand          ; $A9E4 _HandAndHand
            DispAbs PackDispatcher                  ; $A9E5 _InitPack
            DispNear InitAllPacks,PackDispatcher    ; $A9E6 _InitAllPacks
            DispNear Pack0,InitAllPacks             ; $A9E7 _Pack0
            DispNear Pack1,Pack0                    ; $A9E8 _Pack1
            DispNear Pack2,Pack1                    ; $A9E9 _Pack2
            DispNear Pack3,Pack2                    ; $A9EA _Pack3
            DispFar Pack4,Pack3                     ; $A9EB _FP68K
            DispNear Pack5,Pack4                    ; $A9EC _Elems68K
            DispNear Pack6,Pack5                    ; $A9ED _Pack6
            DispNear Pack7,Pack6                    ; $A9EE _DECSTR68K
            DispAbs PtrAndHand                      ; $A9EF _PtrAndHand
            DispAbs Loader                          ; $A9F0 _LoadSeg
            DispNear UnloadSeg,Loader               ; $A9F1 _UnLoadSeg
            DispNear Launch,UnloadSeg               ; $A9F2 _Launch
            DispFar Chain,Launch                    ; $A9F3 _Chain
            DispFar ExitToShell,Chain               ; $A9F4 _ExitToShell
            DispNear GetAppParms,ExitToShell        ; $A9F5 _GetAppParms
            DispAbs GetResFileAttrs                 ; $A9F6 _GetResFileAttrs
            DispNear SetResFileAttrs,GetResFileAttrs ; $A9F7 _SetResFileAttrs
            DispFar MethodDispatch,SetResFileAttrs  ; $A9F8 _MethodDispatch
            DispAbs InfoScrap                       ; $A9F9 _InfoScrap
            DispNear UnloadScrap,InfoScrap          ; $A9FA _UnloadScrap
            DispNear LoadScrap,UnloadScrap          ; $A9FB _LoadScrap
            DispNear ZeroScrap,LoadScrap            ; $A9FC _ZeroScrap
            DispNear GetScrap,ZeroScrap             ; $A9FD _GetScrap
            DispNear PutScrap,GetScrap              ; $A9FE _PutScrap
            DispBad                                 ; $A9FF _Debugger
            DispAbs OpenCPort                       ; $AA00 _OpenCPort
            DispNear InitCPort,OpenCPort            ; $AA01 _InitCPort
            DispNear CloseCPort,InitCPort           ; $AA02
            DispFar NewPixMap,CloseCPort            ; $AA03 _NewPixMap
            DispNear DisposPixMap,NewPixMap         ; $AA04 _DisposPixMap
            DispNear CopyPixMap,DisposPixMap        ; $AA05 _CopyPixMap
            DispFar SETCPORTPIX,CopyPixMap          ; $AA06 _SetPortPix
            DispFar NewPixPat,SETCPORTPIX           ; $AA07 _NewPixPat
            DispNear DisposCCursor,NewPixPat        ; $AA08 _DisposPixPat
            DispFar CopyPixPat,DisposCCursor        ; $AA09 _CopyPixPat
            DispFar PenPixPat,CopyPixPat            ; $AA0A _PenPixPat
            DispNear BackPixPat,PenPixPat           ; $AA0B _BackPixPat
            DispFar GETPIXPAT,BackPixPat            ; $AA0C _GetPixPat
            DispFar MAKERGBPAT,GETPIXPAT            ; $AA0D _MakeRGBPat
            DispFar FillCRect,MAKERGBPAT            ; $AA0E _FillCRect
            DispAbs FillCOval                       ; $AA0F _FillCOval
            DispFar FillCRoundRect,FillCOval        ; $AA10 _FillCRoundRect
            DispFar FillCArc,FillCRoundRect         ; $AA11 _FillCArc
            DispFar FillCRgn,FillCArc               ; $AA12 _FillCRgn
            DispFar FillCPoly,FillCRgn              ; $AA13 _FillCPoly
            DispAbs RGBForeColor                    ; $AA14 _RGBForeColor
            DispNear RGBBackColor,RGBForeColor      ; $AA15 _RGBBackColor
            DispAbs SetCPixel                       ; $AA16 _SetCPixel
            DispFar GetCPixel,SetCPixel             ; $AA17 _GetCPixel
            DispAbs GETCTABLE                       ; $AA18 _GetCTable
            DispFar GetForeColor,GETCTABLE          ; $AA19 _GetForeColor
            DispNear GetBackColor,GetForeColor      ; $AA1A _GetBackColor
            DispAbs GETCCURSOR                      ; $AA1B _GetCCursor
            DispAbs SetCCursor                      ; $AA1C _SetCCursor
            DispFar AllocCursor,SetCCursor          ; $AA1D _AllocCursor
            DispAbs GetCIcon                        ; $AA1E _GetCIcon
            DispNear PlotCIcon,GetCIcon             ; $AA1F _PlotCIcon
            DispFar OpenCPicture,PlotCIcon          ; $AA20 _OpenCPicture
            DispFar OPCOLOR,OpenCPicture            ; $AA21 _OpColor
            DispFar HiliteColor,OPCOLOR             ; $AA22 _HiliteColor
            DispFar CharExtra,HiliteColor           ; $AA23 _CharExtra
            DispFar DisposCTable,CharExtra          ; $AA24 _DisposCTable
            DispFar DisposCIcon,DisposCTable        ; $AA25 _DisposCIcon
            DispFar DisposCCursor,DisposCIcon       ; $AA26 _DisposCCursor
            DispAbs GetMaxDevice                    ; $AA27 _GetMaxDevice
            DispAbs GETCTSEED                       ; $AA28 _GetCTSeed
            DispAbs GetDeviceList                   ; $AA29 _GetDeviceList
            DispNear GetMainDevice,GetDeviceList    ; $AA2A _GetMainDevice
            DispNear GetNextDevice,GetMainDevice    ; $AA2B _GetNextDevice
            DispNear TestDeviceAttribute,GetNextDevice ; $AA2C _TestDeviceAttribute
            DispNear SetDeviceAttribute,TestDeviceAttribute ; $AA2D _SetDeviceAttribute
            DispFar InitGDevice,SetDeviceAttribute  ; $AA2E _InitGDevice
            DispFar NewGDevice,InitGDevice          ; $AA2F _NewGDevice
            DispNear DisposGDevice,NewGDevice       ; $AA30 _DisposGDevice
            DispFar SetGDevice,DisposGDevice        ; $AA31 _SetGDevice
            DispFar GetGDevice,SetGDevice           ; $AA32 _GetGDevice
            DispAbs Color2Index                     ; $AA33 _Color2Index
            DispNear Index2Color,Color2Index        ; $AA34 _Index2Color
            DispNear InvertColor,Index2Color        ; $AA35 _InvertColor
            DispFar RealColor,InvertColor           ; $AA36 _RealColor
            DispFar GetSubTable,RealColor           ; $AA37 _GetSubTable
            DispFar UpdatePixMap,GetSubTable        ; $AA38 _UpdatePixMap
            DispNear MakeITable,UpdatePixMap        ; $AA39 _MakeITable
            DispFar AddSearch,MakeITable            ; $AA3A _AddSearch
            DispNear AddComp,AddSearch              ; $AA3B _AddComp
            DispFar SetClientID,AddComp             ; $AA3C _SetClientID
            DispFar ProtectEntry,SetClientID        ; $AA3D _ProtectEntry
            DispNear ReserveEntry,ProtectEntry      ; $AA3E _ReserveEntry
            DispFar SetEntries,ReserveEntry         ; $AA3F _SetEntries
            DispFar QDError,SetEntries              ; $AA40 _QDError
            DispAbs SetWinColor                     ; $AA41 _SetWinColor
            DispFar GetAuxWin,SetWinColor           ; $AA42 _GetAuxWin
            DispFar SetCtlColor,GetAuxWin           ; $AA43 _SetCtlColor
            DispNear GetAuxCtl,SetCtlColor          ; $AA44 _GetAuxCtl
            DispFar NewCWindow,GetAuxCtl            ; $AA45 _NewCWindow
            DispAbs GetNewCWindow                   ; $AA46 _GetNewCWindow
            DispAbs SetDeskCPat                     ; $AA47 _SetDeskCPat
            DispFar GetCWMgrPort,SetDeskCPat        ; $AA48 _GetCWMgrPort
            DispAbs SaveEntries                     ; $AA49 _SaveEntries
            DispFar RestoreEntries,SaveEntries      ; $AA4A _RestoreEntries
            DispAbs NewCDialog                      ; $AA4B _NewCDialog
            DispAbs DelSearch                       ; $AA4C _DelSearch
            DispNear DelComp,DelSearch              ; $AA4D _DelComp
            DispAbs SetStdCProcs                    ; $AA4E _SetStdCProcs
            DispAbs CALCCMASK                       ; $AA4F _CalcCMask
            DispFar SEEDCFILL,CALCCMASK             ; $AA50 _SeedCFill
            DispBad                                 ; $AA51 _CopyDeepMask
            DispBad                                 ; $AA52 _HFSPinaforeDispatch
            DispBad                                 ; $AA53
            DispBad                                 ; $AA54
            DispBad                                 ; $AA55
            DispBad                                 ; $AA56
            DispBad                                 ; $AA57 _DockingDispatch
            DispBad                                 ; $AA58
            DispBad                                 ; $AA59
            DispBad                                 ; $AA5A
            DispBad                                 ; $AA5B
            DispBad                                 ; $AA5C
            DispBad                                 ; $AA5D
            DispBad                                 ; $AA5E
            DispBad                                 ; $AA5F
            DispAbs DelMCEntries                    ; $AA60 _DelMCEntries
            DispFar GetMCInfo,DelMCEntries          ; $AA61 _GetMCInfo
            DispNear SetMCInfo,GetMCInfo            ; $AA62 _SetMCInfo
            DispNear DispMCInfo,SetMCInfo           ; $AA63 _DispMCInfo
            DispFar GetMCEntry,DispMCInfo           ; $AA64 _GetMCEntry
            DispFar SetMCEntries,GetMCEntry         ; $AA65 _SetMCEntries
            DispFar MenuChoice,SetMCEntries         ; $AA66 _MenuChoice
            DispBad                                 ; $AA67 _ModalDialogMenuSetup
            DispBad                                 ; $AA68 _DialogDispatch
            DispBad                                 ; $AA69
            DispBad                                 ; $AA6A
            DispBad                                 ; $AA6B
            DispBad                                 ; $AA6C
            DispBad                                 ; $AA6D
            DispBad                                 ; $AA6E
            DispBad                                 ; $AA6F
            DispBad                                 ; $AA70
            DispBad                                 ; $AA71
            DispBad                                 ; $AA72
            DispBad                                 ; $AA73
            DispBad                                 ; $AA74
            DispBad                                 ; $AA75
            DispBad                                 ; $AA76
            DispBad                                 ; $AA77
            DispBad                                 ; $AA78
            DispBad                                 ; $AA79
            DispBad                                 ; $AA7A
            DispBad                                 ; $AA7B
            DispBad                                 ; $AA7C
            DispBad                                 ; $AA7D
            DispBad                                 ; $AA7E
            DispBad                                 ; $AA7F
            DispBad                                 ; $AA80
            DispBad                                 ; $AA81
            DispBad                                 ; $AA82
            DispBad                                 ; $AA83
            DispBad                                 ; $AA84
            DispBad                                 ; $AA85
            DispBad                                 ; $AA86
            DispBad                                 ; $AA87
            DispBad                                 ; $AA88
            DispBad                                 ; $AA89
            DispBad                                 ; $AA8A
            DispBad                                 ; $AA8B
            DispBad                                 ; $AA8C
            DispBad                                 ; $AA8D
            DispBad                                 ; $AA8E
            DispBad                                 ; $AA8F
            DispAbs InitPalettes                    ; $AA90 _InitPalettes
            DispFar NewPalette,InitPalettes         ; $AA91 _NewPalette
            DispNear GetNewPalette,NewPalette       ; $AA92 _GetNewPalette
            DispFar DisposePalette,GetNewPalette    ; $AA93 _DisposePalette
            DispFar ACTIVATEPALETTE,DisposePalette  ; $AA94 _ActivatePalette
            DispFar SetPalette,ACTIVATEPALETTE      ; $AA95 _SetPalette
            DispNear GetPalette,SetPalette          ; $AA96 _GetPalette
            DispFar PmForeColor,GetPalette          ; $AA97 _PmForeColor
            DispNear PmBackColor,PmForeColor        ; $AA98 _PmBackColor
            DispNear AnimateEntry,PmBackColor       ; $AA99 _AnimateEntry
            DispFar AnimatePalette,AnimateEntry     ; $AA9A _AnimatePalette
            DispFar GetEntryColor,AnimatePalette    ; $AA9B _GetEntryColor
            DispFar SetEntryColor,GetEntryColor     ; $AA9C _SetEntryColor
            DispNear GetEntryUsage,SetEntryColor    ; $AA9D _GetEntryUsage
            DispNear SetEntryUsage,GetEntryUsage    ; $AA9E _SetEntryUsage
            DispNear CTab2Palette,SetEntryUsage     ; $AA9F _CTab2Palette
            DispNear Palette2CTab,CTab2Palette      ; $AAA0 _Palette2CTab
            DispNear CopyPalette,Palette2CTab       ; $AAA1 _CopyPalette
            DispFar PMgrDispatch,CopyPalette        ; $AAA2 _PaletteDispatch
            DispBad                                 ; $AAA3
            DispBad                                 ; $AAA4
            DispBad                                 ; $AAA5
            DispBad                                 ; $AAA6
            DispBad                                 ; $AAA7
            DispBad                                 ; $AAA8
            DispBad                                 ; $AAA9
            DispBad                                 ; $AAAA
            DispBad                                 ; $AAAB
            DispBad                                 ; $AAAC
            DispBad                                 ; $AAAD
            DispBad                                 ; $AAAE
            DispBad                                 ; $AAAF
            DispBad                                 ; $AAB0
            DispBad                                 ; $AAB1
            DispBad                                 ; $AAB2
            DispBad                                 ; $AAB3
            DispBad                                 ; $AAB4
            DispBad                                 ; $AAB5
            DispBad                                 ; $AAB6
            DispBad                                 ; $AAB7
            DispBad                                 ; $AAB8
            DispBad                                 ; $AAB9
            DispBad                                 ; $AABA
            DispBad                                 ; $AABB
            DispBad                                 ; $AABC
            DispBad                                 ; $AABD
            DispBad                                 ; $AABE
            DispBad                                 ; $AABF
            DispBad                                 ; $AAC0
            DispBad                                 ; $AAC1
            DispBad                                 ; $AAC2
            DispBad                                 ; $AAC3
            DispBad                                 ; $AAC4
            DispBad                                 ; $AAC5
            DispBad                                 ; $AAC6
            DispBad                                 ; $AAC7
            DispBad                                 ; $AAC8
            DispBad                                 ; $AAC9
            DispBad                                 ; $AACA
            DispBad                                 ; $AACB
            DispBad                                 ; $AACC
            DispBad                                 ; $AACD
            DispBad                                 ; $AACE
            DispBad                                 ; $AACF
            DispBad                                 ; $AAD0
            DispBad                                 ; $AAD1
            DispBad                                 ; $AAD2
            DispBad                                 ; $AAD3
            DispBad                                 ; $AAD4
            DispBad                                 ; $AAD5
            DispBad                                 ; $AAD6
            DispBad                                 ; $AAD7
            DispBad                                 ; $AAD8
            DispBad                                 ; $AAD9
            DispBad                                 ; $AADA
            DispBad                                 ; $AADB _CursorADBDispatch
            DispBad                                 ; $AADC
            DispBad                                 ; $AADD
            DispBad                                 ; $AADE
            DispBad                                 ; $AADF
            DispBad                                 ; $AAE0
            DispBad                                 ; $AAE1
            DispBad                                 ; $AAE2
            DispBad                                 ; $AAE3
            DispBad                                 ; $AAE4
            DispBad                                 ; $AAE5
            DispBad                                 ; $AAE6
            DispBad                                 ; $AAE7
            DispBad                                 ; $AAE8
            DispBad                                 ; $AAE9
            DispBad                                 ; $AAEA
            DispBad                                 ; $AAEB
            DispBad                                 ; $AAEC
            DispBad                                 ; $AAED
            DispBad                                 ; $AAEE
            DispBad                                 ; $AAEF
            DispBad                                 ; $AAF0
            DispBad                                 ; $AAF1
            DispBad                                 ; $AAF2
            DispBad                                 ; $AAF3
            DispBad                                 ; $AAF4
            DispBad                                 ; $AAF5
            DispBad                                 ; $AAF6
            DispBad                                 ; $AAF7
            DispBad                                 ; $AAF8
            DispBad                                 ; $AAF9
            DispBad                                 ; $AAFA _InitApplication
            DispBad                                 ; $AAFB _CleanupApplication
            DispBad                                 ; $AAFC
            DispBad                                 ; $AAFD
            DispBad                                 ; $AAFE
            DispBad                                 ; $AAFF
            DispAbs BITBLT                          ; $AB00
            DispFar BitsToMap,BITBLT                ; $AB01
            DispFar BitsToPix,BitsToMap             ; $AB02
            DispFar JACKSONPOLLOCK,BitsToPix        ; $AB03
            DispFar ColorMap,JACKSONPOLLOCK         ; $AB04
            DispFar CopyHandle,ColorMap             ; $AB05
            DispAbs CullPoints                      ; $AB06
            DispAbs DPutPicByte                     ; $AB07
            DispNear DPutPicOp,DPutPicByte          ; $AB08
            DispFar DrawArc,DPutPicOp               ; $AB09
            DispAbs DrawLine                        ; $AB0A
            DispFar DrawSlab,DrawLine               ; $AB0B
            DispFar FASTSLABMODE,DrawSlab           ; $AB0C
            DispAbs GetSeek                         ; $AB0D
            DispAbs MAKESCALETBL                    ; $AB0E
            DispFar CheckPic,MAKESCALETBL           ; $AB0F
            DispAbs DoLine                          ; $AB10
            DispFar OLDPATTONEW,DoLine              ; $AB11
            DispAbs PackRgn                         ; $AB12
            DispAbs PATCONVERT                      ; $AB13
            DispFar PATDITHER,PATCONVERT            ; $AB14
            DispFar PATEXPAND,PATDITHER             ; $AB15
            DispFar PINIT,PATEXPAND                 ; $AB16
            DispFar PortToMap,PINIT                 ; $AB17
            DispFar PUSHVERB,PortToMap              ; $AB18
            DispFar PutLine,PUSHVERB                ; $AB19
            DispAbs PutOval                         ; $AB1A
            DispFar PutRgn,PutOval                  ; $AB1B
            DispAbs NewTempBuffer                   ; $AB1C
            DispAbs QDEXTDISPATCHER                 ; $AB1D _QDExtensions
            DispAbs DisposeTempBuffer               ; $AB1E
            DispFar RgnBlt,DisposeTempBuffer        ; $AB1F
            DispAbs RgnOp                           ; $AB20
            DispAbs RSECT                           ; $AB21
            DispAbs SeekRgn                         ; $AB22
            DispFar SetFillPat,SeekRgn              ; $AB23
            DispFar SETUPSTRETCH,SetFillPat         ; $AB24
            DispAbs SLABMODE                        ; $AB25
            DispAbs SortPoints                      ; $AB26
            DispFar StretchBits,SortPoints          ; $AB27
            DispAbs STDDEVLOOP                      ; $AB28
            DispAbs TrimRect                        ; $AB29
            DispFar XorSlab,TrimRect                ; $AB2A
            DispAbs EXTBL                           ; $AB2B
            DispBad                                 ; $AB2C
            DispFar NEWTEMPHANDLE,EXTBL             ; $AB2D
            DispFar PATEXTBL,NEWTEMPHANDLE          ; $AB2E
            DispBad                                 ; $AB2F
            DispAbs bMAIN0                          ; $AB30
            DispNear bMAIN1,bMAIN0                  ; $AB31
            DispNear bMAIN2,bMAIN1                  ; $AB32
            DispNear bMAIN3,bMAIN2                  ; $AB33
            DispFar bSETUP8,bMAIN3                  ; $AB34
            DispNear bMAIN9,bSETUP8                 ; $AB35
            DispNear bSETUP10,bMAIN9                ; $AB36
            DispNear bMAIN11,bSETUP10               ; $AB37
            DispNear bXMAIN8,bMAIN11                ; $AB38
            DispNear bXMAIN9,bXMAIN8                ; $AB39
            DispNear bXMAIN10,bXMAIN9               ; $AB3A
            DispNear bXMAIN11,bXMAIN10              ; $AB3B
            DispFar bcMain0,bXMAIN11                ; $AB3C
            DispNear bcMain1,bcMain0                ; $AB3D
            DispFar bHilite,bcMain1                 ; $AB3E
            DispFar bcMain3,bHilite                 ; $AB3F
            DispFar bEND0,bcMain3                   ; $AB40
            DispNear bEND1,bEND0                    ; $AB41
            DispNear bEND2,bEND1                    ; $AB42
            DispNear bEND3,bEND2                    ; $AB43
            DispNear bLONG8,bEND3                   ; $AB44
            DispFar bEND9,bLONG8                    ; $AB45
            DispNear bEND10,bEND9                   ; $AB46
            DispNear bEND11,bEND10                  ; $AB47
            DispNear bXLONG8,bEND11                 ; $AB48
            DispNear bXEND9,bXLONG8                 ; $AB49
            DispNear bXEND10,bXEND9                 ; $AB4A
            DispNear bXEND11,bXEND10                ; $AB4B
            DispFar bcEnd0,bXEND11                  ; $AB4C
            DispNear bcEnd1,bcEnd0                  ; $AB4D
            DispFar bSloHilite,bcEnd1               ; $AB4E
            DispFar bcEnd3,bSloHilite               ; $AB4F
            DispFar bAvg,bcEnd3                     ; $AB50
            DispFar bAddPin,bAvg                    ; $AB51
            DispFar bAddOver,bAddPin                ; $AB52
            DispFar bSubPin,bAddOver                ; $AB53
            DispFar bTransparent,bSubPin            ; $AB54
            DispFar bMax,bTransparent               ; $AB55
            DispFar bSubOver,bMax                   ; $AB56
            DispFar bMin,bSubOver                   ; $AB57
            DispFar bSetup0,bMin                    ; $AB58
            DispFar bLeft0,bSetup0                  ; $AB59
            DispFar rMASK0,bLeft0                   ; $AB5A
            DispFar rMASK1,rMASK0                   ; $AB5B
            DispNear rMASK2,rMASK1                  ; $AB5C
            DispNear rMASK3,rMASK2                  ; $AB5D
            DispFar rMASK8,rMASK3                   ; $AB5E
            DispNear rMASK9,rMASK8                  ; $AB5F
            DispNear rMASK10,rMASK9                 ; $AB60
            DispNear rMASK11,rMASK10                ; $AB61
            DispNear rXMASK8,rMASK11                ; $AB62
            DispNear rXMASK9,rXMASK8                ; $AB63
            DispNear rXMASK10,rXMASK9               ; $AB64
            DispNear rXMASK11,rXMASK10              ; $AB65
            DispFar rAvg,rXMASK11                   ; $AB66
            DispFar rAddPin,rAvg                    ; $AB67
            DispFar rAddOver,rAddPin                ; $AB68
            DispFar rSubPin,rAddOver                ; $AB69
            DispFar rTransparent,rSubPin            ; $AB6A
            DispFar rMax,rTransparent               ; $AB6B
            DispFar rSubOver,rMax                   ; $AB6C
            DispFar rMin,rSubOver                   ; $AB6D
            DispFar rcMask0,rMin                    ; $AB6E
            DispNear rcMask1,rcMask0                ; $AB6F
            DispFar rslowHilite,rcMask1             ; $AB70
            DispFar rcMask3,rslowHilite             ; $AB71
            DispFar rHilite,rcMask3                 ; $AB72
            DispAbs stMASK0                         ; $AB73
            DispNear stMASK1,stMASK0                ; $AB74
            DispNear stMASK2,stMASK1                ; $AB75
            DispNear stMASK3,stMASK2                ; $AB76
            DispFar stAvg,stMASK3                   ; $AB77
            DispFar stAddPin,stAvg                  ; $AB78
            DispFar stAddOver,stAddPin              ; $AB79
            DispFar stSubPin,stAddOver              ; $AB7A
            DispFar stTransparent,stSubPin          ; $AB7B
            DispFar stMax,stTransparent             ; $AB7C
            DispFar stSubOver,stMax                 ; $AB7D
            DispFar stMin,stSubOver                 ; $AB7E
            DispFar stHilite,stMin                  ; $AB7F
            DispAbs SLMASK8                         ; $AB80
            DispNear SLMASK9,SLMASK8                ; $AB81
            DispNear SLMASK10,SLMASK9               ; $AB82
            DispNear SLMASK11,SLMASK10              ; $AB83
            DispNear SLXMASK8,SLMASK11              ; $AB84
            DispNear SLXMASK9,SLXMASK8              ; $AB85
            DispNear SLXMASK10,SLXMASK9             ; $AB86
            DispNear SLXMASK11,SLXMASK10            ; $AB87
            DispFar SLAVG,SLXMASK11                 ; $AB88
            DispFar SLADDPIN,SLAVG                  ; $AB89
            DispFar SLADDOVER,SLADDPIN              ; $AB8A
            DispFar SLSUBPIN,SLADDOVER              ; $AB8B
            DispFar SLTRANSPARENT,SLSUBPIN          ; $AB8C
            DispFar SLMAX,SLTRANSPARENT             ; $AB8D
            DispFar SLSUBOVER,SLMAX                 ; $AB8E
            DispFar SLMIN,SLSUBOVER                 ; $AB8F
            DispFar SLHILITE,SLMIN                  ; $AB90
            DispAbs ITabMatch                       ; $AB91
            DispFar COLORTHING2INDEX,ITabMatch      ; $AB92
            DispBad                                 ; $AB93
            DispFar ALLOCRUNBUF,COLORTHING2INDEX    ; $AB94
            DispFar InitRgn,ALLOCRUNBUF             ; $AB95
            DispFar SCALEBLT,InitRgn                ; $AB96
            DispFar STNOSTACK,SCALEBLT              ; $AB97
            DispFar BLITCASE,STNOSTACK              ; $AB98
            DispFar STSCANLOOP,BLITCASE             ; $AB99
            DispFar PicItem1,STSCANLOOP             ; $AB9A
            DispAbs MAKEGRAYITAB                    ; $AB9B
            DispAbs FASTLINE                        ; $AB9C
            DispFar FASTSLANT,FASTLINE              ; $AB9D
            DispAbs BitsDevLoop                     ; $AB9E
            DispBad                                 ; $AB9F
            DispAbs RARITH16TAB                     ; $ABA0
            DispNear RARITH32TAB,RARITH16TAB        ; $ABA1
            DispNear RHILITETAB,RARITH32TAB         ; $ABA2
            DispAbs GSRUNTBL                        ; $ABA3
            DispNear GSEXPTBL,GSRUNTBL              ; $ABA4
            DispNear gsSeekTbl,GSEXPTBL             ; $ABA5
            DispFar STARITH16TAB,gsSeekTbl          ; $ABA6
            DispNear STARITH32TAB,STARITH16TAB      ; $ABA7
            DispFar STCOLORTAB,STARITH32TAB         ; $ABA8
            DispNear STGRAYTAB,STCOLORTAB           ; $ABA9
            DispNear STSEARCHTAB,STGRAYTAB          ; $ABAA
            DispFar SCALEINDEXEDTOINDEXED,STSEARCHTAB ; $ABAB
            DispFar SCINDTAB1,SCALEINDEXEDTOINDEXED ; $ABAC
            DispNear SCINDTAB2,SCINDTAB1            ; $ABAD
            DispNear SCINDTAB4,SCINDTAB2            ; $ABAE
            DispNear SCINDTAB8,SCINDTAB4            ; $ABAF
            DispNear SCINDTAB16,SCINDTAB8           ; $ABB0
            DispNear SCINDTAB32,SCINDTAB16          ; $ABB1
            DispFar SCDIRTAB1,SCINDTAB32            ; $ABB2
            DispNear SCDIRTAB2,SCDIRTAB1            ; $ABB3
            DispNear SCDIRTAB4,SCDIRTAB2            ; $ABB4
            DispNear SCDIRTAB8,SCDIRTAB4            ; $ABB5
            DispNear SCDIRTAB16,SCDIRTAB8           ; $ABB6
            DispNear SCDIRTAB32,SCDIRTAB16          ; $ABB7
            DispAbs bArith16Tab                     ; $ABB8
            DispNear bArith32Tab,bArith16Tab        ; $ABB9
            DispNear bHiliteTab,bArith32Tab         ; $ABBA
            DispFar BARITH16SETUP,bHiliteTab        ; $ABBB
            DispFar BARITH32SETUP,BARITH16SETUP     ; $ABBC
            DispFar SLARITH16TAB,BARITH32SETUP      ; $ABBD
            DispNear SLARITH32TAB,SLARITH16TAB      ; $ABBE
            DispBad                                 ; $ABBF
            DispBad                                 ; $ABC0
            DispBad                                 ; $ABC1
            DispBad                                 ; $ABC2
            DispBad                                 ; $ABC3
            DispBad                                 ; $ABC4
            DispBad                                 ; $ABC5
            DispBad                                 ; $ABC6
            DispBad                                 ; $ABC7
            DispBad                                 ; $ABC8
            DispBad                                 ; $ABC9 _IconDispatch
            DispBad                                 ; $ABCA _DeviceLoop
            DispBad                                 ; $ABCB
            DispBad                                 ; $ABCC
            DispBad                                 ; $ABCD
            DispBad                                 ; $ABCE
            DispBad                                 ; $ABCF
            DispBad                                 ; $ABD0
            DispBad                                 ; $ABD1
            DispBad                                 ; $ABD2
            DispBad                                 ; $ABD3
            DispBad                                 ; $ABD4
            DispBad                                 ; $ABD5
            DispBad                                 ; $ABD6
            DispBad                                 ; $ABD7
            DispBad                                 ; $ABD8
            DispBad                                 ; $ABD9
            DispBad                                 ; $ABDA
            DispBad                                 ; $ABDB
            DispBad                                 ; $ABDC
            DispBad                                 ; $ABDD
            DispBad                                 ; $ABDE
            DispBad                                 ; $ABDF
            DispBad                                 ; $ABE0
            DispBad                                 ; $ABE1
            DispBad                                 ; $ABE2
            DispBad                                 ; $ABE3
            DispBad                                 ; $ABE4
            DispBad                                 ; $ABE5
            DispBad                                 ; $ABE6
            DispBad                                 ; $ABE7
            DispBad                                 ; $ABE8
            DispBad                                 ; $ABE9
            DispBad                                 ; $ABEA
            DispBad                                 ; $ABEB _DisplayDispatch
            DispBad                                 ; $ABEC
            DispBad                                 ; $ABED
            DispBad                                 ; $ABEE
            DispBad                                 ; $ABEF
            DispBad                                 ; $ABF0
            DispBad                                 ; $ABF1
            DispBad                                 ; $ABF2
            DispBad                                 ; $ABF3
            DispBad                                 ; $ABF4
            DispBad                                 ; $ABF5
            DispBad                                 ; $ABF6
            DispBad                                 ; $ABF7 _SynchIdleTime
            DispFar StdOpcodeProc,SLARITH32TAB      ; $ABF8 _StdOpcodeProc
            DispBad                                 ; $ABF9
            DispBad                                 ; $ABFA
            DispBad                                 ; $ABFB
            DispBad                                 ; $ABFC
            DispBad                                 ; $ABFD
            DispBad                                 ; $ABFE
            DispBad                                 ; $ABFF _DebugStr
            DispAbs Open                            ; $A000 _Open
            DispFar Close,Open                      ; $A001 _Close
            DispNear Read,Close                     ; $A002 _Read
            DispNear Write,Read                     ; $A003 _Write
            DispNear Control,Write                  ; $A004 _Control
            DispNear Status,Control                 ; $A005 _Status
            DispNear KillIO,Status                  ; $A006 _KillIO
            DispFar GetVolInfo,KillIO               ; $A007 _GetVolInfo
            DispFar FileCreate,GetVolInfo           ; $A008 _Create
            DispFar FileDelete,FileCreate           ; $A009 _Delete
            DispFar OpenRF,FileDelete               ; $A00A _OpenRF
            DispFar ReName,OpenRF                   ; $A00B _Rename
            DispFar GetFileInfo,ReName              ; $A00C _GetFileInfo
            DispFar SetFileInfo,GetFileInfo         ; $A00D _SetFileInfo
            DispFar UnmountVol,SetFileInfo          ; $A00E _UnmountVol
            DispFar MountVol,UnmountVol             ; $A00F _MountVol
            DispFar FileAlloc,MountVol              ; $A010 _Allocate
            DispFar GetEOF,FileAlloc                ; $A011 _GetEOF
            DispFar SetEOF,GetEOF                   ; $A012 _SetEOF
            DispFar FlushVol,SetEOF                 ; $A013 _FlushVol
            DispFar GetVol,FlushVol                 ; $A014 _GetVol
            DispNear SetVol,GetVol                  ; $A015 _SetVol
            DispFar FInitQueue,SetVol               ; $A016 _FInitQueue
            DispFar Eject_2,FInitQueue              ; $A017 _Eject
            DispFar GetFPos,Eject_2                 ; $A018 _GetFPos
            DispFar InitZone,GetFPos                ; $A019 _InitZone
            DispFar GetZone,InitZone                ; $A01A
            DispNear SetZone,GetZone                ; $A01B _SetZone
            DispNear FreeMem,SetZone                ; $A01C _FreeMem
            DispNear MaxMem,FreeMem                 ; $A01D
            DispFar NewPtr,MaxMem                   ; $A01E
            DispNear DisposePtr,NewPtr              ; $A01F _DisposPtr
            DispNear SetPtrSize,DisposePtr          ; $A020 _SetPtrSize
            DispFar GetPtrSize,SetPtrSize           ; $A021 _GetPtrSize
            DispNear NwHandle,GetPtrSize            ; $A022
            DispNear DsposeHandle,NwHandle          ; $A023 _DisposHandle
            DispNear SetHandleSize,DsposeHandle     ; $A024 _SetHandleSize
            DispFar GetHandleSize,SetHandleSize     ; $A025 _GetHandleSize
            DispNear HandleZone,GetHandleSize       ; $A026
            DispNear ReAllocHandle,HandleZone       ; $A027 _ReallocHandle
            DispFar RecoverHandle,ReAllocHandle     ; $A028
            DispFar HLock,RecoverHandle             ; $A029 _HLock
            DispNear HUnlock,HLock                  ; $A02A _HUnlock
            DispFar EmptyHandle,HUnlock             ; $A02B _EmptyHandle
            DispFar InitApplZone,EmptyHandle        ; $A02C _InitApplZone
            DispFar SetApplLimit,InitApplZone       ; $A02D _SetApplLimit
            DispFar BlockMove68020,SetApplLimit     ; $A02E _BlockMove
            DispFar Events,BlockMove68020           ; $A02F _PostEvent
            DispNear OSEventAvail,Events            ; $A030 _OSEventAvail
            DispNear GetOSEvent,OSEventAvail        ; $A031 _GetOSEvent
            DispNear FlushEvents,GetOSEvent         ; $A032 _FlushEvents
            DispFar VBLCore,FlushEvents             ; $A033 _VInstall
            DispNear VRemove,VBLCore                ; $A034 _VRemove
            DispFar Offline,VRemove                 ; $A035 _OffLine
            DispFar MoreMasters,Offline             ; $A036 _MoreMasters
            DispFar ReadParam,MoreMasters           ; $A037
            DispNear WriteParam,ReadParam           ; $A038 _WriteParam
            DispNear ReadDateTime,WriteParam        ; $A039 _ReadDateTime
            DispNear SetDateTimeTrap,ReadDateTime   ; $A03A _SetDateTime
            DispNear Delay,SetDateTimeTrap          ; $A03B _Delay
            DispNear CmpString,Delay                ; $A03C _CmpString
            DispFar DrvrInstall,CmpString           ; $A03D _DrvrInstall
            DispNear DrvrRemove,DrvrInstall         ; $A03E _DrvrRemove
            DispFar InitUtil,DrvrRemove             ; $A03F _InitUtil
            DispFar ResrvMem,InitUtil               ; $A040 _ResrvMem
            DispFar SetFilLock,ResrvMem             ; $A041 _SetFilLock
            DispNear RstFilLock,SetFilLock          ; $A042 _RstFilLock
            DispFar SetFilType,RstFilLock           ; $A043 _SetFilType
            DispFar SetFPos,SetFilType              ; $A044 _SetFPos
            DispFar FlushFile,SetFPos               ; $A045 _FlushFile
            DispAbs GetTrapAddress                  ; $A046
            DispNear SetTrapAddress,GetTrapAddress  ; $A047 _SetTrapAddress
            DispFar PtrZone,SetTrapAddress          ; $A048
            DispFar HPurge,PtrZone                  ; $A049 _HPurge
            DispNear HNoPurge,HPurge                ; $A04A _HNoPurge
            DispFar SetGrowZone,HNoPurge            ; $A04B _SetGrowZone
            DispFar CompactMem,SetGrowZone          ; $A04C _CompactMem
            DispNear PurgeMem,CompactMem            ; $A04D _PurgeMem
            DispFar AddDrive,PurgeMem               ; $A04E _AddDrive
            DispFar InstallRDrivers,AddDrive        ; $A04F _RDrvrInstall
            DispFar RelStringTrap,InstallRDrivers   ; $A050 _RelString
            DispFar ReadXPRam,RelStringTrap         ; $A051 _ReadXPRam
            DispNear WriteXPRam,ReadXPRam           ; $A052 _WriteXPRam
            DispNear ClkNoMem,WriteXPRam            ; $A053
            DispFar uprstring,ClkNoMem              ; $A054 _UpperString
            DispFar StripAddress,uprstring          ; $A055 _StripAddress
            DispFar LWRSTRING,StripAddress          ; $A056 _LowerText
            DispFar SetApplBase,LWRSTRING           ; $A057 _SetAppBase
            DispFar InsTime,SetApplBase             ; $A058 _InsTime
            DispFar TimeMgr,InsTime                 ; $A059 _RmvTime
            DispNear PrimeTime,TimeMgr              ; $A05A _PrimeTime
            DispFar PowerOff,PrimeTime              ; $A05B _PowerOff
            DispFar MEMORYDISPATCH,PowerOff         ; $A05C _MemoryDispatch
            DispBad                                 ; $A05D _SwapMMUMode
            DispAbs __NMINSTALL                     ; $A05E _NMInstall
            DispNear __NMREMOVE,__NMINSTALL         ; $A05F _NMRemove
            DispAbs TurboFS                         ; $A060 _FSDispatch
            DispFar MaxBlock,TurboFS                ; $A061 _MaxBlock
            DispNear PurgeSpace,MaxBlock            ; $A062
            DispFar MaxApplZone,PurgeSpace          ; $A063 _MaxApplZone
            DispFar MoveHHi,MaxApplZone             ; $A064 _MoveHHi
            DispFar StackSpace,MoveHHi              ; $A065 _StackSpace
            DispFar NewEmptyHandle,StackSpace       ; $A066
            DispFar HRSRC,NewEmptyHandle            ; $A067 _HSetRBit
            DispNear HNoRSRC,HRSRC                  ; $A068 _HClrRBit
            DispNear HGetFlags,HNoRSRC              ; $A069 _HGetState
            DispNear HSetFlags,HGetFlags            ; $A06A _HSetState
            DispAbs TMProc                          ; $A06B
            DispAbs InitFS                          ; $A06C _InitFS
            DispAbs InitEvents                      ; $A06D _InitEvents
            DispFar SlotManager,InitEvents          ; $A06E _SlotManager
            DispFar SlotVInstall,SlotManager        ; $A06F _SlotVInstall
            DispNear SlotVRemove,SlotVInstall       ; $A070 _SlotVRemove
            DispNear AttachVBL,SlotVRemove          ; $A071 _AttachVBL
            DispNear DoVBLTask,AttachVBL            ; $A072 _DoVBLTask
            DispBad                                 ; $A073
            DispFar CacheTrap,DoVBLTask             ; $A074
            DispFar SIntInstall,CacheTrap           ; $A075 _SIntInstall
            DispNear SIntRemove,SIntInstall         ; $A076 _SIntRemove
            DispFar KBDMngr,SIntRemove              ; $A077 _CountADBs
            DispNear GetIndADB,KBDMngr              ; $A078 _GetIndADB
            DispNear GetADBInfo,GetIndADB           ; $A079 _GetADBInfo
            DispNear SetADBInfo,GetADBInfo          ; $A07A _SetADBInfo
            DispFar ADBReInit,SetADBInfo            ; $A07B _ADBReInit
            DispFar ADBOp,ADBReInit                 ; $A07C _ADBOp
            DispAbs GetDefaultStartup               ; $A07D _GetDefaultStartup
            DispNear SetDefaultStartup,GetDefaultStartup ; $A07E _SetDefaultStartup
            DispNear InternalWait,SetDefaultStartup ; $A07F _InternalWait
            DispFar GetVideoDefault,InternalWait    ; $A080 _GetVideoDefault
            DispNear SetVideoDefault,GetVideoDefault ; $A081 _SetVideoDefault
            DispAbs DTCore                          ; $A082 _DTInstall
            DispAbs SetOSDefault                    ; $A083 _SetOSDefault
            DispFar GetOSDefault,SetOSDefault       ; $A084 _GetOSDefault
            DispAbs PmgrOp                          ; $A085 _PMgrOp
            DispAbs IOPMGR                          ; $A086 _IOPInfoAccess
            DispFar IOPMsgRequest,IOPMGR            ; $A087 _IOPMsgRequest
            DispNear IOPMOVEDATA,IOPMsgRequest      ; $A088 _IOPMoveData
            DispBad                                 ; $A089
            DispAbs GoToSleep                       ; $A08A _Sleep
            DispBad                                 ; $A08B _CommToolboxDispatch
            DispBad                                 ; $A08C
            DispAbs DebugUtil                       ; $A08D _DebugUtil
            DispBad                                 ; $A08E
            DispBad                                 ; $A08F _DeferUserFn
            DispFar SYSENVIRONS,DebugUtil           ; $A090 _SysEnvirons
            DispAbs Translate24To32                 ; $A091 _Translate24To32
            DispAbs EgretDispatch                   ; $A092 _EgretDispatch
            DispBad                                 ; $A093
            DispBad                                 ; $A094
            DispBad                                 ; $A095
            DispBad                                 ; $A096
            DispBad                                 ; $A097
            DispAbs HWPRIV                          ; $A098
            DispBad                                 ; $A099
            DispBad                                 ; $A09A
            DispBad                                 ; $A09B
            DispBad                                 ; $A09C
            DispBad                                 ; $A09D _MoveHLow
            DispBad                                 ; $A09E
            DispAbs PowerDispatch                   ; $A09F _PowerDispatch
            DispBad                                 ; $A0A0
            DispBad                                 ; $A0A1
            DispBad                                 ; $A0A2
            DispBad                                 ; $A0A3
            DispBad                                 ; $A0A4 _FigmentDispatch
            DispBad                                 ; $A0A5
            DispAbs vRMgrStdEntry                   ; $A0A6
            DispNear VRMGRSTDEXIT,vRMgrStdEntry     ; $A0A7
            DispBad                                 ; $A0A8
            DispBad                                 ; $A0A9
            DispBad                                 ; $A0AA
            DispBad                                 ; $A0AB
            DispBad                                 ; $A0AC
            DispFar GestaltTrap_,VRMGRSTDEXIT       ; $A0AD
            DispBad                                 ; $A0AE
            DispFar VMTCHECK,GestaltTrap_           ; $A0AF
            DispFar vCheckRemount,VMTCHECK          ; $A0B0
            DispFar vDtrmV2,vCheckRemount           ; $A0B1
            DispFar vFindDrive,vDtrmV2              ; $A0B2
            DispFar vFClose,vFindDrive              ; $A0B3
            DispFar vFlushMDB,vFClose               ; $A0B4
            DispFar vGoDriver,vFlushMDB             ; $A0B5
            DispFar vWaitUntil,vGoDriver            ; $A0B6
            DispNear vSyncWait,vWaitUntil           ; $A0B7
            DispAbs SndAppDead                      ; $A0B8 _SndAppDead
            DispAbs vDisptch                        ; $A0B9
            DispFar vIAZInit,vDisptch               ; $A0BA
            DispFar vIAZPostInit,vIAZInit           ; $A0BB
            DispFar vLaunchInit,vIAZPostInit        ; $A0BC
            DispFar vCacheFlush,vLaunchInit         ; $A0BD
            DispFar SYSUTIL,vCacheFlush             ; $A0BE
            DispFar VLG2PHYS,SYSUTIL                ; $A0BF
            DispFar vFlushCache,VLG2PHYS            ; $A0C0
            DispNear vGetBlock,vFlushCache          ; $A0C1
            DispFar vMarkBlock,vGetBlock            ; $A0C2
            DispNear vRelBlock,vMarkBlock           ; $A0C3
            DispNear vTrashBlocks,vRelBlock         ; $A0C4
            DispFar vTrashVBlks,vTrashBlocks        ; $A0C5
            DispNear vCacheWrIP,vTrashVBlks         ; $A0C6
            DispFar vCacheRdIP,vCacheWrIP           ; $A0C7
            DispNear VBASICIO,vCacheRdIP            ; $A0C8
            DispNear VRDBLOCKS,VBASICIO             ; $A0C9
            DispNear VWRBLOCKS,VRDBLOCKS            ; $A0CA
            DispNear VSETUPTAGS,VWRBLOCKS           ; $A0CB
            DispFar vBTClose,VSETUPTAGS             ; $A0CC
            DispNear vBTDelete,vBTClose             ; $A0CD
            DispFar VBTFLUSH,vBTDelete              ; $A0CE
            DispNear vBTGetRecord,VBTFLUSH          ; $A0CF
            DispNear VBTINSERT,vBTGetRecord         ; $A0D0
            DispFar VBTOPEN,VBTINSERT               ; $A0D1
            DispNear vBTSearch,VBTOPEN              ; $A0D2
            DispNear vBTUpdate,vBTSearch            ; $A0D3
            DispFar vGetNode,vBTUpdate              ; $A0D4
            DispFar vRelNode,vGetNode               ; $A0D5
            DispFar vAllocNode,vRelNode             ; $A0D6
            DispFar vFreeNode,vAllocNode            ; $A0D7
            DispFar vExtBTFile,vFreeNode            ; $A0D8
            DispFar vDeAllocFile,vExtBTFile         ; $A0D9
            DispNear vExtendFile,vDeAllocFile       ; $A0DA
            DispFar vTruncateFile,vExtendFile       ; $A0DB
            DispFar vCMSetUp,vTruncateFile          ; $A0DC
            DispBad                                 ; $A0DD _PPC
            DispFar vDtrmV1,vCMSetUp                ; $A0DE
            DispFar vBlkAlloc,vDtrmV1               ; $A0DF
            DispFar VBLKDEALLOC,vBlkAlloc           ; $A0E0
            DispFar vFileOpen,VBLKDEALLOC           ; $A0E1
            DispFar vPermssnChk,vFileOpen           ; $A0E2
            DispFar vFndFilName,vPermssnChk         ; $A0E3
            DispFar vRfNCall,vFndFilName            ; $A0E4
            DispFar vAdjEOF,vRfNCall                ; $A0E5
            DispAbs vPixel2Char                     ; $A0E6
            DispFar vChar2Pixel,vPixel2Char         ; $A0E7
            DispBad                                 ; $A0E8
            DispAbs vFileClose                      ; $A0E9
            DispFar vFileRead,vFileClose            ; $A0EA
            DispFar vFileWrite,vFileRead            ; $A0EB
            DispBad                                 ; $A0EC
            DispFar VUPDALTMDB,vFileWrite           ; $A0ED
            DispFar vCkExtFS,VUPDALTMDB             ; $A0EE
            DispNear vDtrmV3,vCkExtFS               ; $A0EF
            DispFar vBMChk,vDtrmV3                  ; $A0F0
            DispFar vTstMod,vBMChk                  ; $A0F1
            DispFar VLOCCREC,vTstMod                ; $A0F2
            DispFar vTreeSearch,VLOCCREC            ; $A0F3
            DispFar vMapFBlock,vTreeSearch          ; $A0F4
            DispFar vXFSearch,vMapFBlock            ; $A0F5
            DispFar vReadBM,vXFSearch               ; $A0F6
            DispFar DoEject,vReadBM                 ; $A0F7
            DispFar vSegStack,DoEject               ; $A0F8
            DispAbs vSuperLoad                      ; $A0F9
            DispFar vCmpFrm,vSuperLoad              ; $A0FA
            DispFar vNewMap,vCmpFrm                 ; $A0FB
            DispFar vCheckLoad,vNewMap              ; $A0FC
            DispFar XTrimMeasure,vCheckLoad         ; $A0FD
            DispFar XFINDWORD,XTrimMeasure          ; $A0FE
            DispFar XFINDLINE,XFINDWORD             ; $A0FF
            dc.w    0                               ; End of table
            dc.b    $B0,$50
            REPT    395
            dc.b    'KEBALJWKDMLPATWT'
            dc.b    'OSGSG DEVAJMP>>['
            dc.b    '(c) Copyright Ap'
            dc.b    'ple Computer, In'
            dc.b    'c. 1989-1990][',$11,$54
            dc.b    'ue, Jul 18, 1989'
            dc.b    ']<<HJRBGMSHJMAAG'
            dc.b    'CSLRWHBBMGGDCCHD'
            dc.b    'AFDJWGMRSWCRLESR'
            dc.b    'CSMBP'
            ENDR
            dc.b    'KEBALJWKDMLPATWTOSGSG DEVAJMP>>[(c) Copyright Apple Computer'
            dc.b    ', Inc. 1989-1990]['
            dc.w    $1154

            EVEN
