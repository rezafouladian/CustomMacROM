            include "Include/ROMHeader.s"

            EXPORT  Error1Handler,RdXByte,StartTest1,TMProc,TMRestart,USTPMGRSENDBYTE

            IMPORT  BadDisk_L1,BaseOfROM,BOOTBEEP6,CritErr,EgretInit,ErrorBeep1
            IMPORT  ErrorBeep2,ErrorBeep3,ErrorBeep4,GetHardwareInfo,GI_AllocPermMem,GI_ExecuteTest
            IMPORT  GI_FindSubtest,GI_InitInterface,GI_InstallSubtest,GI_InstallTest,ROMVersion,SendEgretCmd
            IMPORT  StartInit1,StBoot

            SECTION "TestManager",CODE

USTTests:
            dc.w    0,$0001,0,$5490,0,$0030
            ds.b    7
            dc.b    $02,$00,$08,$3D,$60,$00,$00,$00,$3F
            ds.b    4
            dc.w    $FFFF,$FFFF
            ds.b    12
            dc.b    'ROM based test'
            dc.w    $0053
            dc.b    'ONIC Ethernet controller CTE Test'
            dc.b    $00
USTSubtests:
            dc.w    0,$0080,0,$171E,0,$02A0
            ds.b    15
            dc.b    $81,$00,$00,$17,$1E,$00,$00,$02,$B9
            ds.b    15
            dc.b    $82,$00,$00,$17,$1E,$00,$00,$02,$D8
            ds.b    15
            dc.b    $83,$00,$00,$17,$1E,$00,$00,$02,$EB
            ds.b    15
            dc.b    $84,$00,$00,$18,$FA,$00,$00,$03,$01
            ds.b    15
            dc.b    $85,$00,$00,$18,$46,$00,$00,$03,$2B
            ds.b    15
            dc.b    $86,$00,$00,$19,$D8,$00,$00,$03,$5E
            ds.b    15
            dc.b    $87,$00,$00,$1A,$D6,$00,$00,$03,$85
            ds.b    15
            dc.b    $88,$00,$00,$1C,$A4,$00,$00,$03,$A1
            ds.b    15
            dc.b    $89,$00,$00,$1D,$8C,$00,$00,$03,$B4
            ds.b    15
            dc.b    $8A,$00,$00,$20,$8E,$00,$00,$03,$C8
            ds.b    15
            dc.b    $8B,$00,$00,$21,$6A,$00,$00,$03,$D6
            ds.b    15
            dc.b    $8C,$00,$00,$22,$DA,$00,$00,$03,$FA
            ds.b    15
            dc.b    $8D,$00,$00,$25,$D0,$00,$00,$04,$11
            ds.b    15
            dc.b    $8E,$00,$00,$2D,$9C,$00,$00,$04,$25
            ds.b    15
            dc.b    $8F,$00,$00,$2E,$12,$00,$00,$04,$36
            ds.b    15
            dc.b    $90,$00,$00,$2E,$90,$00,$00,$04,$56
            ds.b    15
            dc.b    $91,$00,$00,$2F,$98,$00,$00,$04,$73
            ds.b    15
            dc.b    $92,$00,$00,$30,$42,$00,$00,$04,$9A
            ds.b    15
            dc.b    $93,$00,$00,$30,$B0,$00,$00,$04,$C2
            ds.b    15
            dc.b    $94,$00,$00,$31,$24,$00,$00,$04,$D3
            ds.b    15
            dc.b    $95,$00,$00,$32,$64,$00,$00,$04,$FA
            ds.b    15
            dc.b    $96,$00,$00,$35,$8A,$00,$00,$05,$0A
            ds.b    15
            dc.b    $97,$00,$00,$38,$32,$00,$00,$05,$1D
            ds.b    15
            dc.b    $9A,$00,$00,$38,$A8,$00,$00,$05,$27
            ds.b    15
            dc.b    $9B,$00,$08,$25,$0E,$00,$00,$05,$3D
            ds.b    7
            dc.b    $0C,$00,$00,$00,$2C,$00,$00,$00,$9C,$00,$08,$29,$DE,$00,$00,$05
            dc.b    $5E
            ds.b    7
            dc.b    $1C,$00,$00,$00,$18,$00,$00,$00,$9D,$00,$08,$2C,$5E,$00,$00,$05
            dc.b    $79
            ds.b    7
            dc.b    $80,$00,$00,$00,','
            dc.b    'Portable mapper RAM data'
            dc.b    $00
            dc.b    'Portable mapper RAM uniqueness'
            dc.b    $00
            dc.b    'Portable VRAM data'
            dc.b    $00
            dc.b    'Portable VRAM address'
            dc.b    $00
            dc.b    'Serial Communications Controller register'
            dc.b    $00
            dc.b    'Serial Communications Controller internal loopback'
            dc.b    $00
            dc.b    'Serial Communications Controller timer'
            dc.b    $00
            dc.b    'Versatile Interface Adapter'
            dc.b    $00
            dc.b    'SCSI chip register'
            dc.b    $00
            dc.b    'Sound chip register'
            dc.b    $00
            dc.b    'Parameter RAM'
            dc.b    $00
            dc.b    'RAM Based Video controller register'
            dc.b    $00
            dc.b    'Floppy controller chip'
            dc.b    $00
            dc.b    'Floating point unit'
            dc.b    $00
            dc.b    'IIci type parity'
            dc.b    $00
            dc.b    'Fast Memory Controller register'
            dc.b    $00
            dc.b    'Fast Memory Controller cache'
            dc.b    $00
            dc.b    'Operating System Support chip register'
            dc.b    $00
            dc.b    'Operating System Support chip interrupt'
            dc.b    $00
            dc.b    'IIfx type parity'
            dc.b    $00
            dc.b    'Apple Desktop Bus microcontroller self'
            dc.b    $00
            dc.b    'Sound interrupt'
            dc.b    $00
            dc.b    'Color lookup table'
            dc.b    $00
            dc.b    'Video RAM'
            dc.b    $00
            dc.b    '53C96 Turbo SCSI chip'
            dc.b    $00
            dc.b    'SONIC Ethernet register bitmarch'
            dc.b    $00
            dc.b    'SONIC Ethernet on-chip DMA'
            dc.b    $00
            dc.b    'SONIC Ethernet protocol loopback'
            dc.b    $00
USTCPUList:
            dc.w    $000C,0,$0024,$000E,0,$0078,$0010,0
            dc.w    $00CC,$000F,0,$0120,$000D,0,$0168,$00FD
            dc.w    0,$01C2,$0001,$0084,$001D,$0001,$0085,$001D
            dc.w    $0001,$0086,$001D,$0001,$0087,$001D,$0001,$0088
            dc.w    $001D,$0001,$0089,$001D,$0001,$008A,$001C,$0001
            dc.w    $008B,$001D,$0001,$008C,$001D,$0001,$008D,$001D
            dc.w    $0001,$0094,$001C,$0001,$0095,$001C,$0001,$0096
            dc.w    $001D,$FFFF,$FFFF,0,$0001,$0084,$001D,$0001
            dc.w    $0085,$001D,$0001,$0086,$001D,$0001,$0087,$001D
            dc.w    $0001,$0089,$001D,$0001,$0097,$001C,$0001,$0095
            dc.w    $001C,$0001,$0094,$001C,$0001,$008A,$001C,$0001
            dc.w    $009A,$001C,$0002,$009B,$001C,$0002,$009C,$001C
            dc.w    $0002,$009D,$001C,$FFFF,$FFFF,0,$0001,$0084
            dc.w    $001D,$0001,$0085,$001D,$0001,$0086,$001D,$0001
            dc.w    $0087,$001D,$0001,$0089,$001D,$0001,$008C,$001D
            dc.w    $0001,$0097,$001C,$0001,$0095,$001C,$0001,$008A
            dc.w    $001C,$0001,$009A,$001C,$0002,$009B,$001C,$0002
            dc.w    $009C,$001C,$0002,$009D,$001C,$FFFF,$FFFF,0
            dc.w    $0001,$0084,$001D,$0001,$0085,$001D,$0001,$0086
            dc.w    $001D,$0001,$0087,$001D,$0001,$0088,$001C,$0001
            dc.w    $0089,$001D,$0001,$008D,$001D,$0001,$008C,$001D
            dc.w    $0001,$0097,$001D,$0001,$0095,$001C,$0001,$008A
            dc.w    $001C,$FFFF,$FFFF,0,$0001,$0084,$001D,$0001
            dc.w    $0085,$001D,$0001,$0086,$001D,$0001,$0087,$001D
            dc.w    $0001,$0088,$001D,$0001,$0089,$001D,$0001,$008A
            dc.w    $001C,$0001,$008B,$001D,$0001,$008C,$001D,$0001
            dc.w    $008D,$001D,$0001,$0094,$001C,$0001,$0095,$001C
            dc.w    $0001,$0096,$001D,$0001,$0097,$001F,$FFFF,$FFFF
            dc.w    0,$0001,$0084,$001D,$0001,$0086,$001D,$0001
            dc.w    $0085,$001D,$0001,$0087,$001D,$0001,$0088,$001D
            dc.w    $0001,$0089,$001D,$0001,$008B,$001D,$0001,$008C
            dc.w    $001D,$0001,$008D,$001D,$0001,$008E,$001D,$0001
            dc.w    $0080,$001C,$0001,$0081,$001C,$0001,$0082,$001C
            dc.w    $0001,$0082,$001C,$0001,$008A,$001C,$0001,$0094
            dc.w    $001C,$0001,$0095,$001C,$0001,$0096,$001C,$0001
            dc.w    $0097,$001C,$FFFF,$FFFF
            ds.b    12
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
CritProc:
Mod3Test:
            movem.l .L10(PC),D0-D5
            movea.l A0,A2
            suba.w  #$78,A1
            bra.b   .L2
.L1:
            movem.l D0-D5,(A2)
            movem.l D0-D5,($18,A2)
            movem.l D0-D5,($30,A2)
            movem.l D0-D5,($48,A2)
            movem.l D0-D5,($60,A2)
            lea     ($78,A2),A2
.L2:
            cmpa.l  A1,A2
            ble.b   .L1
            suba.w  #$FF94,A1
            moveq   #$C,D5
            bra.b   .L4
.L3:
            movem.l D0-D2,(A2)
            adda.w  D5,A2
.L4:
            cmpa.l  A1,A2
            ble.b   .L3
            adda.w  D5,A1
            moveq   #4,D4
            cmpa.l  A2,A1
            beq.b   .L5
            move.l  D0,(A2)+
            moveq   #8,D4
            cmpa.l  A2,A1
            beq.b   .L5
            move.l  D1,(A2)+
            moveq   #0,D4
.L5:
            movea.l A0,A2
            move.l  A1,D3
            sub.l   A0,D3
            subq.l  #4,D3
            moveq   #$3F,D2
            and.w   D3,D2
            neg.w   D2
            lsr.l   #6,D3
            eor.l   D1,(A2)
            addi.l  #$FFFFFFFF,D5
            jmp     .L7(PC,D2.w)
.L6:
            move.l  (A2)+,D2
            eor.l   D2,(A2)
            move.l  (A2)+,D2
            eor.l   D2,(A2)
            move.l  (A2)+,D2
            eor.l   D2,(A2)
            move.l  (A2)+,D2
            eor.l   D2,(A2)
            move.l  (A2)+,D2
            eor.l   D2,(A2)
            move.l  (A2)+,D2
            eor.l   D2,(A2)
            move.l  (A2)+,D2
            eor.l   D2,(A2)
            move.l  (A2)+,D2
            eor.l   D2,(A2)
            move.l  (A2)+,D2
            eor.l   D2,(A2)
            move.l  (A2)+,D2
            eor.l   D2,(A2)
            move.l  (A2)+,D2
            eor.l   D2,(A2)
            move.l  (A2)+,D2
            eor.l   D2,(A2)
            move.l  (A2)+,D2
            eor.l   D2,(A2)
            move.l  (A2)+,D2
            eor.l   D2,(A2)
            move.l  (A2)+,D2
            eor.l   D2,(A2)
            move.l  (A2)+,D2
            eor.l   D2,(A2)
.L7:
            dbra    D3,.L6
            subi.l  #$10000,D3
            bpl.b   .L6
            cmpi.w  #$15,D7
            beq.w   .L9
            cmp.l   D0,D1
            beq.b   .L8
            move.l  D0,D1
            bra.b   .L5
.L8:
            movem.l (-$C,A1),D0-D2
            movem.l .L10(PC,D4.w),D3-D5
            eor.l   D3,D0
            eor.l   D4,D1
            eor.l   D5,D2
            or.l    D2,D0
            or.l    D1,D0
            or.l    D0,D6
            btst    #$12,D7
            beq.b   .L9
            move.w  #$15,D7
            movem.l .L11(PC),D0-D5
            bra.w   .L5
.L9:
            RTS6
.L10:
            dc.w    $6DB6,$DB6D
.L11:
            dc.w    $B6DB,$6DB6,$DB6D,$B6DB,$6DB6,$DB6D,$B6DB,$6DB6
            dc.w    $DB6D,$B6DB,0
RevMod3Test:
            movem.l sub_40847486(PC),D0-D5
            movea.l A1,A2
            lea     ($78,A0),A0
            bra.b   .L2
.L1:
            movem.l D0-D5,-(A2)
            movem.l D0-D5,-(A2)
            movem.l D0-D5,-(A2)
            movem.l D0-D5,-(A2)
            movem.l D0-D5,-(A2)
.L2:
            cmpa.l  A2,A0
            ble.b   .L1
            lea     (-$6C,A0),A0
            bra.b   .L4
.L3:
            movem.l D0-D2,-(A2)
.L4:
            cmpa.l  A2,A0
            ble.b   .L3
            suba.w  #$C,A0
            moveq   #8,D4
            cmpa.l  A2,A0
            beq.b   .L5
            move.l  D2,-(A2)
            moveq   #4,D4
            cmpa.l  A2,A0
            beq.b   .L5
            move.l  D1,-(A2)
            moveq   #0,D4
.L5:
            movea.l A1,A2
            subq.l  #4,A2
            move.l  A2,D3
            sub.l   A0,D3
            moveq   #$3F,D0
            and.w   D3,D0
            neg.w   D0
            lsr.l   #6,D3
            eor.l   D1,(A2)
            addi.l  #$FFFFFFFF,D5
            jmp     .L7(PC,D0.w)
.L6:
            move.l  (A2),D0
            eor.l   D0,-(A2)
            move.l  (A2),D0
            eor.l   D0,-(A2)
            move.l  (A2),D0
            eor.l   D0,-(A2)
            move.l  (A2),D0
            eor.l   D0,-(A2)
            move.l  (A2),D0
            eor.l   D0,-(A2)
            move.l  (A2),D0
            eor.l   D0,-(A2)
            move.l  (A2),D0
            eor.l   D0,-(A2)
            move.l  (A2),D0
            eor.l   D0,-(A2)
            move.l  (A2),D0
            eor.l   D0,-(A2)
            move.l  (A2),D0
            eor.l   D0,-(A2)
            move.l  (A2),D0
            eor.l   D0,-(A2)
            move.l  (A2),D0
            eor.l   D0,-(A2)
            move.l  (A2),D0
            eor.l   D0,-(A2)
            move.l  (A2),D0
            eor.l   D0,-(A2)
            move.l  (A2),D0
            eor.l   D0,-(A2)
            move.l  (A2),D0
            eor.l   D0,-(A2)
.L7:
            dbra    D3,.L6
.L8:
            subi.l  #$10000,D3
            bpl.b   .L6
.L9:
            cmpi.w  #$15,D7
.L10:
            beq.w   .L12
            cmp.l   D2,D1
            beq.b   .L11
            move.l  D2,D1
            bra.b   .L5
.L11:
            movem.l (A0),D0-D2
            movem.l sub_40847486(PC,D4.w),D3-D5
            eor.l   D3,D0
            eor.l   D4,D1
            eor.l   D5,D2
            or.l    D2,D0
            or.l    D1,D0
            or.l    D0,D6
            btst    #$12,D7
            beq.b   .L12
            move.w  #$15,D7
            movem.l sub_40847486.L1+2(PC),D0-D5
            bra.w   .L5
.L12:
            RTS6
sub_40847486:
            blt.b   RevMod3Test.L7
.L1:
            add.w   D5,(-$4925,A5)
            blt.b   RevMod3Test.L8+2
            add.w   D5,(-$4925,A5)
            blt.b   RevMod3Test.L9
            add.w   D5,(-$4925,A5)
            blt.b   RevMod3Test.L10+2
            add.w   D5,(-$4925,A5)
RomTest:
            BigLea  BaseOfROM,A0
            lea     ($30,A0),A1
            move.l  ($40,A0),D0
            lea     (0,A0,D0.l),A2
            moveq   #0,D0
            moveq   #0,D1
            moveq   #0,D2
            moveq   #0,D3
            moveq   #0,D4
            addq.l  #4,A0
.L1:
            move.b  (A0)+,D4
            add.l   D4,D0
            move.b  (A0)+,D4
            add.l   D4,D1
            move.b  (A0)+,D4
            add.l   D4,D2
            move.b  (A0)+,D4
            add.l   D4,D3
            cmpa.l  A0,A1
            bne.b   .L2
            adda.w  #$10,A0
            bra.b   .L1
.L2:
            cmpa.l  A0,A2
            bgt.b   .L1
            cmp.l   (A1)+,D0
            beq.b   .L3
            bset    #0,D6
.L3:
            cmp.l   (A1)+,D1
            beq.b   .L4
            bset    #1,D6
.L4:
            cmp.l   (A1)+,D2
            beq.b   .L5
            bset    #2,D6
.L5:
            cmp.l   (A1)+,D3
            beq.b   .L6
            bset    #3,D6
.L6:
            RTS6
StartUpROMTest:
            moveq   #0,D0
            moveq   #0,D1
            BigLea  BaseOfROM,A0
            move.l  ($40,A0),D3
            subq.l  #4,D3
            move.l  (A0)+,D4
.L1:
            move.w  (A0)+,D0
            add.l   D0,D1
            subq.l  #2,D3
            bne.b   .L1
            nop
            nop
            eor.l   D4,D1
            beq.b   .L2
            move.w  #$FFFF,D6
.L2:
            RTS6
ExtRAMTest:
            moveq   #0,D0
            moveq   #-1,D1
            movea.l A0,A2
            move.l  A1,D2
            sub.l   A0,D2
            lsr.l   #2,D2
            move.l  D2,D3
.L1:
            move.l  D0,(A2)+
            subq.l  #1,D2
            bne.b   .L1
            move.l  D3,D2
            movea.l A0,A2
.L2:
            tst.l   (A2)
            bne.b   .L7
            eor.l   D1,(A2)+
            subq.l  #1,D2
            bne.b   .L2
            move.l  D3,D2
.L3:
            eor.l   D1,-(A2)
            bne.b   .L7
            subq.l  #1,D2
            bne.b   .L3
            move.l  D3,D2
.L4:
            tst.l   (A2)
            bne.b   .L7
            eor.l   D1,(A2)+
            subq.l  #1,D2
            bne.b   .L4
            move.l  D3,D2
.L5:
            eor.l   D1,-(A2)
            bne.b   .L7
            subq.l  #1,D2
            bne.b   .L5
            move.l  D3,D2
.L6:
            tst.l   (A2)
            bne.b   .L7
            addq.l  #4,A2
            subq.l  #1,D2
            bne.b   .L6
            RTS6
.L7:
            or.l    (A2),D6
            RTS6
AddrLineTest:
            clr.b   D7
            movea.l A6,A3
            BSR6    SizeMemory
            movea.l A3,A6
            bne.b   .L8
            movea.l (SP),A0
.L1:
            addq.b  #1,D7
            movea.l (A0)+,A1
            cmpa.w  #$FFFF,A1
            beq.b   .L3
            movea.l (A0)+,A2
            move.l  A1,(A1)
            moveq   #4,D5
.L2:
            movea.l D5,A3
            adda.l  A1,A3
            move.l  A3,(A3)
            lsl.l   #1,D5
            cmp.l   A2,D5
            blt.b   .L2
            bra.b   .L1
.L3:
            lea     (-4,A0),A0
.L4:
            subq.b  #1,D7
            movea.l -(A0),A2
            movea.l -(A0),A1
            moveq   #4,D5
.L5:
            lsl.l   #1,D5
            cmp.l   A2,D5
            blt.b   .L5
.L6:
            lsr.l   #1,D5
            move.l  D5,D0
            add.l   A1,D0
            movea.l D0,A3
            move.l  (A3),D6
            eor.l   D0,D6
            bne.b   .L8
            cmpi.l  #4,D5
            bgt.b   .L6
            tst.l   D5
            beq.b   .L7
            moveq   #0,D5
            bra.b   .L6
.L7:
            cmpa.l  (SP),A0
            bgt.b   .L4
            clr.b   D7
.L8:
            RTS6
DataBusTest:
            moveq   #1,D0
            moveq   #-2,D1
            move.w  #$FF,D2
.L1:
            movem.l D0-D1,(A0)
            eor.l   D0,(A0)
            or.l    (A0),D6
            eor.l   D1,(4,A0)
            or.l    (4,A0),D6
            rol.l   #1,D0
            rol.l   #1,D1
            dbra    D2,.L1
            RTS6
.L2:
            dc.w    $0011,$2233
.L3:
            dc.w    $8888,$8888,$8800,$1122,$3388,$8888,$8888,$0011
            dc.w    $2233,$8888,$8888,$8800,$1122,$3388,$8888,$8888
            dc.w    $0011,$2233,$0011,$8888,$8888,$8888,$8800,$1188
            dc.w    $8888,$8888,$8888,$0011,$8888,$8888,$8888,$8800
            dc.w    $1188,$8888,$8888,$8888,$0011,$8888,$0088,$8888
            dc.w    $8888,$8888,$8800,$8888,$8888,$8888,$8888,$0088
            dc.w    $8888,$8888,$8888,$8800,$8888,$8888,$8888,$8888
            dc.w    $0088,$8888
dynamic_bussize_test:
            move.l  #$7FFF,D6
            lea     DataBusTest.L2,A1
            lea     DataBusTest.L3,A2
            move.l  #$112233,D0
            moveq   #0,D1
.L1:
            move.l  (A2),(A0)
            move.l  (A2),(4,A0)
            move.l  D0,(0,A0,D1.w)
            movem.l (A0),D2-D3
            movem.l (A1)+,D4-D5
            cmp.l   D4,D2
            bne.b   .L2
            cmp.l   D5,D3
            bne.b   .L2
            swap    D1
            bclr    D1,D6
            swap    D1
.L2:
            addq.l  #1,D1
            swap    D1
            addq.w  #1,D1
            swap    D1
            cmpi.b  #4,D1
            bls.b   .L1
            move.w  #$11,D0
            clr.w   D1
.L3:
            move.l  (A2),(A0)
            move.l  (A2),(4,A0)
            move.w  D0,(0,A0,D1.w)
            movem.l (A0),D2-D3
            movem.l (A1)+,D4-D5
            cmp.l   D4,D2
            bne.b   .L4
            cmp.l   D5,D3
            bne.b   .L4
            swap    D1
            bclr    D1,D6
            swap    D1
.L4:
            addq.l  #1,D1
            swap    D1
            addq.w  #1,D1
            swap    D1
            cmpi.b  #4,D1
            bls.b   .L3
            moveq   #0,D0
            clr.w   D1
.L5:
            move.l  (A2),(A0)
            move.l  (A2),(4,A0)
            move.b  D0,(0,A0,D1.w)
            movem.l (A0),D2-D3
            movem.l (A1)+,D4-D5
            cmp.l   D4,D2
            bne.b   .L6
            cmp.l   D5,D3
            bne.b   .L6
            swap    D1
            bclr    D1,D6
            swap    D1
.L6:
            addq.l  #1,D1
            swap    D1
            addq.w  #1,D1
            swap    D1
            cmpi.b  #4,D1
            bls.b   .L5
            RTS6
MovInvTest:
            movea.l A0,A5
            move.l  A1,D3
            sub.l   A0,D3
.L1:
            clr.l   (A0)+
            subq.l  #4,D3
            bne.b   .L1
            moveq   #0,D1
            move.w  #4,D1
.L2:
            suba.l  A2,A2
.L3:
            movea.l A5,A0
            adda.l  A2,A0
            moveq   #0,D2
            moveq   #0,D4
.L4:
            movea.l A0,A3
.L5:
            move.l  (A3),D3
            cmp.l   D3,D4
            bne.w   .L9
            bset    D2,D3
            move.l  D3,(A3)
            move.l  (A3),D5
            cmp.l   D5,D3
            bne.w   .L10
            adda.l  D1,A3
            cmpa.l  A1,A3
            bmi.b   .L5
            move.l  D5,D4
            addq.w  #1,D2
            cmpi.w  #$20,D2
            bne.b   .L4
            moveq   #0,D2
            moveq   #-1,D4
