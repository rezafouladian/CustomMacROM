            include "Include/ROMHeader.s"

            EXPORT  AllocFakeRgns,DSErrorHandler

            IMPORT  CritErr

            SECTION "StartAlert",CODE

AllocFakeRgns:
            lea     ($18,A6),A1
            lea     ($6C,A6),A0
            move.l  A0,(A1)+
            addq.w  #4,A0
            move.l  A0,(A1)+
            lea     Scratch20,A1
            move.l  A1,(A0)
            move.l  A1,-(A0)
OpenClip:
            lea     FakeRgn+10,A0
            lea     GetParam+2+8,A1
            move.l  -(A0),-(A1)
            move.l  -(A0),-(A1)
            move.w  -(A0),-(A1)
            rts
FakeRgn:
            dc.w    $000A,$8001,$8001,$7FFF,$7FFF
ClipBox:
            lea     DSAlertRect+8,A0
            lea     GetParam+2+8,A1
            move.l  -(A0),-(A1)
            move.l  -(A0),-(A1)
            move.l  A1,-(SP)
            bclr    #7,(A1)
            movea.l (A5),A0
            movea.l (A0),A0
            move.l  (8,A0),-(SP)
            _OffsetRect
            rts
DSErrorHandler:
            move    #$2500,SR
            moveq   #0,D6
            move.w  DSErrCode,D6
            move.l  DSAlertTab,D7
            bne.b   .GoAlert
            moveq   #15,D7
            BigJmp  CritErr,A0
.GoAlert:
            move    #$2000,SR
            move.w  CurMap,-(SP)
            move.w  SysMap,CurMap
            lea     (-4,SP),A5
            suba.w  #$15A,SP
            movea.l SP,A6
            pea     (-4,A5)
            move.b  QDExist,D3
            _InitGraf
            move.b  D3,QDExist
            bsr.w   AllocFakeRgns
            move.l  A6,-(SP)
            _InitPort
            move.w  D6,D0
            bmi.b   .SkipDBox
            cmpi.w  #$D,D0
            beq.w   MicroBug
            bsr.w   DrawBox
.SkipDBox:
            tst.b   DSAlertRect
            bpl.b   .IsSysAlert
            move.l  DSCtrAdj,-(SP)
            _MovePortTo
.IsSysAlert:
            bsr.w   ClipBox
            move.w  D6,D0
            bsr.w   FindObject
            bne.b   .GotAlert
            movea.l D7,A0
            addq.w  #6,A0
.GotAlert:
            movea.l A0,A3
            bsr.w   DrawText
            bsr.w   DrawText
            move.w  (A3)+,D0
            beq.b   .NoIcon
            bsr.b   FindObject
            beq.b   .NoIcon
            cmpi.w  #$1E,DSErrCode
            bcs.b   .FatalError
            movea.l A0,A2
            subq.w  #4,SP
            move.w  (-4,A2),-(SP)
            _GetCIcon
            tst.l   (SP)
            beq.b   .NoColor
            move.l  A2,-(SP)
            move.l  (4,SP),-(SP)
            _PlotCIcon
            _DisposCIcon
            bra.b   .NoIcon
.NoColor:
            addq.w  #4,SP
            movea.l A2,A0
.FatalError:
            pea     (8,A0)
            move.l  A0,-(SP)
            pea     (4,SP)
            _PlotIcon
            addq.w  #4,SP
.NoIcon:
            move.w  (A3)+,D0
            beq.b   .NoProc
            bsr.b   FindObject
            beq.b   .NoProc
            jsr     (A0)
.NoProc:
            move.w  (A3)+,D0
            beq.b   .NoSemantics
            tst.l   ResumeProc
            beq.b   .NoRestart
            addq.w  #1,D0
.NoRestart:
            bsr.w   DoButtons
            beq.b   .NoSemantics
            move.l  A0,-(SP)
            bra.w   OpenClip
.NoSemantics:
RTS2SysErr:
            bsr.w   OpenClip
            lea     ($15A,SP),SP
            move.w  (SP)+,CurMap
            moveq   #0,D0
            rts
