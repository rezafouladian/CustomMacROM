            include "Include/ROMHeader.s"

            EXPORT  Error1Handler,RdXByte,StartTest1,TMProc,TMRestart,USTPMGRSENDBYTE

            IMPORT  BadDisk_L1,BaseOfROM,BOOTBEEP6,CritErr,EgretInit,ErrorBeep1
            IMPORT  ErrorBeep2,ErrorBeep3,ErrorBeep4,GetHardwareInfo,GI_AllocPermMem,GI_ExecuteTest
            IMPORT  GI_FindSubtest,GI_InitInterface,GI_InstallSubtest,GI_InstallTest,ROMVersion,SendEgretCmd
            IMPORT  SizeMemory,StartInit1,StBoot

            SECTION "USTStartTest",CODE

            include "OS/StartMgr/USTSubtests.s"    ; test and subtest tables
            include "OS/StartMgr/USTStartUp.s"     ; startup and hardware setup
            include "OS/StartMgr/USTCritTests.s"   ; critical tests
            include "OS/StartMgr/USTNonCritTsts.s" ; non-critical tests
            include "OS/StartMgr/USTPostProc.s"    ; post-test processing
            include "OS/StartMgr/USTPram.s"        ; PRAM logging
            include "OS/StartMgr/USTTestMgr.s"     ; test manager
            include "OS/StartMgr/USTEnvirons.s"    ; test environment interface

            EVEN