.L6:
            movea.l A0,A3
.L7:
            move.l  (A3),D3
            cmp.l   D3,D4
            bne.w   .L9
            bclr    D2,D3
            move.l  D3,(A3)
            move.l  (A3),D5
            cmp.l   D5,D3
            bne.w   .L10
            adda.l  D1,A3
            cmpa.l  A1,A3
            bmi.b   .L7
            move.l  D5,D4
            addq.w  #1,D2
            cmpi.w  #$20,D2
            bne.b   .L6
            addq.l  #4,A2
            cmpa.l  D1,A2
            bne.b   .L3
            asl.l   #1,D1
            cmpi.l  #$80000,D1
            bne.b   .L2
.L8:
            movea.l A5,A0
            RTS6
.L9:
            eor.l   D3,D4
            move.l  D4,D6
            bra.b   .L8
.L10:
            eor.l   D5,D3
            move.l  D3,D6
            bra.b   .L8
NoTest:
            moveq   #0,D6
            RTS6
            dc.w    0
NonCritProc:
VramDataTest:
VramAddrTest:
MapRamUniqTest:
MapRamDataTest:
            moveq   #-1,D6
            RTS6
SetSCCIOPBypass:
            move.b  #$32,(-$1C,A3)
            lea     .L5,A0
            movea.l A0,A1
            move.w  (A0)+,D0
            move.w  (A0)+,(-$1F,A3)
.L1:
            move.b  (A0)+,(-$18,A3)
            dbra    D0,.L1
            move.w  (A1)+,D0
            move.w  (A1)+,(-$1F,A3)
.L2:
            move.b  (-$18,A3),D1
            cmp.b   (A1)+,D1
            bne.b   .L4
            dbra    D0,.L2
            move.b  #$36,(-$1C,A3)
            lsr.w   #6,D0
.L3:
            dbra    D0,.L3
.L4:
            addq.w  #1,D0
            RTS6
.L5:
            dc.w    $0011,$7FEE,$A981,$8D30,$F0A9,$448D,$31F0,$80FE
            dc.w    $EE7F,$EE7F,$EE7F
GetSCCVIABases:
            movea.l (8,A0),A2
            btst    #$11,D0
            beq.b   .L1
            movea.l ($44,A0),A3
            moveq   #0,D3
            bra.b   .L2
.L1:
            movea.l ($C,A0),A3
            move.l  ($10,A0),D3
            sub.l   A3,D3
.L2:
            bclr    #3,($1E00,A2)
            bset    #3,($600,A2)
            addq.w  #2,A3
            rts
Restore_USTNonCritTsts:
            lea     LocalSCCInt.L3,A0
            bsr.b   writescc
            lea     LocalSCCInt.L4,A0
            bsr.b   writescc
            subq.w  #2,A3
            lea     LocalSCCInt.L4,A0
            bsr.b   writescc
            rts
writescc:
            move.w  (A0)+,D0
            move.b  (A3),D2
.L1:
            move.w  (SP),(SP)
            move.b  (A0)+,(0,A3,D3.l)
            dbra    D0,.L1
            rts
scclp:
            move.w  #$3E8,D0
.L1:
            tst.b   (A2)
            dbra    D0,.L1
            tst.b   (4,A3)
            move.w  #$80,D1
.L2:
            moveq   #-1,D4
            moveq   #0,D6
            move.b  #$30,(0,A3,D3.l)
            move.b  (SP),(SP)
.L3:
            btst    #2,(A3)
            bne.b   .L4
            dbra    D4,.L3
            moveq   #1,D6
            bra.b   .L11
.L4:
            move.b  D1,(4,A3,D3.l)
            moveq   #-1,D4
.L5:
            move.b  #1,(0,A3,D3.l)
            move.w  (SP),(SP)
            btst    #0,(A3)
            bne.b   .L6
            dbra    D4,.L5
            moveq   #2,D6
            bra.b   .L11
.L6:
            move.w  #$FFFF,D4
.L7:
            btst    #0,(A3)
            bne.b   .L8
            dbra    D4,.L7
            moveq   #3,D6
            bra.b   .L11
.L8:
            move.b  (4,A3),D2
            cmp.b   D1,D2
            beq.b   .L9
            moveq   #4,D6
            bra.b   .L11
.L9:
            move.b  #1,(0,A3,D3.l)
            move.w  (SP),(SP)
            move.b  (A3),D2
            andi.b  #$70,D2
            beq.b   .L10
            moveq   #5,D6
            bra.b   .L11
.L10:
            lsr.b   #1,D1
            bne.b   .L2
.L11:
            rts
SCCLoopTest:
            move    SR,-(SP)
            ori     #$700,SR
            movec   CACR,D3
            move.l  D3,-(SP)
            bclr    #$F,D3
            movec   D3,CACR
            bsr.w   GetSCCVIABases
            lea     LocalSCCInt.L2,A0
            bsr.w   writescc
            lea     LocalSCCInt.L5,A0
            bsr.w   writescc
            bsr.w   scclp
            bne.b   .L1
            bsr.w   writescc
            lea     LocalSCCInt.L2,A0
            bsr.w   writescc
            lea     LocalSCCInt.L5,A0
            bsr.w   writescc
            bsr.w   scclp
            addq.w  #2,A3
            beq.b   .L1
            addi.w  #$10,D6
.L1:
            bsr.w   Restore_USTNonCritTsts
            move.l  (SP)+,D3
            movec   D3,CACR
            move    (SP)+,SR
            RTS6
regLoop:
            moveq   #0,D6
            move.w  #$FF,D1
            moveq   #0,D4
            move.b  (A3),D0
            move.l  (SP),(SP)
            move.b  D2,(0,A3,D3.l)
            move.l  (SP),(SP)
            move.b  (A3),-(SP)
            move.l  (SP),(SP)
.L1:
            move.b  D2,(0,A3,D3.l)
            move.l  (SP),(SP)
            and.b   D5,D4
            move.b  D4,(0,A3,D3.l)
            move.l  (SP),(SP)
            move.b  D2,(0,A3,D3.l)
            move.l  (SP),(SP)
            move.b  (A3),D0
            and.b   D5,D0
            cmp.b   D4,D0
            bne.b   .L2
            addq.l  #1,D4
            dbra    D1,.L1
            bra.b   .L3
.L2:
            move.b  #$FF,D6
            asl.l   #8,D6
            move.b  D2,D6
            asl.l   #8,D6
            move.b  D4,D6
            asl.l   #8,D6
            move.b  D0,D6
.L3:
            move.b  D2,(0,A3,D3.l)
            move.l  (SP),(SP)
            move.b  (SP)+,(0,A3,D3.l)
            tst.l   D6
            rts
SCCRegTest:
            bsr.w   GetSCCVIABases
            lea     LocalSCCInt.L3,A0
            bsr.w   writescc
            lea     LocalSCCInt.L7,A4
.L1:
            move.b  (A4)+,D2
            bmi.b   .L2
            move.b  (A4)+,D5
            bsr.b   regLoop
            beq.b   .L1
            bra.b   .L5
.L2:
            subq.w  #2,A3
            lea     LocalSCCInt.L8,A4
.L3:
            move.b  (A4)+,D2
            bmi.b   .L4
            move.b  (A4)+,D5
            bsr.w   regLoop
            beq.b   .L3
.L4:
            addq.w  #2,A3
.L5:
            bsr.w   Restore_USTNonCritTsts
            RTS6
DisableInts:
            movea.l (SP)+,A1
            ori     #$700,SR
            btst    #$12,D0
            beq.b   .L2
            movea.l ($48,A0),A2
            moveq   #$E,D1
.L1:
            move.b  (0,A2,D1.w),-(SP)
            clr.b   (0,A2,D1.w)
            dbra    D1,.L1
.L2:
            btst    #$B,D0
            beq.b   .L3
            movea.l ($2C,A0),A2
            move.b  ($1C00,A2),-(SP)
            move.b  #$7F,($1C00,A2)
.L3:
            btst    #$D,D0
            beq.b   .L4
            movea.l ($34,A0),A2
            move.b  ($13,A2),-(SP)
            move.b  #$7F,($13,A2)
.L4:
            movea.l (8,A0),A2
            move.b  ($1C00,A2),-(SP)
            move.b  #$7F,($1C00,A2)
            jmp     (A1)
RestoreInts:
            movea.l (SP)+,A1
            movea.l (8,A0),A2
            move.b  #$7F,($1C00,A2)
            move.b  (SP)+,($1C00,A2)
            btst    #$D,D0
            beq.b   .L1
            movea.l ($34,A0),A2
            move.b  (SP)+,($13,A2)
            move.b  #$FF,($12,A2)
.L1:
            btst    #$B,D0
            beq.b   .L2
            movea.l ($2C,A0),A2
            move.b  #$7F,($1C00,A2)
            move.b  (SP)+,($1C00,A2)
.L2:
            btst    #$12,D0
            beq.b   .L4
            movea.l ($48,A0),A2
            moveq   #0,D1
.L3:
            move.b  (SP)+,(0,A2,D1.w)
            addq.b  #1,D1
            cmpi.b  #$E,D1
            ble.b   .L3
.L4:
            jmp     (A1)
SCCTimerTest:
            bsr.w   GetSCCVIABases
            bsr.w   DisableInts
            move.l  D0,-(SP)
            move.l  A0,-(SP)
            btst    #$12,D0
            beq.b   .L1
            movea.l ($48,A0),A1
            move.b  #4,(7,A1)
.L1:
            movec   VBR,A5
            adda.w  #$70,A5
            move.l  (A5),-(SP)
            lea     LocalSCCInt,A1
            move.l  A1,(A5)
            lea     LocalSCCInt.L6,A0
            bsr.w   writescc
            moveq   #1,D6
            moveq   #-1,D1
            move.l  #$50000,D0
            move    #$2300,SR
.L2:
            tst.w   D1
            beq.b   .L3
            subq.l  #1,D0
            bne.b   .L2
            bra.b   .L5
.L3:
            tst.w   D1
            bne.b   .L4
            subq.l  #1,D0
            bne.b   .L3
            moveq   #2,D6
            bra.b   .L5
.L4:
            ori     #$700,SR
            sub.l   D2,D5
            moveq   #3,D6
            cmpi.l  #$10000,D5
            bgt.b   .L5
            moveq   #4,D6
            cmpi.l  #$100,D5
            blt.b   .L5
            moveq   #0,D6
.L5:
            lea     LocalSCCInt.L3,A0
            bsr.w   writescc
            ori     #$700,SR
            movec   VBR,A5
            adda.w  #$70,A5
            move.l  (SP)+,(A5)
            movea.l (SP)+,A0
            move.l  (SP)+,D0
            bsr.w   RestoreInts
            RTS6
LocalSCCInt:
            move.b  #$10,(0,A3,D3.l)
            move.l  D0,D2
            tst.w   D1
            bpl.b   .L1
            move.l  D2,D5
.L1:
            addq.w  #1,D1
            tst.b   ($1C00,A2)
            tst.b   ($1A00,A2)
            rte
.L2:
            dc.w    $0011,$09C0,$044C,$0B50,$0F00,$0C00,$0D00,$0E01
            dc.w    $03C1,$056A
.L3:
            dc.w    $0001,$09C0
.L4:
            dc.w    $0007,$0F08,$0010,$0101,$0908
.L5:
            dc.w    $0003,$0E11,$0568
.L6:
            dc.w    $0011,$09C0,$0CFF,$0DFF,$0E00,$0E03,$0F02,$0010
            dc.w    $0101,$090A
.L7:
            dc.w    $02FF,$0CFF,$0DFF,$0FFA,$FFFF
.L8:
            dc.w    $0200,$0CFF,$0DFF,$0FFA,$FFFF
VIATest:
            bsr.w   DisableInts
            btst    #$12,D0
            beq.b   .L1
            movea.l ($48,A0),A1
            move.b  #1,($B,A1)
            move.b  #1,($A,A1)
.L1:
            movec   VBR,A2
            adda.w  #$64,A2
            move.l  (A2),-(SP)
            lea     LocalVIA1Int,A3
            move.l  A3,(A2)
            moveq   #0,D6
            move.l  D0,D1
            movea.l (8,A0),A2
            andi.b  #$1F,($1600,A2)
            ori.b   #$40,($1600,A2)
            move.b  #$62,($1A00,A2)
            move.b  #$E2,($1C00,A2)
            moveq   #0,D3
            moveq   #0,D4
            moveq   #0,D5
            move.b  #$FF,($A00,A2)
            move.b  #$FF,($1200,A2)
            move.b  #$FF,($800,A2)
            move.b  #$FF,($1000,A2)
            move.b  #2,($A00,A2)
            move.b  #$3F,($1200,A2)
            move.l  #$F0000,D0
            move    #$2000,SR
.L2:
            cmpi.w  #$A,D3
            beq.b   .L3
            subq.l  #1,D0
            bne.b   .L2
.L3:
            ori     #$700,SR
            moveq   #1,D6
            tst.w   D3
            beq.w   .L9
            moveq   #2,D6
            cmpi.w  #$A,D3
            bne.w   .L9
            moveq   #3,D6
            tst.w   D4
            beq.w   .L9
            moveq   #4,D6
            cmpi.w  #$80,D4
            bmi.w   .L9
            moveq   #5,D6
            cmpi.w  #$D0,D4
            bpl.w   .L9
            moveq   #6,D6
            tst.w   D5
            beq.w   .L9
            moveq   #7,D6
            cmpi.w  #1,D5
            bne.w   .L9
            moveq   #8,D6
            moveq   #-1,D0
.L4:
            tst.b   ($800,A2)
            dbne    D0,.L4
            beq.w   .L9
            moveq   #9,D6
            moveq   #-1,D0
.L5:
            tst.b   ($1000,A2)
            dbne    D0,.L5
            beq.w   .L9
            andi.b  #$1F,($1600,A2)
            move.b  #$62,($1A00,A2)
            move.b  #$E2,($1C00,A2)
            moveq   #0,D3
            moveq   #0,D4
            moveq   #0,D5
            move.b  #$FF,($A00,A2)
            move.b  #$FF,($1200,A2)
            move.b  #$FF,($800,A2)
            move.b  #$FF,($1000,A2)
            move.b  #4,($A00,A2)
            move.b  #$1F,($1200,A2)
            move.l  #$F0000,D0
            move    #$2000,SR
.L6:
            cmpi.w  #$A,D3
            beq.b   .L7
            subq.l  #1,D0
            bne.b   .L6
.L7:
            ori     #$700,SR
            moveq   #$A,D6
            tst.w   D3
            beq.b   .L9
            moveq   #$B,D6
            tst.w   D4
            beq.b   .L9
            moveq   #$C,D6
            cmpi.w  #1,D4
            bne.b   .L9
            moveq   #$D,D6
            tst.w   D5
            beq.b   .L9
            moveq   #$E,D6
            cmpi.w  #1,D5
            bne.b   .L9
            moveq   #$F,D6
            moveq   #-1,D0
.L8:
            tst.b   ($1000,A2)
            dbne    D0,.L8
            beq.b   .L9
            clr.w   D6
.L9:
            andi.b  #$1F,($1600,A2)
            ori     #$700,SR
            movec   VBR,A2
            adda.w  #$64,A2
            move.l  (SP)+,(A2)
            move.l  D1,D0
            bsr.w   RestoreInts
            RTS6
LocalVIA1Int:
            move.l  D0,-(SP)
            move.b  ($1A00,A2),D0
            andi.b  #$62,D0
            move.b  D0,($1A00,A2)
            btst    #$12,D1
            beq.b   .L1
            move.w  ($202,A1),D2
            btst    #$A,D2
            beq.b   .L3
            clr.b   ($207,A1)
            bra.b   .L2
.L1:
            btst    #1,D0
            beq.b   .L3
.L2:
            addq.w  #1,D3
.L3:
            btst    #6,D0
            beq.b   .L4
            addq.w  #1,D4
.L4:
            btst    #5,D0
            beq.b   .L5
            addq.w  #1,D5
.L5:
            move.l  (SP)+,D0
            rte
TestSCSI:
            btst    #8,D0
            beq.w   .L2
            movea.l (8,A0),A2
            movea.l ($20,A0),A0
            movea.l A0,A1
            adda.w  #0,A1
            move.b  #$80,($10,A1)
            moveq   #0,D0
            move.b  D0,($10,A1)
            tst.b   ($70,A0)
            moveq   #1,D6
            move.b  #$80,($10,A1)
            move.b  ($10,A0),D1
            cmpi.b  #$80,D1
            bne.w   .L1
            addq.w  #1,D6
            move.b  ($40,A0),D1
            andi.b  #$80,D1
            cmpi.b  #$80,D1
            bne.w   .L1
            clr.b   ($10,A1)
            addq.w  #1,D6
            tst.b   ($1C00,A2)
            tst.b   ($1A00,A2)
            move.b  #$10,($10,A1)
            move.b  ($10,A0),D1
            cmpi.b  #$10,D1
            bne.b   .L1
            addq.w  #1,D6
            move.b  ($50,A0),D1
            andi.b  #1,D1
            cmpi.b  #1,D1
            bne.b   .L1
            addq.w  #1,D6
            move.b  #8,($10,A1)
            move.b  ($10,A0),D1
            cmpi.b  #8,D1
            bne.b   .L1
            addq.w  #1,D6
            move.b  ($40,A0),D1
            andi.b  #$40,D1
            cmpi.b  #$40,D1
            bne.b   .L1
            addq.w  #1,D6
            move.b  #4,($10,A1)
            move.b  ($10,A0),D1
            cmpi.b  #4,D1
            bne.b   .L1
            addq.w  #1,D6
            move.b  ($40,A0),D1
            andi.b  #2,D1
            cmpi.b  #2,D1
            bne.b   .L1
            addq.w  #1,D6
            move.b  #2,($10,A1)
            move.b  ($10,A0),D1
            cmpi.b  #2,D1
            bne.b   .L1
            addq.w  #1,D6
            move.b  ($50,A0),D1
            andi.b  #2,D1
            cmpi.b  #2,D1
            bne.b   .L1
            moveq   #0,D6
.L1:
            RTS6
.L2:
            moveq   #-1,D6
            RTS6
TestASC:
            btst    #$C,D0
            beq.w   sub_40847FC4.L12
            movem.l D0-D5/A0-A4,-(SP)
            move    SR,-(SP)
            ori     #$700,SR
            moveq   #0,D6
            moveq   #0,D5
            moveq   #0,D4
            movea.l (8,A0),A2
            movea.l ($30,A0),A1
            move.b  ($800,A1),D3
            andi.b  #$F0,D3
            cmpi.b  #$E0,D3
            bne.b   .L1
            lea     sub_40847FC4.L8,A4
            lea     sub_40847FC4.L9,A3
            bra.b   .L5
.L1:
            cmpi.b  #$B0,D3
            bne.b   .L2
            lea     sub_40847FC4.L6,A4
            lea     sub_40847FC4.L7,A3
            bra.b   .L5
.L2:
            move.w  D2,D3
            lsr.w   #8,D3
            cmpi.b  #$C,D3
            bne.b   .L3
            lea     sub_40847FC4.L2,A4
            lea     sub_40847FC4.L4,A3
            bra.b   .L5
.L3:
            lea     sub_40847FC4.L10,A4
            lea     sub_40847FC4.L11,A3
            move.b  #$1C,($806,A1)
            move.b  ($806,A1),D3
            andi.b  #$1C,D3
            bne.b   .L5
            lea     sub_40847FC4.L3,A4
            lea     sub_40847FC4.L5,A3
            bra.b   .L5
.L4:
            addq.l  #2,A4
.L5:
            move.l  (A4)+,D3
            bmi.b   .L7
            subq.w  #1,D3
.L6:
            swap    D3
            move.b  (A3)+,D4
            move.b  D4,(0,A1,D3.w)
            tst.b   (A2)
            move.b  (0,A1,D3.w),D5
            and.w   (A4),D5
            swap    D3
            cmp.b   D4,D5
            dbne    D3,.L6
            beq.b   .L4
            swap    D3
            move.l  #$10000,D6
            move.w  D3,D6
            bra.w   .L17
.L7:
            cmpi.b  #7,D2
            beq.w   .L17
            move.b  #2,($801,A1)
            clr.b   ($80A,A1)
            clr.b   ($806,A1)
            clr.b   D5
.L8:
            move.w  #$7FF,D4
            movea.l A1,A2
.L9:
            move.b  D5,D3
            eor.b   D4,D3
            move.b  D3,(A2)+
            dbra    D4,.L9
            movea.l A1,A2
            move.w  #$7FF,D4
.L10:
            move.b  D5,D3
            eor.b   D4,D3
            move.b  (A2)+,D1
            cmp.b   D3,D1
            bne.b   .L11
            dbra    D4,.L10
            cmpi.b  #$FF,D5
            beq.b   .L12
            move.b  #$FF,D5
            bra.b   .L8
.L11:
            move.l  #$20000,D6
            move.w  A2,D6
            andi.w  #$7FF,D6
            bra.w   .L17
.L12:
            move.w  D2,D3
            lsr.w   #8,D3
            cmpi.b  #$C,D3
            bne.b   .L17
            move.b  ($800,A1),D3
            andi.b  #$F0,D3
            cmpi.b  #$B0,D3
            beq.b   .L17
            move.b  #$81,($80A,A1)
            move.b  #$80,($803,A1)
            clr.b   ($803,A1)
            clr.b   D5
.L13:
            move.w  #$3FF,D4
            movea.l A1,A2
.L14:
            move.b  D5,D3
            eor.b   D4,D3
            move.b  D3,(A2)+
            dbra    D4,.L14
            movea.l A1,A2
            move.w  #$3FF,D4
.L15:
            move.b  D5,D3
            eor.b   D4,D3
            move.b  (A2)+,D1
            cmp.b   D3,D1
            bne.b   .L16
            dbra    D4,.L15
            cmpi.b  #$FF,D5
            beq.b   .L17
            move.b  #$FF,D5
            bra.b   .L13
.L16:
            move.l  #$30000,D6
            move.w  A2,D6
            andi.w  #$3FF,D6
.L17:
            bsr.b   sub_40847FC4
            btst    #$B,D0
            beq.b   .L18
            movea.l ($2C,A0),A2
            ori.b   #$90,($1C00,A2)
.L18:
            btst    #$D,D0
            beq.b   .L19
            movea.l ($34,A0),A2
            ori.b   #$90,(3,A2)
.L19:
            move    (SP)+,SR
            movem.l (SP)+,D0-D5/A0-A4
            RTS6
sub_40847FC4:
            move.w  D2,D3
            lsr.w   #8,D3
            cmpi.b  #$C,D3
            bne.b   .L1
            move.b  #1,($80A,A1)
            tst.b   ($804,A1)
            clr.b   ($80A,A1)
.L1:
            move.b  #1,($801,A1)
            clr.b   ($802,A1)
            move.b  #$80,($803,A1)
            clr.b   ($803,A1)
            tst.b   ($804,A1)
            clr.b   ($805,A1)
            clr.b   ($806,A1)
            clr.b   ($807,A1)
            clr.b   ($80F,A1)
            rts
.L2:
            dc.w    $080A,$0008,$0083
.L3:
            dc.w    $0801,$0004,$00FF,$0802,$000D,$007F,$0803,$0003
            dc.w    $00FF,$0804,$0006,$00FF,$0805,$000C,$00FF,$0807
            dc.w    $0004,$00FF,$FFFF,$FFFF,$FFFF
.L4:
            dc.w    $0001,$0203,$8182,$8300
.L5:
            dc.w    $0001,$0200,$0001,$0204,$0810,$1E1D,$1B17,$0F1F
            dc.w    0,$8000,$0001,$0204,$0800,$0080,$0102,$0408
            dc.w    $070B,$0D0E,$0F00,$0002,$0300
.L6:
            dc.w    $0801,$0003,$0003,$0806,$0008,$00E0,$080A,$0003
            dc.w    $0001,$0F08,$0009,$00FF,$0F28,$0009,$00FF,$FFFF
            dc.w    $FFFF,$FFFF
.L7:
            dc.w    $0001,0,$2040,$6080,$A0C0,$E000,$0100,$0001
            dc.w    $0203,$8081,$8283,0,$0102,$0380,$8182,$8300
.L8:
            dc.w    $0801,$0001,$00FF,$0802,$0001,$007F,$0806,$0008
            dc.w    $00FF,$080A,$0005,$00FF,$FFFF,$FFFF,$FFFF
.L9:
            dc.w    $0101,$0020,$4060,$80A0,$C0E0,$0001,$0203,0
.L10:
            dc.w    $0801,$0004,$00FF,$0802,$0005,$007F,$0803,$0009
            dc.w    $00FF,$0804,$0006,$00FF,$0805,$000C,$00FF,$0807
            dc.w    $0004,$00FF,$FFFF,$FFFF,$FFFF