FindObject:
            movea.l D7,A0
            move.w  (A0)+,D1
            bra.b   .GoFindIt
.NextObject:
            cmp.w   (A0)+,D0
            beq.b   .FoundObj
            adda.w  (A0)+,A0
.GoFindIt:
            dbra    D1,.NextObject
            suba.l  A0,A0
            moveq   #0,D0
            rts
.FoundObj:
            addq.w  #2,A0
            moveq   #-1,D0
            rts
DrawText:
            move.w  (A3)+,D0
            beq.b   .NoText
            bsr.b   FindObject
            beq.b   .NoText
            move.l  (A0)+,D3
            movea.l A0,A2
.ScanForEOL:
            move.b  (A2)+,D0
            beq.b   .DrawTxLine
            cmpi.b  #$2F,D0
            bne.b   .ScanForEOL
.DrawTxLine:
            move.b  D0,-(SP)
            move.l  A2,D0
            sub.l   A0,D0
            subq.w  #1,D0
            move.l  A0,-(SP)
            clr.w   -(SP)
            move.w  D0,-(SP)
            move.l  D3,-(SP)
            _MoveTo
            _DrawText
            addi.l  #$E0000,D3
            movea.l A2,A0
            move.b  (SP)+,D0
            bne.b   .ScanForEOL
.NoText:
            rts
DrawBox:
            move.l  DSDrawProc,D0
            ble.b   .StdProc
            move.l  D0,-(SP)
            bset    #7,DSDrawProc
            rts
.StdProc:
            lea     DSAlertRect,A0
            tst.b   (A0)
            bpl.b   DrawSysAlert
DrawSysErr:
            movem.l D1/A1,-(SP)
            movea.l (A5),A1
            lea     (-$70,A1),A1
            moveq   #$64,D0
            mulu.w  (A1)+,D0
            divu.w  #$216,D0
            move.w  D0,(A0)
            moveq   #-$40,D1
            add.w   D0,D1
            move.w  D1,DSCtrAdj
            addi.w  #$7E,D0
            move.w  D0,(4,A0)
            move.w  (A1),D0
            lsr.w   #1,D0
            subi.w  #$E0,D0
            move.w  D0,(2,A0)
            moveq   #-$20,D1
            add.w   D0,D1
            move.w  D1,($DAA).w
            addi.w  #$1C0,D0
            move.w  D0,(6,A0)
            bsr.b   DrawBox2
            bset    #7,DSAlertRect
            movem.l (SP)+,D1/A1
            rts
DrawSysAlert:
            bsr.b   DrawBox2
            move.l  DSAlertRect,-(SP)
            _MovePortTo
            rts
DrawBox2:
            move.l  A0,-(SP)
            move.l  A0,-(SP)
            move.l  A0,-(SP)
            move.l  A0,-(SP)
            move.l  A0,-(SP)
            _EraseRect
            _FrameRect
            move.l  #$20002,-(SP)
            _PenSize
            move.l  #$30003,-(SP)
            _InsetRect
            _FrameRect
            move.l  #$FFFDFFFD,-(SP)
            _InsetRect
            _PenNormal
NoButtons:
            rts
DoButtons:
            bsr.w   FindObject
            beq.b   NoButtons
            movea.l A0,A2
            move.w  (A0)+,D3
            movea.l A0,A3
.DrawBtnLp:
            move.l  (2,A3),-(SP)
            addi.l  #$E0004,(SP)
            _MoveTo
            move.w  (A3)+,D0
            bsr.w   FindObject
            subq.w  #1,A0
            move.l  A0,-(SP)
            _DrawString
            move.l  A3,-(SP)
            move.l  #$100010,-(SP)
            _FrameRoundRect
            lea     ($A,A3),A3
            subq.w  #1,D3
            bne.b   .DrawBtnLp
            movea.l (A5),A0
            pea     (-$6C,A0)
            _SetCursor
            _ShowCursor
            move    #$2000,SR
            st      CrsrCouple
            clr.b   VBLQueue
