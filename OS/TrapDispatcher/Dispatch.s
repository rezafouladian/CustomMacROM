            include "Include/ROMHeader.s"

            EXPORT  BadTrap,CacheFlush,EMT1010,GetTrapAddress,InitDispatcher,SetTrapAddress
            EXPORT  vCacheFlush

            IMPORT  CACHEVECTORPATCH,DISPATCHPATCH,SysErr1

            SECTION "Dispatch",CODE

EMT1010:
Dispatcher:
            move.l  A2,-(SP)
            move.l  D2,-(SP)
            movea.l ($A,SP),A2
            move.w  (A2)+,D2
            cmpi.w  #$A800,D2
            bcs.b   .L2
            subi.w  #$AC00,D2
            bcc.b   .L1
            move.l  ($1E00.w,D2.w*4),(8,SP)
            move.l  A2,($C,SP)
            move.l  (SP)+,D2
            movea.l (SP)+,A2
            rts
            ds.b    8
.L1:
            move.l  ($E00.w,D2.w*4),(8,SP)
            move.l  (SP)+,D2
            movea.l (SP)+,A2
            rtd     #4
.L2:
            move.l  D1,-(SP)
            move.l  A1,-(SP)
            move.w  D2,D1
            move.l  A2,($14,SP)
            andi.w  #$100,D2
            bne.b   .L3
            move.b  D1,D2
            move.l  A0,-(SP)
            jsr     ([DispatchTab.w,D2.w*4])
            movea.l (SP)+,A0
            movea.l (SP)+,A1
            move.l  (SP)+,D1
            move.l  (SP)+,D2
            movea.l (SP)+,A2
            tst.w   D0
            addq.w  #4,SP
            rts
            ds.b    6
.L3:
            move.b  D1,D2
            jsr     ([D2.w*4])
            movea.l (SP)+,A1
            move.l  (SP)+,D1
            move.l  (SP)+,D2
            movea.l (SP)+,A2
            tst.w   D0
            addq.w  #4,SP
            rts
sub_40809A34:
            lsl.w   #6,D1
            bpl.b   .L2
            bcc.b   .L3
.L1:
            andi.w  #$3FF,D0
            lea     ($E00.w,D0.w*4),A1
            rts
.L2:
            andi.w  #$1FF,D0
            moveq   #-$57,D1
            add.w   D0,D1
            bgt.b   .L1
            beq.b   .L3
            addq.w  #8,D1
            ble.b   .L3
            subq.w  #5,D1
            bne.b   .L1
.L3:
            andi.w  #$FF,D0
            lea     (DispatchTab.w,D0.w*4),A1
            rts
GetTrapAddress:
            bsr.b   sub_40809A34
            movea.l (A1),A0
            moveq   #0,D0
            rts
SetTrapAddress:
            bsr.b   sub_40809A34
            bra.l   DISPATCHPATCH
CacheFlush:
            move.l  ($6F4).w,-(SP)
            rts
vCacheFlush:
            movec   CACR,D1
            addq.w  #8,D1
            movec   D1,CACR
            rts
            lea     EMT1010,A0
            beq.b   .L1
            lea     EMT1010,A0
.L1:
            move.l  A0,LineAVector
InitDispatcher:
            lea     BadTrap,A4
            movea.l ROMBase,A3
            movea.l A3,A2
            lea     ($E00).w,A1
            movea.l A3,A0
            adda.l  ($22,A0),A0
            moveq   #$7F,D2
            move.w  #$3FF,D0
.L1:
            move.b  (A0)+,D1
            bmi.b   .L5
            lsl.w   #8,D1
            move.b  (A0)+,D1
.L2:
            add.w   D1,D1
            beq.b   .L7
            adda.w  D1,A2
.L3:
            move.l  A2,(A1)+
.L4:
            dbra    D0,.L1
            lea     DispatchTab,A1
            bra.b   .L1
.L5:
            and.w   D2,D1
            beq.b   .L6
            cmp.w   D2,D1
            bne.b   .L2
            movea.l (A0)+,A2
            adda.l  A3,A2
            bra.b   .L3
.L6:
            move.l  A4,(A1)+
            bra.b   .L4
.L7:
            bra.l   CACHEVECTORPATCH
            ds.b    4
BadTrap:
            movem.l D0-D7/A0-A7,seVars
            moveq   #$C,D0
            jmp     (SysErr1.w,PC)
            ds.b    14

            EVEN
