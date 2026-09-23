.org 0x023A7080 
.orga 0x30F70 + 0x03000 ; Someplace hopefully out-of-the-way after the common area
.area 0x18 ; 24 bytes is prob all I need

GetLinkShopPrice:
    ldr r0, =LINK_SHOP_COST
    bx lr
    .pool

CmpLinkShopPrice:
    ldr r1, =LINK_SHOP_COST
    cmp r0, r1
    mov r1, #0x0 ; Restores r1 to the value it was before we used it for the cmp
    bx lr
    .pool

.endarea

