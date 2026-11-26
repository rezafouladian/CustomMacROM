            include "Include/ROMHeader.s"

            EXPORT  CLISTENER,DOIMAGEDATA,get_image

            IMPORT  BootListen,BootStorage,DDPCloseSocket,DDPOpenSocket,Glue_BlockMove_DRVR_50,Glue_DisposPtr_DRVR_50
            IMPORT  Glue_NewPtrSys_DRVR_50,memset,MPPOpen_piMAIN,myGetA5,myGetIcn,myGetMask
            IMPORT  mySetA5,NBPExtract,sub_40856368,sub_40856390,sub_408564EC,sub_408564FC
            IMPORT  sub_408565D0,sub_40856614

            SECTION "ATBoot_GetServer",CODE

setupGrafWorld:
            move.l  A3,-(SP)
            movea.l (8,SP),A3
            pea     ($CE,A3)
            jsr     (mySetA5.w,PC)
            pea     ($CA,A3)
            _InitGraf
            pea     ($D2,A3)
            _OpenPort
            addq.l  #4,SP
            movea.l (SP)+,A3
            rts
killGrafWorld:
            move.l  A3,-(SP)
            movea.l (8,SP),A3
            pea     ($D2,A3)
            _CloseCPort
            movea.l (SP)+,A3
            rts
centerRect:
            movem.l D6-D7/A3,-(SP)
            move.w  ($1A,SP),D6
            move.w  ($16,SP),D7
            movea.l ($10,SP),A3
            move.w  (4,A3),D0
            sub.w   (A3),D0
            ext.l   D0
            asr.l   #1,D0
            ext.l   D6
            sub.l   D6,D0
            add.w   D0,(A3)
            move.w  (6,A3),D0
            sub.w   (2,A3),D0
            ext.l   D0
            asr.l   #1,D0
            ext.l   D7
            sub.l   D7,D0
            add.w   D0,(2,A3)
            move.w  D6,D0
            add.w   (A3),D0
            add.w   D6,D0
            move.w  D0,(4,A3)
            move.w  D7,D0
            add.w   (2,A3),D0
            add.w   D7,D0
            move.w  D0,(6,A3)
            movem.l (SP)+,D6-D7/A3
            rts
show_Icon:
            link.w  A6,#-$24
            movem.l A3-A4,-(SP)
            movea.l ($C,A6),A4
            movea.l (8,A6),A3
            lea     (-8,A6),A0
            lea     ($E2,A3),A1
            move.l  (A1)+,(A0)+
            move.l  (A1)+,(A0)+
            moveq   #$10,D0
            move.l  D0,-(SP)
            move.l  D0,-(SP)
            pea     (-8,A6)
            jsr     centerRect
            pea     ($D2,A3)
            _SetPort
            move.l  A4,(-$24,A6)
            move.w  #4,(-$20,A6)
            pea     (-$1E,A6)
            moveq   #0,D0
            move.w  D0,-(SP)
            move.w  D0,-(SP)
            moveq   #$20,D1
            move.w  D1,-(SP)
            move.w  D1,-(SP)
            _SetRect
            lea     (myGetMask.w,PC),A0
            move.l  A0,(-$16,A6)
            move.w  #4,(-$12,A6)
            pea     (-$10,A6)
            moveq   #0,D0
            move.w  D0,-(SP)
            move.w  D0,-(SP)
            moveq   #$20,D1
            move.w  D1,-(SP)
            move.w  D1,-(SP)
            _SetRect
            tst.l   ($10,A6)
            lea     ($C,SP),SP
            beq.b   .L1
            pea     (-8,A6)
            pea     ($B2,A3)
            _FillRect
.L1:
            pea     (-$24,A6)
            pea     (-$16,A6)
            pea     ($D4,A3)
            pea     (-$1E,A6)
            pea     (-$10,A6)
            pea     (-8,A6)
            _CopyMask
            movem.l (-$2C,A6),A3-A4
            unlk    A6
            rts
