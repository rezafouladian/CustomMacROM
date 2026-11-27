            include "Include/ROMHeader.s"

            SECTION "CopyrightFill",CODE

            REPT    152
            dc.b    ' Copyright Apple'
            dc.b    ' Computer, Inc. '
            dc.b    '1989-1990][',$11,'Tue,'
            dc.b    ' Jul 18, 1989]<<'
            dc.b    'HJRBGMSHJMAAGCSL'
            dc.b    'RWHBBMGGDCCHDAFD'
            dc.b    'JWGMRSWCRLESRCSM'
            dc.b    'BPKEBALJWKDMLPAT'
            dc.b    'WTOSGSG DEVAJMP>'
            dc.b    '>[(c)'
            ENDR
            dc.b    ' Copyright Apple Computer, Inc. 1989-1990]['
            dc.b    17,'Tue, Jul 18, 1989'
            dc.b    ']<<HJRBGMSHJMAAGCSLRWHBBMGGDCCHDAFDJWGMRSWCRLESRCSMBPKEBALJ'

            EVEN
