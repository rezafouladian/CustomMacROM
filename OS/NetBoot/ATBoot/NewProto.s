            include "Include/ROMHeader.s"

            EXPORT  BootListen,BootStorage

            IMPORT  CLISTENER,DOIMAGEDATA

            SECTION "ATBoot_NewProto",CODE

BootStorage:
            movea.l (SP)+,A0
            move.l  (SP)+,($B50).w
            jmp     (A0)
BootListen:
            movem.l D4-D7,-(SP)
            cmpi.b  #$A,(-1,A3)
            bne.b   .L4
            cmpi.w  #6,D1
            bmi.b   .L4
            movea.l ($B50).w,A5
            cmpi.b  #1,(3,A2)
            bne.b   .L1
            move.b  (2,A2),D2
            swap    D2
            move.w  ($1A,A2),D2
            bra.b   .L2
.L1:
            move.b  (-4,A3),D2
            swap    D2
            move.w  (-7,A3),D2
.L2:
            swap    D2
            lsl.w   #8,D2
            move.b  (-2,A3),D2
            moveq   #6,D3
            suba.l  D3,SP
            movea.l SP,A3
            jsr     (A4)
            move.w  (SP)+,D0
            move.l  (SP)+,D5
            swap    D5
            tst.w   D3
            bne.w   .L7
            move.b  D0,D3
            cmpi.b  #1,D3
            bgt.b   .L4
            lsr.w   #8,D0
            cmpi.b  #4,D0
            bne.b   .L6
            cmp.l   ($26,A5),D2
            bne.b   .L4
.L3:
            cmp.w   (A5),D5
            bne.b   .L4
            swap    D5
            cmp.w   (8,A5),D5
            bgt.b   .L4
            movea.l (4,A5),A3
            move.l  A3,D6
            move.w  D5,D0
            bsr.w   CheckBitmap
            beq.b   .L5
            moveq   #-1,D0
            move.l  A5,D7
            jsr     GoListener
.L4:
            movem.l (SP)+,D4-D7
            moveq   #0,D3
            jmp     (2,A4)
.L5:
            move.l  ($C,A5),D0
            beq.b   .L4
            movea.l D0,A3
            move.w  D5,D0
            bsr.w   getImageBuffer
            move.w  ($10,A5),D3
            move.l  A5,D7
            jsr     (2,A4)
            bne.b   .L7
            tst.w   D3
            bgt.b   .L7
            movea.l D6,A0
            move.w  D5,D0
            jsr     SetBitmap
            moveq   #0,D0
            jsr     GoListener
            bra.b   .L7
.L6:
            cmpi.b  #7,D0
            beq.b   .L7
            cmpi.w  #$FFFF,(A5)
            bne.b   .L4
            cmpi.b  #2,D0
            bne.b   .L4
            lea     ($2E,A5),A3
            move.b  D0,(A3)+
            move.b  D3,(A3)+
            swap    D5
            move.l  D5,(A3)+
            move.l  #$24A,D3
            move.l  A5,D7
            jsr     (2,A4)
            bne.b   .L7
            move.l  D7,-(SP)
            move.l  D2,-(SP)
            jsr     (CLISTENER.w,PC)
            lea     (8,SP),SP
.L7:
            movem.l (SP)+,D4-D7
            rts
GoListener:
            move.l  D0,-(SP)
            move.l  D7,-(SP)
            jsr     (DOIMAGEDATA.w,PC)
            lea     (8,SP),SP
            rts
CheckBitmap:
            movem.l D1,-(SP)
            move.w  D0,D1
            lsr.w   #3,D0
            btst    D1,(0,A3,D0.w)
            movem.l (SP)+,D1
            rts
SetBitmap:
            move.w  D0,D1
            lsr.w   #3,D0
            bset    D1,(0,A0,D0.w)
            rts
getImageBuffer:
            move.l  D0,-(SP)
            mulu.w  ($10,A5),D0
            adda.l  D0,A3
            move.l  (SP)+,D0
            rts

            EVEN
