            include "Include/ROMHeader.s"

            EXPORT  DEBUGENTERCONT,DEBUGEXITCONT,EgretPatches,EGRETPOWEROFF,ENABLEONESECINTS,POWEROFFPATCH
            EXPORT  ReadPRamPatch,ReadTimePatch,ValidatePRAMPatch,WritePRamPatch,WRITETIMEPATCH,XPRAMPATCH

            IMPORT  CheckForEgret,ClkNoMem,ClkRW,ExplicitRequestDone,ImplicitRequestDone,PowerOffCont
            IMPORT  PRAMInit,PRAMInitTbl,READPRAMPATCHRTN,VALIDATEPRAMCONT,WRITEPRAMPATCHRTN,WriteTimePatchRtn
            IMPORT  XPRAMCONT,XPRAMEXIT1

            SECTION "EgretPatches",CODE

EgretPatches:
StartREQEgret:
            tst.l   D3
            bmi.b   .implicit
            bset    #2,($15E,A3)
            bne.b   .ignoreExplicit
            move.b  D3,($171,A3)
            move.w  D2,($176,A3)
            move.l  A2,($178,A3)
            bset    #0,($15E,A3)
            bne.b   .expInited
            lea     .ExplicitCompleted,A0
            move.l  A0,($180,A3)
            lea     ($184,A3),A0
            clr.l   ($10,A0)
            bsr.b   .SendToEgret
            move.l  #$1010000,D0
            bsr.b   .syncReq
.expInited:
            lea     ($170,A3),A0
.SendToEgret:
            moveq   #0,D1
            movea.l ($648).w,A2
            jmp     (A2)
.implicit:
            btst    #5,($15D,A3)
            bne.b   .impDone
            bset    #1,($15E,A3)
            beq.b   .InitImplicit
.ignoreExplicit:
.impDone:
            rts
.InitImplicit:
            lea     ($184,A3),A0
            lea     .ImplicitCompleted,A1
            move.l  A1,($10,A0)
            bsr.b   .SendToEgret
            move.l  #$1190000,D0
            move.w  ($14E,A3),D0
            bsr.b   .syncReq
            move.l  #$101FF00,D0
.syncReq:
            suba.w  #$14,SP
            movea.l SP,A0
            move.l  D0,(A0)
            clr.l   ($10,A0)
            bsr.b   .SendToEgret
            lea     ($14,SP),SP
            rts
.ExplicitCompleted:
            moveq   #1,D3
            and.b   ($C,A0),D3
            neg.l   D3
            move.b  (1,A0),D3
            moveq   #0,D2
            move.w  (6,A0),D2
            movea.l (8,A0),A2
            bsr.b   .FillInVars
            bclr    #2,($15E,A3)
            move.w  ($14E,A3),D1
            btst    D0,D1
            bne.b   .exit
            suba.w  #$14,SP
            movea.l SP,A0
            clr.l   ($10,A0)
            move.w  #$108,(A0)
            move.w  #$3020,-(SP)
            move.l  SP,(8,A0)
            move.w  #$B3,(2,A0)
            move.w  #2,(6,A0)
            _EgretDispatch
            adda.w  #$16,SP
.exit:
            BigJmp  ExplicitRequestDone,A0
.FillInVars:
            movea.l ADBBase,A3
            move.b  D3,($15C,A3)
            move.b  D3,($16E,A3)
            move.b  D3,D0
            lsr.b   #4,D0
            move.b  D0,($16C,A3)
            rts
.ImplicitCompleted:
            moveq   #1,D3
            and.b   (A1)+,D3
            neg.l   D3
            move.b  (A1)+,D3
            moveq   #0,D2
            move.w  D0,D2
            movea.l A1,A2
            bsr.b   .FillInVars
            BigJmp  ImplicitRequestDone,A0
XPRAMPATCH:
            moveq   #$70,D3
            and.l   UnivROMFlags,D3
            cmpi.l  #$20,D3
            bne.b   .L3
            suba.w  #$14,SP
            movea.l SP,A1
            move.b  #1,(A1)
            move.l  A0,(8,A1)
            cmpi.w  #$FF,D0
            bhi.b   .L2
            addi.w  #$100,D0
            move.w  D0,(2,A1)
            swap    D0
            ext.l   D0
            move.w  D0,(6,A1)
            move.b  #2,(1,A1)
            btst    #$C,D1
            bne.b   .L1
            move.b  #8,(1,A1)
