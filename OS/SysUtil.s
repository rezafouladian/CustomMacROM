            include "Include/ROMHeader.s"

            EXPORT  CmpString,Delay,INITRELIABILITY,InitUtil,LWRSTRING,PRAMInit
            EXPORT  PRAMInitTbl,ReadDateTime,ReadParam,READPRAMPATCHRTN,RelStringTrap,SetDateTimeTrap
            EXPORT  SYSENVIRONS,SYSUTIL,uprstring,WPOFF,WPON,WriteParam
            EXPORT  WRITEPRAMPATCHRTN,WriteTimePatchRtn

            IMPORT  ClkRW,ReadPRamPatch,ReadTimePatch,WritePRamPatch,WRITETIMEPATCH

            SECTION "SysUtil",CODE

SYSUTIL:
ASYNCPATCH:
            rts
ReadParam:
            lea     SPValid,A1
            bsr.b   XferPRam
            moveq   #0,D0
            rts
XferPRam:
            moveq   #$13,D2
.L1:
            lsr.l   #1,D0
            bcc.b   .L2
            move.b  (A1),(A0)+
.L2:
            addq.l  #1,A1
            dbra    D2,.L1
            rts
WriteParam:
            bsr.w   WritePram
            lea     Scratch20,A1
            bsr.w   ReadPram
            lea     SPValid,A0
            moveq   #-$57,D0
            moveq   #4,D2
.L1:
            cmpm.l  (A0)+,(A1)+
            bne.b   .L2
            dbra    D2,.L1
            moveq   #0,D0
.L2:
            rts
ReadDateTime:
            bsr.w   ReadTime
            move.l  TimeLM,(A0)
            rts
SetDateTimeTrap:
            move.l  D0,TimeLM
            bra.w   WriteTime
Delay:
            move    #$2000,SR
            move.l  Ticks,D0
            add.l   A0,D0
.L1:
            cmp.l   Ticks,D0
            bgt.b   .L1
            rts
LWRSTRING:
            move.l  A2,-(SP)
            movem.l D0-D1/A0,-(SP)
            clr.l   -(SP)
            move.w  #2,-(SP)
            move.w  #6,-(SP)
            _Pack6
            movea.l (SP)+,A2
            movem.l (SP)+,D0-D1/A0
            move.l  A2,D2
            beq.b   .L4
            movea.l (A2),A2
            btst    #0,(9,A2)
            beq.b   .L4
            movea.l A2,A1
            moveq   #0,D2
            move.w  ($E,A2),D2
            adda.l  D2,A1
            lsr.w   #8,D1
            andi.w  #6,D1
            move.w  sub_4080C100(PC,D1.w),D1
            move.w  (0,A2,D1.w),D2
            adda.l  D2,A2
            moveq   #0,D1
            bra.b   .L2
.L1:
            move.b  (A0),D1
            move.b  (0,A1,D1.w),D1
            move.b  (0,A2,D1.w),D1
            add.b   D1,(A0)+
.L2:
            dbra    D0,.L1
            moveq   #0,D0
.L3:
            movea.l (SP)+,A2
            rts
.L4:
            move.w  #$FF40,D0
            bra.b   .L3
sub_4080C100:
            ori.b   #$1A,(A2)
            ori.b   #$14,(A0)
uprstring:
            bsr.w   EntString
            bra.b   .L2
.L1:
            move.b  (A0),D2
            bsr.b   Canonizer
            move.b  D2,(A0)+
.L2:
            dbra    D0,.L1
            moveq   #0,D0
            bra.w   ExtString
CmpString:
            move.w  D0,D2
            swap    D0
            cmp.w   D0,D2
            bne.b   CSQuickNE
            swap    D0
            bsr.b   RelStringTrap
            bpl.b   .L1
            neg.l   D0
.L1:
            rts
CSQuickNE:
            moveq   #1,D0
            rts
RelStringTrap:
            bsr.b   EntString
            moveq   #0,D4
            move.w  D0,D2
            swap    D0
            cmp.w   D0,D2
            beq.b   ICLoopEntry
            bhi.b   .L1
            moveq   #1,D4
            move.w  D2,D0
            cmp.w   D4,D4
            bra.b   ICLoopEntry
.L1:
            moveq   #-1,D4
            cmp.w   D4,D4
            bra.b   ICLoopEntry
