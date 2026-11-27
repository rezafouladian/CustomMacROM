            include "Include/ROMHeader.s"

            EXPORT  __NMINSTALL,__NMREMOVE

            IMPORT  _NMInstall_,_NMRemove_

            SECTION "NotificationMgr",CODE

__NMINSTALL:
            move.l  A0,-(SP)
            bsr.w   _NMInstall_
            addq.l  #4,SP
            rts
            ds.b    6
__NMREMOVE:
            move.l  A0,-(SP)
            bsr.w   _NMRemove_
            addq.l  #4,SP
            rts
            ds.b    6

            EVEN