.L1:
            clr.l   ($10,A1)
            movea.l A1,A0
            _EgretDispatch
            moveq   #0,D0
.L2:
            adda.w  #$14,SP
            BigJmp  XPRAMEXIT1,A2
.L3:
            and.b   D0,D1
            add.w   D1,D1
            andi.w  #$1F,D0
            or.w    D1,D0
            BigJmp  XPRAMCONT,A2
ValidatePRAMPatch:
            movea.l (8,A0),A1
            andi.b  #$70,D1
            cmpi.b  #$20,D1
            bne.w   .L4
            suba.w  #$100,SP
            moveq   #0,D0
            moveq   #$20,D1
            movea.l SP,A0
            bsr.w   sub_40815346
            cmpi.b  #$A8,($10,SP)
            beq.b   .L1
            BigLea  PRAMInit,A0
            moveq   #$10,D0
            moveq   #$10,D1
            bsr.w   sub_40815392
            lea     ($10,A0),A0
            moveq   #8,D0
            moveq   #4,D1
            bsr.w   sub_40815392
.L1:
            lea     .L5,A0
            move.l  ($C,SP),D0
            cmp.l   (A0),D0
            beq.b   .L3
            moveq   #4,D1
            moveq   #$C,D0
            bsr.w   sub_40815392
            moveq   #$37,D0
            movea.l SP,A0
.L2:
            clr.l   (A0)+
            dbra    D0,.L2
            movea.l SP,A0
            moveq   #$20,D0
            move.w  #$E0,D1
            bsr.w   sub_40815392
            BigLea  PRAMInitTbl,A0
            moveq   #$76,D0
            moveq   #$13,D1
            bsr.w   sub_40815392
.L3:
            adda.w  #$100,SP
            RTS6
.L4:
            BigJmp  VALIDATEPRAMCONT,A2
.L5:
            dc.w    $4E75,$4D63
ReadPramByte:
            andi.b  #$70,D1
            cmpi.b  #$20,D1
            bne.b   .L1
            moveq   #1,D1
            subq.w  #2,SP
            movea.l SP,A0
            bsr.b   sub_40815346
            addq.w  #2,SP
            rts
.L1:
            rol.w   #3,D0
            ror.b   #1,D0
            ror.w   #8,D0
            andi.w  #$7C07,D0
            ori.b   #$B8,D0
            move.w  D0,D1
            BigLea  sub_40815342,A5
            BigJmp  ClkNoMem,A4
sub_40815342:
            move.b  D2,D0
            rts
sub_40815346:
            move.l  A0,-(SP)
            move.w  D0,-(SP)
            bset    #5,(A1)
            moveq   #1,D0
            bsr.w   sub_408153D6
            moveq   #7,D0
            bsr.w   sub_408153D6
            moveq   #0,D0
            bsr.w   sub_408153D6
            move.w  (SP)+,D0
            bsr.w   sub_408153D6
            bclr    #5,(A1)
            bsr.w   sub_40815438
            bsr.w   sub_408153F6
            bsr.w   sub_408153F6
            bsr.w   sub_408153F6
            subq.w  #1,D1
            bra.b   .L2
.L1:
            bsr.w   sub_408153F6
            move.b  D0,(A0)+
.L2:
            dbra    D1,.L1
            bsr.w   sub_4081540E
            move.b  D0,(A0)+
            movea.l (SP)+,A0
            rts
sub_40815392:
            move.l  A0,-(SP)
            move.w  D0,-(SP)
            bset    #5,(A1)
            moveq   #1,D0
            bsr.w   sub_408153D6
            moveq   #8,D0
            bsr.w   sub_408153D6
            moveq   #1,D0
            bsr.w   sub_408153D6
            move.w  (SP)+,D0
            bsr.w   sub_408153D6
            subq.w  #1,D1
.L1:
            move.b  (A0)+,D0
            bsr.w   sub_408153D6
            dbra    D1,.L1
            bclr    #5,(A1)
            bsr.w   sub_40815438
            bsr.w   sub_408153F6
            bsr.w   sub_408153F6
            bsr.w   sub_4081540E
            movea.l (SP)+,A0
            rts
