.org DisplayPrice
.area 0x4
    bl GetLinkShopPrice
.endarea

.org ComparePrice
.area 0x4
    bl CmpLinkShopPrice
.endarea