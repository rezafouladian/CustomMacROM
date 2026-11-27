.L2:
            movem.l D2-D5,-(SP)
            link.w  A6,#0
            movea.l ($20,A6),A0
            move.l  (A0),D5
            movea.l ($18,A6),A0
            movea.l ($1C,A6),A1
            move.l  (A1)+,D4
            addq.w  #1,A0
            moveq   #-$50,D2
            moveq   #0,D1
            move.b  (A1)+,D1
            beq.b   ItsAPass
            btst    #$18,D4
            beq.b   signStuff
            move.b  #$2D,(A0)+
            bra.b   d2inc
signStuff:
            btst    #24,D5
            bne.b   HeyItsFxd
            move.b  #$20,(A0)+
d2inc:
            addq.w  #1,D2
HeyItsFxd:
            move.b  (A1),D0
            cmpi.b  #$3F,D0
ItsAPass:
            beq.w   ErrXit
            ori.b   #$20,D0
            cmpi.b  #$69,D0
            beq.w   INFfound
            cmpi.b  #$6E,D0
            bne.b   ItsANumber
            move.b  #$4E,(A0)+
            move.b  #$41,(A0)+
            move.b  #$4E,(A0)+
            move.b  #$28,(A0)+
            move.b  #$29,(3,A0)
            addq.w  #5,D2
            moveq   #0,D3
            cmpi.b  #5,D1
            ble.b   lngthOK
            moveq   #5,D1
lngthOK:
            bsr.b   Hex2Bin
            move.l  D3,D0
            bsr.b   Hex2Bin
            asl.b   #4,D3
            or.l    D0,D3
FinNaN:
            moveq   #4,D0
            bra.b   FromNaN
Hex2Bin:
            subq.w  #1,D1
            ble.b   FinNaN
            move.b  (0,A1,D1.w),D3
            cmpi.b  #$39,D3
            ble.b   DecmlFnd
            subq.b  #7,D3
DecmlFnd:
            andi.b  #15,D3
            rts
ItsANumber:
            cmpi.b  #$30,(A1)
            bne.b   NotAZero
            moveq   #1,D1
            moveq   #0,D4
NotAZero:
            btst    #$18,D5
            bne.w   ItsFixed
            tst.w   D5
            bgt.b   DigitsOK
            moveq   #1,D5
DigitsOK:
            moveq   #1,D0
            bsr.b   AddDigits
            move.w  D1,D3
            ext.l   D3
            subq.l  #1,D3
            bgt.b   NeedPoint
            cmpi.w  #1,D5
            ble.b   NoPoint
NeedPoint:
            bsr.b   AddPoint
            move.w  D3,D0
            bsr.b   AddDigits
            move.w  D5,D0
            sub.w   D1,D0
            bsr.b   AddZeros
NoPoint:
            addq.w  #2,D2
            bgt.b   ErrXit
            move.b  #$65,(A0)+
            ext.l   D4
            add.l   D4,D3
            blt.b   NegExp
            move.b  #$2B,(A0)+
            bra.b   GetExpDigs
NegExp:
            move.b  #$2D,(A0)+
            neg.l   D3
GetExpDigs:
            moveq   #0,D0
FromNaN:
            lea     tens,A1
NextCmp:
            addq.w  #2,D0
            cmp.w   (-2,A1,D0.w),D3
            bcs.b   GetInLoop
            cmpi.b  #8,D0
            blt.b   NextCmp
NextDig:
            divu.w  (-2,A1,D0.w),D3
LastDig:
            addq.w  #1,D2
            bgt.b   ErrXit
            addi.w  #$30,D3
            move.b  D3,(A0)+
            swap    D3
            ext.l   D3
GetInLoop:
            subq.w  #2,D0
            bgt.b   NextDig
            beq.b   LastDig
            bra.b   SetLength
AddDigits:
            ble.b   EndDigits
            add.w   D0,D2
            bgt.b   ErrXit
loopd:
            move.b  (A1)+,(A0)+
            subq.w  #1,D0
            bgt.b   loopd
EndDigits:
            rts
AddPoint:
            addq.w  #1,D2
            bgt.b   ErrXit
            move.b  #$2E,(A0)+
            rts
loopz:
            addq.w  #1,D2
            bgt.b   ErrXit
            move.b  #$30,(A0)+
AddZeros:
            subq.w  #1,D0
            bge.b   loopz
            rts
ErrXit:
            movea.l ($18,A6),A0
            move.w  #$13F,(A0)
            bra.b   done
ItsFixed:
            move.w  D1,D3
            add.w   D4,D3
            ble.b   AllAfter
            tst.w   D4
            bge.b   AllBefore
            move.w  D3,D0
            bsr.b   AddDigits
            bsr.b   AddPoint
            moveq   #0,D0
            sub.w   D4,D0
            bra.b   FromMid
AllBefore:
            move.w  D1,D0
            bsr.b   AddDigits
            move.w  D4,D0
            bsr.b   AddZeros
            move.w  D5,D0
            ble.b   SetLength
            bsr.b   AddPoint
            bsr.b   AddZeros
            bra.b   SetLength
AllAfter:
            moveq   #1,D0
            bsr.b   AddZeros
            bsr.b   AddPoint
            moveq   #0,D0
            sub.w   D3,D0
            bsr.b   AddZeros
            move.w  D1,D0
FromMid:
            bsr.b   AddDigits
            move.w  D4,D0
            add.w   D5,D0
            bsr.b   AddZeros
SetLength:
            movea.l ($18,A6),A0
            addi.w  #$50,D2
            move.b  D2,(A0)
done:
            unlk    A6
            movem.l (SP)+,D2-D5/A0
            lea     ($C,SP),SP
            jmp     (A0)
INFfound:
            move.b  #$49,(A0)+
            move.b  #$4E,(A0)+
            move.b  #$46,(A0)
            addq.w  #3,D2
            bra.b   SetLength
tens:
            dc.w    $000A,$0064,$03E8,$2710
            ds.b    10