showProgress:
            movem.l D7/A3-A4,-(SP)
            movea.l ($10,SP),A3
            moveq   #0,D7
            moveq   #3,D0
            cmp.w   ($13E,A3),D0
            ble.b   .L2
            tst.w   ($13E,A3)
            bne.b   .L1
            moveq   #1,D7
.L1:
            move.w  ($13E,A3),D0
            ext.l   D0
            move.l  D0,-(SP)
            jsr     (myGetIcn.w,PC)
            movea.l D0,A4
            addq.w  #1,($13E,A3)
            move.l  D7,-(SP)
            move.l  A4,-(SP)
            move.l  A3,-(SP)
            jsr     show_Icon
            lea     ($10,SP),SP
.L2:
            movem.l (SP)+,D7/A3-A4
            rts
send_wksURequestPacket:
            link.w  A6,#-$12
            movem.l A3-A4,-(SP)
            lea     (-$12,A6),A4
            movea.l (8,A6),A3
            subq.l  #4,SP
            _TickCount
            move.l  (SP)+,($42,A3)
            pea     ($2C,A3)
            move.l  A4,-(SP)
            pea     ($3E,A3)
            move.l  ($C,A6),-(SP)
            moveq   #$A,D0
            move.w  D0,-(SP)
            moveq   #$2A,D1
            move.w  D1,-(SP)
            jsr     (sub_408565D0.w,PC)
            subq.l  #2,SP
            move.l  A3,-(SP)
            moveq   #0,D0
            move.b  D0,-(SP)
            jsr     (sub_408564EC.w,PC)
            move.w  (SP)+,D0
            movem.l (-$1A,A6),A3-A4
            unlk    A6
            rts
do_lookup:
            link.w  A6,#0
            movem.l A3-A4,-(SP)
            movea.l ($14,A6),A4
            lea     ($38,A4),A3
            move.l  A4,-(SP)
            move.l  ($C,A6),-(SP)
            move.l  (8,A6),-(SP)
            pea     .L1
            jsr     (sub_40856614.w,PC)
            move.l  A4,($1E,A3)
            move.b  ($23,A6),($1C,A3)
            move.b  ($27,A6),($1D,A3)
            move.l  ($10,A6),($22,A3)
            move.w  #$DE,($26,A3)
            move.w  ($1A,A6),($28,A3)
            moveq   #0,D0
            move.l  D0,($C,A3)
            subq.l  #2,SP
            pea     ($38,A4)
            move.b  ($1F,A6),-(SP)
            jsr     (sub_408564FC.w,PC)
            move.w  (SP)+,D0
            movem.l (-8,A6),A3-A4
            unlk    A6
            rts
.L1:
            dc.w    $012A,0
make_wksURequestPacket:
            movem.l A3-A4,-(SP)
            movea.l ($C,SP),A4
            movea.l ($10,SP),A3
            move.b  #$A,($1C,A3)
            clr.b   ($1D,A3)
            lea     ($2C,A3),A0
            move.l  A0,($1E,A3)
            lea     ($3E,A3),A0
            movea.l A4,A1
            moveq   #9,D0
.L1:
            move.l  (A1)+,(A0)+
            dbra    D0,.L1
            move.w  (A1)+,(A0)+
            movem.l (SP)+,A3-A4
            rts
myNumToStr:
            movem.l D7/A3-A4,-(SP)
            move.w  ($12,SP),D7
            movea.l ($14,SP),A3
            lea     .L1,A4
            moveq   #$F,D0
            and.w   D7,D0
            ext.l   D0
            add.l   A4,D0
            movea.l D0,A0
            move.b  (A0),(1,A3)
            ext.l   D7
            move.l  D7,D0
            asr.l   #4,D0
            moveq   #$F,D1
            and.l   D0,D1
            add.l   A4,D1
            movea.l D1,A0
            move.b  (A0),(2,A3)
            ext.l   D7
            move.l  D7,D0
            asr.l   #8,D0
            moveq   #$F,D1
            and.l   D0,D1
            add.l   A4,D1
            movea.l D1,A0
            move.b  (A0),(3,A3)
            ext.l   D7
            moveq   #$C,D0
            move.l  D7,D1
            asr.l   D0,D1
            moveq   #$F,D0
            and.l   D1,D0
            add.l   A4,D0
            movea.l D0,A0
            move.b  (A0),(4,A3)
            move.b  #4,(A3)
            movem.l (SP)+,D7/A3-A4
            rts