.L11:
            dc.w    $0001,$0200,$0001,$0203,0,$0102,$8003,$8182
            dc.w    $8300,$0001,$0204,$0800,$0080,$0102,$0408,$070B
            dc.w    $0D0E,$0F00,$0002,$0300
.L12:
            moveq   #-1,D6
            RTS6
PramTest:
            move.l  A6,-(SP)
            movea.l (8,A0),A2
            move.l  #$FF,D3
            movea.l SP,A3
            lea     (-$100,SP),SP
.L1:
            move.l  A3,-(SP)
            move.l  D3,D1
            BSR6    RdXByte
            movea.l (SP)+,A3
            move.b  D1,-(A3)
            dbra    D3,.L1
            BSR6    CLKWPOFF
            move.l  #$7C00FC,D1
            swap    D1
            moveq   #0,D2
            BSR6    WrXByte
            clr.w   -(SP)
            move.w  #$7F,-(SP)
            bsr.w   PRAMParamTest
            lea     (4,SP),SP
            tst.l   D6
            bne.b   .L2
            bsr.w   RestoreallPRAM
            move.l  #$7C00FC,D1
            moveq   #0,D2
            BSR6    WrXByte
            move.w  #$80,-(SP)
            move.w  #$FF,-(SP)
            bsr.w   PRAMParamTest
            lea     (4,SP),SP
.L2:
            bsr.w   RestoreallPRAM
            lea     ($100,SP),SP
            rts
RestoreallPRAM:
            lea     (4,SP),A3
            moveq   #0,D3
.L1:
            move.b  (A3)+,D2
            move.l  D3,D1
            move.l  A3,-(SP)
            BSR6    WrXByte
            movea.l (SP)+,A3
            addq.w  #1,D3
            cmpi.w  #$100,D3
            bne.b   .L1
            rts
PRAMParamTest:
            moveq   #0,D6
            move.w  (6,SP),D3
.L1:
            move.w  D3,D1
            move.w  #$A5,D2
            BSR6    WrXByte
            move.w  D3,D1
            BSR6    RdXByte
            cmpi.b  #$A5,D1
            beq.b   .L2
            move.b  D3,D6
            rol.l   #8,D6
            move.b  #$A5,D6
            rol.l   #8,D6
            move.b  D1,D6
            bra.b   .L3
.L2:
            addq.w  #1,D3
            cmp.w   (4,SP),D3
            ble.b   .L1
.L3:
            rts
TestRBV:
            move    #0,CCR
            moveq   #0,D6
            moveq   #0,D5
            moveq   #0,D4
            btst    #$D,D0
            beq.w   .L20
            movea.l ($34,A0),A0
            lea     .L17,A2
            lea     .L18,A3
            move.l  ($1C,A1),D1
            btst    #7,D1
            beq.b   .L1
            lea     .L19,A3
.L1:
            moveq   #0,D1
            move.b  (A2)+,D1
            bmi.w   .L7
            move.b  (A3)+,D2
            moveq   #-1,D4
            move.b  (0,A0,D1.w),-(SP)
.L2:
            move.b  D4,D3
            tst.b   D1
            bne.b   .L3
            ori.b   #$D,D4
.L3:
            and.b   D2,D4
            move.b  D4,(0,A0,D1.w)
            move.b  (0,A0,D1.w),D5
            and.b   D2,D5
            cmp.b   D4,D5
            bne.w   .L6
            move.b  D3,D4
            roxr.b  #1,D4
            cmpi.b  #$FF,D4
            bne.b   .L2
            roxr.b  #1,D4
            clr.b   D4
.L4:
            move.b  D4,D3
            tst.b   D1
            bne.b   .L5
            ori.b   #$D,D4
.L5:
            and.b   D2,D4
            move.b  D4,(0,A0,D1.w)
            move.b  (0,A0,D1.w),D5
            and.b   D2,D5
            cmp.b   D4,D5
            bne.w   .L6
            move.b  D3,D4
            roxr.b  #1,D4
            bne.b   .L4
            roxr.b  #1,D4
            move.b  (SP)+,(0,A0,D1.w)
            bra.b   .L1
.L6:
            move.b  (SP)+,(0,A0,D1.w)
            bra.w   .L15
.L7:
            move.b  (A2)+,D1
            bmi.w   .L16
            move.b  (0,A0,D1.w),-(SP)
            move.b  (A3)+,D2
            move.b  D2,(0,A0,D1.w)
            moveq   #1,D4
.L8:
            addi.w  #$80,D4
            move.b  D4,(0,A0,D1.w)
            move.b  (0,A0,D1.w),D5
            and.b   D2,D5
            bclr    #7,D4
            move.b  D4,D3
            and.b   D2,D3
            cmp.b   D3,D5
            beq.w   .L9
            move.b  D3,D4
            bra.w   .L14
.L9:
            move.b  D4,(0,A0,D1.w)
            move.b  (0,A0,D1.w),D5
            and.b   D2,D5
            tst.b   D5
            beq.w   .L10
            clr.b   D4
            bra.w   .L14
.L10:
            rol.b   #1,D4
            cmpi.b  #$80,D4
            bne.b   .L8
            moveq   #1,D4
.L11:
            move.b  #$FF,(0,A0,D1.w)
            move.b  (0,A0,D1.w),D5
            bclr    #7,D5
            cmp.b   D2,D5
            beq.w   .L12
            move.b  D2,D4
            bra.w   .L14
.L12:
            move.b  D4,(0,A0,D1.w)
            move.b  (0,A0,D1.w),D5
            eori.b  #$FF,D5
            and.b   D2,D5
            move.b  D4,D3
            and.b   D2,D3
            cmp.b   D3,D5
            beq.w   .L13
            move.b  D3,D4
            bra.w   .L14
.L13:
            rol.b   #1,D4
            cmpi.b  #$80,D4
            bne.b   .L11
            move.b  D2,(0,A0,D1.w)
            move.b  (SP)+,D0
            ori.b   #$C0,D0
            move.b  D0,(0,A0,D1.w)
            bra.w   .L7
.L14:
            move.b  D2,(0,A0,D1.w)
            move.b  (SP)+,D0
            ori.b   #$C0,D0
            move.b  D0,(0,A0,D1.w)
.L15:
            move.b  D1,D6
            rol.l   #8,D6
            move.b  D4,D6
            rol.l   #8,D6
            move.b  D5,D6
.L16:
            RTS6
.L17:
            dc.w    $0010,$11FF,$1213,$FF00
.L18:
            dc.w    $8FC3,$FF7F,$1F00
.L19:
            dc.w    $0802,$0078,$7F00
.L20:
            moveq   #-1,D6
            RTS6
TestSWIM:
            btst    #5,D0
            bne.b   .L1
            moveq   #-1,D6
            RTS6
.L1:
            move    SR,-(SP)
            ori     #$700,SR
            movea.l (8,A0),A2
            movea.l ($14,A0),A0
            lea     ($1E00,A2),A2
            tst.b   ($1400,A0)
            tst.b   ($1C00,A0)
            tst.b   ($1000,A0)
            tst.b   ($1A00,A0)
            moveq   #$57,D0
            move.b  D0,($1E00,A0)
            move.b  #$17,($1E00,A0)
            move.b  D0,($1E00,A0)
            move.b  D0,($1E00,A0)
            moveq   #-$B,D0
            move.b  D0,($800,A0)
            nop
            cmp.b   ($1800,A0),D0
            bne.w   .L2
            moveq   #-$A,D0
            move.b  D0,($800,A0)
            nop
            cmp.b   ($1800,A0),D0
            bne.w   .L2
            moveq   #-9,D0
            move.b  D0,($800,A0)
            nop
            cmp.b   ($1800,A0),D0
            bne.w   .L2
            bra.w   .L3
.L2:
            moveq   #-2,D6
            bra.w   .L32
.L3:
            moveq   #0,D6
            lea     .L33,A1
            move.w  #$F,D1
.L4:
            move.b  (0,A1,D1.w),($800,A0)
            nop
            move.b  ($1800,A0),D0
            cmp.b   (0,A1,D1.w),D0
            bne.w   .L20
            dbra    D1,.L4
            link.w  A4,#-$10
            move.b  ($1A00,A0),D4
            clr.b   ($A00,A0)
            move.b  #$38,($C00,A0)
            move.w  #$F,D1
.L5:
            move.b  (A2),(A2)
            move.b  ($1600,A0),(0,SP,D1.w)
            dbra    D1,.L5
            lea     .L34,A1
            move.w  #4,D2
.L6:
            move.b  #$38,($C00,A0)
            move.w  #$F,D1
            moveq   #0,D0
.L7:
            move.b  (A2),(A2)
            move.b  (0,A1,D1.w),($600,A0)
            dbra    D1,.L7
            dbra    D2,.L6
            lea     .L35,A1
            move.b  #$38,($C00,A0)
            moveq   #0,D0
            moveq   #0,D2
            move.w  #$F,D1
            move.b  (A2),(A2)
.L8:
            move.b  (A2),(A2)
            move.b  ($1600,A0),D0
            cmp.b   (0,A1,D1.w),D0
            bne.w   .L21
            dbne    D1,.L8
            moveq   #0,D0
            moveq   #7,D2
            moveq   #1,D3
.L9:
            move.b  #$38,($C00,A0)
            move.w  #$F,D1
.L10:
            move.b  (A2),(A2)
            move.b  D3,($600,A0)
            dbra    D1,.L10
            move.b  #$38,($C00,A0)
            move.w  #$F,D1
.L11:
            move.b  (A2),(A2)
            move.b  ($1600,A0),D0
            cmp.b   D3,D0
            bne.w   .L22
            dbra    D1,.L11
            rol.w   #1,D3
            dbra    D2,.L9
            moveq   #0,D0
            move.l  #$FF,D2
.L12:
            move.b  #$38,($C00,A0)
            move.w  #$F,D1
.L13:
            move.b  (A2),(A2)
            move.b  D2,($600,A0)
            dbra    D1,.L13
            move.b  #$38,($C00,A0)
            move.w  #$F,D1
.L14:
            move.b  (A2),(A2)
            move.b  ($1600,A0),D0
            cmp.b   D2,D0
            bne.w   .L23
            dbra    D1,.L14
            dbra    D2,.L12
            BSR5    .L18
            move.b  ($1A00,A0),D3
            move.w  #7,D1
            moveq   #1,D2
.L15:
            move.b  D2,($A00,A0)
            move.b  ($1A00,A0),D0
            cmp.b   D2,D0
            bne.w   .L24
            rol.w   #1,D2
            dbra    D1,.L15
            move.b  D3,($A00,A0)
            move.b  ($1C00,A0),D3
            move.w  #7,D1
            move.b  #$BF,($C00,A0)
            move.b  ($1C00,A0),D0
            andi.b  #$BF,D0
            bne.w   .L25
.L16:
            moveq   #0,D2
            bset    D1,D2
            move.b  D2,($E00,A0)
            move.b  ($1C00,A0),D0
            btst    D1,D0
            beq.w   .L26
            cmpi.b  #6,D1
            beq.b   .L17
            move.b  D2,($C00,A0)
            move.b  ($1C00,A0),D0
            andi.b  #$BF,D0
            bne.w   .L25
.L17:
            dbra    D1,.L16
            jmp     .L28
.L18:
            move.b  #$38,($C00,A0)
            move.w  #$F,D1
.L19:
            move.b  (A2),(A2)
            move.b  (0,SP,D1.w),($600,A0)
            dbra    D1,.L19
            move.b  D4,($A00,A0)
            unlk    A4
            RTS5
.L20:
            move.b  ($1800,A0),D6
            ori.w   #$100,D6
            swap    D6
            or.b    (0,A1,D1.w),D6
            bra.w   .L31
.L21:
            move.b  (0,A1,D1.w),D2
            move.b  D0,D6
            ori.w   #$200,D6
            swap    D6
            or.w    D2,D6
            lea     .L31,A5
            jmp     .L18
.L22:
            move.b  D0,D6
            ori.w   #$300,D6
            swap    D6
            or.w    D3,D6
            lea     .L31,A5
            jmp     .L18
.L23:
            move.b  D0,D6
            ori.w   #$400,D6
            swap    D6
            or.w    D2,D6
            lea     .L31,A5
            jmp     .L18
.L24:
            move.b  D0,D6
            ori.w   #$500,D6
            swap    D6
            or.w    D2,D6
            move.b  D3,($A00,A0)
            jmp     .L31
.L25:
            move.b  D0,D6
            ori.w   #$600,D6
            swap    D6
            ori.w   #0,D6
            jmp     .L28
.L26:
            move.b  D0,D6
            ori.w   #$700,D6
            swap    D6
            or.w    D2,D6
            jmp     .L28
.L27:
            move.b  ($1C00,A0),D6
            ori.w   #$800,D6
            swap    D6
            or.w    D3,D6
            jmp     .L31
.L28:
            move.w  #7,D1
.L29:
            moveq   #0,D2
            btst    D1,D3
            beq.b   .L30
            bset    D1,D2
            move.b  D2,($E00,A0)
.L30:
            dbra    D1,.L29
            cmp.b   ($1C00,A0),D3
            bne.b   .L27
.L31:
            move.b  #$F8,($C00,A0)
.L32:
            tst.b   ($1C00,A0)
            tst.b   ($1800,A0)
            move    (SP)+,SR
            RTS6
.L33:
            dc.w    $F0F1,$F2F3,$F4F5,$F6F7,$F8F9,$FAFB,$FCFD,$FEFF
.L34:
            dc.w    $FFEE,$DDCC,$BBAA,$9988,$7766,$5544,$3322,$1100
.L35:
            dc.w    $FFEC,$DDCC,$BBAA,$9988,$7766,$5544,$3322,$1100
Float_Test:
            move.w  ($10,A1),D3
            btst    #$C,D3
            bne.b   .FPUInstalled
            moveq   #-1,D6
            RTS6
.FPUInstalled:
            move    SR,-(SP)
            movem.l D2/D7,-(SP)
            ori     #$700,SR
            link.w  A6,#-$640
            moveq   #1,D6
            moveq   #0,D5
            moveq   #0,D7
            move.w  #$FF,D0
            movec   VBR,A0
            movea.l A0,A5
            lea     (-$400,A6),A1
            movea.l A1,A2
.FTB1:
            move.l  (A0)+,(A1)+
            dbra    D0,.FTB1
            lea     .FPC_EHND,A0
            move.l  A0,($1C,A2)
            move.l  A0,($C0,A2)
            move.l  A0,($C4,A2)
            move.l  A0,($C8,A2)
            move.l  A0,($CC,A2)
            move.l  A0,($D0,A2)
            move.l  A0,($D4,A2)
            move.l  A0,($D8,A2)
            lea     .PM_EXCPT,A0
            move.l  A0,($2C,A2)
            move.l  A0,($34,A2)
            move.l  A0,($38,A2)
            movec   A2,VBR
            addq.w  #1,D6                           ; Subtest #2
            lea     .CP_PRES,A0
            moveq   #$B,D7
            fmove.l D0,FP0
.CP_PRES:
            tst.b   D5
            bne.w   .FAIL
            moveq   #0,D5
            moveq   #0,D7
            lea     (-$514,A6),A4
            addq.w  #1,D6                           ; Subtest #3
            lea     .MOVLNGCR,A0
            fmove.l (A0),FPCR
            fmove.l FPCR,(A4)
            bsr.w   .VER_DAT
            bne.w   .FAIL
            tst.b   D5
            bne.w   .FAIL
            addq.w  #1,D6                           ; Subtest #4
            lea     .MOVLNG1,A0
            fmove.l (A0),FPIAR
            fmove.l FPIAR,(A4)
            bsr.w   .VER_DAT
            bne.w   .FAIL
            tst.b   D5
            bne.w   .FAIL
            addq.w  #1,D6
            lea     .MOVLNG2,A0
            fmove.l (A0),FPIAR
            fmove.l FPIAR,(A4)
            bsr.w   .VER_DAT
            bne.w   .FAIL
            tst.b   D5
            bne.w   .FAIL
            addq.w  #1,D6
            lea     .MOVLNG1,A0
            fmove.l (A0),FP0
            fmove.l FP0,(A4)
            bsr.w   .VER_DAT
            bne.w   .FAIL
            tst.b   D5
            bne.w   .FAIL
            addq.w  #1,D6
            lea     .MOVLNG2,A0
            fmove.l (A0),FP0
            fmove.l FP0,(A4)
            bsr.w   .VER_DAT
            bne.w   .FAIL
            tst.b   D5
            bne.w   .FAIL
            addq.w  #1,D6
            lea     .MOVWD,A0
            fmove.w (A0),FP1
            fmove.w FP1,(A4)
            bsr.w   .VER_DAT
            bne.w   .FAIL
            tst.b   D5
            bne.w   .FAIL
            addq.w  #1,D6
            lea     .MOVBT,A0
            fmove.b (A0),FP2
            fmove.b FP2,(A4)
            bsr.w   .VER_DAT
            bne.w   .FAIL
            tst.b   D5
            bne.w   .FAIL
            addq.w  #1,D6
            lea     .MOVSGL,A0
            fmove.s (A0),FP3
            fmove.s FP3,(A4)
            bsr.w   .VER_DAT
            bne.w   .FAIL
            tst.b   D5
            bne.w   .FAIL
            addq.w  #1,D6
            lea     .MOVDBL,A0
            fmove.d (A0),FP4
            fmove.d FP4,(A4)
            bsr.w   .VER_DAT
            bne.w   .FAIL
            tst.b   D5
            bne.w   .FAIL
            addq.w  #1,D6
            lea     .MOVEXT,A0
            fmove.x (A0),FP5
            fmove.x FP5,(A4)
            bsr.w   .VER_DAT
            bne.w   .FAIL
            tst.b   D5
            bne.w   .FAIL
            addq.w  #1,D6
            lea     .MOVBCDW,A0
            fmove.p (A0),FP6
            lea     .MOVBCDSR,A0
            fmove.p FP6,(A4){3}
            bsr.w   .VER_DAT
            bne.w   .FAIL
            tst.b   D5
            bne.w   .FAIL
            addq.w  #1,D6
            moveq   #-5,D2
            lea     .MOVBCDW,A0
            fmove.p (A0),FP7
            lea     .MOVBCDDR,A0
            fmove.p FP7,(A4){D2}
            bsr.w   .VER_DAT
            bne.w   .FAIL
            tst.b   D5
            bne.w   .FAIL
            addq.w  #1,D6
            fmovecr.x #0,FP0
            lea     .PI,A0
            fmove.p FP0,(A4){-7}
            bsr.w   .VER_DAT
            bne.w   .FAIL
            tst.b   D5
            bne.w   .FAIL
            addq.w  #1,D6
            lea     .MOVMEXT,A0
            movea.l A0,A2
            lea     (-$4FC,A6),A4
            fmovem.x (A2)+,FP2/FP7
            fmovem.x FP2/FP7,-(A4)
            bsr.w   .VER_DAT
            bne.w   .FAIL
            tst.b   D5
            bne.w   .FAIL
            addq.w  #1,D6                           ; Subtest #17
            lea     (-$514,A6),A2
            clr.l   -(A2)
            frestore (A2)+
            fmovem.l FPCR/FPSR/FPIAR,-(A2)
            moveq   #2,D0
.FSRB1:
            tst.l   (A2)+
            dbne    D0,.FSRB1
            bne.w   .FAIL
            fmovem.x FP0-FP7,-(A2)
            moveq   #7,D0
            lea     .NAN,A1
.FSRB2:
            movea.l A1,A0
            cmpm.l  (A0)+,(A2)+
            bne.b   .FSRB3
            cmpm.l  (A0)+,(A2)+
            bne.b   .FSRB3
            cmpm.l  (A0)+,(A2)+
.FSRB3:
            dbne    D0,.FSRB2
            bne.w   .FAIL
            clr.l   -(A2)
            frestore (A2)
            fsave   -(A2)
            tst.b   (A2)
            bne.w   .FAIL
            tst.b   D5
            bne.w   .FAIL
; Subtest #18
; Test the busy state FSAVE/FRESTORE
            addq.w  #1,D6                           ; Subtest #18
            lea     (-$514,A6),A2                   ; Get some stack space
            fmove.x .BIGNUM,FP0                     ; Get big number
            frem.x  .SMALLNUM,FP0                   ; Divide by small and calculate remainder
            fsave   -(A2)                           ; Cause busy state save
            clr.l   -(A2)                           ; Set format word for null
            frestore (A2)+
            frestore (A2)+
            lea     .FREMRSLT,A0
            lea     (-$514,A6),A4
            fmove.x FP0,(A4)
            bsr.w   .VER_DAT
            bne.w   .FAIL
            tst.b   D5
            bne.w   .FAIL
            addq.w  #1,D6                           ; Subtest #19
            lea     (-$514,A6),A2
            moveq   #$B,D0
            bsr.w   .SET_FPCR_BIT
            fmove.x .XDENORM,FP1
            fsave   -(A2)
            fmovem.l FPCR/FPSR,-(A2)
            clr.l   -(A2)
            frestore (A2)+
            fnop
            tst.b   D5
            bne.w   .FAIL
            fmovem.l (A2)+,FPCR/FPSR
            frestore (A2)+
            tst.b   D5
            bne.w   .FAIL
            moveq   #$33,D7
            fnop
            cmpi.b  #1,D5
            bne.w   .FAIL
            moveq   #0,D5
            moveq   #0,D7
            fmove.l D7,FPCR
            addq.w  #1,D6                           ; Subtest #20
            fmove.x .SGLNAN,FP0
            fadd.x  .SGLNAN,FP0
            moveq   #$E,D0
            bsr.w   .CK_FPSTAT
            beq.w   .FAIL
            tst.b   D5
            bne.w   .FAIL
            addq.w  #1,D6                           ; Subtest #21
            moveq   #$F,D0
            fmove.x .SGLNAN,FP1
            fblt.w  .CKBSUN
.CKBSUN:
            bsr.w   .CK_FPSTAT
            beq.w   .FAIL
            tst.b   D5
            bne.w   .FAIL
            addq.w  #1,D6                           ; Subtest #22
            moveq   #$A,D0
            bsr.w   .SET_FPCR_BIT
            fmove.x .ONE_X,FP2
            fdiv.x  .ZERO_X,FP2
            tst.b   D5
            bne.w   .FAIL
            moveq   #$32,D7
            bsr.w   .CK_FPSTAT
            beq.w   .FAIL
            cmpi.b  #1,D5
            bne.w   .FAIL
            moveq   #0,D5
            moveq   #0,D7
            fmove.l D7,FPCR
            addq.w  #1,D6                           ; Subtest #23
            moveq   #$C,D0
            bsr.w   .SET_FPCR_BIT
            fmove.x .BIGNO,FP3                      ; Move in an almost overflow number
            fmul.x  .BIGNO,FP3
            tst.b   D5
            bne.w   .FAIL
            moveq   #$35,D7
            bsr.w   .CK_FPSTAT
            beq.w   .FAIL
            cmpi.b  #1,D5
            bne.w   .FAIL
            moveq   #0,D5
            addq.w  #1,D6                           ; Subtest #24
            fmove.x .EXTNO,FP3
            tst.b   D5
            bne.w   .FAIL
            fmove.s FP3,(A4)
            cmpi.b  #1,D5
            bne.w   .FAIL
            bsr.w   .CK_FPSTAT
            beq.w   .FAIL
            moveq   #0,D5
            moveq   #0,D7
            fmove.l D7,FPCR
            addq.w  #1,D6                           ; Subtest #25
            moveq   #$B,D0
            fmove.x .SMALLNO,FP4
            fmul.x  .SMALLNO,FP4
            bsr.w   .CK_FPSTAT
            beq.w   .FAIL
            tst.b   D5
            bne.w   .FAIL
            addq.w  #1,D6                           ; Subtest #26
            moveq   #9,D0
            fmove.x .MULOPRND,FP5
            fmul.x  .TINYNO,FP5
            bsr.w   .CK_FPSTAT
            beq.w   .FAIL
            tst.b   D5                              ; Did unexpected exception occur?
            bne.w   .FAIL                           ; Yes, failed
