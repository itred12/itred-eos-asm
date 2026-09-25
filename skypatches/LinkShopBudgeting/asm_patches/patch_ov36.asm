.org 0x023A7080 
.orga 0x30F70 + 0x03000 ; Someplace hopefully out-of-the-way after the common area
.area 0x3A ; 42 bytes is prob all I need

GetLinkShopPrice:
    ldr r0, =LINK_SHOP_COST
    bx lr

CmpLinkShopPrice:
    push r1
    ldr r1, =LINK_SHOP_COST
    cmp r0, r1
    pop r1
    bx lr

SubLinkShopPrice:
    push r1
    ldr r1, =LINK_SHOP_COST
    subne r0, r0, r1 ; Original instruction, kinda
    pop r1
    bx lr


.pool

.endarea

