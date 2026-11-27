StartTest:
ElsieTMVectors:
            dc.l    $2000                           ; $00 initial SP
            dc.l    StartTest1-BaseOfROM+ElsieROMBase ; $04 initial PC
            dc.l    BusError-BaseOfROM+ElsieROMBase ; $08 Bus Error
            dc.l    AdrError-BaseOfROM+ElsieROMBase ; $0C Address error
            dc.l    illError-BaseOfROM+ElsieROMBase ; $10 illegal instruction
            dc.l    ZerError-BaseOfROM+ElsieROMBase ; $14 zero divide
            dc.l    ChkError-BaseOfROM+ElsieROMBase ; $18 Chk,Chk2 instructions
            dc.l    xTrapx-BaseOfROM+ElsieROMBase   ; $1C cpTrapcc,Trapcc,TrapV
            dc.l    PrivError-BaseOfROM+ElsieROMBase ; $20 Privilege violation
            dc.l    Trace-BaseOfROM+ElsieROMBase    ; $24 Trace bit
            dc.l    LineA-BaseOfROM+ElsieROMBase    ; $28 line A trap
            dc.l    LineF-BaseOfROM+ElsieROMBase    ; $2C line F trap
            dc.l    NotAss-BaseOfROM+ElsieROMBase   ; $30 not assigned
            dc.l    cpProtocol-BaseOfROM+ElsieROMBase ; $34 cp protocol violation
            dc.l    FormatX-BaseOfROM+ElsieROMBase  ; $38 format error
            dc.l    SpurInterrupt-BaseOfROM+ElsieROMBase ; $3C uninitialized interrupt
            dc.l    NotAss-BaseOfROM+ElsieROMBase   ; $40 not assigned
            dc.l    NotAss-BaseOfROM+ElsieROMBase   ; $44 not assigned
            dc.l    NotAss-BaseOfROM+ElsieROMBase   ; $48 not assigned
            dc.l    NotAss-BaseOfROM+ElsieROMBase   ; $4C not assigned
            dc.l    NotAss-BaseOfROM+ElsieROMBase   ; $50 not assigned
            dc.l    NotAss-BaseOfROM+ElsieROMBase   ; $54 not assigned
            dc.l    NotAss-BaseOfROM+ElsieROMBase   ; $58 not assigned
            dc.l    NotAss-BaseOfROM+ElsieROMBase   ; $5C not assigned
            dc.l    SpurInterrupt-BaseOfROM+ElsieROMBase ; $60 spurious interrupt
            dc.l    IntLevel1-BaseOfROM+ElsieROMBase ; $64 Level 1 interrupt
            dc.l    IntLevel2-BaseOfROM+ElsieROMBase ; $68 Level 2 interrupt
            dc.l    IntLevel3-BaseOfROM+ElsieROMBase ; $6C Level 3 interrupt
            dc.l    IntLevel4-BaseOfROM+ElsieROMBase ; $70 Level 4 interrupt
            dc.l    IntLevel5-BaseOfROM+ElsieROMBase ; $74 Level 5 interrupt
            dc.l    IntLevel6-BaseOfROM+ElsieROMBase ; $78 Level 6 interrupt
            dc.l    IntLevel7-BaseOfROM+ElsieROMBase ; $7C Level 7 interrupt
            dc.l    TrapN-BaseOfROM+ElsieROMBase    ; $80 Trap #0
            dc.l    TrapN-BaseOfROM+ElsieROMBase    ; $84 Trap #1
            dc.l    TrapN-BaseOfROM+ElsieROMBase    ; $88 Trap #2
            dc.l    TrapN-BaseOfROM+ElsieROMBase    ; $8C Trap #3
            dc.l    TrapN-BaseOfROM+ElsieROMBase    ; $90 Trap #4
            dc.l    TrapN-BaseOfROM+ElsieROMBase    ; $94 Trap #5
            dc.l    TrapN-BaseOfROM+ElsieROMBase    ; $98 Trap #6
            dc.l    TrapN-BaseOfROM+ElsieROMBase    ; $9C Trap #7
            dc.l    TrapN-BaseOfROM+ElsieROMBase    ; $A0 Trap #8
            dc.l    TrapN-BaseOfROM+ElsieROMBase    ; $A4 Trap #9
            dc.l    TrapN-BaseOfROM+ElsieROMBase    ; $A8 Trap #10
            dc.l    TrapN-BaseOfROM+ElsieROMBase    ; $AC Trap #11
            dc.l    TrapN-BaseOfROM+ElsieROMBase    ; $B0 Trap #12
            dc.l    TrapN-BaseOfROM+ElsieROMBase    ; $B4 Trap #13
            dc.l    TrapN-BaseOfROM+ElsieROMBase    ; $B8 Trap #14
            dc.l    TrapN-BaseOfROM+ElsieROMBase    ; $BC Trap #15
            dc.l    FPCP1-BaseOfROM+ElsieROMBase    ; $C0 FPCP bra or set on unordered cond
            dc.l    FPCP2-BaseOfROM+ElsieROMBase    ; $C4 FPCP inexact result
            dc.l    FPCP3-BaseOfROM+ElsieROMBase    ; $C8 FPCP divide by zero
            dc.l    FPCP4-BaseOfROM+ElsieROMBase    ; $CC FPCP underflow
            dc.l    FPCP5-BaseOfROM+ElsieROMBase    ; $D0 FPCP operand error
            dc.l    FPCP6-BaseOfROM+ElsieROMBase    ; $D4 FPCP overflow
            dc.l    FPCP7-BaseOfROM+ElsieROMBase    ; $D8 FPCP signaling NAN
            dc.l    NotAss-BaseOfROM+ElsieROMBase   ; $DC not assigned
            dc.l    PMMUConfig-BaseOfROM+ElsieROMBase ; $E0 PMMU configuration
            dc.l    PMMUillegal-BaseOfROM+ElsieROMBase ; $E4 PMMU illegal operation
            dc.l    PMMUAccess-BaseOfROM+ElsieROMBase ; $E8 PMMU access level violation
            dc.l    NotAss-BaseOfROM+ElsieROMBase   ; $EC not assigned
            dc.l    NotAss-BaseOfROM+ElsieROMBase   ; $F0 not assigned
            dc.l    NotAss-BaseOfROM+ElsieROMBase   ; $F4 not assigned
            dc.l    NotAss-BaseOfROM+ElsieROMBase   ; $F8 not assigned
            dc.l    NotAss-BaseOfROM+ElsieROMBase   ; $FC not assigned