; Subtest #27
; Test status register oper bit
            addq.w  #1,D6                           ; Subtest #27
            moveq   #$D,D0                          ; Set bit test for operand error
            bsr.w   .SET_FPCR_BIT                   ; Enable operand error exception
            fsqrt.x .MINUS_X,FP6                    ; Cause an operand error
            tst.b   D5                              ; Did an unexpected exception occur?
            bne.w   .FAIL                           ; Yes, failed
            moveq   #$34,D7                         ; Expected exception number
            bsr.w   .CK_FPSTAT                      ; Is oper bit set
            beq.w   .FAIL                           ; No, failed
            cmpi.b  #1,D5                           ; Did expected exception occur
            bne.w   .FAIL                           ; No, failed
            moveq   #0,D5                           ; Clear exception pass/fail flag
            moveq   #0,D7                           ; Set exception vector to none expected
            fmove.l D7,FPCR                         ; Disable all FPC exceptions
            addq.w  #1,D6
            fmovecr.x #$C,FP0
            ftrapeq
            tst.b   D5
            bne.w   .FAIL
            moveq   #7,D7
            fmovecr.x #$F,FP1
            ftrapeq
            cmpi.b  #1,D5
            bne.w   .FAIL
            moveq   #0,D5
            moveq   #0,D7
            fmove.l D7,FPCR
            addq.w  #1,D6
            fmovecr.x #0,FP0
            fmove.x FP0,FP1
            fadd.x  FP1,FP0
            fmul.x  #"$400040008000000000000000",FP1
            fcmp.x  FP0,FP1
            fbne.w  .FAIL
            tst.b   D5
            bne.w   .FAIL
            addq.w  #1,D6
            fmovecr.x #0,FP0
            fmove.x FP0,FP1
            fmove.x .ONE_X,FP2
            fmove.x FP2,FP3
            fdiv.x  #"$40004000C000000000000000",FP2
            fdiv.x  #"$40014001C000000000000000",FP3
            fmul.x  FP2,FP0
            fmul.x  FP3,FP1
            fsin.x  FP0,FP0
            fcos.x  FP1,FP1
            fmove.s FP0,D0
            fmove.s FP1,D1
            fmove.s D0,FP0
            fmove.s D1,FP1
            fcmp.x  FP0,FP1
            fbne.w  .FAIL
            fsqrt.x #"$40004000C000000000000000",FP4
            fdiv.x  #"$400040008000000000000000",FP4
            fmove.s FP4,D2
            fmove.s D2,FP4
            fcmp.x  FP1,FP4
            fbne.w  .FAIL
            tst.b   D5
            bne.w   .FAIL
            addq.w  #1,D6
            fmove.x .ONE_X,FP5
            fmove.x FP5,FP0
            fmovecr.x #0,FP6
            fdiv.x  #"$400140018000000000000000",FP5
            fmul.x  FP6,FP5
            ftan.x  FP5,FP5
            fdiv.x  #"$400040008000000000000000",FP0
            fmul.x  FP6,FP0
            fsin.x  FP0,FP0
            fmove.s FP0,D0
            fmove.s FP5,D1
            fmove.s D0,FP0
            fmove.s D1,FP5
            fcmp.x  FP0,FP5
            fbne.w  .FAIL
            tst.b   D5
            bne.b   .FAIL
            addq.w  #1,D6
            fmove.x #"$3FF83FF8A3D70A3D70A3D70B",FP0
            fmove.x FP0,FP1
            flog10.x FP1,FP1
            ftentox.x FP1,FP1
            fmove.s FP0,D0
            fmove.s FP1,D1
            fmove.s D0,FP0
            fmove.s D1,FP1
            fcmp.x  FP0,FP1
            fbne.w  .FAIL
            tst.b   D5
            bne.b   .FAIL
            move.l  D6,D0
            moveq   #0,D6
            bra.b   .FPUFinish
.FAIL:
            move.l  D6,D0
.FPUFinish:
            moveq   #0,D2
            cmpi.b  #2,D0
            bls.b   .NO_FPU
            lea     (-$514,A6),A2
            clr.l   -(A2)
            frestore (A2)+
            fsave   -(A2)
            move.w  #1,D2
            move.b  (1,A2),D1
            cmpi.b  #$18,D1
            beq.b   .FL881
            addq.w  #1,D2
.FL881:
            swap    D2
.NO_FPU:
            or.l    D2,D0
            movea.l A5,A0
            movec   A0,VBR
            unlk    A6
            movem.l (SP)+,D2/D7
            cmpi.b  #2,D6
            bne.b   .FPUrtn
            move.w  D2,D1
            lsr.w   #8,D1
            lea     .FPUOptnBox,A0
.OptnLoop:
            move.b  (A0)+,D3
            cmpi.b  #$FD,D3
            beq.b   .FPUrtn
            cmp.b   D3,D1
            bne.b   .OptnLoop
            moveq   #-1,D6
.FPUrtn:
            move    (SP)+,SR
            RTS6
.FPUOptnBox:
            dc.w    $0C0D,$0FFD
.CK_FPSTAT:
            fmove.l FPSR,D1
            btst    D0,D1
            rts
.SET_FPCR_BIT:
            fmove.l FPCR,D1
            bset    D0,D1
            fmove.l D1,FPCR
            rts
.VER_DAT:
            movem.l D0/A4,-(SP)
            move.w  (-2,A0),D0
            subq.w  #1,D0
.VD1:
            cmpm.b  (A0)+,(A4)+
            dbne    D0,.VD1
            beq.b   .VD2
            moveq   #1,D0
.VD2:
            movem.l (SP)+,D0/A4
            rts
.FPC_EHND:
            move.l  D0,-(SP)
            fsave   -(SP)
            move.b  (SP),D0
            beq.w   .NULL
            moveq   #0,D0
            move.b  (1,SP),D0
            bset    #3,(0,SP,D0.w)
.NULL:
            frestore (SP)+
            moveq   #1,D5
            tst.b   D7
            beq.b   .FE1
            move.w  ($A,SP),D0
            andi.w  #$FFF,D0
            lsr.w   #2,D0
            cmp.b   D7,D0
            beq.b   .FE2
.FE1:
            moveq   #2,D5
.FE2:
            move.l  (SP)+,D0
            rte
.PM_EXCPT:
            moveq   #1,D5
            moveq   #$A,D1
            move.w  (6,SP),D0
            lsr.w   #2,D0
            cmp.b   D0,D7
            bne.b   .PE1
            lsr.w   D1,D0
            tst.b   D0
            bne.b   .PE2
            move.l  A0,(2,SP)
            bra.b   .PE3
.PE2:
            move.l  A0,(8,SP)
.PE3:
            rte
.PE1:
            lsr.w   D1,D0
            tst.b   D0
            bne.b   .PE4
            addq.l  #8,SP
            bra.b   .PE5
.PE4:
            adda.w  #$14,SP
.PE5:
            addi.w  #$1000,D6
            bra.w   .FAIL
.XDENORM:
            dc.w    $0000,$0000
            dc.w    $7FFF,$FFFF,$FFFF,$FFFF
.BIGNUM:
            dc.w    $7FFD,0,$E35F,$A931,$A000,0
.SMALLNUM:
            dc.w    $9001,0,$ABCC,$7711,$8461,$CEFD
.SGLNAN:
            dc.w    $7FFF,0,$00A0,$A0A0
            ds.b    4
.ZERO_X:
            ds.b    12
.ONE_X:
            dc.b    $3F,$FF,$3F,$FF,$80
            ds.b    7
.MINUS_X:
            dc.b    $BF,$FF,$BF,$FF,$80
            ds.b    7
.EXTNO:
            dc.w    $7FFE,0,$89AB,$CDEF,$0123,$4567
.BIGNO:
            dc.w    $7FFE,0,$8000,$1020
            ds.b    4
.SMALLNO:
            dc.w    $0002,0,$8000,$0001
            ds.b    4
.MULOPRND:
            dc.b    $3F,$FF,$00,$00,$C0
            ds.b    4
            dc.b    $01,$73,$A1
.TINYNO:
            dc.b    $3F,$FF,$00,$00,$80
            ds.b    6
            dc.b    $01,$00,$0C
.FREMRSLT:
            dc.w    $9000,0,$A0AC,$F842,$FB63,$6FFC,$000C
.NAN:
            dc.w    $7FFF,0,$FFFF,$FFFF,$FFFF,$FFFF,$0004
.MOVLNGCR:
            ds.b    5
            dc.b    $04
.MOVLNG1:
            dc.w    $5555,$5555,$0004
.MOVLNG2:
            dc.w    $AAAA,$AAAA,$0002
.MOVWD:
            dc.w    $5555,$0001
.MOVBT:
            dc.w    $AA00,$0004
.MOVSGL:
            dc.w    $4CEB,$79A3,$0008
.MOVDBL:
            dc.w    $437B,$69B4,$BACD,$05F1,$000C
.MOVEXT:
            dc.w    $4055,0,$CC3D,$FBE5,$C763,$3EF5,$000C
.MOVEXT2:
            ds.b    12
.MOVBCDW:
            dc.b    $00,$04,$00,$01,$23,$45,$67,$87,$65
            ds.b    4
            dc.b    $0C
.MOVBCDSR:
            dc.b    $00,$04,$00,$01,$23
            ds.b    8
            dc.b    $0C
.MOVBCDDR:
            dc.b    $00,$04,$00,$01,$23,$45,$67,$87,$70
            ds.b    4
            dc.b    $0C
.PI:
            dc.w    0,$0003,$1415,$9270
            ds.b    5
            dc.b    $18
.MOVMEXT:
            dc.w    $4055,0,$CC3D,$FBE5,$C763,$3EF5
            ds.b    12
TestPGC:
            btst    #$D,D0
            beq.b   .L6
            btst    #$12,D7
            beq.b   .L6
            movea.l (8,A0),A2
            movea.l ($34,A0),A3
            move.l  A6,-(SP)
            movea.l SP,A5
            bset    #$1B,D7
            move.l  #'PGCp',D0
            moveq   #$1F,D5
            moveq   #1,D4
            lea     (-4,SP),A4
            bclr    #6,(A2)
.L1:
            lea     .L2,A6
            bclr    #7,(A3)
            tst.b   (A2)
            move.l  D4,(A4)
            tst.l   (A4)
            bra.b   .L4
.L2:
            lea     .L3,A6
            bset    #7,(A3)
            tst.b   (A2)
            tst.l   (A4)
            bra.b   .L4
.L3:
            lea     .L4,A6
            move.l  D4,(A4)
            tst.l   (A4)
            rol.l   #1,D4
            dbra    D5,.L1
            moveq   #0,D6
            bra.b   .L5
.L4:
            moveq   #$10,D6
            bset    #6,(A2)
            bset    #7,(A3)
            tst.b   (A2)
.L5:
            moveq   #0,D0
            bclr    #$1B,D7
            rts
.L6:
            moveq   #-1,D6
            RTS6
FMCRegTest:
            btst    #$13,D0
            beq.w   .L11
            movea.l A6,A5
            movea.l ($4C,A0),A0
            moveq   #0,D6
            BSR6    .L9
            move.w  D0,D2
.L1:
            move.w  D6,D0
            BSR6    .L7
            move.l  .L2,D0
            bra.b   .L3
.L2:
            dc.w    $FFFF,$FFFF
.L3:
            BSR6    .L9
            cmp.w   D0,D6
            bne.b   .L5
            cmpi.w  #$FFFF,D6
            beq.b   .L4
            asl.w   #1,D6
            ori.w   #1,D6
            bra.b   .L1
.L4:
            moveq   #0,D6
            bra.b   .L6
.L5:
            swap    D6
            move.w  D0,D6
.L6:
            move.w  D2,D0
            BSR6    .L7
            movea.l A5,A6
            RTS6
.L7:
            moveq   #$F,D1
.L8:
            move.b  D0,(A0)
            ror.w   #1,D0
            dbra    D1,.L8
            RTS6
.L9:
            moveq   #0,D0
            moveq   #$F,D1
.L10:
            move.b  (A0),D0
            ror.l   #1,D0
            dbra    D1,.L10
            swap    D0
            RTS6
.L11:
            moveq   #-1,D6
            RTS6
FMCCacheTest:
            btst    #$13,D0
            beq.w   .L19
            movea.l #$8000,A2
            lea     ($40000000.l,A2),A3
            movea.l ($48,A0),A4
            movec   CACR,D4
            move.l  #$1909,D1
            movec   D1,CACR
            move.l  #$8000,D5
.L1:
            subq.l  #4,D5
            bmi.b   .L2
            tst.l   ($8000.l,A3,D5.l)
            bra.b   .L1
.L2:
            move.l  #$8000,D5
.L3:
            subq.l  #4,D5
            bmi.b   .L4
            move.l  (0,A3,D5.l),D3
            not.l   D3
            move.l  D3,(0,A2,D5.l)
            bra.b   .L3
.L4:
            bclr    #3,($204,A4)
            move.l  #$8000,D5
.L5:
            subq.l  #4,D5
            bmi.b   .L6
            tst.l   (0,A2,D5.l)
            bra.b   .L5
.L6:
            andi.l  #$FFFFEEFF,D1
            movec   D1,CACR
            bset    #3,($204,A4)
            move.l  #$8000,D5
.L7:
            subq.l  #4,D5
            bmi.b   .L8
            move.l  (0,A3,D5.l),D3
            cmp.l   (0,A2,D5.l),D3
            bne.w   .L13
            bra.b   .L7
.L8:
            move.l  #$8000,D5
.L9:
            subq.l  #4,D5
            bmi.b   .L10
            move.l  (0,A3,D5.l),D3
            not.l   D3
            move.l  D3,(0,A2,D5.l)
            bra.b   .L9
.L10:
            bclr    #3,($204,A4)
            move.l  #$8000,D5
.L11:
            subq.l  #4,D5
            bmi.b   .L12
            move.l  (0,A3,D5.l),D3
            not.l   D3
            cmp.l   (0,A2,D5.l),D3
            bne.b   .L14
            bra.b   .L11
.L12:
            moveq   #0,D6
            bra.b   .L16
.L13:
            move.l  #$10000000,D6
            bra.b   .L15
.L14:
            move.l  #$20000000,D6
.L15:
            move.w  D5,D6
            nop
.L16:
            bset    #3,($204,A4)
            ori.l   #$1900,D1
            movec   D1,CACR
            move.l  #$8000,D5
.L17:
            subq.l  #4,D5
            bmi.b   .L18
            tst.l   (0,A2,D5.l)
            clr.l   (0,A2,D5.l)
            bra.b   .L17
.L18:
            movec   D4,CACR
            RTS6
.L19:
            moveq   #-1,D6
            RTS6
OSSRegTest:
            btst    #$12,D0
            beq.w   .L10
            move    SR,D5
            ori     #$700,SR
            movea.l ($48,A0),A0
            lea     .L9,A1
            moveq   #0,D6
.L1:
            moveq   #0,D0
            move.l  (A1)+,D2
            beq.b   .L6
            move.w  D2,D4
            swap    D2
            move.b  (0,A0,D2.w),D3
.L2:
            move.b  D0,(0,A0,D2.w)
            move.l  .L3,D1
            bra.b   .L4
.L3:
            dc.w    $FFFF,$FFFF
.L4:
            move.b  (0,A0,D2.w),D1
            ror.w   #8,D4
            and.b   D4,D1
            eor.b   D0,D1
            bne.b   .L7
            ror.w   #8,D4
            cmp.b   D4,D0
            beq.b   .L5
            addq.w  #1,D0
            bra.b   .L2
.L5:
            move.b  D3,(0,A0,D2.w)
            addq.w  #1,D6
            bra.b   .L1
.L6:
            moveq   #0,D6
            bra.b   .L8
.L7:
            move.w  D3,(0,A0,D2.w)
            swap    D6
            move.w  D1,D6
.L8:
            move    D5,SR
            RTS6
.L9:
            dc.w    0,$0706,$0001,$0706,$0002,$0706,$0003,$0706
            dc.w    $0004,$0706,$0005,$0706,$0006,$0706,$0007,$0706
            dc.w    $0008,$0706,$0009,$0706,$000A,$0706,$000B,$0706
            dc.w    $000C,$0706,$000D,$0706,$0204,$1F1F,$0205,$0303
            ds.b    4
.L10:
            moveq   #-1,D6
            RTS6
OSSIntTest:
            btst    #$12,D0
            beq.w   sub_40849142.L1
            move    SR,D5
            andi    #$F8FF,SR
            movea.l ($48,A0),A0
            lea     sub_40849142,A3
            move.b  ($A,A0),D2
            move.b  #6,D6
            movec   VBR,A1
            adda.w  #$78,A1
.L1:
            movea.l (A1),A2
            move.l  A3,(A1)
            move.b  D6,($A,A0)
            move.w  #$8000,D1
            moveq   #0,D0
.L2:
            cmpi.l  #'debi',D0
            beq.b   .L3
            dbra    D1,.L2
            clr.b   ($A,A0)
            move.l  A2,(A1)
            bra.b   .L4
.L3:
            clr.b   ($A,A0)
            move.l  A2,(A1)
            subq.w  #1,D6
            subq.w  #4,A1
            tst.b   D6
            bne.b   .L1
.L4:
            move.b  D2,($A,A0)
            move    D5,SR
            RTS6
sub_40849142:
            clr.b   ($207,A0)
            move.l  #'debi',D0
            rte
.L1:
            moveq   #-1,D6
            RTS6
RPUTest:
            btst    #$14,D0
            beq.b   .L6
            btst    #$12,D7
            beq.b   .L6
            movea.l ($50,A0),A3
            move.l  A6,-(SP)
            movea.l SP,A5
            bset    #$1B,D7
            move.l  #'RPUp',D0
            moveq   #$1F,D5
            moveq   #1,D4
            lea     (-4,SP),A4
.L1:
            st      ($10,A3)
            move.l  (A3),D1
            bset    #$18,D1
            move.l  D1,(A3)
            lea     .L2,A6
            move.l  D4,(A4)
            tst.l   (A4)
            bra.b   .L4
.L2:
            move.l  (A3),D1
            bclr    #$18,D1
            move.l  D1,(A3)
            lea     .L3,A6
            tst.l   (A4)
            bra.b   .L4
.L3:
            lea     .L4,A6
            move.l  D4,(A4)
            tst.l   (A4)
            rol.l   #1,D4
            dbra    D5,.L1
            moveq   #0,D6
            bra.b   .L5
.L4:
            moveq   #$10,D6
            move.l  (A3),D1
            bclr    #$18,D1
            move.l  D1,(A3)
.L5:
            moveq   #0,D0
            bclr    #$1B,D7
            rts
.L6:
            moveq   #-1,D6
            RTS6
EgretTest:
            move.l  A6,-(SP)
            move.l  ($1C,A1),D0
            andi.l  #$70,D0
            cmpi.l  #$20,D0
            bne.w   .L12
            movea.l (8,A0),A2
            moveq   #1,D6
            btst    #3,(A2)
            beq.w   .L13
            addq.l  #1,D6
            ori.b   #$C,($1600,A2)
            bset    #4,($1600,A2)
            bset    #5,(A2)
            move.b  #1,($1400,A2)
            bset    #4,(A2)
            move.w  #$7FFF,D0
.L1:
            btst    #2,($1A00,A2)
            dbne    D0,.L1
            tst.b   ($1400,A2)
            tst.w   D0
            bmi.w   .L11
            addq.l  #1,D6
            bclr    #4,(A2)
            BSR6    TM_Wait
            btst    #3,(A2)
            beq.w   .L11
            addq.l  #1,D6
            moveq   #$F,D2
            BSR6    TM_SendByte
            bclr    #4,($1600,A2)
            bclr    #5,(A2)
            move.w  #$FFFF,D0
.L2:
            btst    #2,($1A00,A2)
            beq.b   .L3
            btst    #3,(A2)
            beq.b   .L4
.L3:
            dbra    D0,.L2
            bra.w   .L11
.L4:
            move.b  ($1400,A2),D2
            BSR6    TM_Wait
            bset    #5,(A2)
            addq.l  #1,D6
            swap    D6
            move.w  #4,D6
            link.w  A6,#-6
.L5:
            movem.l D6/A6,-(SP)
            BSR6    TM_GetByte
            movem.l (SP)+,D6/A6
            sne     D0
            move.b  D2,(-6,A6,D6.w)
            tst.b   D0
            bne.b   .L6
            dbra    D6,.L5
            swap    D6
            bra.b   .L10
.L6:
            tst.w   D6
            beq.b   .L7
            swap    D6
            bra.b   .L10
.L7:
            swap    D6
            addq.l  #1,D6
            cmpi.b  #$F,(-4,A6)
            bne.w   .L10
            addq.l  #1,D6
            tst.b   (-3,A6)
            beq.b   .L9
            cmpi.b  #3,(-3,A6)
            bne.b   .L8
            moveq   #$E,D0
            and.l   ($1C,A1),D0
            cmpi.w  #6,D0
            bne.b   .L9
.L8:
            moveq   #0,D6
            move.b  (-3,A6),D6
            rol.l   #8,D6
            move.b  (-5,A6),D6
            rol.l   #8,D6
            move.b  (-6,A6),D6
            bset    #$1F,D6
            bra.b   .L10
.L9:
            moveq   #0,D6
.L10:
            unlk    A6
.L11:
            bclr    #4,(A2)
            bclr    #5,(A2)
            BSR6    TM_Wait
            bra.b   .L13
.L12:
            moveq   #-1,D6
.L13:
            rts
TestSndInts:
            btst    #$C,D0
            beq.w   WaitforInt.L2
            movem.l D0-D1/D3-D5/D7/A0-A4,-(SP)
            move    SR,-(SP)
            ori     #$700,SR
            moveq   #0,D4
            suba.l  A3,A3
            btst    #$B,D0
            beq.b   .VIA2done
            movea.l ($2C,A0),A3
            move.l  #$1A001C00,D7
.VIA2done:
            btst    #$D,D0
            beq.b   .RBVdone
            movea.l ($34,A0),A3
            move.l  #$30013,D7
.RBVdone:
            moveq   #-1,D6
            cmpa.w  #0,A3
            beq.w   .L22
            moveq   #0,D6
            movea.l A3,A5
            btst    #2,D0
            beq.b   .L3
            movea.l (8,A0),A5
.L3:
            movec   VBR,A4
            move.l  ($68,A4),-(SP)
            lea     IntHdlr,A1
            move.l  A1,($68,A4)
            movea.l ($30,A0),A4
            move.b  ($800,A4),D3
            andi.b  #$F0,D3
            move.b  D3,D6
            swap    D6
            cmpi.b  #$B0,D3
            bne.w   .L5
            move.w  #$FFFF,D6
            bset    #$1E,D6
.L4:
            tst.b   (A5)
            move.b  ($804,A4),D5
            cmpi.b  #$F,D5
            dbeq    D6,.L4
            bne.w   .L21
            bclr    #$1E,D6
            clr.w   D6
            move.b  #1,($F09,A4)
            move.b  #1,($F29,A4)
            clr.b   ($F08,A4)
            clr.b   ($F28,A4)
            move.b  #$3F,($F04,A4)
            move.b  #$DB,($F05,A4)
            move.b  #$3F,($F24,A4)
            move.b  #$DB,($F25,A4)
            bset    #7,($F08,A4)
            bset    #7,($F28,A4)
            clr.b   ($80A,A4)
            clr.b   ($80B,A4)
            bset    #7,($803,A4)
            bclr    #7,($803,A4)
            clr.b   ($802,A4)
            move.b  #1,($801,A4)
            bra.b   .L6
.L5:
            move.b  #1,($801,A4)
            clr.b   ($80A,A4)
            move.b  #$80,($803,A4)
            clr.b   ($803,A4)
            tst.b   ($804,A4)
            move.b  #2,($802,A4)
            clr.b   ($805,A4)
            clr.b   ($806,A4)
            clr.b   ($807,A4)
.L6:
            move.b  #$90,(0,A3,D7.w)
            move.b  #$6F,(0,A3,D7.w)
            swap    D7
            move.b  #$FF,(0,A3,D7.w)
            cmpi.b  #$E0,D3
            bne.b   .L7
            bset    #$1F,D6
            bra.b   .L12
.L7:
            lea     ($400,A4),A2
            move.b  #8,D6
            cmpi.b  #$B0,D3
            bne.b   .L9
            clr.b   ($F29,A4)
            move.b  #$FF,(0,A3,D7.w)
            move.w  #$3E8,D5
.L8:
            move.b  D0,(A2)
            dbra    D5,.L8
.L9:
            bsr.w   FIFOFill
            bpl.b   .L10
            cmpi.b  #$B0,D3
            bne.w   .L21
.L10:
            lsr.b   #1,D6
            bsr.w   WaitforInt
            bmi.w   .L21
            cmpi.b  #$B0,D3
            bne.b   .L12
            lsl.b   #1,D6
            move.w  #$7FFF,D1
.L11:
            tst.b   (A5)
            move.b  ($804,A4),D5
            and.b   D6,D5
            dbne    D1,.L11
            beq.w   .L21
            ori     #$700,SR
            move.b  #1,($F29,A4)
            clr.b   ($F09,A4)
            move.b  #$FF,(0,A3,D7.w)
            moveq   #0,D4
.L12:
            lea     (A4),A2
            move.b  #2,D6
            move.w  #$3E8,D5
.L13:
            move.b  D0,(A2)
            dbra    D5,.L13
            bsr.w   FIFOFill
            bpl.b   .L14
            btst    #$1F,D6
            bne.b   .L14
            cmpi.b  #$B0,D3
            bne.w   .L21