sub_408153D6:
            bset    #4,($1600,A1)
            move.b  D0,($1400,A1)
            bset    #4,(A1)
.L1:
            btst    #2,($1A00,A1)
            beq.b   .L1
            tst.b   ($1400,A1)
            bclr    #4,(A1)
            bra.b   sub_4081542E
sub_408153F6:
            btst    #2,($1A00,A1)
            beq.b   sub_408153F6
            move.b  ($1400,A1),D0
            bset    #4,(A1)
            bsr.b   sub_4081542E
            bclr    #4,(A1)
            rts
sub_4081540E:
            btst    #2,($1A00,A1)
            beq.b   sub_4081540E
            move.b  ($1400,A1),D0
            bset    #4,(A1)
            bsr.b   sub_4081542E
            bclr    #5,(A1)
.L1:
            btst    #3,(A1)
            beq.b   .L1
            bclr    #4,(A1)
sub_4081542E:
            moveq   #$68,D2
.L1:
            tst.b   (A1)
            dbra    D2,.L1
            rts
sub_40815438:
            bclr    #4,($1600,A1)
.L1:
            btst    #2,($1A00,A1)
            beq.b   .L1
            tst.b   ($1400,A1)
            bsr.b   sub_4081542E
            bsr.b   sub_4081542E
            bset    #5,(A1)
            rts
POWEROFFPATCH:
            bsr.l   CheckForEgret
            bne.b   EGRETPOWEROFF.L1
            bra.b   EGRETPOWEROFF
            ds.b    8
EGRETPOWEROFF:
            move.l  A0,-(SP)
            suba.w  #$14,SP
            movea.l SP,A0
            move.b  #1,(A0)
            move.b  #$A,(1,A0)
            clr.b   (2,A0)
            clr.l   ($10,A0)
            _EgretDispatch
            adda.w  #$14,SP
            movea.l (SP)+,A0
            bra.b   .L4
.L1:
            movea.l VIA2,A0
            btst    #3,($DD2).w                     ; TestFor VIA2Exists
            bne.b   .L2
            btst    #5,($DD2).w                     ; TestFor RBVExists
            beq.b   .L3
.L2:
            moveq   #2,D0
            bset    D0,($400,A0)
            bclr    D0,(A0)
.L3:
            BigJmp  PowerOffCont,A0
.L4:
            move.l  #$FE0C0000,D0
.L5:
            move.w  TimeDBRA,D0
.L6:
            dbra    D0,.L6
            addq.l  #1,D0
            bne.b   .L5
            rts
ENABLEONESECINTS:
            move.l  UnivROMFlags,D3
            andi.b  #$70,D3
            cmpi.b  #$20,D3
            bne.b   STARTEGRET1SECIRQ.L1
STARTEGRET1SECIRQ:
            move.l  A0,-(SP)
            suba.w  #$14,SP
            movea.l SP,A0
            move.b  #1,(A0)
            move.b  #$1B,(1,A0)
            move.b  #3,(2,A0)
            clr.l   ($10,A0)
            _EgretDispatch
            adda.w  #$14,SP
            movea.l (SP)+,A0
            rts
.L1:
            movea.l VIA,A0
            move.b  #$81,(vIER,A0)
            rts
DEBUGENTERCONT:
            move.l  UnivROMFlags,D0
            andi.l  #$E,D0
            cmpi.l  #6,D0
            bne.b   .L2
            move.l  A0,-(SP)
            suba.w  #$14,SP
            movea.l SP,A0
            move.w  #9,D0
            move.l  A0,-(SP)
.L1:
            clr.w   (A0)+
            dbra    D0,.L1
            movea.l (SP)+,A0
            move.w  #$11B,(A0)
            _EgretDispatch
            adda.w  #$14,SP
            movea.l (SP)+,A0
.L2:
            moveq   #0,D0
            rts
DEBUGEXITCONT:
            move.l  UnivROMFlags,D0
            andi.l  #$E,D0
            cmpi.l  #6,D0
            bne.b   .L2
            move.l  A0,-(SP)
            suba.w  #$14,SP
            movea.l SP,A0
            move.w  #9,D0
            move.l  A0,-(SP)