TMVectors:
            dc.l    $2000                           ; $00 initial SP
            dc.l    StartTest1                      ; $04 initial PC
            dc.l    BusError                        ; $08 Bus Error
            dc.l    AdrError                        ; $0C Address error
            dc.l    illError                        ; $10 illegal instruction
            dc.l    ZerError                        ; $14 zero divide
            dc.l    ChkError                        ; $18 Chk,Chk2 instructions
            dc.l    xTrapx                          ; $1C cpTrapcc,Trapcc,TrapV
            dc.l    PrivError                       ; $20 Privilege violation
            dc.l    Trace                           ; $24 Trace bit
            dc.l    LineA                           ; $28 line A trap
            dc.l    LineF                           ; $2C line F trap
            dc.l    NotAss                          ; $30 not assigned
            dc.l    cpProtocol                      ; $34 cp protocol violation
            dc.l    FormatX                         ; $38 format error
            dc.l    SpurInterrupt                   ; $3C uninitialized interrupt
            dc.l    NotAss                          ; $40 not assigned
            dc.l    NotAss                          ; $44 not assigned
            dc.l    NotAss                          ; $48 not assigned
            dc.l    NotAss                          ; $4C not assigned
            dc.l    NotAss                          ; $50 not assigned
            dc.l    NotAss                          ; $54 not assigned
            dc.l    NotAss                          ; $58 not assigned
            dc.l    NotAss                          ; $5C not assigned
            dc.l    SpurInterrupt                   ; $60 spurious interrupt
            dc.l    IntLevel1                       ; $64 Level 1 interrupt
            dc.l    IntLevel2                       ; $68 Level 2 interrupt
            dc.l    IntLevel3                       ; $6C Level 3 interrupt
            dc.l    IntLevel4                       ; $70 Level 4 interrupt
            dc.l    IntLevel5                       ; $74 Level 5 interrupt
            dc.l    IntLevel6                       ; $78 Level 6 interrupt
            dc.l    IntLevel7                       ; $7C Level 7 interrupt
            dc.l    TrapN                           ; $80 Trap #0
            dc.l    TrapN                           ; $84 Trap #1
            dc.l    TrapN                           ; $88 Trap #2
            dc.l    TrapN                           ; $8C Trap #3
            dc.l    TrapN                           ; $90 Trap #4
            dc.l    TrapN                           ; $94 Trap #5
            dc.l    TrapN                           ; $98 Trap #6
            dc.l    TrapN                           ; $9C Trap #7
            dc.l    TrapN                           ; $A0 Trap #8
            dc.l    TrapN                           ; $A4 Trap #9
            dc.l    TrapN                           ; $A8 Trap #10
            dc.l    TrapN                           ; $AC Trap #11
            dc.l    TrapN                           ; $B0 Trap #12
            dc.l    TrapN                           ; $B4 Trap #13
            dc.l    TrapN                           ; $B8 Trap #14
            dc.l    TrapN                           ; $BC Trap #15
            dc.l    FPCP1                           ; $C0 FPCP bra or set on unordered cond
            dc.l    FPCP2                           ; $C4 FPCP inexact result
            dc.l    FPCP3                           ; $C8 FPCP divide by zero
            dc.l    FPCP4                           ; $CC FPCP underflow
            dc.l    FPCP5                           ; $D0 FPCP operand error
            dc.l    FPCP6                           ; $D4 FPCP overflow
            dc.l    FPCP7                           ; $D8 FPCP signaling NAN
            dc.l    NotAss                          ; $DC not assigned
            dc.l    PMMUConfig                      ; $E0 PMMU configuration
            dc.l    PMMUillegal                     ; $E4 PMMU illegal operation
            dc.l    PMMUAccess                      ; $E8 PMMU access level violation
            dc.l    NotAss                          ; $EC not assigned
            dc.l    NotAss                          ; $F0 not assigned
            dc.l    NotAss                          ; $F4 not assigned
            dc.l    NotAss                          ; $F8 not assigned
            dc.l    NotAss                          ; $FC not assigned