.L14:
            lsr.b   #1,D6
            bsr.w   WaitforInt
            bmi.w   .L21
            btst    #$1F,D6
            bne.b   .L15
            cmpi.b  #$B0,D3
            bne.b   .L16
.L15:
            lsl.b   #1,D6
            bsr.w   WaitforInt
            bpl.b   .L16
            cmpi.b  #$B0,D3
            bne.b   .L21
            move.b  ($804,A4),D5
            and.b   D6,D5
            beq.b   .L21
.L16:
            bset    #7,($803,A4)
            bclr    #7,($803,A4)
            cmpi.b  #$E0,D3
            beq.b   .L17
            cmpi.b  #$B0,D3
            beq.b   .L17
            move.w  D2,D1
            lsr.w   #8,D1
            cmpi.b  #$C,D1
            bne.b   .L20
.L17:
            ori     #$700,SR
            clr.w   D6
            bset    #$F,D6
            move.b  #1,($80A,A4)
            bset    #7,($803,A4)
            bclr    #7,($803,A4)
            cmpi.b  #$B0,D3
            bne.b   .L18
            move.b  #1,($F09,A4)
            clr.b   ($F09,A4)
.L18:
            tst.b   ($804,A4)
            move.b  #$90,(0,A3,D7.w)
            move.w  #$7FFF,D5
            move    #$2100,SR
.L19:
            tst.b   (A5)
            tst.w   D6
            dbeq    D5,.L19
            bne.b   .L21
.L20:
            moveq   #0,D6
.L21:
            ori     #$700,SR
            swap    D7
            move.b  #$10,(0,A3,D7.w)
            move.b  #$80,($803,A4)
            clr.b   ($803,A4)
            clr.b   ($80A,A4)
            movec   VBR,A0
            move.l  (SP)+,($68,A0)
.L22:
            move    (SP)+,SR
            movem.l (SP)+,D0-D1/D3-D5/D7/A0-A4
            RTS6
IntHdlr:
            move.b  (0,A3,D7.w),D0
            btst    #4,D0
            bne.b   .L1
            move.b  #$FF,D6
            move    SR,(SP)
            bra.b   .L8
.L1:
            move.b  ($804,A4),D4
            btst    #$F,D6
            bne.b   .L2
            andi.b  #$F,D4
            btst    #$1F,D6
            beq.b   .L9
            move    SR,(SP)
            bra.b   .L9
.L2:
            cmpi.b  #$B0,D3
            beq.b   .L3
            btst    #0,D4
            bne.b   .L4
            bra.b   .L6
.L3:
            btst    #0,D4
            bne.b   .L6
.L4:
            move.w  #$7FFF,D1
.L5:
            tst.b   (A5)
            btst    #1,($804,A4)
            dbne    D1,.L5
            bne.b   .L7
            move.b  #2,D6
            bra.b   .L8
.L6:
            move.b  #1,D6
            bra.b   .L8
.L7:
            clr.w   D6
.L8:
            swap    D7
            move.b  #$10,(0,A3,D7.w)
            swap    D7
.L9:
            move.b  #$90,(0,A3,D7.w)
            rte
FIFOFill:
            move.w  #$7D0,D5
.L1:
            move    #$2100,SR
            move.b  D0,(A2)
            and.b   D6,D4
            dbne    D5,.L1
            tst.w   D5
            rts
WaitforInt:
            move.w  #$7FFF,D1
.L1:
            move    #$2100,SR
            tst.b   (A5)
            and.b   D6,D4
            dbne    D1,.L1
            tst.w   D1
            rts
.L2:
            moveq   #-1,D6
            RTS6
TestCLUT:
            move.l  ($18,A1),D0
            btst    #$E,D0
            beq.w   sub_408496F0.L2
            moveq   #0,D6
            move.l  A6,-(SP)
            movem.l D1-D3/A0/A2-A3,-(SP)
            movea.l ($38,A0),A0
            move.b  (8,A0),-(SP)
            move.b  #$FF,(8,A0)
            movea.l A0,A2
            lea     (1,A2),A3
            lea     (A2),A0
            move.b  ($12,A1),D0
            cmpi.b  #$D,D0
            beq.b   .L1
            lea     (4,A2),A3
            lea     (A2),A0
.L1:
            clr.b   (A0)
            bsr.w   sub_408496F0
            link.w  A2,#-$300
            movea.l SP,A2
            move.w  #$FF,D0
.L2:
            moveq   #2,D2
.L3:
            move.b  (A3),(A2)+
            dbra    D2,.L3
            dbra    D0,.L2
            clr.b   (A0)
            move.w  #$FF,D0
            move.b  #$FF,D1
.L4:
            moveq   #2,D2
.L5:
            addq.b  #1,D1
            move.b  D1,(A3)
            dbra    D2,.L5
            dbra    D0,.L4
            clr.b   (A0)
            bsr.w   sub_408496F0
            move.w  #$FF,D0
            move.b  #$FF,D1
.L6:
            moveq   #2,D2
.L7:
            addq.b  #1,D1
            move.b  (A3),D3
            cmp.b   D3,D1
            dbne    D2,.L7
            dbne    D0,.L6
            beq.b   .L8
            neg.b   D0
            subq.b  #1,D0
            neg.b   D2
            addq.b  #3,D2
            move.b  D2,D6
            lsl.l   #8,D6
            move.b  D0,D6
            lsl.l   #8,D6
            move.b  D1,D6
            lsl.l   #8,D6
            move.b  D3,D6
.L8:
            clr.b   (A0)
            move.w  #$FF,D0
            movea.l SP,A2
.L9:
            moveq   #2,D2
.L10:
            move.b  (A2)+,(A3)
            dbra    D2,.L10
            dbra    D0,.L9
            unlk    A2
            move.b  (SP)+,(8,A0)
            movem.l (SP)+,D1-D3/A0/A2-A3
            rts
sub_408496F0:
            move.b  ($12,A1),D0
            cmpi.b  #$D,D0
            beq.b   .L1
            tst.b   (A3)
            tst.b   (A3)
            tst.b   (A3)
.L1:
            rts
.L2:
            moveq   #-1,D6
            RTS6
SizeVRAM:
            move.b  ($13,A1),D0
            cmpi.b  #7,D0
            beq.b   .L1
            cmpi.b  #9,D0
            beq.b   .L3
            cmpi.b  #8,D0
            beq.b   .L4
            moveq   #-1,D6
            bra.w   .L16
.L1:
            movea.l ($34,A0),A2
            moveq   #0,D0
            btst    #2,(1,A2)
            beq.w   .L15
            move.l  #$40000,D0
            btst    #1,(1,A2)
            bne.b   .L2
            lsl.l   #1,D0
.L2:
            move.l  (8,A1),D1
            movea.l (0,A1,D1.l),A0
            lea     (0,A0,D0.l),A1
            bra.w   .L15
.L3:
            move.l  (8,A1),D0
            movea.l (0,A1,D0.l),A0
            move.l  #$8000,D0
            lea     (0,A0,D0.l),A1
            bra.w   .L15
.L4:
            movea.l ($68,A0),A2
            lea     .L17,A3
            moveq   #0,D1
            bra.b   .L6
.L5:
            move.w  (A3)+,D1
            move.l  D1,(0,A2,D0.w)
.L6:
            move.w  (A3)+,D0
            bpl.b   .L5
            movea.l ($2C,A0),A3
            btst    #5,(A3)
            beq.b   .L7
            ori.l   #$F00,($10,A2)
.L7:
            lea     ($300,A2),A3
            lea     .L18,A4
            moveq   #0,D0
.L8:
            move.b  (A4)+,D0
            bmi.b   .L9
            move.l  D0,(A3)
            lea     ($10,A3),A3
            bra.b   .L8
.L9:
            move.l  #3,($20,A2)
            bsr.w   sub_408498C2
            move.l  #7,($20,A2)
            bsr.w   sub_408498C2
            move.l  #3,($20,A2)
            bsr.w   sub_408498C2
            move.l  #2,($20,A2)
            bsr.w   sub_408498C2
            clr.l   ($20,A2)
            bsr.w   sub_408498C2
            movea.l #$F9000000,A3
            moveq   #0,D0
            move.l  #'Shel',D1
            moveq   #-1,D2
            moveq   #0,D6
.L10:
            lea     (0,A3,D0.l),A4
            move.l  D1,(A4)
            move.l  D2,(4,A4)
            move.l  D1,D3
            moveq   #0,D4
            moveq   #3,D5
.L11:
            cmp.b   (0,A4,D5.w),D3
            bne.b   .L12
            not.b   D3
            not.b   (0,A4,D5.w)
            move.l  D2,(4,A4)
            cmp.b   (0,A4,D5.w),D3
            beq.b   .L13
.L12:
            bset    D5,D4
.L13:
            ror.l   #8,D3
            dbra    D5,.L11
            cmpi.b  #$F,D4
            beq.b   .L14
            rol.l   #4,D6
            or.b    D4,D6
            move.l  D2,(0,A3,D0.l)
            addi.l  #$80000,D0
            cmpi.l  #$200000,D0
            bne.b   .L10
.L14:
            movea.l A3,A0
            lea     (0,A0,D0.l),A1
            bra.b   .L16
.L15:
            moveq   #0,D6
.L16:
            rts
.L17:
            dc.w    $0020,$0007,0,$0008,$0004,0,$0008,$0064
            dc.w    $000C,$0602,$0010,$0050,$0100,$0FF2,$0168,$008E
            dc.w    $0124,$031E,$0128,$01B0,$012C,$0020,$0130,$035F
            dc.w    $0134,$003F,$0138,$004B,$013C,$006F,$0140,$0098
            dc.w    $0144,$0318,$0148,$035E,$014C,$041A,$0150,$0418
            dc.w    $0154,$0004,$0158,$0009,$015C,$0052,$0160,$0412
            dc.w    $0164,$0416,$0220,$0098,$FFFF
.L18:
            dc.w    $0F07,0,$0501,0,$0002,$0506,$0401,0
            dc.w    $FF00
sub_408498C2:
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            rts
TestVRAM:
            move.l  A6,-(SP)
            move.l  A1,-(SP)
            bsr.w   SizeVRAM
            movea.l (SP)+,A2
            cmpi.l  #$FFFFFFFF,D6
            beq.b   .L7
            tst.l   D0
            beq.b   .L7
            cmpi.b  #8,($13,A2)
            bne.b   .L5
            movea.l A1,A2
            movea.l A0,A1
            moveq   #0,D2
.L1:
            movea.l A1,A0
            adda.l  #$80000,A1
            rol.w   #4,D2
            moveq   #0,D6
            movem.l D2/A2,-(SP)
            BSR6    CritProc
            movem.l (SP)+,D2/A2
            tst.l   D6
            beq.b   .L4
            moveq   #3,D3
.L2:
            tst.b   D6
            beq.b   .L3
            bset    D3,D2
.L3:
            ror.l   #8,D6
            dbra    D3,.L2
.L4:
            cmpa.l  A1,A2
            bne.b   .L1
            move.l  D2,D6
            bra.b   .L6
.L5:
            moveq   #0,D6
            BSR6    CritProc
            tst.l   D6
            bne.b   .L6
            BSR6    RevMod3Test
.L6:
            rts
.L7:
            moveq   #-1,D6
            rts
TestC96:
            move.l  A6,-(SP)
            btst    #$18,D0
            bne.b   .L1
            btst    #$19,D0
            bne.b   .L2
            moveq   #-1,D6
            rts
.L1:
            movea.l ($60,A0),A2
            bsr.b   TestC96Chip
            bne.b   .L3
            btst    #$19,D0
            beq.b   .L3
.L2:
            movea.l ($64,A0),A2
            bsr.b   TestC96Chip
            beq.b   .L3
            bset    #$1F,D6
.L3:
            rts
TestC96Chip:
            movem.l D0-D3,-(SP)
            move.b  #2,($30,A2)
            moveq   #0,D6
            moveq   #0,D0
.L1:
            move.b  D0,(A2)
            ror.w   #8,D0
            move.b  D0,($10,A2)
            ror.w   #8,D0
            move.b  #$80,($30,A2)
            move.b  ($10,A2),D1
            asl.w   #8,D1
            move.b  (A2),D1
            cmp.w   D0,D1
            bne.w   .L7
            addq.l  #5,D0
            cmpi.l  #$FFFF,D0
            ble.b   .L1
            move.b  #3,D6
            swap    D6
            asl.l   #8,D6
            move.b  ($70,A2),D0
            andi.b  #$1F,D0
            bne.w   .L16
            move.w  #$F,D0
.L2:
            move.b  D0,($20,A2)
            dbra    D0,.L2
            move.b  #4,D6
            move.b  ($70,A2),D0
            andi.b  #$1F,D0
            cmpi.b  #$10,D0
            bne.w   .L9
            move.w  #$F,D0
            move.b  #5,D6
.L3:
            move.b  ($20,A2),D1
            cmp.b   D0,D1
            dbne    D0,.L3
            bne.w   .L10
            move.b  #6,D6
            move.b  ($70,A2),D0
            andi.b  #$1F,D0
            bne.w   .L11
            move.w  #$F,D2
            moveq   #1,D0
.L4:
            move.b  D0,($20,A2)
            rol.b   #1,D0
            dbra    D2,.L4
            move.w  #$F,D2
            moveq   #1,D0
            move.b  #7,D6
.L5:
            move.b  ($20,A2),D1
            cmp.b   D0,D1
            bne.b   .L10
            rol.b   #1,D0
            dbra    D2,.L5
            move.w  #$300,D2
            moveq   #0,D0
.L6:
            move.b  D0,($80,A2)
            addq.l  #1,D0
            move.b  D0,($B0,A2)
            addq.l  #1,D0
            move.b  D0,($C0,A2)
            subq.l  #2,D0
            move.b  ($80,A2),D1
            cmp.b   D0,D1
            bne.b   .L12
            addq.l  #1,D0
            move.b  ($B0,A2),D1
            move.b  D0,D3
            andi.b  #$DF,D0
            cmp.b   D0,D1
            bne.b   .L13
            move.b  D3,D0
            addq.l  #1,D0
            move.b  ($C0,A2),D1
            move.b  D0,D3
            andi.b  #7,D0
            cmp.b   D0,D1
            bne.b   .L14
            move.b  D3,D0
            addq.l  #1,D0
            dbra    D2,.L6
            moveq   #0,D6
            bra.b   .L16
.L7:
            move.b  #1,D6
            cmp.b   D0,D1
            bne.b   .L8
            move.b  #2,D6
            ror.w   #8,D0
            ror.w   #8,D1
.L8:
            swap    D6
            move.b  D0,D6
            asl.l   #8,D6
            move.b  D1,D6
            bra.b   .L16
.L9:
            swap    D6
            move.b  #$10,D6
            asl.l   #8,D6
            move.b  D0,D6
            bra.b   .L16
.L10:
            asl.l   #8,D6
            move.b  ($70,A2),D6
            asl.l   #8,D6
            move.b  D0,D6
            asl.l   #8,D6
            move.b  D1,D6
            bra.b   .L16
.L11:
            swap    D6
            asl.l   #8,D6
            move.b  D0,D6
            bra.b   .L16
.L12:
            move.b  #8,D6
            bra.b   .L15
.L13:
            move.b  #9,D6
            bra.b   .L15
.L14:
            move.b  #$A,D6
.L15:
            swap    D6
            move.b  D0,D6
            asl.l   #8,D6
            move.b  D1,D6
.L16:
            move.b  #2,($30,A2)
            movem.l (SP)+,D0-D3
            tst.l   D6
            rts
            ds.b    14
PostProc:
GoTM:
            tst.w   D7
            bne.b   Error1Handler
            move.l  #$87654321,D6
Error1Handler:
            movea.w #$2600,SP
            moveq   #0,D2
            BSR6    JGetHardwareInfo
            btst    #$1A,D7
            bne.b   .L1
            movea.l ($30,A0),A3
            movea.l (8,A0),A5
            BigBSR6 ErrorBeep1,A0
            bra.w   TMEntry1
.L1:
            btst    #1,D0
            beq.b   .L2
            lea     .L2,A6
            bset    #$1B,D7
            movea.l (4,A0),A1
            movem.l (A1)+,D0/A0
            cmpi.l  #$AAAA5555,D0
            bne.b   .L2
            lea     .L2,A1
            jmp     (A0)
.L2:
            bclr    #$1B,D7
            bset    #$10,D7
            bset    #$16,D7
            move.w  #$C,D4
            BSR6    StartTimer
            movec   CACR,D0
            bset    #$F,D0
            movec   D0,CACR
            movec   CACR,D0
            btst    #$F,D0
            beq.b   .L3
            mc68040
            cinva   IC
            mc68030
            bra.b   .L4
.L3:
            movec   CACR,D0
            bset    #3,D0
            movec   D0,CACR
            movec   CACR,D0
            ori.b   #$11,D0
            movec   D0,CACR
.L4:
            bra.w   TMEntry1
Error2Handler:
            moveq   #0,D2
            BSR6    JGetHardwareInfo
            movea.l ($30,A0),A3
            movea.l (8,A0),A2
            btst    #$1A,D7
            bne.b   .L1
            movea.l A2,A5
            BigBSR6 ErrorBeep1,A0
            BigJmp  CritErr,A0
.L1:
            bra.w   TMEntry1
Error3Handler:
            moveq   #0,D2
            BSR6    JGetHardwareInfo
            movea.l ($30,A0),A3
            movea.l (8,A0),A5
            BigBSR6 ErrorBeep2,A0
            BigJmp  CritErr,A0
Error4Handler:
            moveq   #0,D2
            BSR6    JGetHardwareInfo
            movea.l ($30,A0),A3
            movea.l (8,A0),A5
            BigBSR6 ErrorBeep3,A0
            BigJmp  CritErr,A0
NCErrorHandler:
            cmpi.l  #$FFFFFFFF,D6
            beq.w   .L5
            movea.l (8,A0),A2
            BSR6    CLKWPOFF
            move.w  #$F9,D1
            BSR6    RdXByte
            bset    #0,D1
            bne.b   .L2
            move.b  D1,D2
            move.w  #$F9,D1
            BSR6    WrXByte
            move.l  #$F00007,D4
.L1:
            swap    D4
            move.w  D4,D1
            addq.w  #1,D4
            moveq   #0,D2
            BSR6    WrXByte
            swap    D4
            dbra    D4,.L1
.L2:
            move.l  #$F80006,D4
.L3:
            swap    D4
            subq.w  #2,D4
            move.w  D4,D1
            BSR6    RdXByte
            move.b  D1,D2
            addq.w  #1,D4
            move.w  D4,D1
            BSR6    WrXByte
            swap    D4
            dbra    D4,.L3
            move.w  #$F0,D1
            move.b  D7,D2
            BSR6    WrXByte
            move.l  #$FC0003,D4
.L4:
            swap    D4
            move.w  D4,D1
            addq.l  #1,D4
            rol.l   #8,D6
            move.b  D6,D2
            BSR6    WrXByte
            swap    D4
            dbra    D4,.L4
.L5:
            rts
            ds.b    4
PRLOG:
RBIMGR:
            BSR6    sub_4084A146.L2
            BSR6    SizeMemory
            bne.w   .L21
            move.w  #3,D7
            movea.l (SP),SP
            movea.l SP,A4
.L1:
            movea.l (A4)+,A0
            cmpa.w  #$FFFF,A0
            beq.b   .L3
            movea.l (A4)+,A1
            adda.l  A0,A1
            cmpa.l  A1,SP
            bhi.b   .L2
            movea.l SP,A1
.L2:
            BSR6    CritProc
            tst.l   D6
            bne.w   .L21
            addq.w  #1,D7
            bra.b   .L1
.L3:
            clr.w   D7
            BSR6    USTINIT
            movea.l ($2E,A5),A1
            suba.w  #$13E,A1
            bsr.w   sub_4084A146
            movea.l ($22,A5),A0
            movea.l ($26,A5),A1
            movea.l (8,A0),A2
            movem.l A0-A2,($164,A5)
            bsr.w   sub_4084A1C4
            movem.l ($164,A5),A0-A2
            bsr.w   IndicatorOn
            move.l  A5,-(SP)
            BSR6    CLKWPOFF
            move.l  #$7C00FC,D3
            BSR6    ReadPramSig
            movea.l (SP)+,A5
            cmpi.l  #'RBBI',D4
            beq.b   .L4
            clr.w   -(SP)
            move.w  #$80,-(SP)
            bra.b   .L5
.L4:
            move.l  #$7C00FC,D1
            swap    D1
            moveq   #0,D2
            move.l  A5,-(SP)
            BSR6    WrXByte
            movea.l (SP)+,A5
            move.w  #$80,-(SP)
            clr.w   -(SP)
.L5:
            move.w  #$80,-(SP)
            bsr.w   RelocatePRAM
            lea     (6,SP),SP
            bsr.w   InvalidUpper
            move.w  #$E6,-(SP)
            pea     ($32,A5)
            move.w  #2,-(SP)
            bsr.w   COPYPRAMTORAM
            lea     (8,SP),SP
            addq.w  #1,($32,A5)
            pea     ($32,A5)
            move.w  #$E6,-(SP)
            move.w  #2,-(SP)
            bsr.w   COPYRAMTOPRAM
            lea     (8,SP),SP
            bsr.w   UpperToLower
            move.w  #$F2,-(SP)
            pea     ($146,A5)
            move.w  #2,-(SP)
            bsr.w   COPYPRAMTORAM
            lea     (8,SP),SP
            move.w  #$F4,-(SP)
            pea     ($148,A5)
            move.w  #4,-(SP)
            bsr.w   COPYPRAMTORAM
            lea     (8,SP),SP
            move.w  #$D0,-(SP)
            pea     ($14C,A5)
            move.w  #4,-(SP)
            bsr.w   COPYPRAMTORAM
            lea     (8,SP),SP
            move.w  #$E8,-(SP)
            pea     ($150,A5)
            move.w  #2,-(SP)
            bsr.w   COPYPRAMTORAM
            lea     (8,SP),SP
            move.w  #$EA,-(SP)
            pea     ($152,A5)
            move.w  #2,-(SP)
            bsr.w   COPYPRAMTORAM
            lea     (8,SP),SP
            move.w  #$E0,-(SP)
            pea     ($154,A5)
            move.w  #2,-(SP)
            bsr.w   COPYPRAMTORAM
            lea     (8,SP),SP
            move.w  #$E2,-(SP)
            pea     ($156,A5)
            move.w  #2,-(SP)
            bsr.w   COPYPRAMTORAM
            lea     (8,SP),SP
            move.w  #$80,-(SP)
            pea     ($3C,A5)
            move.w  #$20,-(SP)
            bsr.w   COPYPRAMTORAM
            lea     (8,SP),SP
            move.w  ($150,A5),D1
            sub.w   D1,($146,A5)
.L6:
            clr.w   ($3A,A5)
            subq.w  #1,($146,A5)
            bmi.w   .L16
            addq.w  #1,($150,A5)
            move.l  ($148,A5),D0
            moveq   #$1F,D1
.L7:
            tst.l   D0
            beq.w   .L14
            asl.l   #1,D0
            bcc.w   .L13
            move.w  D1,D7
            ori.w   #$C0,D7
            move.b  ($3C,A5,D1.w),D2
            andi.w  #$FF,D2
            moveq   #0,D5
            bset    D1,D5
            move.l  D5,($36,A5)
            andi.l  #$E0000000,D5
            bne.b   .L9
            cmp.w   ($144,A5),D1
            bge.w   .L13
            move.l  ($5C,A5,D1.w*8),($158,A5)
            move.l  ($60,A5,D1.w*8),($15C,A5)
            movem.l D0-D1/A5,-(SP)
            movea.l ($16,A5),A3
.L8:
            movem.l D1-D2/A3,-(SP)
            clr.l   -(SP)
            clr.l   -(SP)
            move.l  ($15C,A5),-(SP)
            move.l  ($158,A5),-(SP)
            pea     (A3)
            BigJsr  GI_ExecuteTest,A0
            adda.w  #$14,SP
            movem.l (SP)+,D1-D2/A3
            move.l  D0,D6
            dbne    D2,.L8
            bra.b   .L11
.L9:
            move.l  D1,($158,A5)
            move.l  #1,($15C,A5)
            lea     sub_4084A23A.L2,A0
            move.w  #$1F,D5
            sub.w   D1,D5
            move.l  (0,A0,D5.w*4),D5
            lea     (0,A0,D5.l),A0
            movem.l D0-D1/A5,-(SP)
.L10:
            movem.l D2/A0,-(SP)
            jsr     (A0)
            movem.l (SP)+,D2/A0
            tst.l   D6
            dbne    D2,.L10