.L1:
            dc.b    '0123456789ABCDEF'
            dc.w    0
find_server:
            link.w  A6,#-$23E
            movem.l D4-D7/A3-A4,-(SP)
            movea.l ($1C,A6),A3
            moveq   #0,D0
            movea.l D0,A4
            moveq   #1,D5
            move.w  #$FFFF,(-$16E,A6)
            move.b  #$FF,(-$16C,A6)
            move.b  #$FF,(-$16B,A6)
            move.l  A3,D1
            beq.w   .L6
            move.w  #$FFFF,(A3)
            pea     (-$100,A6)
            moveq   #0,D0
            move.w  ($16,A6),D0
            move.l  D0,-(SP)
            jsr     myNumToStr
            pea     (-$23A,A6)
            move.l  ($18,A6),-(SP)
            jsr     make_wksURequestPacket
            subq.l  #4,SP
            pea     ($DE).w
            jsr     (Glue_NewPtrSys_DRVR_50.w,PC)
            movea.l (SP)+,A4
            move.l  A4,D0
            lea     ($10,SP),SP
            beq.w   .L6
            moveq   #0,D0
            move.w  (A3),D0
            cmpi.l  #$FFFF,D0
            bne.b   .L2
            moveq   #0,D0
            move.b  ($F,A6),D0
            move.l  D0,-(SP)
            moveq   #0,D0
            move.b  ($B,A6),D0
            move.l  D0,-(SP)
            moveq   #0,D0
            move.l  D0,-(SP)
            moveq   #1,D1
            move.l  D1,-(SP)
            pea     (-$1D2,A6)
            move.l  A4,-(SP)
            pea     (-$100,A6)
            move.l  ($10,A6),-(SP)
            jsr     do_lookup
            tst.w   D0
            lea     ($20,SP),SP
            bne.w   .L6
            bra.b   .L2
.L1:
            move.l  (-$104,A6),-(SP)
            pea     (-$23A,A6)
            jsr     send_wksURequestPacket
            addq.l  #8,SP
.L2:
            moveq   #0,D0
            move.w  (A3),D0
            cmpi.l  #$FFFF,D0
            bne.b   .L3
            cmp.w   (-$170,A6),D5
            bgt.b   .L3
            subq.l  #2,SP
            move.l  A4,-(SP)
            move.w  (-$170,A6),-(SP)
            move.w  D5,-(SP)
            addq.w  #1,D5
            pea     (-$16A,A6)
            pea     (-$104,A6)
            jsr     (NBPExtract.w,PC)
            move.w  (SP)+,(-$19C,A6)
            beq.b   .L1
.L3:
            tst.w   (-$170,A6)
            ble.b   .L6
            subq.l  #4,SP
            _TickCount
            move.l  (SP)+,D6
            move.b  ($B,A6),D0
            lsl.b   #4,D0
            moveq   #0,D1
            move.b  D0,D1
            move.l  D1,D7
            move.l  D6,D4
            move.l  D7,D0
            lsl.l   #2,D0
            move.l  D0,(-$23E,A6)
            bra.b   .L5
.L4:
            subq.l  #4,SP
            _TickCount
            move.l  (SP)+,D0
            sub.l   D4,D0
            cmp.l   D0,D7
            bcc.b   .L5
            subq.l  #4,SP
            _TickCount
            move.l  (SP)+,D4
            move.l  (-$104,A6),-(SP)
            pea     (-$23A,A6)
            jsr     send_wksURequestPacket
            addq.l  #8,SP