ICLoopTop:
            moveq   #0,D2
            move.b  (A0)+,D2
            bsr.b   Canonizer
            add.w   D2,D2
            move.w  (0,A3,D2.w),D3
            moveq   #0,D2
            move.b  (A1)+,D2
            bsr.b   Canonizer
            add.w   D2,D2
            cmp.w   (0,A3,D2.w),D3
ICLoopEntry:
            dbne    D0,ICLoopTop
            beq.b   ICEqual
            bhi.b   ICHigh
            moveq   #-1,D0
            bra.b   ICExit
ICHigh:
            moveq   #1,D4
ICEqual:
            move.l  D4,D0
ICExit:
            bra.b   ExtString
Canonizer:
            tst.w   D1
            bpl.b   dontStrip
            move.b  StripTab(PC,D2.w),D2
dontStrip:
            tst.b   D1
            bmi.b   dontUpper
            move.b  (0,A2,D2.w),D2
dontUpper:
            rts
EntString:
            move.l  (SP)+,D2
            movem.l D2-D4/A2-A3,-(SP)
            lea     UpperTab,A2
            lea     CmpTab,A3
            rol.w   #6,D1
            ror.b   #1,D1
            moveq   #0,D2
            rts
ExtString:
            movem.l (SP)+,D3-D4/A2-A3
            rts
StripTab:
            dc.w    $0001,$0203,$0405,$0607,$0809,$0A0B,$0C0D,$0E0F
            dc.w    $1011,$1213,$1415,$1617,$1819,$1A1B,$1C1D,$1E1F
            dc.b    $20,$21,$22
            dc.b    '#$%&',$27,'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ['
            dc.w    $5C5D
            dc.b    '^_`abcdefghijklmnopqrstuvwxyz'
            dc.b    $7B,$7C,$7D,$7E,$7F
            dc.b    'AACENOUaaaaaaceeeeiiiinooooouuuu'
            dc.w    $A0A1,$A2A3,$A4A5,$A6A7,$A8A9,$AAAB,$ACAD,$AE4F
            dc.w    $B0B1,$B2B3,$B4B5,$B6B7,$B8B9,$BA61,$6FBD,$BE6F
            dc.w    $C0C1,$C2C3,$C4C5,$C6C7,$C8C9,$CA41,$414F,$CECF
            dc.w    $D0D1,$D2D3,$D4D5,$D6D7,$79D9,$DADB,$DCDD,$DEDF
            dc.w    $E0E1,$E2E3,$E4E5,$E6E7,$E8E9,$EAEB,$ECED,$EEEF
            dc.w    $F0F1,$F2F3,$F4F5,$F6F7,$F8F9,$FAFB,$FCFD,$FEFF
UpperTab:
            dc.w    $0001,$0203,$0405,$0607,$0809,$0A0B,$0C0D,$0E0F
            dc.w    $1011,$1213,$1415,$1617,$1819,$1A1B,$1C1D,$1E1F
            dc.b    $20,$21,$22
            dc.b    '#$%&',$27,'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ['
            dc.w    $5C5D
            dc.b    '^_aABCDEFGHIJKLMNOPQRSTUVWXYZ'
            dc.b    $7B,$7C,$7D,$7E,$7F,$80,$81,$82,$83,$84,$85,$86,$87,$CB,$89,$80
            dc.b    $CC,$81,$82,$83,$8F,$90,$91,$92,$93,$94,$95,$84,$97,$98,$99,$85
            dc.b    $CD,$9C,$9D,$9E,$86,$A0,$A1,$A2,$A3,$A4,$A5,$A6,$A7,$A8,$A9,$AA
            dc.b    $AB,$AC,$AD,$AE,$AF,$B0,$B1,$B2,$B3,$B4,$B5,$B6,$B7,$B8,$B9,$BA
            dc.b    $BB,$BC,$BD,$AE,$AF,$C0,$C1,$C2,$C3,$C4,$C5,$C6,$C7,$C8,$C9,$CA
            dc.b    $CB,$CC,$CD,$CE,$CE,$D0,$D1,$D2,$D3,$D4,$D5,$D6,$D7,$D8,$D9,$DA
            dc.b    $DB,$DC,$DD,$DE,$DF,$E0,$E1,$E2,$E3,$E4,$E5,$E6,$E7,$E8,$E9,$EA
            dc.b    $EB,$EC,$ED,$EE,$EF,$F0,$F1,$F2,$F3,$F4,$F5,$F6,$F7,$F8,$F9,$FA
            dc.b    $FB,$FC,$FD,$FE,$FF
