; Overlay 22 (Kecleon bros. shop)
.org GREENKECLEON_ENTRYPOINT_HWORD
.area 0x4
    .word GENERAL_SHOP_SPECIES
.endarea

.org PURPLEKECLEON_ENTRYPOINT_IMMEDIATE
.area 0x8
    bl GETMON_WARES_SHOP_PURPLEKECLEON
    nop ; No-op because the equivalent step at 0x238D750 was done in the function
.endarea