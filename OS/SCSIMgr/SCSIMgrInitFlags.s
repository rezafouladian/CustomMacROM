            include "Include/ROMHeader.s"

            EXPORT  SCSISetFlags

            IMPORT  SCSISETFLAGSPATCH

            SECTION "SCSIMgrInitFlags",CODE

SCSISetFlags:
            movem.l D1/A0,-(SP)
            moveq   #0,D0
            btst    #VIA2Exists-8,(AddrMapFlags+2).w ; TestFor VIA2Exists
            beq.b   .L1
            bset    #sVIA2Exists,D0
.L1:
            btst    #RBVExists-8,(AddrMapFlags+2).w ; TestFor RBVExists
            beq.b   .L2
            bset    #sRBVExists,D0
.L2:
            btst    #SCSIDMAExists-8,(AddrMapFlags+2).w ; TestFor SCSIDMAExists
            beq.b   .L3
            bset    #sSCSIDMAExists,D0
.L3:
            btst    #OSSExists-16,(AddrMapFlags+1).w ; TestFor OSSExists
            beq.b   .L4
            bset    #sOSSExists,D0
.L4:
            bsr.l   SCSISETFLAGSPATCH
            nop
            nop
            movem.l (SP)+,D1/A0
            rts
            dc.w    $6040,$0808,$0808,$4104,$1812

            EVEN