CmpTab:
            dc.w    0,$0100,$0200,$0300,$0400,$0500,$0600,$0700
            dc.w    $0800,$0900,$0A00,$0B00,$0C00,$0D00,$0E00,$0F00
            dc.w    $1000,$1100,$1200,$1300,$1400,$1500,$1600,$1700
            dc.w    $1800,$1900,$1A00,$1B00,$1C00,$1D00,$1E00,$1F00
            dc.w    $2000,$2100,$2200,$2300,$2400,$2500,$2600,$2700
            dc.w    $2800,$2900,$2A00,$2B00,$2C00,$2D00,$2E00,$2F00
            dc.w    $3000,$3100,$3200,$3300,$3400,$3500,$3600,$3700
            dc.w    $3800,$3900,$3A00,$3B00,$3C00,$3D00,$3E00,$3F00
            dc.w    $4000,$4100,$4200,$4300,$4400,$4500,$4600,$4700
            dc.w    $4800,$4900,$4A00,$4B00,$4C00,$4D00,$4E00,$4F00
            dc.w    $5000,$5100,$5200,$5300,$5400,$5500,$5600,$5700
            dc.w    $5800,$5900,$5A00,$5B00,$5C00,$5D00,$5E00,$5F00
            dc.w    $6100,$4180,$4280,$4380,$4480,$4580,$4680,$4780
            dc.w    $4880,$4980,$4A80,$4B80,$4C80,$4D80,$4E80,$4F80
            dc.w    $5080,$5180,$5280,$5380,$5480,$5580,$5680,$5780
            dc.w    $5880,$5980,$5A80,$7B00,$7C00,$7D00,$7E00,$7F00
            dc.w    $4108,$410C,$4310,$4502,$4E0A,$4F08,$5508,$4182
            dc.w    $4184,$4186,$4188,$418A,$418C,$4390,$4582,$4584
            dc.w    $4586,$4588,$4982,$4984,$4986,$4988,$4E8A,$4F82
            dc.w    $4F84,$4F86,$4F88,$4F8A,$5582,$5584,$5586,$5588
            dc.w    $A000,$A100,$A200,$A300,$A400,$A500,$A600,$5382
            dc.w    $A800,$A900,$AA00,$AB00,$AC00,$AD00,$4114,$4F0E
            dc.w    $B000,$B100,$B200,$B300,$B400,$B500,$B600,$B700
            dc.w    $B800,$B900,$BA00,$4192,$4F92,$BD00,$4194,$4F8E
            dc.w    $C000,$C100,$C200,$C300,$C400,$C500,$C600,$2206
            dc.w    $2208,$C900,$2000,$4104,$410A,$4F0A,$4F14,$4F94
            dc.w    $D000,$D100,$2202,$2204,$2702,$2704,$D600,$D700
            dc.w    $5988,$D900,$DA00,$DB00,$DC00,$DD00,$DE00,$DF00
            dc.w    $E000,$E100,$E200,$E300,$E400,$E500,$E600,$E700
            dc.w    $E800,$E900,$EA00,$EB00,$EC00,$ED00,$EE00,$EF00
            dc.w    $F000,$F100,$F200,$F300,$F400,$F500,$F600,$F700
            dc.w    $F800,$F900,$FA00,$FB00,$FC00,$FD00,$FE00,$FF00
; ReadPram
ReadPram:
            BigJmp  ReadPRamPatch,A0
READPRAMPATCHRTN:
            moveq   #-$5F,D1
            moveq   #3,D5
            bsr.b   sub_4080C5BE
            movem.l (SP)+,D1-D2/D5/A0-A1
            rts
sub_4080C5BE:
            jsr     (ClkRW.w,PC)
            move.b  D2,(A1)+
            addq.b  #4,D1
            dbra    D5,sub_4080C5BE
            rts
