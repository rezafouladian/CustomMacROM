            include "Include/ROMHeader.s"

            EXPORT  ExceptionHandlerStub,GetCTEGlobals,InstallExceptionVector,FakeExceptionCall,GetInterruptLevel,SetInterruptLevel

            SECTION "ExceptionSupport",CODE

SetInterruptLevel:
            jsr     GetInterruptLevel
            move.l  (4,SP),D1
            lsl.w   #8,D1
            move    SR,D2
            andi.w  #$F8FF,D2
            or.w    D1,D2
            move    D2,SR
            rts
            ds.b    10
GetInterruptLevel:
            move    SR,D0
            lsr.w   #8,D0
            andi.w  #7,D0
            rts
            ds.b    6
InstallExceptionVector:
            move.l  (8,SP),D0
            jsr     FindVectorEntry
            move.l  (A0),D0
            move.l  (4,SP),(A0)
            rts
ExceptionHandlerStub:
            movem.l D0-D3/A0-A1,-(SP)
            movea.l ($18,SP),A1
            move.w  ($22,SP),D3
            rol.w   #4,D3
            andi.l  #$F,D3
            move.l  (8,A1),-(SP)
            pea     ($20,SP)
            move.l  D3,-(SP)
            move.l  (A1),-(SP)
            movea.l (4,A1),A0
            jsr     (A0)
            lea     ($10,SP),SP
            movem.l (SP)+,D0-D3/A0-A1
            addq.l  #4,SP
            rte
            ds.b    14
FakeExceptionCall:
            move.l  (4,SP),D0
            jsr     FindVectorEntry
            movea.l (A0),A0
            move.l  (4,SP),D1
            asl.w   #2,D1
            move.w  D1,-(SP)
            pea     .L1
            move    SR,-(SP)
            jmp     (A0)
.L1:
            dc.w    $4E75
            ds.b    4
FindVectorEntry:
            movec   VBR,A0
CalcVectorEntry:
            lsl.w   #2,D0
            lea     (0,A0,D0.w),A0
            rts
            ds.b    4
GetCTEGlobals:
            move.l  ($16,A5),D0
            rts
            ds.b    10

            EVEN
