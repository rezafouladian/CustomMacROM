            include "Include/ROMHeader.s"

            EXPORT  CHECKPACKETPATCH,DEBUGUTILRUNKBDPATCH,DELAY100PATCH,ECLIPSEEGRETPATCHES,EGRETPATCHTOO,RequestDonePatch
            EXPORT  SETTRANSFERPARMSPATCH,SHIFTREGIRQPATCH

            IMPORT  DEBUGPWRMGRADBPATCH2,EGRETPOWEROFF,INITRELIABILITY,SETRESPONSEPARAMS

            SECTION "EgretPatchesToo",CODE

EGRETPATCHTOO:
EGRETDISPATCHPATCH:
            bne.b   .L1
            move.l  A0,($30,A2)
            bra.b   .L2
.L1:
            cmpi.b  #$FE,(A0)
            bne.b   .L3
            move.l  (2,A0),($2C,A2)
.L2:
            moveq   #0,D0
            addq.w  #4,SP
.L3:
            rts
CHECKPACKETPATCH:
            cmpi.b  #$FF,(A0)
            beq.b   .L1
            cmpi.b  #$FE,(A0)
            bne.b   .L2
.L1:
            clr.w   ($E,A0)
            addq.w  #4,SP
.L2:
            rts
DELAY100PATCH:
            move.l  D1,-(SP)
            move.w  TimeVIADB,D1
            lsr.w   #3,D1
            addi.w  #$19,D1
.L1:
            tst.b   (A1)
            dbra    D1,.L1
            move.l  (SP)+,D1
            rts
SHIFTREGIRQPATCH:
            bne.b   .L1
            cmpi.b  #3,(3,A1)
            bne.b   .L2
            rts
.L1:
            cmpi.b  #4,(1,A1)
            bne.b   .L2
            move.l  ($2C,A2),D2
            beq.b   .L2
            movea.l D2,A3
            move.b  (3,A1),D0
            bsr.l   SETRESPONSEPARAMS
            move    D3,SR
            jsr     (A3)
            bra.b   .L3
.L2:
            bsr.l   SETRESPONSEPARAMS
            move    D3,SR
            bra.b   .L3
            bclr    #4,(A1)
.L3:
            addq.w  #4,SP
            rts
SETTRANSFERPARMSPATCH:
            andi.b  #$F,D0
            lea     .L1,A1
            rts
.L1:
            ds.b    16
            dc.w    $8000,$8000,$8000,$8000,$0008,$0008,$0008,$0008
ECLIPSEEGRETPATCHES:
            bsr.l   INITRELIABILITY
            moveq   #$70,D0
            and.l   UnivROMFlags,D0
            subi.l  #$20,D0
            bne.b   .L1
            cmpi.b  #4,CPUFlag
            bne.b   .L1
            bsr.w   ECLIPSEDFACPATCH
            bsr.b   ECLIPSEPDMPATCH
.L1:
            rts
ECLIPSEPDMPATCH:
            movem.l A0-A1,-(SP)
            suba.w  #$14,SP
            movea.l SP,A0
            move.w  #$FE00,(A0)
            clr.l   ($10,A0)
            lea     KEYSWITCHHANDLER,A1
            move.l  A1,(2,A0)
            _EgretDispatch
            movea.l ExpandMem,A1
            moveq   #$22,D0
            _NewPtrSysClear
            move.l  A0,($1B6,A1)
            adda.w  #$14,SP
            movem.l (SP)+,A0-A1
            rts
KEYSWITCHHANDLER:
            tst.b   D0
            bne.b   .L2
            movem.l A0-A1,-(SP)
            movea.l ExpandMem,A1
            movea.l ($1B6,A1),A0
            movea.l A0,A1
            moveq   #$10,D0
.L1:
            clr.w   (A1)+
            dbra    D0,.L1
            lea     PullThePlug,A1
            move.l  A1,(6,A0)
            _InsTime
            move.l  #$1388,D0
            _PrimeTime
            lea     ($E,A0),A0
            move.w  #7,(4,A0)
            lea     EclipseAdios,A1
            move.l  A1,(8,A0)
            jsr     ([JDTInstall.w])
            movem.l (SP)+,A0-A1
            tst.w   D0
            bne.b   PullThePlug
.L2:
            rts
EclipseAdios:
            movea.l ($358).w,A1
            bra.b   .L3
.L1:
            tst.w   ($4C,A1)
            bne.b   .L2
            suba.w  #$32,SP
            movea.l SP,A0
            move.w  ($4E,A1),($16,A0)
            clr.l   ($12,A0)
            clr.l   ($C,A0)
            move.l  A1,-(SP)
            _HUnmountVol
            movea.l (SP)+,A1
            lea     ($32,SP),SP
.L2:
            movea.l (A1),A1
.L3:
            move.l  A1,D0
            bne.b   .L1
PullThePlug:
            bsr.l   EGRETPOWEROFF
            bra.b   PullThePlug
ECLIPSEDFACPATCH:
            movem.l A0-A1,-(SP)
            suba.w  #$14,SP
            movea.l SP,A0
            move.w  #$120,(A0)
            clr.l   ($10,A0)
            move.w  #$100,-(SP)
            move.l  SP,(8,A0)
            move.w  #2,(6,A0)
            _EgretDispatch
            adda.w  #$16,SP
            movem.l (SP)+,A0-A1
            rts
RequestDonePatch:
            btst    #0,($DD5).w                     ; TestFor SupportsIdle
            beq.b   .L1
            move.l  D0,-(SP)
            moveq   #1,D0
            _PowerDispatch
            move.l  (SP)+,D0
.L1:
            move.l  A1,D1
            beq.b   .noHandler
            bsr.b   sub_40885604
            bne.b   .JustDoIt
            btst    #5,($15D,A3)
            bne.b   .JustDoIt
            move.l  A1,-(SP)
            movea.l VIA2,A1
            btst    #0,(A1)
            movea.l (SP)+,A1
            beq.b   .noHandler
.JustDoIt:
            jsr     (A1)
.noHandler:
            movea.l (SP),SP
            rts
DEBUGUTILRUNKBDPATCH:
            bsr.b   sub_40885604
            bne.b   .L1
            move.l  A1,-(SP)
            movea.l VIA2,A1
            btst    #2,(A1)
            movea.l (SP)+,A1
            beq.b   .L2
.L1:
            bra.l   DEBUGPWRMGRADBPATCH2
.L2:
            bra.w   PullThePlug
sub_40885604:
            move.l  D0,-(SP)
            move.l  #$C0000,D0
            and.l   UnivROMFlags,D0
            subi.l  #$40000,D0
            movem.l (SP)+,D0
            rts
            ds.b    1508

            EVEN
