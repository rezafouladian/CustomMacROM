            include "Include/ROMHeader.s"

            EXPORT  InstallFPSP

            SECTION "FPEmulation",CODE

InstallFPSP:
            movec   VBR,A0
            move.l  ($2C,A0),($1FC8).w
            lea     fline,A1
            move.l  A1,($2C,A0)
            lea     bsun,A1
            move.l  A1,($C0,A0)
            lea     unfl,A1
            move.l  A1,($CC,A0)
            lea     operr,A1
            move.l  A1,($D0,A0)
            lea     ovfl,A1
            move.l  A1,($D4,A0)
            lea     snan,A1
            move.l  A1,($D8,A0)
            lea     unsupp,A1
            move.l  A1,($DC,A0)
            rts

            include "OS/FPUEmulation/FPSPMain.s"   ; main FPSP entry/utility
            include "OS/FPUEmulation/XBSUN.s"      ; BSUN exception
            include "OS/FPUEmulation/XOpErr.s"     ; operand error exception
            include "OS/FPUEmulation/XOvfl.s"      ; overflow exception
            include "OS/FPUEmulation/XSNAN.s"      ; signalling NAN exception
            include "OS/FPUEmulation/XUnfl.s"      ; underflow exception
            include "OS/FPUEmulation/XFLine.s"     ; F-line exception
            include "OS/FPUEmulation/XUnSupp.s"    ; unsupported data type exception
            include "OS/FPUEmulation/XUnImp.s"     ; unimplemented instruction exception
            include "OS/FPUEmulation/BugFix.s"     ; D43B hardware bug fix
            include "OS/FPUEmulation/GenExcept.s"  ; exception exit
            include "OS/FPUEmulation/GetOp.s"      ; operand fetch
            include "OS/FPUEmulation/DecBin.s"     ; decimal to binary
            include "OS/FPUEmulation/XStore.s"     ; store results
            include "OS/FPUEmulation/ResFunc.s"    ; result functions
            include "OS/FPUEmulation/Round.s"      ; rounding
            include "OS/FPUEmulation/BinDec.s"     ; binary to decimal
            include "OS/FPUEmulation/Util.s"       ; utilities
            include "OS/FPUEmulation/KerneLex.s"   ; kernel exceptions
            include "OS/FPUEmulation/DoFunc.s"     ; function dispatch
            include "OS/FPUEmulation/GetEM.s"      ; getexp/getman
            include "OS/FPUEmulation/Int.s"        ; fint/fintrz
            include "OS/FPUEmulation/MoveCR.s"     ; fmovecr
            include "OS/FPUEmulation/RemMod.s"     ; fmod/frem
            include "OS/FPUEmulation/Scale.s"      ; fscale
            include "OS/FPUEmulation/Hyperbolic.s" ; hyperbolic functions
            include "OS/FPUEmulation/Trig.s"       ; trigonometric functions
            include "OS/FPUEmulation/Power.s"      ; exponential functions
            include "OS/FPUEmulation/InvTrig.s"    ; inverse trigonometric functions
            include "OS/FPUEmulation/Log.s"        ; logarithm functions
            include "OS/FPUEmulation/Constants.s"  ; constants

            EVEN
