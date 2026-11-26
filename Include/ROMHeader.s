; Shared header for the split PowerBook 170 ROM: included first by every piece.
; Holds the equate/macro includes, assembler options and ROM-wide macros.

            include "ROMTools/Globals.s"
            include "ROMTools/CommonConst.s"
            include "ROMTools/TrapMacros.s"
            include "ROMTools/Macros.s"
            include "ROMTools/Hardware/Powerbook170.s"

            OPT     mzy                             ; Suppressed index field is A0.W, like MPW Asm
            OPT     w1019                           ; Bit numbers above 7 on memory are intended
            OPT     mxy                             ; Decimal extended constants repeat the exponent, like MPW Asm
            OPT     mqy                             ; Keep instructions as written (no addq/moveq/addi rewrites)

; Placeholder Equates
theCRP      EQU     $0
theTC       EQU     $8
ElsieROMBase EQU     $A00000                        ; Elsie (Mac LC) ROM base, for ElsieTMVectors

            ; Trap dispatch table entries (see InitDispatcher)
            ; Unimplemented trap, dispatches to BadTrap
DispBad:    MACRO
            dc.b    $80
            ENDM

            ; Routine at an absolute ROM offset
DispAbs:    MACRO
            dc.b    $FF
            dc.l    \1-BaseOfROM
            ENDM

            ; Routine \1 within $FC bytes after the previous routine \2
DispNear:   MACRO
            dc.b    $80|((\1-\2)>>1)
            ENDM

            ; Routine \1 within +/-32K of the previous routine \2
DispFar:    MACRO
            dc.w    ((\1-\2)>>1)&$7FFF
            ENDM

            mc68030
            fpu68881
            OPT     w1008                           ; Disable warning on privileged instruction