.L11:
            movem.l (SP),D0-D1/A5
            movem.l ($164,A5),A0-A2
            bsr.w   IndicatorOn
            move.l  D6,($160,A5)
            beq.b   .L12
            bsr.w   sub_4084A23A
.L12:
            movem.l (SP)+,D0-D1/A5
.L13:
            subq.w  #1,D1
            bra.w   .L7
.L14:
            bsr.w   InvalidUpper
            pea     ($150,A5)
            move.w  #$E8,-(SP)
            move.w  #2,-(SP)
            bsr.w   COPYRAMTOPRAM
            lea     (8,SP),SP
            tst.w   ($3A,A5)
            bne.w   .L15
            addq.w  #1,($152,A5)
            pea     ($152,A5)
            move.w  #$EA,-(SP)
            move.w  #2,-(SP)
            bsr.w   COPYRAMTOPRAM
            lea     (8,SP),SP
.L15:
            bsr.w   UpperToLower
            bra.w   .L6
.L16:
            clr.w   D7
            bsr.w   InvalidUpper
            pea     sub_4084A23A.L10
            move.w  #$EC,-(SP)
            move.w  #4,-(SP)
            bsr.w   COPYRAMTOPRAM
            lea     (8,SP),SP
            bsr.w   UpperToLower
            tst.l   ($14C,A5)
            bne.b   .L21
            move.w  #$F0,-(SP)
            pea     ($32,A5)
            move.w  #1,-(SP)
            bsr.w   COPYPRAMTORAM
            lea     (8,SP),SP
            tst.b   ($32,A5)
            bne.b   .L21
            bsr.w   IndicatorOff
            moveq   #0,D2
.L17:
            move.w  #$1F4,D0
.L18:
            move.w  #$320,D1
.L19:
            tst.b   (A2)
            dbra    D1,.L19
            dbra    D0,.L18
            eori.b  #1,D2
            beq.b   .L20
            bsr.w   IndicatorOn
            bra.b   .L17
.L20:
            bsr.w   IndicatorOff
            bra.b   .L17
.L21:
            bsr.w   IndicatorOff
            bra.w   Error1Handler
InvalidUpper:
            move.l  A5,-(SP)
            move.l  #$7C00FC,D1
            moveq   #0,D2
            BSR6    WrXByte
            movea.l (SP)+,A5
            rts
UpperToLower:
            move.l  A5,-(SP)
            move.l  #$7C00FC,D1
            move.l  #'RBBI',D2
            rol.l   #8,D2
            BSR6    WrXByte
            move.l  #$7C00FC,D1
            swap    D1
            moveq   #0,D2
            BSR6    WrXByte
            move.w  #$80,-(SP)
            clr.w   -(SP)
            move.w  #$80,-(SP)
            bsr.w   RelocatePRAM
            lea     (6,SP),SP
            movea.l (SP)+,A5
            rts
RelocatePRAM:
            move.l  A5,-(SP)
.L1:
            move.w  ($C,SP),D1
            BSR6    RdXByte
            move.b  D1,D2
            move.w  ($A,SP),D1
            BSR6    WrXByte
            addq.w  #1,($C,SP)
            addq.w  #1,($A,SP)
            subq.w  #1,(8,SP)
            bne.b   .L1
            movea.l (SP)+,A5
            rts
IndicatorOn:
            move.l  ($2A,A5),D0
            btst    #8,D0
            beq.b   .L1
            movea.l ($20,A0),A3
            bset    #3,($10,A3)
            rts
.L1:
            bsr.w   FindC96Base
            move.b  #$22,($30,A3)
            rts
IndicatorOff:
            move.l  ($2A,A5),D0
            btst    #8,D0
            beq.b   .L1
            movea.l ($20,A0),A3
            bclr    #3,($10,A3)
            rts
.L1:
            bsr.w   FindC96Base
            move.b  #$1B,($30,A3)
            rts
FindC96Base:
            movea.l ($60,A0),A3
            btst    #$19,D0
            beq.b   .L1
            movea.l ($64,A0),A3
.L1:
            move.b  #2,($30,A3)
            clr.b   ($30,A3)
            move.b  #8,($80,A3)
            move.b  #1,($A0,A3)
            rts
COPYRAMTOPRAM:
            move.w  (6,SP),D1
            movea.l (8,SP),A3
            move.w  (4,SP),D3
            moveq   #0,D2
            subq.w  #1,D3
            blt.b   .L2
.L1:
            move.b  (A3)+,D2
            movem.l D1/D3/A3/A5,-(SP)
            BSR6    WrXByte
            movem.l (SP)+,D1/D3/A3/A5
            addq.w  #1,D1
            dbra    D3,.L1
.L2:
            rts
COPYPRAMTORAM:
            move.w  ($A,SP),D2
            movea.l (6,SP),A3
            move.w  (4,SP),D3
            subq.w  #1,D3
            blt.b   .L2
.L1:
            move.w  D2,D1
            movem.l D2-D3/A3/A5,-(SP)
            BSR6    RdXByte
            movem.l (SP)+,D2-D3/A3/A5
            move.b  D1,(A3)+
            addq.w  #1,D2
            dbra    D3,.L1
.L2:
            rts
sub_4084A146:
            lea     ($32,A5),A0
            move.l  A0,D0
            sub.l   SP,D0
            move.l  D0,D1
            movea.l A1,A2
            lsr.l   #2,D0
            addq.l  #1,D0
.L1:
            move.l  -(A0),-(A1)
            dbra    D0,.L1
            movea.l A2,A0
            suba.l  D1,A0
            movea.l A0,SP
            addq.l  #4,A0
            movec   A0,VBR
            lea     (-$32,A2),A5
            rts
.L2:
            sub.l   D0,D0
            bset    #$1F,D0
            movec   D0,CACR
            movec   CACR,D0
            btst    #$1F,D0
            beq.b   .L3
            mc68040
            cinva   BC
            mc68030
            sub.l   D0,D0
            movec   D0,CACR
            mc68040
            movec   D0,TC
            mc68030
            move.l  #$FFC040,D0
            mc68040
            movec   D0,DTT0
            mc68030
            move.l  #$FFC040,D0
            mc68040
            movec   D0,DTT1
            mc68030
            bra.b   .L4
.L3:
            move.l  #$2000,D0
            movec   D0,CACR
            movec   CACR,D0
            tst.l   D0
            beq.b   .L4
            lea     .L5,A0
            pmove.l (A0),TC
.L4:
            RTS6
.L5:
            ds.b    4
sub_4084A1C4:
            movea.l (SP)+,A1
            suba.l  #$D800,SP
            move.l  SP,($16,A5)
            movea.l SP,A0
            move.l  A1,-(SP)
            move.w  #$10,(8,A5)
            move.l  #$D800,-(SP)
            pea     (A0)
            BigJsr  GI_InitInterface,A0
            addq.l  #8,SP
            movea.l ($12,A5),A0
            lea     ($5C,A5),A1
            clr.w   ($144,A5)
.L1:
            moveq   #0,D0
            move.w  (2,A0),D0
            cmpi.w  #$FFFF,D0
            beq.b   .L3
            move.w  (4,A0),D1
            and.w   (8,A5),D1
            beq.b   .L2
            moveq   #0,D1
            move.w  (A0),D1
            move.l  D1,(A1)+
            move.l  D0,(A1)+
            movem.l A0-A1,-(SP)
            bsr.w   USTGETANDINSTALL
            movem.l (SP)+,A0-A1
            addq.w  #1,($144,A5)
            cmpi.w  #$1D,($144,A5)
            beq.b   .L3
.L2:
            addq.w  #6,A0
            bra.b   .L1
.L3:
            bsr.w   UTEINSTROMTESTS
            rts
sub_4084A23A:
            bsr.w   InvalidUpper
            addq.w  #1,($3A,A5)
            move.w  ($150,A5),($156,A5)
            pea     ($156,A5)
            move.w  #$E2,-(SP)
            move.w  #2,-(SP)
            bsr.w   COPYRAMTOPRAM
            lea     (8,SP),SP
            pea     ($158,A5)
            move.w  #$D4,-(SP)
            move.w  #4,-(SP)
            bsr.w   COPYRAMTOPRAM
            lea     (8,SP),SP
            pea     ($15C,A5)
            move.w  #$D8,-(SP)
            move.w  #4,-(SP)
            bsr.w   COPYRAMTOPRAM
            lea     (8,SP),SP
            pea     ($160,A5)
            move.w  #$DC,-(SP)
            move.w  #4,-(SP)
            bsr.w   COPYRAMTOPRAM
            lea     (8,SP),SP
            tst.w   ($154,A5)
            bne.b   .L1
            move.w  ($150,A5),($154,A5)
            pea     ($154,A5)
            move.w  #$E0,-(SP)
            move.w  #2,-(SP)
            bsr.w   COPYRAMTOPRAM
            lea     (8,SP),SP
.L1:
            move.l  ($36,A5),D2
            or.l    D2,($14C,A5)
            pea     ($14C,A5)
            move.w  #$D0,-(SP)
            move.w  #4,-(SP)
            bsr.w   COPYRAMTOPRAM
            lea     (8,SP),SP
            bsr.w   UpperToLower
            rts
.L2:
            dc.w    0,$0010,0,$0050,0,$00E0
            ds.b    4
            dc.w    $7C00,$2B7C,0,$0001,$015C,$2F0D,$4DFA,$0006
            dc.w    $4EFA,$D1A2,$2A5F,$4A86,$6620,$2B7C,0,$0002
            dc.w    $015C,$2F0D,$4DFA,$0006,$4EFA,$D1EC,$2A5F,$4A86
            dc.w    $6606,$42AD,$0160,$6002,$2C01,$2B46,$0160,$4E75
            moveq   #0,D6
            movea.l ($2E,A5),A3
.L3:
            movea.l (A3)+,A0
            cmpa.w  #$FFFF,A0
            beq.b   .L5
            movea.l (A3)+,A1
            adda.l  A0,A1
            cmpa.l  A1,SP
            bhi.b   .L4
            move.l  SP,D0
            andi.b  #$FC,D0
            movea.l D0,A1
.L4:
            move.l  #1,($15C,A5)
            BSR6    CritProc
            tst.l   D6
            bne.b   .L6
            move.l  #2,($15C,A5)
            BSR6    RevMod3Test
            tst.l   D6
            bne.b   .L6
            move.l  #3,($15C,A5)
            BSR6    ExtRAMTest
            tst.l   D6
            bne.b   .L6
            bra.b   .L3
.L5:
            movea.l ($2E,A5),A0
            movea.l (A0),A0
            lea     ($100,A0),A0
            move.l  #4,($15C,A5)
            BSR6    DataBusTest
            move.l  D6,($160,A5)
            rts
.L6:
            movea.l ($2E,A5),A1
            suba.l  A1,A3
            move.l  A3,D0
            lsl.l   #1,D0
            or.l    D0,($15C,A5)
            move.l  D6,($160,A5)
            rts
            move.l  A5,-(SP)
            moveq   #0,D6
            move.l  #1,($15C,A5)
            movea.l ($2E,A5),A3
.L7:
            movea.l (A3)+,A0
            cmpa.w  #$FFFF,A0
            beq.b   .L9
            movea.l (A3)+,A1
            move.l  A3,-(SP)
            adda.l  A0,A1
            cmpa.l  A1,SP
            bhi.b   .L8
            move.l  SP,D0
            andi.b  #$FC,D0
            movea.l D0,A1
.L8:
            BSR6    MovInvTest
            movea.l (SP)+,A3
            tst.l   D6
            beq.b   .L7
            movea.l (SP)+,A5
            bra.b   .L6
.L9:
            movea.l (SP)+,A5
            move.l  D6,($160,A5)
            rts
.L10:
            dc.w    $444F,$4E45
            ds.b    14
TMProc:
TestManager:
            movem.l D1-D5/A0-A6,-(SP)
            move    SR,-(SP)
            ori     #$700,SR
            movec   VBR,A2
            move.l  A2,-(SP)
            suba.w  #$100,SP
            move.l  D0,D3
            movea.l A0,A3
            movea.l A1,A4
            movea.l SP,A1
            BSR6    SETVECTORTABLE
            move.l  D3,D0
            movea.l A3,A0
            movea.l A4,A1
            lea     TestMgrCmds,A2
            cmp.w   (A2)+,D0
            bcc.b   TestMgrExit
            add.w   D0,D0
            adda.w  (0,A2,D0.w),A2
            jmp     (A2)
TestMgrExit:
            adda.w  #$100,SP
            movea.l (SP)+,A2
            movec   A2,VBR
            move    (SP)+,SR
            movem.l (SP)+,D1-D5/A0-A6
            rts
TestMgrCmds:
            dc.w    $000C,$0020,$001E,$0018,$0384,$002C,$0090,$009C
            dc.w    $FFEC,$0100,$014A,$02EE,$09C0,$006F,$0700,$0104
cmd1:
            bra.b   TestMgrExit
cmd0:
            moveq   #0,D6
            move.l  (A0),D7
            movea.l (8,A0),A1
            movea.l (4,A0),A0
cmd4:
            move.w  D7,D1
            lsr.w   #8,D1
            cmp.w   MaxTest,D1
            bge.b   TestMgrExit
            movea.l UnivInfoPtr,A2
            move.l  A2,USP
            add.w   D1,D1
            lea     TJump,A5
            adda.w  (A5,D1.w),A5
.loop:
            lea     .L1,A6
            RTS5
.L1:
            tst.l   D6
            beq.b   .noErr
            btst    #$1D,D7
            bne.b   TestLoop
            btst    #$1C,D7
            bne.b   StopTest
.noErr:
            subq.b  #1,D7
            bne.b   .loop
StopTest:
            btst    #$1E,D7
            beq.b   .L3
            move.l  USP,A1
            movea.l (A1),A2
            adda.l  A1,A2
            movea.l (8,A2),A2
            BSR6    StoreResults
.L3:
            btst    #$1F,D7
            beq.w   TestMgrExit
            BigJmp  StBoot,A0
TestLoop:
            lea     TestLoop,A6
            RTS5
cmd5:
            moveq   #0,D6
            move.l  (A0),D7
            movea.l (8,A0),A1
            movea.l (4,A0),A0
cmd6:
            moveq   #7,D1
            movea.l UnivInfoPtr,A2
            move.l  A2,USP
.next:
            addq.l  #1,D1
            cmpi.w  #$F,D1
            bgt.b   .cntPass
            btst    D1,D7
            beq.b   .next
            add.w   D1,D1
            lea     TJump,A5
            adda.w  (-$10,A5,D1.w),A5
            add.w   D1,D1
            lea     .return-32(PC,D1.w),A6
            RTS5
.return
            moveq   #8,D1
            bra.b   .checkErrors
            moveq   #9,D1
            bra.b   .checkErrors
            moveq   #$A,D1
            bra.b   .checkErrors
            moveq   #$B,D1
            bra.b   .checkErrors
            moveq   #$C,D1
            bra.b   .checkErrors
            moveq   #$D,D1
            bra.b   .checkErrors
            moveq   #$E,D1
            bra.b   .checkErrors
            moveq   #$F,D1
.checkErrors:
            tst.l   D6
            beq.b   .next
            btst    #$1D,D7
            bne.b   TestLoop
            btst    #$1C,D7
            bne.w   StopTest
.cntPass:
            subq.b  #1,D7
            bne.b   cmd6
            bclr    #$F,D7
            bne.b   cmd6
            bra.w   StopTest
cmd8:
            moveq   #0,D6
            move.l  (A0),D7
.loop:
            move.l  D7,D1
            lsr.w   #8,D1
            subi.w  #$80,D1
            cmp.w   MaxNTest,D1
            bge.b   .exit
            add.w   D1,D1
            lea     NJump,A5
            adda.w  (0,A5,D1.w),A5
.test:
            movea.l UnivInfoPtr,A1
            movea.l A1,A0
            adda.l  (A0),A0
            move.l  AddrMapFlags,D0
            move.w  ($12,A1),D2
            lea     .L1,A6
            RTS5
.L1:
            tst.l   D6
            beq.b   .cntPass
            btst    #$1D,D7
            bne.b   .test
            btst    #$1C,D7
            bne.b   .exit
.cntPass:
            subq.b  #1,D7
            bne.b   .loop
.exit:
            bra.w   TestMgrExit
cmd9:
            moveq   #0,D6
            move.l  (A0),D7
            lea     StartTest,A3
            lea     StartTest1,A4
            cmpa.l  (4,A3),A4
            beq.b   .onElsie
            lea     TMVectors,A3
.onElsie:
            movec   A3,VBR
            movec   CACR,D0
            move.l  D0,D1
            bset    #$F,D0
            movec   D0,CACR
            movec   CACR,D0
            btst    #$F,D0
            bne.b   .onAn040
            bset    #$D,D0
            movec   D0,CACR
            movec   CACR,D0
            movec   D1,CACR
            btst    #$D,D0
            beq.b   .not030
            lea     (-4,SP),SP
            pmove.l TC,(SP)
            move.l  (SP),D0
            bclr    #$1F,D0
            move.l  D0,(SP)
            pmove.l (SP),TC
            lea     (4,SP),SP
.not030:
            movec   CACR,D0
            bclr    #8,D0
            movec   D0,CACR
            bra.b   .begin
.onAn040:
            mc68040
            movec   TC,D0
            mc68030
            bclr    #$F,D0
            mc68040
            movec   D0,TC
            mc68030
            movec   CACR,D0
            bclr    #$1F,D0
            movec   D0,CACR
.begin:
            BSR6    SizeMemory
            movea.l (SP),SP
            movea.l SP,A4
            moveq   #0,D6
.testm:
            movea.l (A4)+,A0
            movea.l A0,A1
            adda.l  (A4)+,A1
            BSR6    CritProc
            tst.l   D6
            bne.w   .error
            BSR6    RevMod3Test
            tst.l   D6
            bne.w   .error
            BSR6    ExtRAMTest
            tst.l   D6
            bne.w   .error
            BSR6    SizeMemory
            movea.l (SP),SP
            moveq   #0,D6
            cmpi.l  #$FFFFFFFF,(A4)
            bne.b   .testm
            bra.w   .pass
.error:
            btst    #$1D,D7
            beq.b   .stp
.loop:
            lea     .loop,A6
            RTS5
.stp:
            btst    #$1C,D7
            bne.w   .done
.pass:
            subq.b  #1,D7
            bne.b   .begin
            bclr    #$F,D7
            bne.b   .begin
.done:
            btst    #$1E,D7
            beq.b   .boot
            moveq   #0,D2
            BSR6    JGetHardwareInfo
            movea.l (8,A0),A2
            suba.l  SP,A4
            move.l  A4,D2
            lsl.w   #5,D2
            swap    D7
            move.w  D2,D7
            swap    D7
            BSR6    StoreResults
.boot:
            move.l  #'WLSC',(-4,SP)
            BigJmp  StBoot,A0
StoreResults:
            movea.l A6,A0
            BSR6    CLKWPOFF
            moveq   #0,D4
            move.l  #$F0,D3
.loop1:
            rol.l   #8,D7
            move.b  D7,D2
            move.b  D3,D1
            BSR6    TM_Wait
            BSR6    TM_Wait
            BSR6    WrXByte
            addq.w  #1,D3
            cmpi.w  #$F4,D3
            blt.b   .loop1
.loop2:
            rol.l   #8,D6
            move.b  D6,D2
            move.b  D3,D1
            BSR6    WrXByte
            addq.w  #1,D3
            cmpi.w  #$F8,D3
            blt.b   .loop2
            move.l  #$54480000,D5
            move.w  D4,D5
            move.l  D5,D4
.L7:
            rol.l   #8,D4
            move.b  D4,D2
            move.b  D3,D1
            BSR6    WrXByte
            addq.w  #1,D3
            cmpi.w  #$FC,D3
            blt.b   .L7
            jmp     (A0)
            move.w  (A0),D1
            ext.l   D1
            lea     USTSubtests,A1
            move.w  #$18,D2
            tst.w   (2,A0)
            beq.b   .L8
            lea     USTTests,A1
            move.w  #$10,D2
.L8:
            move.l  A1,D6
.L9:
            cmp.l   (A1),D1
            beq.b   .L10
            adda.w  D2,A1
            cmpi.l  #$FFFFFFFF,(A1)
            bne.b   .L9
            moveq   #0,D6
            bra.b   .L11
.L10:
            add.l   (8,A1),D6
.L11:
            bra.w   TestMgrExit
TJump:
            dc.w    SizeMem-TJump
            dc.w    DataBusTest-TJump
            dc.w    Mod3Test-TJump
            dc.w    AddrLineTest-TJump
            dc.w    RomTest-TJump
            dc.w    RevMod3Test-TJump
            dc.w    ExtRAMTest-TJump
            dc.w    MovInvTest-TJump
            dc.w    SizeV8VRAMShell-TJump
            dc.w    NoTest-TJump
MaxTest:
            dc.w    10
NJump:
            dc.w    MapRamDataTest-NJump
            dc.w    MapRamUniqTest-NJump
            dc.w    VramDataTest-NJump
            dc.w    VramAddrTest-NJump
            dc.w    SCCRegTest-NJump
            dc.w    SCCLoopTest-NJump
            dc.w    SCCTimerTest-NJump
            dc.w    VIATest-NJump
            dc.w    TestSCSI-NJump
            dc.w    TestASC-NJump
            dc.w    PramTest-NJump
            dc.w    TestRBV-NJump
            dc.w    TestSWIM-NJump
            dc.w    Float_Test-NJump
            dc.w    TestPGC-NJump
            dc.w    FMCRegTest-NJump
            dc.w    FMCCacheTest-NJump
            dc.w    OSSRegTest-NJump
            dc.w    OSSIntTest-NJump
            dc.w    RPUTest-NJump
            dc.w    EgretTest-NJump
            dc.w    TestSndInts-NJump
            dc.w    TestCLUT-NJump
            dc.w    TestVRAM-NJump
            dc.w    NoTest2-NJump
            dc.w    NoTest2-NJump
            dc.w    TestC96-NJump
MaxNTest:
            dc.w    27
NoTest2:
            moveq   #-1,D6
            jmp     (A6)
TMRestart:
            lea     (-$100,SP),SP
            movea.l SP,A1
            BSR6    SETVECTORTABLE
            moveq   #0,D6
            moveq   #0,D7
TMEntry1:
            moveq   #0,D2
            BSR6    JGetHardwareInfo
            movea.l (8,A0),A2
            btst    #$18,D2
            beq.b   .noPmgr
            BSR6    USTPmgrTurnOn
.noPmgr:
            btst    #$1A,D7
            bne.b   .SkipSound
            moveq   #0,D2
            BSR6    JGetHardwareInfo
            btst    #$C,D0
            beq.b   .SkipSound
            movea.l ($30,A0),A3
            movea.l (8,A0),A5
            BigBSR6 ErrorBeep4,A0
.SkipSound:
            moveq   #0,D5
            BSR6    SETUPBASES
            BSR6    InitSCC
getCmd:
            BSR6    getchar
            tst.w   D0
            bmi.w   Continue
.gotChar:
            andi.b  #$7F,D0
            cmpi.b  #$2A,D0
            bne.b   .checkCmd
            bset    #$13,D7
            bra.w   Continue
.checkCmd:
            btst    #$13,D7
            bne.b   .gotStar
            cmpi.b  #$21,D0
            bne.w   Invalid
            bsr.w   UTECmd
            move.l  D0,-(SP)
            BSR6    SETUPBASES
            BSR6    InitSCC
            move.l  (SP)+,D0
            tst.l   D0
            bne.w   CTEReturn
            move.b  #$21,D0
            bra.w   CTEReturn
.gotStar:
            bclr    #$13,D7
            moveq   #0,D1
            moveq   #0,D2
            lea     CmdTable,A5
.loop:
            move.w  (A5)+,D2
            beq.w   Invalid
            cmp.b   D2,D0
            beq.b   .found
            addq.l  #2,A5
            bra.b   .loop
.found:
            move.l  A5,D5
            lsr.w   #8,D2
            BSR6    GetNBytes
            movea.l D5,A5
            move.b  (-1,A5),D5
            swap    D5
            move.w  (A5),D0
            jmp     (0,A5,D0.w)
CmdTable:
            dc.b    0,'S'
            dc.w    Service-*
            dc.b    4,'L'
            dc.w    LoadAddr-*
            dc.w    $0242,$016A,$0044,$0184,$0043,$01A4
            dc.w    $0447,$01C6,$0430,$01DC,$0431,$01F2,$0432,$0208
            dc.w    $0033,$0210,$0034,$0254,$0035,$0258,$0036,$0270
            dc.w    $0037,$0272,$0041,$0276,$0048,$027A,$0052,$027E
            dc.w    $004D,$029A,$0045,$02B8,$0049,$02BC,$0250,$02C2
            dc.w    $0454,$02CA,$044E,$0394,$0056,$0486,$005A,$04EA
            ds.b    4