BusError:
            btst    #$1B,D7
            beq.b   .L1
            movea.l A5,SP
            RTS6
.L1:
            ori.w   #$100,D7
            bra.b   JmpHandler
AdrError:
            ori.w   #$200,D7
            bra.b   JmpHandler
illError:
            ori.w   #$300,D7
            bra.b   JmpHandler
ZerError:
            ori.w   #$400,D7
            bra.b   JmpHandler
ChkError:
            ori.w   #$500,D7
            bra.b   JmpHandler
xTrapx:
            ori.w   #$600,D7
            bra.b   JmpHandler
PrivError:
            ori.w   #$700,D7
            bra.b   JmpHandler
Trace:
            ori.w   #$800,D7
            bra.b   JmpHandler
LineA:
            ori.w   #$900,D7
            bra.b   JmpHandler
LineF:
            ori.w   #$A00,D7
            bra.b   JmpHandler
NotAss:
            ori.w   #$B00,D7
            bra.b   JmpHandler
cpProtocol:
            ori.w   #$C00,D7
            bra.b   JmpHandler
FormatX:
            ori.w   #$D00,D7
            bra.b   JmpHandler
SpurInterrupt:
            ori.w   #$E00,D7
            bra.b   JmpHandler
TrapN:
            ori.w   #$F00,D7
            bra.b   JmpHandler
IntLevel1:
            ori.w   #$1000,D7
            bra.b   JmpHandler
IntLevel2:
            ori.w   #$1100,D7
            bra.b   JmpHandler
IntLevel3:
            ori.w   #$1200,D7
            bra.b   JmpHandler
IntLevel4:
            ori.w   #$1300,D7
            bra.b   JmpHandler
IntLevel5:
            ori.w   #$1400,D7
JmpHandler:
            bra.w   ExceptionHandler
IntLevel6:
            ori.w   #$1500,D7
            moveq   #0,D2
            BSR6    JGetHardwareInfo
            movea.l ($2C,A0),A0
            bset    #2,($400,A0)
            bclr    #2,(A0)
.die:
            bra.b   .die
            bra.b   JmpHandler
IntLevel7:
            btst    #$1B,D7
            beq.b   .notParity
            cmpi.l  #'PGCp',D0
            bne.b   .notRBV
            movea.l A5,SP
            movea.l (8,A0),A1
            move.b  (A1),D1
            bclr    #7,($400,A1)
            beq.b   .dataValid
            move.b  (A1),D1
            bset    #7,($400,A1)
.dataValid:
            btst    #7,D1
            bne.b   .notParity
            bset    #6,(A1)
            tst.b   (A1)
            bclr    #6,(A1)
            tst.b   (A1)
            RTS6