.L1:
            clr.w   (A0)+
            dbra    D0,.L1
            movea.l (SP)+,A0
            move.w  #$11B,(A0)
            move.b  #3,(2,A0)
            _EgretDispatch
            adda.w  #$14,SP
            movea.l (SP)+,A0
.L2:
            moveq   #0,D0
            rts
ReadPRamPatch:
            movem.l D1-D2/D5/A0-A1,-(SP)
            moveq   #$70,D0
            and.l   UnivROMFlags,D0
            cmpi.l  #$20,D0
            bne.b   .L1
            suba.w  #$14,SP
            movea.l SP,A0
            move.w  #$107,(A0)
            move.w  #$10,(2,A0)
            move.l  A1,(8,A0)
            move.w  #$10,(6,A0)
            clr.l   ($10,A0)
            _EgretDispatch
            move.w  #8,(2,A0)
            addi.l  #$10,(8,A0)
            move.w  #4,(6,A0)
            _EgretDispatch
            adda.w  #$14,SP
            movem.l (SP)+,D1-D2/D5/A0-A1
            rts
.L1:
            moveq   #-$3F,D1
            moveq   #$F,D5
.L2:
            BigJsr  ClkRW,A0
            move.b  D2,(A1)+
            addq.b  #4,D1
            dbra    D5,.L2
            BigJmp  READPRAMPATCHRTN,A0
ReadTimePatch:
            moveq   #$70,D0
            and.l   UnivROMFlags,D0
            cmpi.l  #$20,D0
            bne.b   .L1
            suba.w  #$14,SP
            movea.l SP,A0
            move.w  #$103,(A0)
            clr.l   ($10,A0)
            _EgretDispatch
            move.l  (2,A0),Scratch20
            adda.w  #$14,SP
            bra.b   .L4
.L1:
            moveq   #1,D4
            moveq   #0,D0
.L2:
            moveq   #-$63,D1
            moveq   #7,D5
            lea     Scratch20,A2
            movea.l A2,A3
.L3:
            BigJsr  ClkRW,A0
            move.b  D2,(A2)+
            subq.b  #4,D1
            dbra    D5,.L3
            cmpm.l  (A3)+,(A3)+
            dbeq    D4,.L2
            beq.b   .L4
            moveq   #-$55,D0
.L4:
            move.l  Scratch20,TimeLM
            movem.l (SP)+,D1-D2/D4-D5/A0/A2-A3
            tst.w   D0
            rts
WRITETIMEPATCH:
            movem.l D1-D5/A0,-(SP)
            moveq   #$70,D0
            and.l   UnivROMFlags,D0
            cmpi.l  #$20,D0
            bne.b   .L1
            suba.w  #$14,SP
            movea.l SP,A0
            move.w  #$109,(A0)
            move.l  TimeLM,(2,A0)
            clr.l   ($10,A0)
            _EgretDispatch
            adda.w  #$14,SP
            movem.l (SP)+,D1-D5/A0
            rts
.L1:
            bsr.b   sub_40815690
            move.l  TimeLM,D3
            BigJmp  WriteTimePatchRtn,A0
sub_40815690:
            moveq   #$35,D1
            moveq   #$55,D2
            BigJmp  ClkRW,A0
WritePRamPatch:
            movem.l D1-D3/A1-A2,-(SP)
            moveq   #$70,D0
            and.l   UnivROMFlags,D0
            cmpi.l  #$20,D0
            bne.b   .L1
            suba.w  #$14,SP
            movea.l SP,A0
            move.w  #$108,(A0)
            move.w  #$110,(2,A0)
            lea     SPValid,A1
            move.l  A1,(8,A0)
            move.w  #$10,(6,A0)
            clr.l   ($10,A0)
            _EgretDispatch
            addi.l  #$10,(8,A0)
            move.w  #$108,(2,A0)
            move.w  #4,(6,A0)
            _EgretDispatch
            adda.w  #$14,SP
            movem.l (SP)+,D1-D3/A1-A2
            rts
.L1:
            bsr.b   sub_40815690
            lea     SPValid,A2
            BigJmp  WRITEPRAMPATCHRTN,A1
            ds.b    716

            EVEN
