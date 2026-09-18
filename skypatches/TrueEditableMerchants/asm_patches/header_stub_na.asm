.relativeinclude on
.nds
.arm


; Superceded by these being set in config.xml
// ========================================================================
// SPECIES DEFINITIONS
// 
// Replace these entries with the monster ID of the NPC you want to show up instead!
// ========================================================================
/*
.definelabel ASSEMBLY_SPECIES,                  390 ; Assembly organizer (Chimecho)
.definelabel BANKER_SPECIES,                    388 ; Banker Duskull 
.definelabel LINKSHOP_SPECIES,                  507 ; Link shop owner (Electivire) 

.definelabel GENERAL_SHOP_SPECIES,              383 ; General shop owner (Green Keckleon)
.definelabel WARES_SHOP_SPECIES,                384 ; Wares shop owner (Purple Keckleon)
.definelabel STORAGE_SPECIES,                   115 ; Storage manager (Kangaskhan)

.definelabel BARTENDER_SPECIES,                 354 ; Cafe bartender (Spinda)
.definelabel RECYCLE_SHOP_SPECIES,              393 ; Recycle shop owner (Wynaut)


.definelabel NURSERY_SPECIES,                   113 ; 

.definelabel SWAP_SHOP_SPECIES,                 495 ; Swap shop owner (Croagunk)
.definelabel SENTRY_DUTY_DIGLETT,               50  ; Diglett (sentry duty minigame)
.definelabel SENTRY_DUTY_LOUDRED,               322 ; Loudred (sentry duty minigame)
.definelabel SENTRY_DUTY_CHATOT,                483 ; Chatot (sentry duty minigame)
.definelabel SENTRY_DUTY_GROVYLE,               281 ; Story Grovyle. Explicitly excluded from being shown as a choice in the sentry duty minigame

.definelabel MISSION_REWARD_SPECIES,            483 ; Chatot
 */ 


; Overlay 19
    ; Yes, there's three. Yes, they're all identical. Yes, Spike Chunsoft could have easily just have had all Spinda Cafe functions reference one address.
    ; We may perhaps never know the genius behind their programming
.definelabel SPINDA_HWORD_BARENTRY, 0x0238D5F8 
.definelabel SPINDA_HWORD_BARRESUME, 0x0238D688
.definelabel SPINDA_HWORD_BARCASEMANAGER , 0x0238C500

; Overlay 18
.definelabel IMMEDIATE_ELECTIVIRE_ID1, 0x238B164 
.definelabel IMMEDIATE_ELECTIVIRE_ID2, 0x238B1E4
.definelabel IMMEDIATE_ELECTIVIRE_GETPORTRAIT, 0x238B4DC 

; Overlay 17
.definelabel CHIMECHO_HWORD, 0x0238B078

; Overlay 15
.definelabel DUSKULL_HALFWORD, 0x0238A22C

; Overlay 14
.definelabel LOUDRED_HWORD, 0x0238C14C
.definelabel CHATOT_HWORD, 0x0238C198
.definelabel GROVYLE_HWORD, 0x0238CA64
.definelabel IMMEDIATE_DIGLETT_END, 0x0238BDDC
.definelabel IMMEDIATE_DIGLETT_SORRYTOKEEPYOUWAITING, 0x0238BCA4 ; (I had to legitimately do a quintuple-take when I saw this in memory)

; Overlay 20
.definelabel IMMEDIATE_WYNAUT_NORMPORTRAIT, 0x238B4D8 ; this must be at r1
.definelabel IMMEDIATE_WYNAUT_PRINTEXTBOX, 0x238B36C ; r2
.definelabel IMMEDIATE_WYNAUT_SIMPLEMENU, 0x238B3C8 ; r3

; Overlay 21
.definelabel CROAGUNK_ENTRYPOINT_HWORD, 0x238B8F8 ; Preprocessor args
.definelabel CROAGUNK_DIALOGUEMANAGER_HWORD, 0x238B09C ; Portrait

; Overlay 22
.definelabel GREENKECLEON_ENTRYPOINT_HWORD, 0x238D7AC
.definelabel PURPLEKECLEON_ENTRYPOINT_IMMEDIATE, 0x238D74C

; Overlay 23
.definelabel KANGASKHAN_SUBCASE_IMMEDIATE, 0x238A22C
.definelabel KANGASKHAN_ENTRYPOINT_IMMEDIATE, 0x238C384

; Overlay 24
.definelabel CHANSEY_MAYBINIT_IMMEDIATE, 0x238A720 ; r1, Portrait
.definelabel CHANSEY_ENTRYPOINT_IMMEDIATE, 0x238C298 ; r3, Name


; Overlay 25
.definelabel XATU_ENTRYPOINT_IMMEDIATE, 0x238B188 ; r3, Name
.definelabel XATU_MAYBEINIT_IMMEDIATE, 0x238A780 ; r1, Portrait

; Overlay 26
.definelabel CHATOT_ENTRYPOINT_HWORD, 0x238A560 