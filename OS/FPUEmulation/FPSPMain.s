.L1:
            dc.w    $F27F,0
sub_4088D248:
            subq.l  #1,D0
.L1:
            move.b  (A0)+,(A1)+
            dbra    D0,.L1
            rts