.L5:
            subq.l  #4,SP
            _TickCount
            move.l  (SP)+,D0
            sub.l   D6,D0
            cmp.l   (-$23E,A6),D0
            bcc.b   .L6
            moveq   #0,D0
            move.w  (A3),D0
            cmpi.l  #$FFFF,D0
            beq.b   .L4
.L6:
            moveq   #0,D0
            move.w  (A3),D0
            cmpi.l  #$FFFF,D0
            beq.b   .L7
            move.l  ($26,A3),(-$16E,A6)
.L7:
            move.l  A4,D0
            beq.b   .L8
            move.l  A4,-(SP)
            jsr     (Glue_DisposPtr_DRVR_50.w,PC)
.L8:
            move.l  (-$16E,A6),D0
            movem.l (-$256,A6),D4-D7/A3-A4
            unlk    A6
            rts
CLISTENER:
            link.w  A6,#0
            move.l  A3,-(SP)
            movea.l ($C,A6),A3
            move.w  ($30,A3),D0
            cmp.w   (2,A3),D0
            bne.b   .L3
            tst.w   ($3A,A3)
            bne.b   .L3
            move.w  ($38,A3),(A3)
            move.l  (8,A6),($26,A3)
            subq.l  #4,SP
            _TickCount
            move.l  (SP)+,D0
            sub.l   ($32,A3),D0
            lsl.l   #2,D0
            move.w  D0,($1E,A3)
            moveq   #4,D0
            cmp.w   ($1E,A3),D0
            ble.b   .L1
            moveq   #4,D0
            bra.b   .L2
.L1:
            move.w  ($1E,A3),D0
            ext.l   D0
.L2:
            move.w  D0,($1E,A3)
.L3:
            movea.l (-4,A6),A3
            unlk    A6
            rts
DOIMAGEDATA:
            link.w  A6,#0
            movem.l D7/A3,-(SP)
            movea.l (8,A6),A3
            subq.l  #4,SP
            _TickCount
            move.l  (SP)+,D7
            tst.l   ($C,A6)
            bne.b   .L2
            tst.l   ($22,A3)
            beq.b   .L1
            moveq   #0,D0
            move.l  D0,($22,A3)
.L1:
            move.l  D7,($16,A3)
            addq.w  #1,($A,A3)
.L2:
            move.l  D7,($12,A3)
            movem.l (-8,A6),D7/A3
            unlk    A6
            rts
makeImageRequest:
            movem.l D5-D7/A3-A4,-(SP)
            movea.l ($1C,SP),A4
            movea.l ($18,SP),A3
            clr.w   D5
            move.b  #$A,($1C,A3)
            clr.b   ($1D,A3)
            lea     ($2C,A3),A0
            move.l  A0,($1E,A3)
            move.b  #3,($3E,A3)
            move.b  #1,($3F,A3)
            move.w  (A4),($40,A3)
            clr.b   ($42,A3)
            clr.b   ($43,A3)
            moveq   #0,D0
            move.w  (8,A4),D0
            divs.w  #8,D0
            move.w  D0,D6
            moveq   #0,D0
            move.w  (8,A4),D0
            move.l  D0,D5
            lsr.l   #3,D5
            beq.b   .L1
            addq.w  #1,D6
.L1:
            clr.w   D7
            bra.b   .L3
.L2:
            moveq   #0,D0
            move.w  D7,D0
            move.b  #$FF,($46,A3,D0.l)
            addq.w  #1,D7
.L3:
            cmp.w   D7,D6
            bhi.b   .L2
            tst.w   D5
            beq.b   .L4
            move.w  D6,D0
            subq.w  #1,D0
            moveq   #0,D1
            move.w  D0,D1
            move.b  #$FF,($46,A3,D1.l)