EchoCmd:
            move.b  #'*',D0
            BSR6    OutChar
            swap    D5
            move.b  D5,D0
            swap    D5
CTEReturn:
            BSR6    OutChar
            bset    #$17,D7
            moveq   #0,D2
            BSR6    PutNBytes
            bclr    #$17,D7
            bra.b   Continue
Invalid:
            BSR6    OutChar
Continue:
            btst    #$10,D7
            beq.w   .NoUnQ
            btst    #$16,D7
            beq.b   .NoTimer
            btst    #5,($1A00,A2)
            beq.w   .NoUnQ
            move.b  #$20,($1C00,A2)
            move.b  #$FF,($1000,A2)
            move.b  #$FF,($1200,A2)
            subq.w  #1,D4
            bpl.w   .NoUnQ
            move.w  #$C,D4
.NoTimer:
            lea     a1Msg,A1
            BSR6    SendString
            bclr    #$17,D7
            bset    #$14,D7
            move.l  D6,D0
            moveq   #4,D2
            BSR6    PutNBytes
            move.w  D7,D0
            moveq   #2,D2
            BSR6    PutNBytes
            bclr    #$14,D7
            move.b  #$2A,D0
            BSR6    OutChar
            BSR6    SETUPBASES
            lea     b1Msg,A1
            lsr.w   #8,D2
            ext.w   D2
            move.b  (0,A1,D2.w),D0
            BSR6    OutChar
            lea     trailer,A1
            BSR6    SendString
            btst    #$16,D7
            bne.b   .NoUnQ
            bclr    #$10,D7
.NoUnQ:
            bra.w   getCmd
Service:
            bclr    #$10,D7
            bclr    #$16,D7
            lea     EchoCmd,A6
            jmp     PutNBytes
LoadAddr:
            movea.l D1,A4
            swap    D4
            clr.w   D4
            swap    D4
            btst    #$15,D7
            beq.w   EchoCmd
            bclr    #$17,D7
            move.l  D1,D0
            moveq   #4,D2
            lea     EchoCmd,A6
            jmp     PutNBytes
ByteCnt
            swap    D4
            move.w  D1,D4
            swap    D4
            btst    #$15,D7
            beq.w   EchoCmd
            bclr    #$17,D7
            move.w  D1,D0
            moveq   #2,D2
            lea     EchoCmd,A6
            jmp     PutNBytes
GetData:
            moveq   #0,D6
            swap    D4
            subq.w  #1,D4
            blt.b   .exit
.fetch:
            moveq   #1,D2
            BSR6    GetNBytes
            move.b  D1,(A4)+
            moveq   #0,D0
            move.b  D1,D0
            add.l   D0,D6
            dbra    D4,.fetch
.exit:
            swap    D4
            bra.w   EchoCmd
CheckSum:
            moveq   #0,D6
            swap    D4
            subq.w  #1,D4
            blt.b   .noMore
.sum:
            move.b  (A4)+,D1
            moveq   #0,D0
            move.b  D1,D0
            add.l   D0,D6
            dbra    D4,.sum
.noMore:
            swap    D4
            bclr    #$17,D7
            move.l  D6,D0
            moveq   #4,D2
            lea     EchoCmd,A6
            jmp     PutNBytes
Execute:
            movea.l D1,A2
            lea     .L1,A6
            jmp     (A2)
.L1:
            BSR6    SETUPBASES
            move.l  #$470000,D5
            bra.w   EchoCmd
LoadA0:
            movea.l D1,A0
            btst    #$15,D7
            beq.w   EchoCmd
            bclr    #$17,D7
            move.l  D1,D0
            moveq   #4,D2
            lea     EchoCmd,A6
            jmp     PutNBytes
LoadA1:
            movea.l D1,A1
            btst    #$15,D7
            beq.w   EchoCmd
            bclr    #$17,D7
            move.l  D1,D0
            moveq   #4,D2
            lea     EchoCmd,A6
            jmp     PutNBytes
SetCache:
            movec   D1,CACR
            bra.w   EchoCmd
MMUDis:
            dc.l    0
MMUOff:
            movec   CACR,D0
            move.l  D0,D1
            bset    #31,D0
            movec   D0,CACR
            movec   CACR,D0
            btst    #31,D0
            bne.b   .onAn040
            bset    #CACR_WA_030,D0
            movec   D0,CACR
            movec   CACR,D0
            btst    #CACR_WA_030,D0
            beq.b   .exit
            lea     MMUDis,A0
            pmove.l (A0),TC
            bra.b   .restoreCACR
.onAn040:
            mc68040
            movec   TC,D0
            bclr    #15,D0
            movec   D0,TC
            mc68030
.restoreCACR:
            movec   D1,CACR
.exit:
            bra.w   EchoCmd
ClearResult:
            clr.w   D7
            moveq   #0,D6
            bra.w   EchoCmd
StartBootMsg:
            bset    #$16,D7
            bset    #$10,D7
            move.w  #$C,D4
            BSR6    StartTimer
            lea     EchoCmd,A6
            jmp     SETUPBASES
CPUReset:
            reset
            bra.w   EchoCmd
PreventSleep:
            bset    #$12,D7
            bra.w   EchoCmd
ASCIIMode:
            bset    #$14,D7
            bra.w   EchoCmd
HEXMode:
            bclr    #$14,D7
            bra.w   EchoCmd
SendResults:
            bclr    #$17,D7
            move.l  D6,D0
            moveq   #4,D2
            BSR6    PutNBytes
            bclr    #$17,D7
            move.w  D7,D0
            moveq   #2,D2
            lea     EchoCmd,A6
            jmp     PutNBytes
MemDump:
            swap    D4
            subq.w  #1,D4
            bge.b   .L1
            clr.w   D4
.L1:
            bset    #$17,D7
.L2:
            move.l  (A4)+,D0
            moveq   #4,D2
            BSR6    PutNBytes
            dbra    D4,.L2
            swap    D4
            bra.w   EchoCmd
EchoOn:
            bset    #$15,D7
            bra.w   EchoCmd
InitTestManager:
            BigJmp  StBoot,A0
PwrMgrCmd:
            lea     ErrorMsg,A1
            lea     EchoCmd,A6
            jmp     SendString
DoCritTest:
            lea     ElsieTMVectors,A5
            lea     StartTest1,A4
            cmpa.l  (4,A5),A4
            beq.b   .L2
            lea     TMVectors,A5
.L2:
            movec   A5,VBR
            movea.l D1,A4
            btst    #$15,D7
            beq.b   .L3
            move.l  D1,D0
            moveq   #4,D2
            BSR6    PutNBytes
.L3:
            moveq   #2,D2
            BSR6    GetNBytes
            moveq   #-1,D0
            moveq   #$1C,D2
            lsl.l   D2,D0
            not.l   D0
            and.l   D0,D7
            move.w  D1,D0
            lsl.l   D2,D1
            or.l    D1,D7
            btst    #$15,D7
            beq.b   .Loop
            moveq   #2,D2
            BSR6    PutNBytes
.Loop:
            moveq   #0,D6
            move.l  A4,D1
            swap    D1
            move.b  #$3F,D0
            cmp.w   MaxTest,D1
            bge.w   Invalid
            asl.w   #1,D1
            lea     TJump,A5
            move.w  (0,A5,D1.w),D1
            lea     (0,A5,D1.w),A5
            lea     .L1,A6
            RTS5
.L1:
            movea.w #$2600,SP
            move.l  A0,D4
            move.l  A1,D5
            BSR6    SETUPBASES
            movea.l D4,A0
            movea.l D5,A1
            tst.l   D6
            beq.b   .Continue
            lea     ErrorMsg,A1
            BSR6    SendString
            btst    #$1D,D7
            beq.b   .NoLoop
.ErrLoop:
            lea     .ErrLoop,A6
            RTS5
.NoLoop:
            btst    #$1C,D7
            bne.b   .Echo
.Continue:
            move.l  A4,D1
            subq.w  #1,D1
            beq.b   .Echo
            movea.l D1,A4
            BSR6    getchar
            tst.w   D0
            bmi.b   .Loop
.Echo:
            move.l  #$540000,D5                     ; Fake an "N" to echo
            bra.w   EchoCmd                         
DoNonCritTest:
            movea.l D1,A4
            BSR6    SizeMemory
            movea.l (SP),A1
            movea.l (A1),A1
            BSR6    SETVECTORTABLE
            BSR6    SETUPBASES
            btst    #$15,D7
            beq.b   .getOpt
            move.l  A4,D0
            moveq   #4,D2
            BSR6    PutNBytes
.getOpt:
            moveq   #2,D2
            BSR6    GetNBytes
            moveq   #-1,D0
            moveq   #$1C,D2
            lsl.l   D2,D0
            not.l   D0
            and.l   D0,D7
            move.w  D1,D0
            lsl.l   D2,D1
            or.l    D1,D7
            btst    #$15,D7
            beq.b   .valid
            moveq   #2,D2
            BSR6    PutNBytes
.valid:
            move.l  A4,D1
            swap    D1
            subi.w  #$80,D1
            cmp.w   MaxNTest,D1
            blt.w   .table
            move.b  #$3F,D0
            bra.w   Invalid
.table:
            asl.w   #1,D1
            lea     NJump,A5
            move.w  (0,A5,D1.w),D1
            lea     (0,A5,D1.w),A5
            move.w  A4,-(SP)
            move.l  A5,-(SP)
            moveq   #0,D2
            BSR6    JGetHardwareInfo
            movea.l (SP)+,A5
            movem.l D0-D2/A0-A2/A5,-(SP)
.Loop:
            moveq   #0,D6
            movem.l (SP),D0-D2/A0-A2/A5
            lea     .L9,A6
            RTS5
.L9:
            BSR6    SETUPBASES
            BSR6    InitSCC
            tst.l   D6
            beq.b   .Continue
            lea     ErrorMsg,A1
            BSR6    SendString
            btst    #$1D,D7
            beq.b   .NoLoop
.ErrLoop:
            lea     .ErrLoop,A6
            movem.l (SP),D0-D2/A0-A2/A5
            RTS5
.NoLoop:
            btst    #$1C,D7
            bne.b   .Echo
.Continue:
            subq.w  #1,($1C,SP)
            beq.b   .Echo
            BSR6    getchar
            tst.w   D0
            bmi.b   .Loop
.Echo:
            lea     ($1E,SP),SP
            move.l  #$4E0000,D5
            bra.w   EchoCmd
EchoVersion
            BSR6    SETUPBASES
            BSR6    InitSCC
            lea     Version,A1
            BSR6    SendString
            move.l  D7,D4
            bset    #$14,D7
            bclr    #$17,D7
            BigLea  ROMVersion+1,A0
            move.b  (A0),D0
            moveq   #1,D2
            BSR6    PutNBytes
            move.b  #$20,D0
            BSR6    OutChar
            BigLea  BadDisk_L1,A0
            move.w  (A0),D0
            moveq   #2,D2
            bset    #$17,D7
            BSR6    PutNBytes
            move.l  D4,D7
            bra.w   EchoCmd
NubSTMDispatch:
            BigJmp  NubSTMDispatch,A0
NubMgrDispatch:
            BigJmp  NubMgrDispatch,A0
SETUPBASES:
            movea.l A6,A3
            moveq   #0,D2
            BSR6    JGetHardwareInfo
            movea.l A3,A6
            movea.l (8,A0),A2
            btst    #$11,D0
            beq.b   .L1
            movea.l ($44,A0),A3
            moveq   #0,D3
            bra.b   .L2
.L1:
            movea.l ($C,A0),A3
            move.l  ($10,A0),D3
            sub.l   A3,D3
.L2:
            RTS6
InitSCC:
            movea.l A6,A5
            btst    #$11,D0
            beq.b   .L4
            BSR6    SetSCCIOPBypass
.L4:
            tst.b   (0,A3,D3.l)
            lea     .L7,A1
.L5:
            move.b  (A1)+,D0
            bmi.b   .L6
            move.b  D0,(2,A3,D3.l)
            move.b  (A1)+,(2,A3,D3.l)
            bra.b   .L5
.L6:
            bset    #$11,D7
            move.b  (6,A3),D0
            bset    #3,($600,A2)
            move.b  ($1E00,A2),D0
            bclr    #3,D0
            move.b  D0,($1E00,A2)
            RTS5
.L7:
            dc.w    $09C0,$0F00,$044C,$0B50,$0E00,$0C0A,$0D00,$0E01
            dc.w    $0A00,$03C1,$05EA,$0100,$FFFF
OutChar:
            move.b  #$30,(2,A3,D3.l)
            move.b  D0,(6,A3,D3.l)
.L1:
            move.w  #1,D0
            move.b  D0,(2,A3,D3.l)
            btst    #0,(2,A3)
            beq.b   .L1
            RTS6
SendString:
            movea.l A6,A0
.L3:
            move.b  (A1)+,D0
            beq.b   .L4
            BSR6    OutChar
            bra.b   .L3
.L4:
            jmp     (A0)
ErrorMsg:
            dc.b    '*ERROR*'
            dc.b    $00
a1Msg:
            dc.b    '*APPLE*'
            dc.b    $00,$30,$33,$32
b1Msg:
            dc.b    '11116788AAABCDEHIJ'
trailer:
            dc.b    '*',$0D,$0A,$00
Version:
            dc.b    'STM Version 2.1, Scott Smyers '
            dc.b    $0D,$0A
            dc.b    'CTE Version 1.5.1 '
            dc.b    $0D,$0A
            dc.b    'ROM Version '
            dc.b    $00
StartTimer:
            movea.l A6,A3
            moveq   #0,D2
            BSR6    JGetHardwareInfo
            movea.l (8,A0),A2
            clr.b   ($1600,A2)
            move.b  #$20,($1C00,A2)
            move.b  #$FF,($1000,A2)
            move.b  #$FF,($1200,A2)
            jmp     (A3)
            movea.l A6,A5
            bclr    #$F,D0
            btst    #5,($1A00,A2)
            beq.b   .L1
            move.b  #$20,($1C00,A2)
            move.b  #$FF,($1000,A2)
            move.b  #$FF,($1200,A2)
            subq.w  #1,D4
            bpl.b   .L1
            move.w  D0,D4
            bset    #$F,D0
.L1:
            RTS5
getchar:
            move.w  #$8000,D0
            btst    #$11,D7
            beq.b   .L2
            btst    #0,(2,A3)
            beq.b   .L2
            moveq   #1,D0
            move.b  D0,(2,A3,D3.l)
            move.b  (2,A3),D0
            andi.b  #$70,D0
            beq.b   .L1
            move.b  #$30,(2,A3,D3.l)
.L1:
            lsl.l   #8,D0
            move.b  (6,A3),D0
.L2:
            RTS6
CVTASCII:
            andi.w  #$7F,D0
            subi.b  #$30,D0
            bmi.b   .L2
            cmpi.b  #$16,D0
            bgt.b   .L2
            cmpi.b  #9,D0
            ble.b   .L1
            subq.b  #7,D0
.L1:
            RTS6
.L2:
            clr.w   D0
            RTS6
GetNBytes:
            movea.l A6,A5
            tst.w   D2
            beq.b   .exit
            moveq   #0,D1
            btst    #$14,D7
            beq.b   .adjust
            asl.w   #1,D2
.adjust:
            subq.w  #1,D2
.loop:
            BSR6    getchar
            tst.w   D0
            bmi.b   .loop
            btst    #$14,D7
            beq.b   .hex
            BSR6    CVTASCII
            lsl.l   #4,D1
            or.b    D0,D1
            bra.b   .next
.hex:
            lsl.l   #8,D1
            move.b  D0,D1
.next:
            dbra    D2,.loop
.exit:
            RTS5
CvtHex:
            cmpi.b  #$A,D0
            blt.b   .num
            addq.b  #7,D0
.num:
            addi.b  #$30,D0
            RTS6
PutNBytes:
            movea.l A6,A5
            move.l  D0,D1
            tst.w   D2
            beq.b   .crlf
            moveq   #4,D0
            sub.w   D2,D0
            mulu.w  #8,D0
            rol.l   D0,D1
            btst    #$14,D7
            beq.b   .hex
            asl.w   #1,D2
.hex:
            subq.w  #1,D2
.loop:
            btst    #$14,D7
            bne.b   .ascii
            rol.l   #8,D1
            move.b  D1,D0
            bra.b   .send
.ascii:
            rol.l   #4,D1
            move.b  D1,D0
            andi.b  #$F,D0
            BSR6    CvtHex
.send:
            BSR6    OutChar
            dbra    D2,.loop
.crlf:
            btst    #$17,D7
            beq.b   .exit
            move.b  #$D,D0
            BSR6    OutChar
            move.b  #$A,D0
            BSR6    OutChar
.exit:
            RTS5
SendToClk:
            moveq   #8-1,D0                         ; Shifting out 8 bits
.ShiftLoop:
            swap    D0                              ; Save the count
            move.b  (vBufB,A2),D0                   ; Get the VIA register's contents
            ror.b   #1,D0
            roxl.b  #1,D1
            roxl.b  #1,D0
            move.b  D0,(vBufB,A2)
            bclr    #vRTCClk,(vBufB,A2)
            bset    #vRTCClk,(vBufB,A2)
            swap    D0
            dbra    D0,.ShiftLoop
            RTS6
.L2:
            moveq   #7,D1
            bclr    #vRTCData,(vDIRB,A2)
.L3:
            bclr    #vRTCClk,(vBufB,A2)
            bset    #vRTCClk,(vBufB,A2)
            move.b  (vBufB,A2),D0
            lsr.b   #vRTCData+1,D0
            roxl.b  #1,D2
            dbra    D1,.L3
            bset    #vRTCData,(vDIRB,A2)
            RTS6
WrXByte:
            movea.l A6,A3
            move.l  ($1C,A1),D0
            andi.l  #$70,D0
            cmpi.l  #$20,D0
            bne.w   .L8
            move.l  D2,D5
            btst    #5,(A2)
            beq.b   .L1
            bclr    #5,(A2)
            BSR6    TM_Wait
            bclr    #4,(A2)
            BSR6    TM_Wait
.L1:
            ori.b   #$C,($1600,A2)
            bset    #4,($1600,A2)
            btst    #3,(A2)
            beq.b   .L3
            bset    #5,(A2)
            move.b  #1,($1400,A2)
            bset    #4,(A2)
            move.w  #$7FFF,D0
.L2:
            btst    #2,($1A00,A2)
            dbne    D0,.L2
            tst.b   ($1400,A2)
            tst.w   D0
            bmi.w   .L4
            bclr    #4,(A2)
            BSR6    TM_Wait
            btst    #3,(A2)
            bne.b   .L5
            bra.b   .L4
.L3:
            BSR6    TM_Wait
            tst.b   ($1400,A2)
.L4:
            bclr    #5,(A2)
            bclr    #4,(A2)
            bclr    #4,($1600,A2)
            BSR6    TM_Wait
            BSR6    dispose
            bra.b   .L1
.L5:
            moveq   #$C,D2
            BSR6    TM_SendByte
            move.l  D1,D2
            lsr.l   #8,D2
            BSR6    TM_SendByte
            move.l  D1,D2
            BSR6    TM_SendByte
            move.l  D5,D2
            BSR6    TM_SendByte
            bclr    #4,($1600,A2)
            bclr    #5,(A2)
.L6:
            btst    #2,($1A00,A2)
            beq.b   .L6
            btst    #3,(A2)
            bne.b   .L6
            tst.b   ($1400,A2)
            BSR6    TM_Wait
            bset    #5,(A2)
            BSR6    TM_GetByte
            bne.b   .L4
            BSR6    TM_GetByte
            bne.w   .L4
            BSR6    TM_GetByte
            beq.w   .L7
            cmpi.b  #$C,D2
            bne.w   .L4
            bclr    #5,(A2)
            bclr    #4,(A2)
            BSR6    TM_Wait
            jmp     (A3)
.L7:
            BSR6    TM_GetByte
            beq.b   .L7
            bra.w   .L4
.L8:
            bclr    #2,(A2)
            ror.w   #5,D1
            andi.b  #7,D1
            ori.b   #$38,D1
            BSR6    SendToClk
            rol.w   #7,D1
            BSR6    SendToClk
            move.b  D2,D1
            andi.w  #$FF,D1
            BSR6    SendToClk
            bset    #2,(A2)
            jmp     (A3)
RdXByte:
            movea.l A6,A3
            move.l  ($1C,A1),D0
            andi.l  #$70,D0
            cmpi.l  #$20,D0
            bne.w   .L8
            btst    #5,(A2)
            beq.b   .L1
            bclr    #5,(A2)
            BSR6    TM_Wait
            bclr    #4,(A2)
            BSR6    TM_Wait
.L1:
            ori.b   #$C,($1600,A2)
            bset    #4,($1600,A2)
            btst    #3,(A2)
            beq.b   .L3
            bset    #5,(A2)
            move.b  #1,($1400,A2)
            bset    #4,(A2)
            move.w  #$7FFF,D0
.L2:
            btst    #2,($1A00,A2)
            dbne    D0,.L2
            tst.b   ($1400,A2)
            tst.w   D0
            bmi.w   .L4
            bclr    #4,(A2)
            BSR6    TM_Wait
            btst    #3,(A2)
            bne.b   .L5
            bra.b   .L4
.L3:
            BSR6    TM_Wait
            tst.b   ($1400,A2)
.L4:
            bclr    #5,(A2)
            bclr    #4,(A2)
            bclr    #4,($1600,A2)
            BSR6    TM_Wait
            BSR6    dispose
            bra.b   .L1
.L5:
            moveq   #7,D2
            BSR6    TM_SendByte
            move.l  D1,D2
            lsr.l   #8,D2
            BSR6    TM_SendByte
            move.l  D1,D2
            BSR6    TM_SendByte
            bclr    #4,($1600,A2)
            bclr    #5,(A2)
.L6:
            btst    #2,($1A00,A2)
            beq.b   .L6
            btst    #3,(A2)
            bne.b   .L6
            move.b  ($1400,A2),D2
            BSR6    TM_Wait
            bset    #5,(A2)
            BSR6    TM_GetByte
            bne.b   .L4
            BSR6    TM_GetByte
            bne.b   .L4
            BSR6    TM_GetByte
            bne.w   .L4
            cmpi.b  #7,D2
            bne.w   .L4
            BSR6    TM_GetByte
            bclr    #5,(A2)
.L7:
            btst    #3,(A2)
            beq.b   .L7
            bclr    #4,(A2)
            BSR6    TM_Wait
            move.l  D2,D1
            jmp     (A3)
.L8:
            bclr    #2,(A2)
            ror.w   #5,D1
            andi.b  #7,D1
            ori.b   #$B8,D1
            BSR6    SendToClk
            rol.w   #7,D1
            BSR6    SendToClk
            BSR6    SendToClk.L2
            bset    #2,(A2)
            andi.w  #$FF,D2
            move.l  D2,D1
            jmp     (A3)
TM_SendByte:
            movea.l A6,A5
            move.b  D2,($1400,A2)
            bset    #4,(A2)
.L1:
            btst    #2,($1A00,A2)
            beq.b   .L1
            tst.b   ($1400,A2)
            bclr    #4,(A2)
            movea.l A5,A6
            jmp     TM_Wait
TM_GetByte:
            movea.l A6,A5
            bclr    #4,(A2)
.L1:
            btst    #2,($1A00,A2)
            beq.b   .L1
            bset    #4,(A2)
            move.b  ($1400,A2),D2
            BSR6    TM_Wait
            andi.w  #$FF,D2
            btst    #3,(A2)
            RTS5
TM_Wait:
            move.w  #delay325uS,D0                  ; Delay using a VIA access as a time base
.delay:
            tst.b   (vBufB,A2)                      ; Touch the VIA (each access is ~127uS)
            dbra    D0,.delay                       ; Delay
            RTS6
dispose:
            movea.l A6,A4                           ; Save the return address
            btst    #vXcvrSesBit,(vBufB,A2)         ; Is XCVR Session asserted?
            bne.b   .L4                             ; If not, just delay an return
            BSR6    TM_Wait                         ; Give Egret a breather
            bset    #vSysSesbit,(vBufB,A2)          ; TElse set sys session
.L3:
            BSR6    TM_GetByte                      ; Read a byte - to throw away
            beq.b   .L3
            bclr    #vSysSesbit,(A2)
            bclr    #4,(A2)
.L4:
            movea.l A4,A6
            jmp     TM_Wait
CLKWPOFF:
            move.l  ($1C,A1),D1
            andi.l  #$70,D1
            cmpi.l  #$20,D1
            bne.b   .L1
            RTS6
.L1:
            movea.l A6,A5
            bclr    #2,(A2)
            moveq   #$35,D1
            moveq   #$55,D2
            BSR6    SendToClk
            move.w  D2,D1
            BSR6    SendToClk
            bset    #2,(A2)
            RTS5
            movea.l A6,A5
            RTS5
