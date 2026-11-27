            include "Include/ROMHeader.s"

            EXPORT  RomRsrcHead

            IMPORT  BaseOfROM,RsrcEntryCURS_1

            SECTION "RomResources",CODE

RomRsrcHead:
            dc.l    RsrcEntryCURS_1-BaseOfROM       ; Offset to first resource entry
            dc.b    $0A,$08                         ; Max valid index, combo field size
            dc.w    $0001,$000C                     ; Combo version, header size
            ds.b    5094

            EVEN