.L4:
            movem.l (SP)+,D5-D7/A3-A4
            rts
makeBitmap:
            movem.l D6-D7/A3-A4,-(SP)
            move.w  ($1E,SP),D6
            movea.l ($18,SP),A4
            movea.l ($14,SP),A3
            ext.l   D6
            move.l  D6,D0
            divs.w  #8,D0
            move.w  D0,D7
            bra.b   .L2
.L1:
            move.b  (A3)+,D0
            not.b   D0
            move.b  D0,(A4)+
.L2:
            move.w  D7,D0
            subq.w  #1,D7
            tst.w   D0
            bne.b   .L1
            ext.l   D6
            move.l  D6,D0
            asr.l   #3,D0
            beq.b   .L3
            move.b  (A3),D0
            not.b   D0
            move.b  D0,(A4)
.L3:
            movem.l (SP)+,D6-D7/A3-A4
            rts
sendImageRequest:
            link.w  A6,#-$12
            movem.l A3-A4,-(SP)
            movea.l ($10,A6),A4
            movea.l (8,A6),A3
            pea     ($2C,A3)
            pea     (-$12,A6)
            pea     ($3E,A3)
            move.l  ($C,A6),-(SP)
            moveq   #$A,D0
            move.w  D0,-(SP)
            moveq   #0,D1
            move.w  (8,A4),D1
            move.l  D1,D0
            moveq   #8,D1
            jsr     (sub_40856390.w,PC)
            addq.l  #8,D0
            moveq   #0,D1
            move.w  (8,A4),D1
            lsr.l   #3,D1
            beq.b   .L1
            moveq   #1,D1
            bra.b   .L2
.L1:
            moveq   #0,D1
.L2:
            add.l   D0,D1
            move.w  D1,-(SP)
            jsr     (sub_408565D0.w,PC)
            subq.l  #2,SP
            move.l  A3,-(SP)
            moveq   #0,D0
            move.b  D0,-(SP)
            jsr     (sub_408564EC.w,PC)
            move.w  (SP)+,D0
            movem.l (-$1A,A6),A3-A4
            unlk    A6
            rts
get_image:
            link.w  A6,#-$80C
            movem.l D4-D7/A3-A4,-(SP)
            movea.l ($10,A6),A4
            move.l  (8,A6),D5
            lea     (-$344,A6),A3
            clr.w   (-$592,A6)
            moveq   #0,D4
            pea     ($140).w
            moveq   #0,D0
            move.l  D0,-(SP)
            pea     (-$140,A6)
            jsr     (memset.w,PC)
            jsr     (myGetA5.w,PC)
            move.l  D0,(-$144,A6)
            pea     (-$140,A6)
            jsr     setupGrafWorld
            move.w  #$FFFF,(-$80C,A6)
            move.w  #1,(-$80A,A6)
            move.l  A3,(-$808,A6)
            clr.w   (-$804,A6)
            clr.w   (-$802,A6)
            moveq   #0,D0
            move.l  D0,(-$800,A6)
            clr.w   (-$7FC,A6)
            move.l  D0,(-$7FA,A6)
            move.l  D0,(-$7F6,A6)
            move.l  D5,D1
            asr.l   #3,D1
            move.l  D1,(-$7F2,A6)
            move.w  #4,(-$7EE,A6)
            move.w  #1,(-$7EC,A6)
            move.l  D0,(-$7EA,A6)
            moveq   #-1,D1
            move.l  D1,(-$7E6,A6)
            pea     (-$80C,A6)
            jsr     (BootStorage.w,PC)
            subq.l  #2,SP
            jsr     (MPPOpen_piMAIN.w,PC)
            move.w  (SP)+,(-$594,A6)
            lea     ($14,SP),SP
            beq.b   .L1
            move.w  (-$594,A6),D0
            ext.l   D0
            bra.w   .L23