SizeMem:
            move.l  A6,USP
            BSR6    SizeMemory
            sne     D7
            bne.b   .L1
            move.l  (SP),D6
.L1:
            move.l  USP,A6
            RTS6
SizeV8VRAMShell:
            movea.l A6,A3
            moveq   #0,D2
            BSR6    JGetHardwareInfo
            suba.l  A2,A2
            BSR6    SizeV8VRAM
            move.l  A2,D0
            bne.b   .L2
            moveq   #-1,D6
            bra.b   .L3
.L2:
            moveq   #0,D6
            btst    #2,(1,A2)
            beq.b   .L3
            move.l  #$40000,D6
            btst    #1,(1,A2)
            bne.b   .L3
            lsl.l   #1,D6
.L3:
            jmp     (A3)
USTMAINTEST:
            move.l  ($10,SP),D0
            movea.l (4,SP),A0
            move.l  D0,-(SP)
            pea     (A0)
            BigJsr  GI_FindSubtest,A0
            addq.l  #8,SP
            movea.l D0,A0
            movea.l ($10,A0),A3
            move.l  ($2A,A5),D0
            movea.l ($26,A5),A1
            movea.l ($22,A5),A0
            move.w  ($12,A1),D2
            moveq   #0,D6
            movem.l D0/D2/A0-A2/A5-A6,-(SP)
            lea     .L1,A6
            jmp     (A3)
.L1:
            tst.l   D6
            beq.b   .L2
            movem.l (SP),D0/D2/A0-A2/A5-A6
            tst.l   ($1A,A5)
            beq.b   .L2
            movea.l ($1A,A5),A3
            jsr     (A3)
.L2:
            movem.l (SP)+,D0/D2/A0-A2/A5-A6
            move.l  D6,D0
            rts
STM_Util:
            dc.w    0,$010C,0,$0176,0,$01A0,0,$0146
            dc.w    0,$01EE,0,$0204,0,$0254
GI_Table:
            dc.w    $0007,$C57E,$0007,$C63E,0,$0296,0,$02EC
            dc.w    $0007,$C71E,$0007,$C73E,$0007,$C75E,$0007,$C77E
            dc.w    $0007,$C79E,$0007,$C7BE,$0007,$C7DE,$0007,$C80E
            dc.w    $0007,$C82E,$0007,$C84E,$0007,$C86E,$0007,$C87E
            dc.w    $0007,$C88E,$0007,$C89E,$0007,$C8AE,$0007,$C8BE
            dc.w    $0007,$C8CE,$0007,$C64E,$0007,$C6AE
UTECmd:
            lea     (-6,SP),SP
            move.l  SP,-(SP)
            move.l  #6,-(SP)
            bsr.w   GetCmdData
            lea     (8,SP),SP
            move.l  (SP)+,D0
            bne.b   .notInit
            addq.l  #2,SP
            movea.l (SP),A6
            lea     STM_Util,A0
            adda.l  (A0),A0
            jmp     (A0)
.notInit:
            moveq   #0,D1
            move.w  (SP)+,D1
            movea.l (4,SP),A5
            movem.l D3/A3,-(SP)
            move.l  D0,(A5)
            move.l  D1,(4,A5)
            beq.b   .CmdDecode
            suba.l  D1,SP
            move.l  SP,-(SP)
            move.l  D1,-(SP)
            bsr.w   GetCmdData
            lea     (8,SP),SP
            move.l  (A5),D0
.CmdDecode:
            lea     STM_Util,A0
            cmpi.l  #$10000,D0
            blt.b   .Branch
            lea     GI_Table,A0
            subi.l  #$10000,D0
.Branch:
            move.l  ($16,A5),-(SP)
            lsl.l   #2,D0
            move.l  (0,A0,D0.l),D0
            jsr     (0,A0,D0.l)
            addq.l  #4,SP
            adda.l  (4,A5),SP
            movem.l (SP)+,D3/A3
            move.l  D0,-(SP)
            move.l  SP,-(SP)
            move.l  #4,-(SP)
            bsr.w   SendData
            lea     (8,SP),SP
            moveq   #0,D0
            move.l  (SP)+,D6
            beq.b   .finish
            move.b  #$58,D0
.finish:
            rts
UTEReset:
            move.l  A6,USP
            BSR6    USTINIT
            move.w  #4,(8,A5)
            suba.l  #$D800,SP
            move.l  SP,($16,A5)
            move.l  A5,-(SP)
            move.l  USP,A0
            move.l  A0,-(SP)
            movea.l ($16,A5),A0
            move.l  #$D800,-(SP)
            pea     (A0)
            BigJsr  GI_InitInterface,A0
            addq.l  #8,SP
            rts
            move.l  (8,SP),D0
            movea.l ($12,A5),A0
.L5:
            cmp.w   (2,A0),D0
            beq.b   .L6
            cmpi.w  #$FFFF,(2,A0)
            beq.b   .L7
            addq.w  #6,A0
            bra.b   .L5
.L6:
            move.w  (4,A0),D1
            and.w   (8,A5),D1
            beq.b   .L7
            bsr.w   USTGETANDINSTALL
            moveq   #0,D0
            rts
.L7:
            moveq   #-1,D0
            rts
            movea.l ($12,A5),A0
.L8:
            moveq   #0,D0
            move.w  (2,A0),D0
            cmpi.w  #$FFFF,D0
            beq.b   .L10
            move.w  (4,A0),D1
            and.w   (8,A5),D1
            beq.b   .L9
            move.l  A0,-(SP)
            bsr.w   USTGETANDINSTALL
            movea.l (SP)+,A0
.L9:
            addq.w  #6,A0
            bra.b   .L8
.L10:
            moveq   #0,D0
            rts
UTEINSTROMTESTS:
            clr.l   ($1A,A5)
            lea     USTTests,A0
            move.l  A0,D1
.L1:
            movea.l (4,A0),A1
            adda.l  D1,A1
            move.l  (8,A0),D0
            beq.b   .L2
            add.l   D1,D0
.L2:
            movea.l D0,A2
            movea.l ($16,A5),A3
            movem.l D1/A0,-(SP)
            pea     (A2)
            move.l  ($C,A0),-(SP)
            pea     (A1)
            move.l  (A0),-(SP)
            pea     (A3)
            BigJsr  GI_InstallTest,A0
            adda.w  #$14,SP
            movem.l (SP)+,D1/A0
            lea     ($10,A0),A0
            cmpi.l  #$FFFFFFFF,(A0)
            bne.b   .L1
            rts
            movea.l SP,A0
            move.l  (8,A0),-(SP)
            move.l  ($C,A0),-(SP)
            bsr.w   SendData
            lea     (8,SP),SP
            moveq   #0,D0
            rts
            link.w  A6,#0
            movea.l ($22,A5),A0
            movea.l ($26,A5),A1
            movea.l (8,A0),A2
            suba.w  ($E,A6),SP
            movea.l SP,A4
            movem.l D3/A3-A4/A6,-(SP)
            move.w  ($C,A6),-(SP)
            pea     (A4)
            move.w  ($E,A6),-(SP)
            bsr.w   COPYPRAMTORAM
            lea     (8,SP),SP
            movem.l (SP)+,D3/A3-A4/A6
            movem.l A6,-(SP)
            move.l  A4,-(SP)
            move.w  ($E,A6),D0
            ext.l   D0
            move.l  D0,-(SP)
            bsr.w   SendData
            lea     (8,SP),SP
            movem.l (SP)+,A6
            unlk    A6
            moveq   #0,D0
            rts
            link.w  A6,#0
            move.w  ($E,A6),D0
            ext.l   D0
            suba.l  D0,SP
            movea.l SP,A4
            movem.l A4/A6,-(SP)
            move.l  A4,-(SP)
            move.l  D0,-(SP)
            bsr.w   GetCmdData
            lea     (8,SP),SP
            movem.l (SP)+,A4/A6
            movea.l ($22,A5),A0
            movea.l ($26,A5),A1
            movea.l (8,A0),A2
            movem.l A4-A6,-(SP)
            BSR6    CLKWPOFF
            movem.l (SP)+,A4-A6
            movem.l A6,-(SP)
            pea     (A4)
            move.w  ($C,A6),-(SP)
            move.w  ($E,A6),-(SP)
            bsr.w   COPYRAMTOPRAM
            lea     (8,SP),SP
            movem.l (SP)+,A6
            unlk    A6
            moveq   #0,D0
            rts
            movea.l (4,SP),A0
            move.l  ($10,SP),D0
            move.l  D0,-(SP)
            pea     (A0)
            BigJsr  GI_AllocPermMem,A0
            addq.l  #8,SP
            tst.l   D0
            bne.b   .L3
            moveq   #-1,D0
            bra.b   .L4
.L3:
            move.l  ($10,SP),D1
            move.l  D0,-(SP)
            move.l  D1,-(SP)
            bsr.w   GetCmdData
            move.l  (SP)+,D1
            movea.l (SP)+,A0
            move.l  (8,SP),D2
            movea.l (4,SP),A1
            movea.l ($14,SP),A2
            pea     (A2)
            move.l  D1,-(SP)
            pea     (A0)
            move.l  D2,-(SP)
            pea     (A1)
            BigJsr  GI_InstallTest,A0
            adda.w  #$14,SP
.L4:
            rts
            movea.l (4,SP),A0
            move.l  ($10,SP),D0
            move.l  D0,-(SP)
            pea     (A0)
            BigJsr  GI_AllocPermMem,A0
            addq.l  #8,SP
            tst.l   D0
            bne.b   .L5
            moveq   #-1,D0
            bra.b   .L6
.L5:
            move.l  ($10,SP),D1
            move.l  D0,-(SP)
            move.l  D1,-(SP)
            bsr.w   GetCmdData
            move.l  (SP)+,D1
            movea.l (SP)+,A0
            movea.l SP,A0
            movea.l (4,A0),A1
            movea.l ($14,A0),A2
            move.l  ($1C,A0),-(SP)
            move.l  ($18,A0),-(SP)
            pea     (A2)
            move.l  D1,-(SP)
            pea     (A0)
            move.l  (8,A0),-(SP)
            pea     (A1)
            BigJsr  GI_InstallSubtest,A0
            adda.w  #$1C,SP
.L6:
            rts
GetCmdData:
            move.l  (4,SP),D1
            btst    #$14,D7
            beq.b   .L1
            lsl.l   #1,D1
.L1:
            movea.l (8,SP),A0
.L2:
            movem.l D1/A0/A5,-(SP)
.L3:
            BSR6    getchar
            tst.w   D0
            bmi.b   .L3
            btst    #$15,D7
            beq.b   .L4
            move.l  D0,D1
            BSR6    OutChar
            move.l  D1,D0
.L4:
            btst    #$14,D7
            beq.b   .L7
            cmpi.b  #$61,D0
            blt.b   .L5
            andi.b  #$DF,D0
.L5:
            BSR6    CVTASCII
            movem.l (SP)+,D1/A0/A5
            btst    #0,D1
            bne.b   .L6
            lsl.b   #4,D0
            move.b  D0,(A0)
            bra.b   .L8
.L6:
            or.b    D0,(A0)+
            bra.b   .L8
.L7:
            movem.l (SP)+,D1/A0/A5
            move.b  D0,(A0)+
.L8:
            subq.l  #1,D1
            bgt.b   .L2
            rts
SendData:
            bsr.w   sub_4084B95C
            move.l  (4,SP),D1
            move.l  D1,D4
            movea.l (8,SP),A0
.L1:
            move.b  (A0)+,D0
            btst    #$14,D7
            beq.b   .L2
            move.b  D0,D2
            lsr.b   #4,D0
            bsr.w   sub_4084B94A
            BSR6    OutChar
            move.b  D2,D0
            andi.b  #$F,D0
            bsr.w   sub_4084B94A
.L2:
            BSR6    OutChar
            cmpi.l  #4,D4
            ble.b   .L3
            move.l  A0,D0
            andi.b  #3,D0
            bne.b   .L3
            bsr.w   sub_4084B95C
.L3:
            subq.l  #1,D1
            bgt.b   .L1
            moveq   #0,D0
            rts
sub_4084B94A:
            cmpi.b  #$A,D0
            blt.b   .L1
            addi.b  #$37,D0
            bra.b   .L2
.L1:
            addi.b  #$30,D0
.L2:
            rts
sub_4084B95C:
            move.b  #$D,D0
            BSR6    OutChar
            move.b  #$A,D0
            BSR6    OutChar
            rts
USTGETANDINSTALL:
            suba.w  #$18,SP
            move.l  SP,-(SP)
            move.l  D0,-(SP)
            bsr.w   USTGETSUBTEST
            addq.l  #8,SP
            movea.l SP,A0
            movea.l ($16,A5),A1
            movea.l (4,A0),A2
            movea.l (8,A0),A3
            move.l  ($14,A0),-(SP)
            move.l  ($10,A0),-(SP)
            pea     (A3)
            move.l  ($C,A0),-(SP)
            pea     (A2)
            move.l  (A0),-(SP)
            pea     (A1)
            BigJsr  GI_InstallSubtest,A0
            adda.w  #$1C,SP
            lea     ($18,SP),SP
            rts
diagROMentry:
            tst.l   D7
            bne.b   .L1
            movea.l (SP),A6
            move.l  A6,USP
            BSR6    USTINIT
            move.w  #4,(8,A5)
            suba.l  #$D800,SP
            move.l  SP,($16,A5)
            move.l  USP,A0
            move.l  A0,-(SP)
            movea.l ($16,A5),A0
            move.l  #$D800,-(SP)
            pea     (A0)
            BigJsr  GI_InitInterface,A0
            addq.l  #8,SP
            lea     diagROMentry,A3
            rts
.L1:
            move.l  D7,D0
            lea     .L3,A0
            cmpi.l  #$10000,D0
            blt.b   .L2
            lea     GI_Table,A0
            subi.l  #$10000,D0
.L2:
            move.l  (SP)+,(A5)
            move.l  ($16,A5),-(SP)
            lsl.l   #2,D0
            move.l  (0,A0,D0.l),D0
            jsr     (0,A0,D0.l)
            addq.l  #4,SP
            move.l  D0,D6
            movea.l (A5),A0
            lea     diagROMentry,A3
            jmp     (A0)
.L3:
            ds.b    4
            dc.w    $FFFF,$FC6C,$FFFF,$FC96,0,$0014,0,$0046
            link.w  A6,#0
            movea.l ($22,A5),A0
            movea.l ($26,A5),A1
            movea.l (8,A0),A2
            movea.l ($E,A6),A3
            movem.l A6,-(SP)
            move.w  ($12,A6),-(SP)
            pea     (A3)
            move.w  ($C,A6),-(SP)
            bsr.w   COPYPRAMTORAM
            lea     (8,SP),SP
            movem.l (SP)+,A6
            unlk    A6
            rts
            link.w  A6,#0
            movea.l ($22,A5),A0
            movea.l ($26,A5),A1
            movea.l (8,A0),A2
            movem.l A5-A6,-(SP)
            BSR6    CLKWPOFF
            movem.l (SP)+,A5-A6
            movea.l ($10,A6),A3
            movem.l A6,-(SP)
            pea     (A3)
            move.w  ($E,A6),-(SP)
            move.w  ($C,A6),-(SP)
            bsr.w   COPYRAMTOPRAM
            lea     (8,SP),SP
            movem.l (SP)+,A6
            unlk    A6
            rts
            ds.b    8
SizeMemory:
            move.l  A6,D3
            moveq   #0,D2
            BigBSR6 GetHardwareInfo,A0
            movea.l D3,A2
            moveq   #0,D3
            move.b  D2,D3
            add.w   D3,D3
            move.w  .L1(PC,D3.w),D3
            jmp     .L1(PC,D3.w)
.L1:
            dc.w    .L10-.L1
            dc.w    .L10-.L1
            dc.w    .L10-.L1
            dc.w    .L10-.L1
            dc.w    .L2-.L1
            dc.w    .L10-.L1
            dc.w    .L3-.L1
            dc.w    .L7-.L1
            dc.w    .L5-.L1
            dc.w    .L8-.L1
            dc.w    .L9-.L1
.L2:
            movea.l ($2C,A0),A5
            ori.b   #$C0,($1E00,A5)
            bra.w   .L10
.L3:
            movea.l ($4C,A0),A5
            move.w  #$F3EF,D2
            moveq   #$F,D3
.L4:
            move.b  D2,(A5)
            lsr.w   #1,D2
            dbra    D3,.L4
            move.b  D2,($10,A5)
            bra.w   .L10
.L5:
            movea.l ($54,A0),A5
            lea     (A5),A0
            move.l  #$30810,D3
            moveq   #$11,D2
.L6:
            move.l  D3,(A0)+
            lsr.l   #1,D3
            dbra    D2,.L6
            move.l  D2,($A0,A5)
            bra.w   .L10
.L7:
            movea.l ($34,A0),A5
            ori.b   #$E0,(1,A5)
            bra.w   .L10
.L8:
            moveq   #0,D0
            movea.l ($58,A0),A5
            adda.l  #$10000,A5
            move.b  D0,(A5)
            lea     ($2000,A5),A5
            move.b  D0,(A5)
            lea     ($2000,A5),A5
            move.b  D0,(A5)
            bra.w   .L10
.L9:
            movea.l ($6C,A0),A5
            ori.b   #$E0,(1,A5)
.L10:
            movea.l A1,A5
            adda.l  (4,A5),A5
            movea.l A5,SP
            addq.l  #4,SP
            moveq   #0,D0
            moveq   #0,D5
            moveq   #0,D6
            move.l  #'Tina',D1
.L11:
            ror.l   #4,D5
            ror.l   #4,D6
            movea.l (SP)+,A0
            move.l  A0,D2
            addq.l  #1,D2
            beq.b   .L13
            movea.l (SP)+,A1
            BSR6    .L21
            moveq   #$F,D3
            and.b   D6,D3
            beq.b   .L12
            cmpi.b  #$F,D3
            bne.b   .L11
            eor.b   D3,D6
            bra.b   .L11
.L12:
            BSR6    .L14
            bra.b   .L11
.L13:
            suba.l  A5,SP
            subq.l  #8,SP
            move.l  SP,D2
            lsr.w   #1,D2
            rol.l   D2,D5
            rol.l   D2,D6
            tst.l   D6
            beq.b   .L25
            jmp     (A2)
.L14:
            move.l  A0,D4
            subq.l  #4,A1
.L15:
            move.l  (A1),D2
            move.l  D1,(A1)
            cmp.l   (A1),D1
            beq.b   .L16
            suba.l  (A5),A1
            cmpa.l  A0,A1
            bgt.b   .L15
            bra.b   .L20
.L16:
            subq.l  #4,A0
.L17:
            adda.l  (A5),A0
            cmp.l   (A0),D1
            bne.b   .L17
            move.l  D2,(A0)+
            suba.l  D4,A0
            moveq   #0,D3
            move.l  A0,D2
            beq.b   .L19
            move.l  (A5),D2
.L18:
            addq.w  #1,D3
            cmpa.l  D2,A0
            beq.b   .L19
            add.l   D2,D2
            bra.b   .L18
.L19:
            or.b    D3,D5
            add.l   A0,D0
.L20:
            RTS6
.L21:
            move.l  (A0),D3
            move.l  (4,A0),D4
            move.l  D1,(A0)
            moveq   #3,D2
.L22:
            move.l  #$FFFFFFFF,(4,A0)
            cmp.b   (0,A0,D2.w),D1
            bne.b   .L23
            not.b   D1
            not.b   (0,A0,D2.w)
            cmp.b   (0,A0,D2.w),D1
            beq.b   .L24
.L23:
            bset    D2,D6
.L24:
            ror.l   #8,D1
            dbra    D2,.L22
            move.l  D3,(A0)
            move.l  D4,(4,A0)
            RTS6
.L25:
            move.l  D0,D3
            moveq   #0,D2
            movea.w #$2600,SP
            move.l  A2,D4
            BigBSR6 GetHardwareInfo,A0
            movea.l D4,A2
            adda.l  (4,A1),A1
            add.b   D2,D2
            ext.w   D2
            move.w  .L26(PC,D2.w),D1
            move.l  (A1)+,D2
            jmp     .L26(PC,D1.w)
.L26:
            ori.b   #$16,(A6)
            ori.b   #$16,(A6)
            ori.b   #$40,(A4)+
            dc.w    $007A,$011E,$00B8,$0154,$0212,$7214,$6000,$022A
            dc.w    $720F,$C205,$6604,$5049,$E88D,$103B,$1010,$2A68
            dc.w    $002C,$C12D,$1E00,$721C,$6000,$020E,$FF3F,$FF7F
            dc.w    $FFBF,$FFFF,$9BCD,$43E9,$0010,$4A05,$6700,$0226
            dc.w    $5149,$E98D,$3205,$E049,$0201,$000F,$67EC,$4DFA
            dc.w    $0006,$4EFA,$01D6,$220D,$660E,$2A51,$DBC0,$42A5
            dc.w    $42A5,$2B3C,$FFFF,$FFFF,$2B00,$2B11,$60CC,$323C
            dc.w    $F3EF,$0800,$0014,$6704,$323C,$F3FF,$3001,$720F
            dc.w    $C205,$6604,$5049,$E88D,$C03B,$101A,$2A68,$004C
            dc.w    $720F,$1A80,$E248,$51C9,$FFFA,$50ED,$0010,$721C
            dc.w    $6000,$0196,$FFFF,$FF3F,$7FBF,$FFFF,$3205,$4845
            dc.w    $3A01,$2C09,$97CB,$7600,$6032,$2203,$5381,$4C3C
            dc.w    $1001,0,$0006,$2A68,$0054,$4BF5,$1400,$220B
            dc.w    $7816,$E8A9,$383C,$0005,$2AC1,$E289,$51CC,$FFFA
            dc.w    $2A68,$0054,$4BED,$00A0,$1ABC,$00FF,$720F,$C205
            dc.w    $E88D,$4DFA,$0006,$4EFA,$0132,$D7C0,$4AA9,$0008
            dc.w    $6B06,$5089,$5283,$60B2,$722C,$260B,$2246,$6000
            dc.w    $0128,$1205,$E809,$4DFA,$0006,$4EFA,$010E,$2200
            dc.w    $70DF,$0C81,$0010,0,$6702,$70FF,$720F,$C205
            dc.w    $C03B,$1010,$2A68,$0034,$C12D,$0001,$721C,$6000
            dc.w    $00F8,$3FFF,$7FBF,$FF00,$7800,$7203,$BA81,$6604
            dc.w    $7800,$6020,$4841,$BA81,$6604,$7820,$6016,$4DFA
            dc.w    $0006,$4EFA,$0036,$4DFA,$0006,$4EFA,$002E,$700D
            dc.w    $E16C,$E0AC,$103B,$4050,$2A68,$0058,$DBFC,$0001
            dc.w    0,$1A80,$E408,$4BED,$2000,$1A80,$E408,$4BED
            dc.w    $2000,$1A80,$724C,$6000,$00A0,$2A4E,$7203,$4841
            dc.w    $323C,$000F,$E99D,$C205,$4DFA,$0006,$4EFA,$007C
            dc.w    $D880,$4841,$51C9,$FFE8,$4844,$E84C,$0C04,$0008
            dc.w    $6602,$5304,$4ED5,$0001,$0102
            ds.b    4
            dc.w    $1F13,$030A,$0900,$0608,$1F07,$0312,$0900,$0608
            dc.b    $1D,$04,$04,$19,$11,$00,$0E,$18,$17,$09,$05,$0F,$1B,$00,$16
            ds.b    9
            dc.w    $170B,$0B0C,$1400,$1A00,$170D,$0D15,$1700,$1700
            dc.w    $2205,$0281,$000F,0,$6614,$7015,$E0AB,$5343
            dc.w    $EB0B,$0003,$001F,$2A68,$006C,$C72D,$0001,$7234
            dc.w    $6000,$0010
.L27:
            moveq   #0,D0
            tst.w   D1
            beq.b   .L28
            move.l  D2,D0
            subq.w  #1,D1
            lsl.l   D1,D0
.L28:
            RTS6
            movea.l (A1),A5
            movea.l A5,A0
            adda.l  D3,A5
            suba.l  D1,A5
            movea.l A5,SP
.L29:
            moveq   #$F,D1
            and.b   D5,D1
            beq.b   .L30
            BSR6    .L27
            move.l  A0,(SP)+
            move.l  D0,(SP)+
            adda.l  D0,A0
.L30:
            lsr.l   #4,D5
            bne.b   .L29
            subq.l  #1,D5
            move.l  D5,(SP)+
.L31:
            clr.l   (SP)+
            move.w  SP,D0
            bne.b   .L31
            movea.l (A1),SP
            adda.l  #$8000,SP
            move.l  A5,-(SP)
            moveq   #0,D6
            jmp     (A2)
            ds.b    14

            EVEN