; InitUtil
InitUtil:
            clr.w   -(SP)
            bsr.w   WPOFF
            moveq   #$31,D1
            clr.b   D2
            jsr     (ClkRW.w,PC)
            bsr.w   WPON
            lea     SPValid,A1
            bsr.b   ReadPram
            bsr.w   ReadTime
            moveq   #0,D0
            cmpi.b  #$A8,(A1)
            beq.b   .L2
            move.w  #$FFA8,(SP)
            moveq   #4,D1
            lea     PRAMInit,A0
.L1:
            move.l  (A0)+,(A1)+
            dbra    D1,.L1
            bsr.w   WritePram
.L2:
            btst    #6,HWCfgFlags
            beq.b   .L5
            lea     Scratch20,A0
            move.l  #$4000C,D0
            _ReadXPRam
            move.l  #'NuMc',D1
            cmp.l   (A0),D1
            beq.b   .L5
            move.w  #$FFA8,(SP)
            move.l  D1,(A0)
            move.l  #$4000C,D0
            _WriteXPRam
            moveq   #$20,D1
.L3:
            moveq   #4,D0
            swap    D0
            move.w  D1,D0
            clr.l   (A0)
            _WriteXPRam
            addq.b  #4,D1
            cmpi.b  #8,D1
            bne.b   .L3
            movem.l A1,-(SP)
            lea     PRAMInitTbl,A0
            lea     Scratch20,A1
            moveq   #4,D0
.L4:
            move.l  (A0)+,(A1)+
            dbra    D0,.L4
            move.l  #$140076,D0
            lea     Scratch20,A0
            _WriteXPRam
            movem.l (SP)+,A1
.L5:
            move.w  (SP)+,D0
            bne.b   .L6
            bset    #5,HWCfgFlags
.L6:
            ext.l   D0
            rts
PRAMInit:
            dc.b    $A8,
            dc.b    0
            dc.b    0
            dc.w    $CC0A,$CC0A
            ds.b    5
            dc.b    $02,$63,$00,$13,$88,$00,$4C
PRAMInitTbl:
            dc.w    $0001,$FFFF,$FFDF
            ds.b    14
ReadTime:
            movem.l D1-D2/D4-D5/A0/A2-A3,-(SP)
            BigJmp  ReadTimePatch,A0                ; Overpatched: rest of the read loop zeroed
            ds.b    24
            ; Unreachable tail of the original ReadTime (same as ReadTimePatch .L4)
            moveq   #-$55,D0
            move.l  Scratch20,TimeLM
.NoEntry:
            movem.l (SP)+,D1-D2/D4-D5/A0/A2-A3
            tst.w   D0
            rts
WriteTime:
            BigJmp  WRITETIMEPATCH,A0
WriteTimePatchRtn:
            moveq   #1,D5
.L1:
            move.l  D3,D2
            moveq   #1,D1
            moveq   #3,D4
.L2:
            jsr     (ClkRW.w,PC)
            addq.b  #4,D1
            lsr.l   #8,D2
            dbra    D4,.L2
            bsr.b   ReadTime
            bne.b   .L3
            cmp.l   TimeLM,D3
            dbeq    D5,.L1
            beq.b   .L3
            moveq   #-$56,D0
.L3:
            bsr.b   WPON
            movem.l (SP)+,D1-D5/A0
            rts
WPON:
            moveq   #$35,D1
            moveq   #-$2B,D2
            jmp     (ClkRW.w,PC)
WPOFF:
            moveq   #$35,D1
            moveq   #$55,D2
            jmp     (ClkRW.w,PC)
WritePram:
            BigJmp  WritePRamPatch,A1
WRITEPRAMPATCHRTN:
            move.b  #$41,D1
            moveq   #$F,D3
            bsr.b   sub_4080C73C
            move.b  #$21,D1
            moveq   #3,D3
            bsr.b   sub_4080C73C
            bsr.b   WPON
            movem.l (SP)+,D1-D3/A1-A2
            rts
sub_4080C73C:
            move.b  (A2)+,D2
            jsr     (ClkRW.w,PC)
            addq.b  #4,D1
            dbra    D3,sub_4080C73C
            rts
            ds.b    6
SYSENVIRONS:
            movem.l D2/A0,-(SP)
            movea.l A0,A2
            move.w  #$EA83,D2
            tst.w   D0
            ble.w   .L14
            clr.w   D2
            move.w  D0,D1
            cmpi.w  #2,D0
            ble.b   .L1
            move.w  #$EA82,D2
            move.w  #$10,D0
            bra.b   .L2
