            include "Include/ROMHeader.s"

            EXPORT  BadDisk_L1,BaseOfROM,Critical,ROMVersion,StBoot

            IMPORT  CritErr,DispTable,ForeignOS,GOOFYDoEject,ResetEntry,RomRsrcHead
            IMPORT  StartBoot

            SECTION "Header",CODE[$40800000]

BaseOfROM:
            dc.l    $420DBFF3                       ; Checksum
StartPC:
            dc.l    ResetEntry-BaseOfROM
ROMVersion:
            dc.b    $6
            dc.b    $7C
StBoot:
            jmp     StartBoot(PC)
BadDisk:
            jmp     StartBoot(PC)
BadDisk_L1:
            dc.w    $15F1
PatchFlags:
            dc.b    0
            dc.b    0
            dc.l    ForeignOS-BaseOfROM
RomRsrc:
            dc.l    RomRsrcHead-BaseOfROM
Eject:
            jmp     GOOFYDoEject(PC)
DispOff:
            dc.l    DispTable-BaseOfROM
Critical:
            jmp     CritErr(PC)

            EVEN