.Wait4Click:
            tst.b   MBState
            bne.b   .Wait4Click
            movea.l A2,A3
            move.w  (A3)+,D3
            addq.w  #2,A3
.FindBtnHit:
            bsr.b   myPtInRect
            bne.b   .TrackBtn
            lea     ($C,A3),A3
            subq.w  #1,D3
            bne.b   .FindBtnHit
            bra.b   .Wait4Click
.TrackLoop:
            bsr.b   myPtInRect
            cmp.b   D0,D3
            beq.b   .NoChange
.TrackBtn:
            move.b  D0,D3
            bsr.b   InvertBut
.NoChange:
            tst.b   MBState
            beq.b   .TrackLoop
            tst.b   D3
            beq.b   .Wait4Click
            move.w  (8,A3),D0
            bra.w   FindObject
myPtInRect:
            subq.w  #2,SP
            move.l  Mouse,-(SP)
            pea     (SP)
            _GlobalToLocal
            move.l  A3,-(SP)
            _PtInRect
            move.b  (SP)+,D0
            rts
; InvertBut
; A utility to invert the button whose rectangle is pointed to by A3
InvertBut:
            move.l  A3,-(SP)
            move.l  #$100010,-(SP)
            _InverRoundRect
            rts
MicroBug:
            clr.w   DSErrCode
            lea     DSAlertRect,A0
            bsr.w   DrawSysErr
            move.l  DSCtrAdj,-(SP)
            addi.l  #$460026,(SP)
            _MovePortTo
            bsr.w   ClipBox
            suba.w  #$10,SP
            clr.w   D7
            clr.l   MBdotAddr
            clr.l   MBlocAddr
CmdReset:
            move.l  #$1101B0,-(SP)
            clr.l   -(SP)
            bsr.w   MBDoErase
            lea     ($CA6).w,A6
            moveq   #0,D6
.L0:
            move.w  #$20,-(A6)
            addq.w  #2,D6
            cmpi.w  #$22,D6
            bne.b   .L0
            movea.l A6,A4
            move.l  #$F000A,-(SP)
            _MoveTo
            moveq   #$3E,D0
            move.w  D0,-(SP)
            _DrawChar
CmdLoop:
            movea.l SP,A0
            moveq   #8,D0
            _GetOSEvent
            bne.b   CmdLoop
            bclr    #7,NMIFlag
            moveq   #$7F,D0
            and.b   (5,SP),D0
            cmpi.b  #$61,D0
            blt.b   .L0
            bclr    #5,D0
.L0:
            cmpi.b  #$D,D0
            beq.b   GotCommand
            cmpi.b  #8,D0
            bne.b   RegChar
            cmpa.l  A6,A4
            beq.b   CmdLoop
            addq.w  #1,D6
            subq.w  #1,A6
            subq.w  #4,SP
            move.l  SP,-(SP)
            _GetPen
            move.l  (SP),-(SP)
            subq.w  #2,SP
            move.b  (A6),D0
            move.w  D0,-(SP)
            _CharWidth
            move.w  (SP)+,D3
            sub.w   D3,(2,SP)
            clr.w   (SP)
            move.l  SP,-(SP)
            clr.w   -(SP)
            move.w  #2,-(SP)
            _OffsetRect
            bsr.w   MBDoErase
            move.w  D3,-(SP)
            neg.w   (SP)
            clr.w   -(SP)
            _Move
            bra.b   CmdLoop
RegChar:
            tst.w   D6
            beq.b   CmdLoop
            subq.w  #1,D6
            move.b  D0,(A6)+
            move.w  D0,-(SP)
            _DrawChar
            bra.b   CmdLoop
GotCommand:
            cmpa.l  A4,A6
            bne.b   .L0
            move.w  D7,(A6)+
.L0:
            move.w  (A4)+,D7
            lea     MBcmds,A0
.L1:
            move.w  (A0)+,D0
            bmi.b   .L11
            move.w  (A0)+,D2
            cmpi.b  #$40,D0
            bne.b   .L10
            move.b  D7,D0
            cmpi.b  #$30,D0
            bmi.b   .L1
            cmpi.b  #$37,D0
            bgt.b   .L1