.notRBV:
            cmpi.l  #'RPUp',D0
            bne.b   .notParity
            movea.l A5,SP
            movea.l ($48,A0),A1
            move.w  ($202,A1),D1
            btst    #$E,D1
            beq.b   .notParity
            movea.l ($50,A0),A1
            st      ($10,A1)
            move.l  (A1),D1
            bset    #$10,D1
            move.l  D1,(A1)
            RTS6
.notParity:
            andi.w  #$FF,D7
            ori.w   #$1600,D7
            bset    #$19,D7
            bra.b   ExceptionHandler
FPCP1:
            andi.w  #$FF,D7
            ori.w   #$1700,D7
            bra.b   ExceptionHandler
FPCP2:
            andi.w  #$FF,D7
            ori.w   #$1800,D7
            bra.b   ExceptionHandler
FPCP3:
            andi.w  #$FF,D7
            ori.w   #$1900,D7
            bra.b   ExceptionHandler
FPCP4:
            andi.w  #$FF,D7
            ori.w   #$1A00,D7
            bra.b   ExceptionHandler
FPCP5:
            andi.w  #$FF,D7
            ori.w   #$1B00,D7
            bra.b   ExceptionHandler
FPCP6:
            andi.w  #$FF,D7
            ori.w   #$1C00,D7
            bra.b   ExceptionHandler
FPCP7:
            andi.w  #$FF,D7
            ori.w   #$1D00,D7
            bra.b   ExceptionHandler
PMMUConfig:
            andi.w  #$FF,D7
            ori.w   #$1E00,D7
            bra.b   ExceptionHandler
PMMUillegal:
            andi.w  #$FF,D7
            ori.w   #$1F00,D7
            bra.b   ExceptionHandler
PMMUAccess:
            andi.w  #$FF,D7
            ori.w   #$2000,D7
ExceptionHandler:
            bset    #$18,D7
            move.l  SP,D6
            movea.w #$2600,SP
            jmp     Error1Handler
StartTest1:
            movea.w #$2600,SP
            moveq   #0,D7
            moveq   #0,D6
            lea     StartTest,A1
            lea     StartTest1,A5
            cmpa.l  (4,A1),A5
            beq.b   .L1
            lea     TMVectors,A1
.L1:
            movec   A1,VBR
            movea.l SP,A5
            moveq   #0,D2
            BSR6    JGetHardwareInfo
            btst    #1,D0
            beq.b   sub_40846C58.L1
            lea     sub_40846C58.L1,A6
            bset    #$1B,D7
            movea.l (4,A0),A1
            movem.l (A1)+,D3/A0
            cmpi.l  #$AAAA5555,D3
            bne.b   sub_40846C58.L1
            lea     sub_40846C58,A1
            lea     diagROMentry,A3
            jmp     (A0)
sub_40846C58:
            moveq   #0,D2
            BSR6    JGetHardwareInfo
.L1:
            bclr    #$1B,D7
            btst    #$11,D0
            beq.b   .L2
            move.w  #$12,D7
            BSR6    SETUPBASES
            BSR6    SetSCCIOPBypass
            bne.w   Error1Handler
.L2:
            moveq   #0,D2
            BSR6    JGetHardwareInfo
            movea.l (8,A0),A2
            cmpi.b  #6,D2
            bne.b   .L3
            movea.l ($48,A0),A3
            btst    #1,($206,A3)
            beq.w   .L15
            bra.w   .L13
.L3:
            asr.w   #8,D2
            cmpi.b  #$D,D2
            ble.b   .L5
            lea     USTPMGRSENDBYTE.L4,A3
.L4:
            move.b  (A3)+,D3
            cmpi.b  #$FD,D3
            beq.b   .L6
            cmp.b   D2,D3
            bne.b   .L4
.L5:
            bclr    #0,($600,A2)
            bclr    #1,($1E00,A2)
            btst    #0,($1E00,A2)
            beq.w   .L13
.L6:
            move.l  #$7800F8,D3
.L7:
            BSR6    ReadPramSig
            cmpi.l  #'SCBI',D4
            beq.b   .L8
            clr.w   D3
            swap    D3
            bne.b   .L7
            bra.w   .L15
