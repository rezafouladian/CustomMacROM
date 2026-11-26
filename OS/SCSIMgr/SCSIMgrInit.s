            include "Include/ROMHeader.s"

            EXPORT  INITSCSIDONE,InitSCSIMgr,SCSIINTHNDRESUME

            IMPORT  FASTREADOSS,FASTWRITEOSS,INITSCSIMGRPATCH1,INITSCSIMGRPATCH2,INSTALLSCSIINTHND96,PFastReadOSS
            IMPORT  PFASTWRITEOSS,SCSIDT,SCSIIntHnd,SCSIMgr,TIMETASK,VFASTREADOSS
            IMPORT  VFASTWRITEOSS

            SECTION "SCSIMgrInit",CODE

SCSIInit:
InitSCSIMgr:
            movem.l D0-D7/A0-A5,-(SP)
            moveq   #0,D7
            move.l  #$404,D0
            _NewPtrSysClear
            bne.w   INITSCSIDONE
            move.l  A0,SCSIGlobals
            movea.l A0,A4
            bsr.l   INITSCSIMGRPATCH1
            nop
            btst    #4,($67,A4)
            beq.b   .DMAdone
            movea.l SCSIBase,A3
            move.l  #2,($80,A3)
.DMAdone:
            moveq   #$D,D1
            lea     (SCSIMgr.w,PC),A1
            move.l  A1,D0
            lea     OffsetTbl,A1
            movea.l A4,A0
.MakeJmpTbl:
            moveq   #0,D2
            move.w  (A1)+,D2
            add.l   D0,D2
            move.l  D2,(A0)+
            dbra    D1,.MakeJmpTbl
            lea     ($40,A4),A0
            move.l  SCSIBase,(A0)+
            move.l  SCSIDMA,(A0)+
            move.l  SCSIHsk,(A0)+
            clr.w   (A0)+
            moveq   #-1,D0
            move.l  D0,($5C,A4)
            subq.l  #2,SP
            movea.l SP,A0
            move.l  #$20002,D0
            _ReadXPRam
            move.w  (SP),D0
            andi.w  #$7878,D0
            cmpi.w  #$4848,D0
            beq.b   .L3
            move.w  #$4F48,(SP)
            movea.l SP,A0
            move.l  #$20002,D0
            _WriteXPRam
.L3:
            move.w  (SP),D0
            andi.w  #$707,D0
            move.b  D0,SCSIPoll
            lsr.w   #8,D0
            moveq   #1,D1
            lsl.b   D0,D1
            move.b  D1,($60,A4)
            move.b  D1,SCSIDrvrs
            btst    #4,($67,A4)
            beq.b   .noDCTRL
            andi.l  #7,D0
            moveq   #9,D1
            lsl.l   D1,D0
            ori.l   #$1002,D0
            move.l  D0,($6C,A4)
.noDCTRL:
            move.w  #250,($62,A4)
            move.b  #1,($7E,A4)
            move.l  #4,($80,A4)
            btst    #4,($67,A4)
            beq.b   .initPhaseTable
            move.l  #$19999999,($80,A4)
.initPhaseTable:
            moveq   #$5F,D1
            lea     (SCSIMgr.w,PC),A1
            move.l  A1,D0
            lea     OffsetTbl2,A1
            lea     ($84,A4),A0
.MakeJmpTbl2:
            moveq   #0,D2
            move.w  (A1)+,D2
            beq.b   .zero
            add.l   D0,D2
            move.l  D2,(A0)+
            bra.b   .loop
.zero:
            move.l  D7,(A0)+
.loop:
            dbra    D1,.MakeJmpTbl2
            moveq   #$11,D1
            lea     msgTbl,A1
            lea     ($204,A4),A0