.L10:
            cmp.w   D0,D7
            bne.b   .L1
            lea     MBcmds,A0
            jsr     (0,A0,D2.w)
.L11:
            bra.w   CmdReset
MBcmds:
            dc.w    'G ',GCmd-MBcmds
            dc.w    'DM',DMCmd-MBcmds
            dc.w    'SM',SMCmd-MBcmds
            dc.w    'TD',TDCmd-MBcmds
            dc.w    'D@',DCmd-MBcmds
            dc.w    'A@',ACmd-MBcmds
            dc.w    'PC',PCCmd-MBcmds
            dc.w    'SR',SRCmd-MBcmds
            dc.w    -1
GCmd:
            bsr.w   ReadToken
            beq.b   GotResume
            move.l  D0,-(SP)
            bsr.w   OpenClip
            rts
GotResume:
            lea     ($14,SP),SP
            clr.b   DSWndUpdate
            bra.w   RTS2SysErr
MBDoErase:
            movea.l (SP)+,A2
            move.l  SP,-(SP)
            _EraseRect
            addq.w  #8,SP
            jmp     (A2)
DMCmd:
            move.l  #$7001B0,-(SP)
            clr.l   -(SP)
            bsr.b   MBDoErase
            bsr.w   ReadXToken
            bclr    #0,D0
            movea.l D0,A3
            move.l  D0,MBdotAddr
            moveq   #5,D6
            moveq   #$F,D5
.L1:
            addi.w  #$F,D5
            move.w  #$A,-(SP)
            move.w  D5,-(SP)
            _MoveTo
            move.l  A3,D0
            bsr.b   Print6Hx
            moveq   #7,D4
            moveq   #$23,D3
.L2:
            addi.w  #$2D,D3
            move.w  D3,-(SP)
            move.w  D5,-(SP)
            _MoveTo
            move.w  (A3)+,D0
            bsr.b   Print4Hx
            dbra    D4,.L2
            dbra    D6,.L1
            move.l  A3,MBlocAddr
            rts
Print6Hx:
            swap    D0
            bsr.b   Print2Hx
            swap    D0
Print4Hx:
            move.w  D0,-(SP)
            roxr.w  #8,D0
            bsr.b   Print2Hx
            move.w  (SP)+,D0
Print2Hx:
            move.w  D0,-(SP)
            ror.w   #4,D0
            bsr.b   PUTHEX
            move.w  (SP)+,D0
PUTHEX:
            andi.b  #$F,D0
            ori.b   #'0',D0
            cmpi.b  #'9',D0
            ble.b   .L0
            addq.w  #7,D0
.L0:
            move.l  D0,-(SP)
            move.w  D0,-(SP)
            _DrawChar
            move.l  (SP)+,D0
            rts
SMCmd:
            bsr.w   ReadXToken
            movea.l D0,A1
            lea     MBdotAddr,A0
            move.l  D0,(A0)+
            move.l  D0,(A0)+
            move.w  #$444D,D7
.L1:
            bsr.w   ReadToken
            beq.w   DMCmd
            movea.l A1,A2
.L2:
            move.b  D0,(-1,A2,D1.w)
            asr.l   #8,D0
            addq.l  #1,A1
            subq.l  #1,D1
            bne.b   .L2
            bra.b   .L1
TDCmd:
            move.l  #$C30,MBlocAddr
            bra.w   DMCmd
DCmd:
            lea     seVars,A3
            bra.b   SetR
ACmd:
            lea     ($C50).w,A3
            bra.b   SetR
PCCmd:
            lea     sePC,A3
            bra.b   SetR0
SRCmd:
            lea     seSR,A3
            bsr.b   ReadToken
            beq.b   SetR2
            move.w  D0,(A3)
            rts
SetR:
            bsr.b   GetHex
            lsl.l   #2,D0
            adda.l  D0,A3
SetR0:
            bsr.b   ReadToken
            beq.b   SetR1
            move.l  D0,(A3)
            rts
SetR2:
            moveq   #-1,D6