.L8:
            moveq   #0,D2
            BSR6    JGetHardwareInfo
            movea.l (8,A0),A2
            btst    #8,D0
            beq.b   .L9
            movea.l ($20,A0),A3
            move.b  ($40,A3),D3
            andi.b  #$1C,D3
            cmpi.b  #$10,D3
            bne.b   .L11
            bra.b   .L13
.L9:
            movea.l ($60,A0),A3
            btst    #$19,D0
            beq.b   .L10
            movea.l ($64,A0),A3
.L10:
            move.b  ($40,A3),D3
            andi.b  #7,D3
            cmpi.b  #4,D3
            beq.b   .L13
.L11:
            BSR6    CLKWPOFF
            move.w  #$FF,D3
.L12:
            moveq   #0,D2
            move.w  D3,D1
            BSR6    WrXByte
            dbra    D3,.L12
            bra.b   .L15
.L13:
            bset    #$1A,D7
            move.l  #$7C00FC,D3
.L14:
            BSR6    ReadPramSig
            cmpi.l  #'RBBI',D4
            beq.w   PRLOG
            clr.w   D3
            swap    D3
            bne.b   .L14
.L15:
            movec   CACR,D0
            bset    #$F,D0
            movec   D0,CACR
            movec   CACR,D0
            btst    #$F,D0
            beq.b   .L16
            mc68040
            cinva   IC
            mc68030
            bra.b   .L17
.L16:
            movec   CACR,D0
            ori.b   #9,D0
            bclr    #8,D0
            movec   D0,CACR
.L17:
            moveq   #0,D2
            BSR6    JGetHardwareInfo
            moveq   #$E,D0
            and.l   D1,D0
            subq.l  #6,D0
            beq.b   .L18
            moveq   #$70,D0
            and.l   D1,D0
            cmpi.b  #$20,D0
            bne.b   .L19
            BigBSR6 EgretInit,A1
            move.l  #$210001,D0
            moveq   #0,D1
            moveq   #1,D2
            BigBSR6 SendEgretCmd,A1
            bra.b   .L19
.L18:
            BigBSR6 EgretInit,A1
            move.l  #$1C0001,D0
            moveq   #1,D1
            moveq   #1,D2
            BigBSR6 SendEgretCmd,A1
.L19:
            moveq   #0,D2
            BSR6    JGetHardwareInfo
            move.l  ($30,A1),D3
            beq.b   .L20
            lea     (0,A1,D3.l),A2
            move.l  (A2),D3
            beq.b   .L20
            lea     .L20,A6
            jmp     (0,A2,D3.l)
.L20:
            move.w  #1,D7
            BSR6    StartUpROMTest
            tst.l   D6
            bne.w   Error1Handler
            clr.w   D7
            moveq   #0,D2
            BSR6    JGetHardwareInfo
            btst    #$18,D2
            beq.b   .L21
            BSR6    USTPmgrTurnOn
.L21:
            movea.l ($30,A0),A3
            movea.l (8,A0),A5
            ori.b   #7,($600,A5)
            move.b  #1,($1E00,A5)
            moveq   #$28,D0
            BigBSR6 BOOTBEEP6,A0
            clr.b   ($804,A3)
            moveq   #0,D2
            BSR6    JGetHardwareInfo
            BSR6    SizeV8VRAM
            move.w  #$11,D7
            BSR6    SizeMemory
            bne.w   Error1Handler
            BSR6    .L35
            tst.l   D6
            bne.b   .L22
            movea.l (SP),A6
            cmpi.l  #'WLSC',(-4,A6)
            bne.b   .L22
            clr.w   D7
            bra.w   .L27
.L22:
            movea.w #$FFFF,A3
            move.w  #3,D7
            movea.l (SP),A4
            movea.l A4,A5
.L23:
            movea.l (A4)+,A0
            cmpa.w  #$FFFF,A0
            beq.b   .L26
            move.l  (A4)+,D0
            movea.l A0,A1
            adda.l  D0,A1
            cmpa.l  A1,A5
            bhi.b   .L24
            movea.l (SP),A1
.L24:
            cmpa.l  A1,A3
            bhi.b   .L25
            movea.l A3,A1
.L25:
            BSR6    CritProc
            move.l  A5,(SP)
            tst.l   D6
            bne.w   Error1Handler
            addq.w  #1,D7
            bra.b   .L23
.L26:
            move.w  #$13,D7
            movea.l (SP),A0
            movea.l (A0),A0
            BSR6    dynamic_bussize_test
            tst.l   D6
            bne.w   Error1Handler
