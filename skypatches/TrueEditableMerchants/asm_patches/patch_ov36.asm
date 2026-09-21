; Back in the building again!
.org 0x023A7080 
.orga 0x30F70 + 0x04000 ; Someplace hopefully out-of-the-way after the common area
.area 0x7C ; 112 bytes

; As Happylappy graciously explained to me, you can only store a single "literal" byte in a `mov` instruction
; So monster IDs >255 can't be loaded directly without a few extra instructions to grab it from a literal pool
; Any monster IDs in vanilla below this (i.e., Diglett #0050) must be replaced using this method here, to accomodate for changing them to a monster >#50

GETMON_SENTRY_DUTY_DIGLETT:
    ldr r1, =SENTRY_DUTY_DIGLETT
    bx lr
    .pool


GETMON_LINK_SHOP_ELECTIVIRE_R0:
    ldr r0, =LINKSHOP_SPECIES
    bx lr
    .pool


GETMON_LINK_SHOP_ELECTIVIRE_R1:
    ldr r1, =LINKSHOP_SPECIES
    bx lr
    .pool


GETMON_RECYCLE_SHOP_WYNAUT_R1:
    ldr r1, =RECYCLE_SHOP_SPECIES
    bx lr
    .pool

GETMON_RECYCLE_SHOP_WYNAUT_R2:    
    ldr r2, =RECYCLE_SHOP_SPECIES
    bx lr
    .pool

GETMON_RECYCLE_SHOP_WYNAUT_R3:
    ldr r3, =RECYCLE_SHOP_SPECIES
    bx lr
    .pool

GETMON_WARES_SHOP_PURPLEKECLEON:
    ldr r1, =WARES_SHOP_SPECIES
    ; Also update the speaker_id
    ldr r0,[r0, #0x0]
    str r1, [r0, #0x9c] 
    bx lr
    .pool

GETMON_STORAGE_KANGASKHAN_R3:
    ldr r3, =STORAGE_SPECIES
    bx lr
    .pool

GETMON_STORAGE_KANGASKHAN_R4:
    ldr r4, =STORAGE_SPECIES
    bx lr
    .pool

GETMON_DAYCARE_CHANSEY_R1:
    ldr r1, =NURSERY_SPECIES
    bx lr
    .pool

GETMON_DAYCARE_CHANSEY_R3:
    ldr r3, =NURSERY_SPECIES
    bx lr
    .pool

GETMON_APPRAISAL_XATU_R1:
    ldr r1, =BOXAPPRAISAL_SPECIES
    bx lr
    .pool

GETMON_APPRAISAL_XATU_R3:
    ldr r3, =BOXAPPRAISAL_SPECIES
    bx lr
    .pool


.endarea