.makeMsgTbl:
            move.l  (A1)+,(A0)+
            dbra    D1,.makeMsgTbl
            lea     ($24C,A4),A1
            move.w  #7,(4,A1)
            lea     (SCSIDT.w,PC),A0
            move.l  A0,(8,A1)
            lea     ($260,A4),A0
            lea     (TIMETASK.w,PC),A1
            move.l  A1,(6,A0)
            _InsTime
            move.w  #$300,($26E,A4)
            lea     ($274,A4),A1
            moveq   #1,D0
            move.l  D0,(4,A1)
            move.l  D0,(8,A1)
            lea     ($10,A1),A1
            moveq   #-1,D0
            move.l  D0,(A1)
            move.l  D0,(8,A1)
            lea     ($2A4,A4),A1
            st      ($C,A1)
            lea     ($2E4,A4),A0
            move.l  A0,(4,A1)
            lea     ($344,A4),A1
            move.l  A1,($38,A4)
            move.l  A1,($3C,A4)
            move.l  A1,D0
            moveq   #$30,D1
            add.l   D1,D0
            move.l  D0,(A1)
            movea.l D0,A1
            add.l   D1,D0
            move.l  D0,(A1)
            bsr.l   INITSCSIMGRPATCH2
            btst    #4,($67,A4)
            beq.b   .L10
            btst    #1,($67,A4)
            bra.b   .L10
            lea     (VFASTREADOSS.w,PC),A0
            move.l  A0,($AC,A4)
            lea     (VFASTWRITEOSS.w,PC),A0
            move.l  A0,($B0,A4)
            lea     (PFastReadOSS.w,PC),A0
            move.l  A0,($BC,A4)
            lea     (PFASTWRITEOSS.w,PC),A0
            move.l  A0,($C0,A4)
            lea     (FASTREADOSS.w,PC),A0
            move.l  A0,($CC,A4)
            lea     (FASTWRITEOSS.w,PC),A0
            move.l  A0,($D0,A4)
.L10:
            btst    #1,($67,A4)
            bne.b   .L11
            btst    #2,($67,A4)
            beq.b   .L12
.L11:
            lea     (SCSIIntHnd.w,PC),A1
            move.l  A1,($D7C).w
.L12:
            btst    #3,($67,A4)
            beq.b   SCSIINTHNDRESUME.L2
            lea     (SCSIIntHnd.w,PC),A1
            bra.l   INSTALLSCSIINTHND96
SCSIINTHNDRESUME:
            beq.b   .L1
            move.l  A1,($D7C).w
            bra.b   .L2
.L1:
            move.l  A1,($D7C).w
.L2:
            btst    #$F,(SP)
            bne.b   .L3
            clr.w   -(SP)
            _SCSIDispatch
.L3:
            addq.l  #2,SP
INITSCSIDONE:
            movem.l (SP)+,D0-D7/A0-A5
            rts
OffsetTbl:
            dc.w    $0052,$007C,$00CC,$00F4,$01D2,$0120,$0118,$0028
            dc.w    $011C,$0114,$002E,$00CC,$0230,$0244
OffsetTbl2:
            dc.w    $13F8,$13F8,$0DD6,$0E4C,$05A4,$05A4,$1276,$0E98
            dc.w    $18DA,$1934,$1DEE,$1AF4
            ds.b    4
            dc.w    $1DEC,$1AF2,$18DA,$1934,$1DEE,$1AF4,$1F6E,0
            dc.w    $1FD4,0,$0EFC,$0F14,$0F60,0,$1122,$1152
            dc.w    $118C,$11B2,$1208
            ds.b    14
            dc.w    $12BE,$1304,$1330,$1382,$13DA,$1380
            ds.b    20
            dc.w    $179C,$07D4,$15F0,$15F8,$06A6,$0A6C,$0966,$0924
            dc.w    $0826,$0618,$1648,$16EC,$178A,$06BE,$189A,$09DC
            dc.w    $05A4,$07BC,$1604,$1518
            ds.b    24
            dc.w    $053C,$0562,$056C
            ds.b    8
            dc.w    $051A
msgTbl:
            dc.w    $0800,$1014,$1800,$001C
            ds.b    28
            dc.b    '@DHLPTHHHHHHHHHHHHHHHHHHHHHHHHHHHHHH'
            ds.b    30

            EVEN