.L27:
            BSR6    USTINIT
            moveq   #2,D0
            cmpi.l  #'WLSC',($1E,A5)
            beq.b   .L28
            bset    #0,D0
.L28:
            move.w  D0,(8,A5)
            movea.l ($12,A5),A2
            move.l  ($2A,A5),D0
            movea.l ($26,A5),A1
            movea.l ($22,A5),A0
            move.w  ($12,A1),D2
            suba.w  #$18,SP
            movea.l SP,A3
.L29:
            moveq   #0,D4
            move.w  (2,A2),D4
            cmpi.w  #$FFFF,D4
            beq.b   .L33
            move.w  (4,A2),D3
            and.w   (8,A5),D3
            beq.b   .L32
            move.l  A3,-(SP)
            move.l  D4,-(SP)
            bsr.w   USTGETSUBTEST
            addq.l  #8,SP
            move.w  D4,D7
            movea.l (4,A3),A4
            movem.l D0/D2/A0-A3/A5,-(SP)
            moveq   #0,D6
            lea     .L30,A6
            jmp     (A4)
.L30:
            tst.l   D6
            beq.b   .L31
            movem.l (SP),D0/D2/A0-A3/A5
            move.w  (8,A5),D0
            btst    #0,D0
            beq.b   .L31
            bsr.w   NCErrorHandler
            btst    #$1A,D7
            bne.w   PostProc
.L31:
            movem.l (SP)+,D0/D2/A0-A3/A5
.L32:
            addq.w  #6,A2
            bra.b   .L29
.L33:
            lea     ($18,SP),SP
            clr.w   D7
            btst    #$1A,D7
            bne.w   PostProc
            movea.l ($26,A5),A1
            moveq   #$E,D0
            and.l   ($1C,A1),D0
            cmpi.w  #6,D0
            bne.b   .L34
            movea.l ($22,A5),A0
            move.l  #$1C0001,D0
            moveq   #0,D1
            moveq   #1,D2
            move.l  A5,-(SP)
            BigBSR6 SendEgretCmd,A1
            movea.l (SP)+,A5
.L34:
            movea.l ($2E,A5),A6
            BigJmp  StartInit1,A0
.L35:
            move.l  A6,D4
            moveq   #0,D2
            BSR6    JGetHardwareInfo
            bset    #$12,D7
            bset    #$1B,D7
            movea.l SP,A5
            btst    #0,D1
            beq.b   .L38
            move.l  #'PGCp',D0
            movea.l (8,A0),A2
            bclr    #6,(A2)
            tst.b   (A2)
            lea     .L37,A6
            movea.l (SP),A4
.L36:
            movea.l (A4)+,A3
            cmpa.w  #$FFFF,A3
            beq.b   .L39
            addq.l  #4,A4
            move.l  #$1010101,(A3)
            tst.l   (A3)
            clr.l   (A3)
            tst.l   (A3)
            bra.b   .L36
.L37:
            bset    #6,(A1)
            bra.b   .L43
.L38:
            btst    #$14,D0
            beq.b   .L43
            move.l  #'RPUp',D0
            movea.l ($50,A0),A2
            st      ($10,A2)
            clr.b   (A2)
            st      (A2)
            movea.l ($48,A0),A1
            move.b  #7,($E,A1)
.L39:
            lea     .L42,A6
            movea.l (SP),A4
.L40:
            movea.l (A4)+,A2
            cmpa.w  #$FFFF,A2
            beq.b   .L44
            move.l  (A4)+,D5
.L41:
            movem.l (A2)+,D1-D3/D6
            subq.l  #4,D5
            bgt.b   .L41
            bra.b   .L40
.L42:
            moveq   #1,D6
            bra.b   .L45
.L43:
            bclr    #$12,D7
.L44:
            moveq   #0,D6
.L45:
            bclr    #$1B,D7
            moveq   #0,D0
            movea.l D4,A6
            RTS6
SETVECTORTABLE:
            BigLea  BaseOfROM,A0
            move.l  A0,D2
            subi.l  #$40800000,D2
            lea     TMVectors,A0
            movea.l A1,A2
            move.w  #$3F,D0
.L1:
            move.l  (A0)+,D1
            add.l   D2,D1
            move.l  D1,(A1)+
            dbra    D0,.L1
            movec   A2,VBR
            RTS6
JGetHardwareInfo:
            ori     #$700,SR
            BigJmp  GetHardwareInfo,A0
