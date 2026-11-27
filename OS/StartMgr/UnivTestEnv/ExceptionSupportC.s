            include "Include/ROMHeader.s"

            EXPORT  InstallExceptionHandler,RemoveExceptionHandler

            IMPORT  ExceptionHandlerStub,GetCTEGlobals,InstallExceptionVector

            SECTION "ExceptionSupportC",CODE

InstallExceptionHandler:
            link.w  A6,#0
            movem.l D7/A3-A4,-(SP)
            movea.l (8,A6),A4
            move.l  ($18,A6),D7
            movea.l ($C,A6),A3
            move.w  #$4EB9,(A3)
            lea     (ExceptionHandlerStub.w,PC),A0
            move.l  A0,(2,A3)
            move.l  A4,(6,A3)
            move.l  ($10,A6),($A,A3)
            move.l  ($14,A6),($E,A3)
            move.w  D7,($1A,A3)
            move.l  D7,D0
            asl.l   #2,D0
            lea     ($94,A4),A0
            move.l  (0,A0,D0.l),($16,A3)
            move.l  D7,D0
            asl.l   #2,D0
            lea     ($94,A4),A0
            move.l  A3,(0,A0,D0.l)
            move.l  D7,-(SP)
            move.l  A3,-(SP)
            jsr     (InstallExceptionVector.w,PC)
            move.l  D0,($12,A3)
            movem.l (-$C,A6),D7/A3-A4
            unlk    A6
            rts
            ds.b    12
RemoveExceptionHandler:
            movem.l D7/A3-A4,-(SP)
            movea.l ($10,SP),A4
            movea.l ($14,SP),A3
            move.w  ($1A,A3),D7
            moveq   #0,D0
            move.w  D7,D0
            move.l  D0,-(SP)
            move.l  ($12,A3),-(SP)
            jsr     (InstallExceptionVector.w,PC)
            moveq   #0,D0
            move.w  D7,D0
            asl.l   #2,D0
            lea     ($94,A4),A0
            move.l  ($16,A3),(0,A0,D0.l)
            addq.l  #8,SP
            movem.l (SP)+,D7/A3-A4
            rts
            ds.b    10
GetExceptionInfoPtrTable:
            jsr     (GetCTEGlobals.w,PC)
            movea.l D0,A0
            lea     ($94,A0),A0
            move.l  A0,D0
            rts
            dc.w    0

            EVEN
