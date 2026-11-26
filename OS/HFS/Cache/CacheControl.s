            include "Include/ROMHeader.s"

            EXPORT  CacheTrap

            IMPORT  CmdDone,FSQueueSync

            SECTION "CacheControl",CODE

CacheProc:
CTrapTbl:
            dc.w    GetCSize-CTrapTbl               ; 0
            dc.w    SetCSize-CTrapTbl               ; 1
            dc.w    GetApZnSiz-CTrapTbl             ; 2
            dc.w    SetApZnSiz-CTrapTbl             ; 3
            dc.w    GetMaxCXfr-CTrapTbl             ; 4
            dc.w    SetMaxCXfr-CTrapTbl             ; 5
            dc.w    GetCStatus-CTrapTbl             ; 6
            dc.w    SetCStatus-CTrapTbl             ; 7
CacheTrap:
            cmpi.w  #(CacheTrap-CTrapTbl)/2,D0
            bcs.b   .L1
            moveq   #paramErr,D0
            rts
.L1:
            lea     CTrapTbl,A1
            add.w   D0,D0
            adda.w  (0,A1,D0.w),A1
            jmp     (A1)
CTExit:
            jmp     (CmdDone.w,PC)
GetCSize:
            jsr     (FSQueueSync.w,PC)
            movea.l ($394).w,A1                     ; CacheVars
            move.l  ($4,A1),D0                      ; OldBufPtr
            sub.l   ($8,A1),D0                      ; NewBufPtr
            move.l  D0,($1C,A0)                     ; ioMisc
            moveq   #0,D0
            bra.b   CTExit
SetCSize:
            jsr     (FSQueueSync.w,PC)
            move.l  ($1C,A0),D0                     ; ioMisc
            moveq   #15,D1
            lsr.l   D1,D0
            move.b  D0,($20A).w                     ; CacheConfig
            moveq   #0,D0
            bra.b   CTExit
GetApZnSiz:
            jsr     (FSQueueSync.w,PC)
            movea.l ($394).w,A1                     ; CacheVars
            move.l  ($20,A1),($1C,A0)               ; CacheMinZn -> ioMisc
            moveq   #0,D0
            bra.b   CTExit
SetApZnSiz:
            jsr     (FSQueueSync.w,PC)
            movea.l ($394).w,A1                     ; CacheVars
            move.l  ($1C,A0),($20,A1)               ; ioMisc -> CacheMinZn
            moveq   #0,D0
            bra.b   CTExit
GetMaxCXfr:
            jsr     (FSQueueSync.w,PC)
            movea.l ($394).w,A1                     ; CacheVars
            move.l  ($12,A1),($1C,A0)               ; CacheByteLim -> ioMisc
            moveq   #0,D0
            bra.b   CTExit
SetMaxCXfr:
            jsr     (FSQueueSync.w,PC)
            movea.l ($394).w,A1                     ; CacheVars
            move.l  ($4,A1),D0                      ; OldBufPtr
            sub.l   ($8,A1),D0                      ; NewBufPtr
            move.l  ($1C,A0),D1                     ; ioMisc
            cmp.l   D1,D0
            bcc.b   .L1
            moveq   #paramErr,D0
            bra.w   CTExit
.L1:
            move.l  D1,($12,A1)                     ; CacheByteLim
            moveq   #0,D0
            bra.w   CTExit
GetCStatus:
            jsr     (FSQueueSync.w,PC)
            movea.l ($394).w,A1                     ; CacheVars
            moveq   #0,D0
            tst.b   ($11,A1)                        ; CurEnable
            beq.b   .L1
            btst    #5,($20B).w                     ; CacheEnable
            beq.b   .L1
            moveq   #1,D0
.L1:
            move.l  D0,($1C,A0)                     ; ioMisc
            moveq   #0,D0
            bra.w   CTExit
SetCStatus:
            jsr     (FSQueueSync.w,PC)
            tst.l   ($1C,A0)                        ; ioMisc
            beq.b   .L1
            bset    #5,($20B).w                     ; CacheEnable
            bra.b   .L2
.L1:
            bclr    #5,($20B).w                     ; CacheEnable
.L2:
            moveq   #0,D0
            bra.w   CTExit
            ds.b    10

            EVEN
