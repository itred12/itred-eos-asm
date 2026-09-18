
; Overlay 21 (Croagunk Swap Shop)
.org CROAGUNK_ENTRYPOINT_HWORD
.area 0x4
    .word SWAP_SHOP_SPECIES
.endarea

.org CROAGUNK_DIALOGUEMANAGER_HWORD
.area 0x4
    .word SWAP_SHOP_SPECIES
.endarea