.L1:
            move.w  #$10,D0
.L2:
            asr.w   #1,D0
            subq.w  #1,D0
.L3:
            clr.w   (A0)+
            dbra    D0,.L3
            move.w  D1,(A2)
            move.l  #'mach',D0
            _Gestalt
            tst.w   D0
            beq.b   .L4
            suba.l  A0,A0
            bra.b   .L5
.L4:
            subq.w  #2,A0
.L5:
            move.w  A0,(2,A2)
            move.l  #'sysv',D0
            _Gestalt
            tst.w   D0
            beq.b   .L6
            suba.l  A0,A0
.L6:
            move.w  A0,(4,A2)
            move.l  #'proc',D0
            _Gestalt
            tst.w   D0
            beq.b   .L7
            suba.l  A0,A0
.L7:
            move.w  A0,(6,A2)
            move.l  #'fpu ',D0
            _Gestalt
            tst.w   D0
            bne.b   .L8
            move.l  A0,D0
            beq.b   .L8
            move.b  #1,(8,A2)
.L8:
            move.l  #$71642020,D0
            _Gestalt
            tst.w   D0
            bne.b   .L9
            move.l  A0,D0
            beq.b   .L9
            move.b  #1,(9,A2)
.L9:
            move.l  #'kbd ',D0
            _Gestalt
            tst.w   D0
            beq.b   .L10
            suba.l  A0,A0
.L10:
            move.w  A0,($A,A2)
            move.l  #'atlk',D0
            _Gestalt
            tst.w   D0
            beq.b   .L11
            suba.l  A0,A0
.L11:
            move.w  A0,($C,A2)
            moveq   #0,D0
            move.w  #$3C,D1
.L12:
            clr.w   -(SP)
            dbra    D1,.L12
            movea.l SP,A0
            move.w  SysMap,($18,A0)
            moveq   #8,D0
            _HFSDispatch
            bne.b   .L13
            move.w  ($34,A0),($16,A0)
            _HGetVInfo
            bne.b   .L13
            move.l  ($5A,A0),($30,A0)
            move.l  #'ERIK',($1C,A0)
            moveq   #1,D0
            _HFSDispatch
            bne.b   .L13
            move.w  ($16,A0),($E,A2)
.L13:
            lea     ($7A,SP),SP
.L14:
            move.w  D2,D0
            movem.l (SP)+,D2/A0
            rts
            ds.b    8
INITRELIABILITY:
            subq.w  #4,SP
            move.l  TimeLM,D1
            subi.l  #$9FE31A80,D1
            bcs.b   .L1
            movea.l SP,A0
            move.l  #$400B8,D0
            _ReadXPRam
            move.l  (SP),D0
            andi.l  #$7FF80000,D0
            bne.b   .L1
            lsr.l   #8,D1
            divu.w  #$2A3,D1
            moveq   #$13,D0
            lsl.l   D0,D1
            andi.l  #$7FF80000,D1
            andi.l  #$8007FFFF,(SP)
            or.l    D1,(SP)
            move.l  #$400B8,D0
            _WriteXPRam
.L1:
            addq.w  #4,SP
            moveq   #$18,D0
            move.b  D0,D1
            _NewPtrSysClear
            bne.b   .L2
            movea.l ExpandMem,A1
            move.l  A0,($84,A1)
            move.b  D1,(1,A0)
            move.b  #1,(A0)
            bclr    #7,UnSwitchedFlags
            lea     (2,A0),A0
            lea     RELTIMETASK,A1
            move.l  A1,(6,A0)
            _InsXTime
            move.l  #$493E0,D0
            clr.l   ($E,A0)
            _PrimeTime
.L2:
            rts
            dc.w    0
RELTIMETASK:
            subq.w  #4,SP
            movea.l SP,A0
            move.l  #$400B8,D0
            _ReadXPRam
            move.l  (SP),D0
            move.l  D0,D1
            andi.l  #$7FFFF,D0
            addq.l  #1,D0
            andi.l  #$7FFFF,D0
            andi.l  #$FFF80000,D1
            or.l    D0,D1
            move.l  D1,(A0)
            move.l  #$400B8,D0
            _WriteXPRam
            addq.w  #4,SP
            movea.l A1,A0
            move.l  #$493E0,D0
            _PrimeTime
            rts
            dc.w    0

            EVEN
