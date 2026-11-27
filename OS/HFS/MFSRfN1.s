sub_40811A30:
            move.w  ($18,A2),D0
            move.w  ($16,A2),D3
            add.w   D3,D0
            move.w  D0,($344).w
            bra.b   sub_40811A50
sub_40811A40:
            move.w  FileVars,D3
            addq.w  #1,D3
            cmp.w   ($344).w,D3
            bcs.b   sub_40811A50
            moveq   #-$21,D0
            rts
sub_40811A50:
            move.w  D3,FileVars
            bsr.w   ReadBlock_TFSRFN1
            movea.l ($380).w,A1
            bra.b   MFSMapRead.L2
sub_40811A5E:
            bsr.w   ReadBlock_TFSRFN1
            bra.b   MFSMapRead.L1
MFSMapRead:
            bsr.w   ReadBlock_TFSRFN1
            moveq   #4,D1
.L1:
            movea.l ($37C).w,A1
.L2:
            moveq   #0,D2
            move.w  D3,D2
            move.w  ($4E,A2),D0
            rts