SizeV8VRAM:
            move.b  ($12,A1),D0
            cmpi.b  #$D,D0
            bne.w   .L2
            movea.l ($34,A0),A2
            move.l  (8,A1),D0
            movea.l (0,A1,D0.l),A0
            move.l  #'Shel',D0
            moveq   #-1,D1
            move.l  #$40000,D2
            bset    #2,(1,A2)
            bset    #1,(1,A2)
            move.l  D0,(A0)
            move.l  D1,(4,A0)
            cmp.l   (0,A0,D2.l),D0
            beq.b   .L2
            cmp.l   (A0),D0
            beq.b   .L1
            bclr    #2,(1,A2)
            bra.b   .L2
.L1:
            bclr    #1,(1,A2)
.L2:
            RTS6
USTINIT:
            movea.l A6,A4
            BSR6    SizeMemory
            moveq   #0,D2
            BSR6    JGetHardwareInfo
            movea.l (SP),A2
            movea.l (A2),A5
            adda.l  #$10000,A5
            suba.w  #$32,A5
            move.l  A2,($2E,A5)
            movea.l A5,SP
            move.l  (-4,A2),($1E,A5)
            move.l  D0,($2A,A5)
            move.l  A1,($26,A5)
            move.l  A0,($22,A5)
            move.b  ($12,A1),D0
            lea     USTCPUList,A0
            move.l  A0,D2
.L1:
            move.w  (A0),D1
            cmpi.b  #$FD,D1
            beq.b   .L2
            cmp.b   D1,D0
            beq.b   .L2
            addq.l  #6,A0
            bra.b   .L1
.L2:
            movea.l (2,A0),A0
            lea     (0,A0,D2.l),A0
            move.l  A0,($12,A5)
            suba.w  #$100,SP
            movea.l SP,A1
            BSR6    SETVECTORTABLE
            jmp     (A4)
USTGETSUBTEST:
            link.w  A0,#0
            movem.l D0-D1/A1-A2,-(SP)
            lea     USTSubtests,A1
            move.l  A1,D1
            move.l  (8,A0),D0
.L1:
            cmp.l   (A1),D0
            beq.b   .L2
            lea     ($18,A1),A1
            bra.b   .L1
.L2:
            moveq   #5,D0
            movea.l ($C,A0),A2
.L3:
            move.l  (A1)+,(A2)+
            dbra    D0,.L3
            movea.l ($C,A0),A2
            add.l   D1,(4,A2)
            add.l   D1,(8,A2)
            movem.l (SP)+,D0-D1/A1-A2
            unlk    A0
            rts
USTPmgrTurnOn:
            movea.l (8,A0),A2
            movea.l ($2C,A0),A3
            clr.b   ($600,A3)
            move.w  #$C80,D3
.L1:
            btst    #1,(A3)
            beq.b   .L2
            cmpi.b  #$FF,($200,A3)
            beq.b   .L3
.L2:
            dbra    D3,.L1
            moveq   #1,D6
            bra.b   .L4
.L3:
            bclr    #7,($600,A2)
            move.b  #$10,D3
            BSR5    USTPMGRSENDBYTE
            bne.b   .L4
            move.b  #1,D3
            BSR5    USTPMGRSENDBYTE
            bne.b   .L4
            move.b  #$B3,D3
            BSR5    USTPMGRSENDBYTE
.L4:
            RTS6
ReadPramSig:
            move.l  A6,D5
.L1:
            move.w  D3,D1
            BSR6    RdXByte
            rol.l   #8,D4
            move.b  D1,D4
            addq.w  #1,D3
            move.w  D3,D1
            andi.w  #3,D1
            bne.b   .L1
            movea.l D5,A6
            RTS6
USTPMGRSENDBYTE:
            move.w  #$400,D4
            moveq   #2,D6
            move.b  #$FF,($600,A3)
            move.b  D3,($200,A3)
            bclr    #2,(A3)
.L1:
            btst    #1,(A3)
            dbeq    D4,.L1
            bne.b   .L3
            move.w  #$40,D4
            bset    #2,(A3)
.L2:
            btst    #1,(A3)
            dbne    D4,.L2
            beq.b   .L3
            moveq   #0,D6
.L3:
            bset    #2,(A3)
            clr.b   ($600,A3)
            tst.l   D6
            RTS5
.L4:
            dc.w    $0E10,$11FD
            ds.b    4