SetR1:
            move.l  #$7001B0,-(SP)
            clr.l   -(SP)
            bsr.w   MBDoErase
            move.l  #$300010,-(SP)
            _MoveTo
            move.w  (A3)+,D0
            tst.w   D6
            bne.b   .L4
            bsr.w   Print4Hx
            move.w  (A3)+,D0
.L4:
            bra.w   Print4Hx
GetHex:
            andi.l  #$FF,D0
            cmpi.b  #$39,D0
            ble.b   .L1
            subq.b  #7,D0
.L1:
            andi.b  #$F,D0
            rts
ReadXToken:
            bsr.b   ReadToken
            bne.b   .L1
            move.l  MBlocAddr,D0
.L1:
            rts
ReadToken:
            moveq   #0,D4
            moveq   #0,D6
ReadMore:
            moveq   #0,D5
            clr.w   ($CA6).w
            moveq   #0,D3
            moveq   #0,D0
            moveq   #0,D1
blanks:
            cmpa.l  A6,A4
            bge.w   ReadExit
leadSP:
            move.b  (A4)+,D0
            cmpi.b  #$20,D0
            ble.b   blanks
            cmpi.b  #$40,D0
            bne.b   .L4
            addq.w  #1,D3
            bra.b   leadSP
.L4:
            cmpi.b  #$2B,D0
            beq.b   leadSP
            cmpi.b  #$2D,D0
            bne.b   getBase
            not.b   ($CA6).w
            bra.b   leadSP
getBase:
            cmpi.b  #$24,D0
            bne.w   getLabel
            moveq   #0,D0
            move.b  (A4)+,D0
getNumber:
            bsr.b   GetHex
            addq.w  #1,D5
            lsl.l   #4,D1
            add.l   D0,D1
            cmpa.l  A6,A4
            bge.b   ReadExit
            move.b  (A4)+,D0
            cmpi.b  #$30,D0
            bge.b   getNumber
ReadExit:
            tst.w   D3
            beq.b   .L9
            moveq   #8,D5
.L8:
            bclr    #0,D1
            movea.l D1,A0
            move.l  (A0),D1
            subq.w  #1,D3
            bne.b   .L8
.L9:
            tst.b   ($CA6).w
            beq.b   .L10
            neg.l   D1
.L10:
            add.l   D1,D4
            addq.w  #1,D5
            lsr.w   #1,D5
            cmpi.w  #4,D5
            ble.b   .L11
            moveq   #4,D5
.L11:
            cmp.w   D6,D5
            ble.b   .L12
            move.w  D5,D6
.L12:
            cmpi.b  #$2B,D0
            beq.b   .L13
            cmpi.b  #$2D,D0
            bne.b   .L14
.L13:
            move.b  D0,-(A4)
            bra.w   ReadMore
.L14:
            move.l  D4,D0
            move.l  D6,D1
            rts
getLabel:
            cmpi.b  #$2E,D0
            bne.b   notDot
            move.l  MBdotAddr,D1
            moveq   #1,D2
goLabel:
            moveq   #8,D5
cleanExit:
            move.b  (A4)+,D0
            subq.w  #1,D2
            bne.b   cleanExit
            bra.b   ReadExit
notDot:
            move.w  D0,D2
            lsl.w   #8,D2
            move.b  (A4),D2
            cmpi.w  #$5043,D2
            bne.b   notPC
            move.l  sePC,D1
go2Label:
            moveq   #2,D2
            bra.b   goLabel
notPC:
            cmpi.b  #$52,D0
            bne.w   getNumber
            cmpi.b  #$41,D2
            bne.b   notAs
            lea     ($C50).w,A0
doReg:
            moveq   #0,D2
            move.b  (1,A4),D2
            subi.w  #$30,D2
            bmi.w   getNumber
            cmpi.w  #7,D2
            bgt.w   getNumber
            lsl.w   #2,D2
            move.l  (0,A0,D2.w),D1
            moveq   #3,D2
            bra.b   goLabel
notAs:
            cmpi.b  #$44,D2
            bne.w   getNumber
            lea     seVars,A0
            bra.b   doReg
            ds.b    4

            EVEN