.L1:
            tst.b   ($17,A6)
            beq.b   .L2
            moveq   #$F,D0
            and.b   ($17,A6),D0
            moveq   #0,D1
            move.b  D0,D1
            asl.w   #2,D1
            move.b  D1,(-$58C,A6)
            move.w  #$F0,D0
            and.b   ($17,A6),D0
            moveq   #0,D1
            move.b  D0,D1
            lsr.l   #4,D1
            move.b  D1,(-$58B,A6)
            bra.b   .L3
.L2:
            move.b  #4,(-$58C,A6)
            move.b  #1,(-$58B,A6)
.L3:
            move.w  #$A,(-$592,A6)
            subq.l  #2,SP
            pea     (-$592,A6)
            pea     (BootListen.w,PC)
            jsr     (DDPOpenSocket.w,PC)
            move.w  (SP)+,(-$594,A6)
            beq.b   .L4
            move.w  (-$594,A6),D0
            ext.l   D0
            bra.w   .L23
.L4:
            move.b  #1,(A4)
            move.b  #1,(1,A4)
            moveq   #0,D0
            move.l  D0,(4,A4)
            move.w  #$FFFF,(-$590,A6)
            move.b  #$FF,(-$58E,A6)
            move.b  #$FF,(-$58D,A6)
            pea     (-$80C,A6)
            move.l  A4,-(SP)
            moveq   #0,D1
            move.w  ($E,A6),D1
            move.l  D1,-(SP)
            pea     BootServerStr
            moveq   #0,D1
            move.b  (-$58B,A6),D1
            move.l  D1,-(SP)
            moveq   #0,D1
            move.b  (-$58C,A6),D1
            move.l  D1,-(SP)
            jsr     find_server
            move.l  D0,(-$590,A6)
            moveq   #0,D0
            move.w  (-$80C,A6),D0
            cmpi.l  #$FFFF,D0
            lea     ($18,SP),SP
            beq.w   .L15
            moveq   #-1,D0
            cmp.l   (-$590,A6),D0
            beq.w   .L15
            move.w  (-$7D6,A6),(-$7FC,A6)
            move.l  (-$7D0,A6),D0
            subq.l  #1,D0
            move.w  D0,(-$804,A6)
            moveq   #0,D0
            move.w  (-$804,A6),D0
            moveq   #8,D1
            jsr     (sub_40856390.w,PC)
            cmpi.l  #$1FF,D0
            bge.b   .L5
            move.w  (-$7FC,A6),D0
            mulu.w  (-$804,A6),D0
            move.l  D0,-(SP)
            move.l  BufPtr,D0
            moveq   #4,D1
            jsr     (sub_40856390.w,PC)
            move.l  D0,D1
            move.l  (SP)+,D0
            cmp.l   D0,D1
            bcc.b   .L6
.L5:
            moveq   #-2,D4
            bra.w   .L16
.L6:
            subq.l  #4,SP
            moveq   #0,D0
            move.w  (-$7D6,A6),D0
            move.l  D0,D1
            move.l  (-$7D0,A6),D0
            jsr     (sub_40856368.w,PC)
            move.l  D0,-(SP)
            jsr     (Glue_NewPtrSys_DRVR_50.w,PC)
            move.l  (SP)+,(-$800,A6)
            bne.b   .L7
            moveq   #-2,D4
            bra.w   .L16
.L7:
            pea     (-$80C,A6)
            pea     (-$58A,A6)
            jsr     makeImageRequest
            clr.w   D6
            addq.l  #8,SP
            bra.b   .L9
.L8:
            clr.b   (0,A3,D6.w)
            addq.w  #1,D6
.L9:
            ext.l   D6
            moveq   #0,D0
            move.w  (-$804,A6),D0
            moveq   #8,D1
            jsr     (sub_40856390.w,PC)
            addq.l  #1,D0
            cmp.l   D6,D0
            bgt.b   .L8
            bra.w   .L14
