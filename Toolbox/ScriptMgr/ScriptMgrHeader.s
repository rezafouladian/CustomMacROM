            include "Include/ROMHeader.s"

            EXPORT  CODEENTRY,PATCHSTART

            SECTION "ScriptMgrHeader",CODE

CODEENTRY:
VERSIONADDRESS:
            dc.w    $0215
PATCHSTART:
            ds.b    14

            EVEN