.L10:
            subq.l  #4,SP
            _TickCount
            move.l  (SP)+,D7
            moveq   #0,D0
            move.w  (-$802,A6),D0
            move.l  D0,D1
            add.l   D0,D0
            add.l   D1,D0
            moveq   #0,D1
            move.w  (-$804,A6),D1
            jsr     (sub_40856390.w,PC)
            move.w  (-2,A6),D1
            ext.l   D1
            cmp.l   D0,D1
            bgt.b   .L11
            pea     (-$140,A6)
            jsr     showProgress
            addq.l  #4,SP
.L11:
            move.l  D7,D0
            sub.l   (-$7FA,A6),D0
            cmp.l   (-$7F2,A6),D0
            bgt.b   .L12
            move.l  D7,D0
            sub.l   (-$7F6,A6),D0
            move.l  (-$7F2,A6),D2
            move.l  D2,D1
            mulu.w  #$32,D2
            swap    D1
            mulu.w  #$32,D1
            swap    D1
            clr.w   D1
            add.l   D1,D2
            cmp.l   D0,D2
            bge.b   .L14
.L12:
            tst.l   (-$7EA,A6)
            beq.b   .L13
            move.w  (-$7EC,A6),D0
            add.w   D0,(-$7EC,A6)
            move.w  (-$7EE,A6),D0
            muls.w  (-$7EC,A6),D0
            move.l  D0,(-$7F2,A6)
.L13:
            moveq   #0,D0
            move.w  (-$804,A6),D0
            move.l  D0,-(SP)
            pea     (-$544,A6)
            move.l  A3,-(SP)
            jsr     makeBitmap
            move.l  D7,(-$7EA,A6)
            move.l  D7,(-$7F6,A6)
            move.l  D7,(-$7FA,A6)
            pea     (-$80C,A6)
            move.l  (-$590,A6),-(SP)
            pea     (-$58A,A6)
            jsr     sendImageRequest
            lea     ($18,SP),SP
.L14:
            move.w  (-$802,A6),D0
            cmp.w   (-$804,A6),D0
            bhi.b   .L16
            cmp.l   (-$7F2,A6),D5
            bgt.w   .L10
            bra.b   .L16
.L15:
            moveq   #-3,D4
.L16:
            pea     (-$140,A6)
            jsr     killGrafWorld
            move.l  (-$144,A6),-(SP)
            jsr     (mySetA5.w,PC)
            tst.w   (-$592,A6)
            addq.l  #8,SP
            beq.b   .L17
            subq.l  #2,SP
            move.w  (-$592,A6),-(SP)
            jsr     (DDPCloseSocket.w,PC)
            move.w  (SP)+,(-$594,A6)
.L17:
            tst.l   (-$800,A6)
            beq.b   .L18
            tst.l   D4
            beq.b   .L18
            move.l  (-$800,A6),-(SP)
            jsr     (Glue_DisposPtr_DRVR_50.w,PC)
            bra.b   .L19
.L18:
            movea.l ($18,A6),A0
            move.l  (-$800,A6),(A0)
.L19:
            tst.l   D4
            beq.b   .L20
            move.l  D4,D0
            bra.b   .L23
.L20:
            move.w  (-$802,A6),D0
            cmp.w   (-$804,A6),D0
            bhi.b   .L21
            moveq   #-4,D0
            bra.b   .L23
.L21:
            moveq   #-1,D0
            cmp.l   (-$590,A6),D0
            bne.b   .L22
            moveq   #-3,D0
            bra.b   .L23
.L22:
            movea.l ($1C,A6),A0
            move.l  (-$590,A6),(A0)
            pea     (-$7DE,A6)
            move.l  ($20,A6),-(SP)
            pea     ($24A).w
            jsr     (Glue_BlockMove_DRVR_50.w,PC)
            move.l  D4,D0
.L23:
            movem.l (-$824,A6),D4-D7/A3-A4
            unlk    A6
            rts
BootServerStr:
            dc.b    10,'BootServer',0

            EVEN
