.org DisplayPrice
.area 0x4
    bl GetLinkShopPrice
.endarea

.org ComparePrice
.area 0x4
    bl CmpLinkShopPrice
.endarea

.org ComparePriceWhenGrabbingDialogueString
.area 0x4
    bl CmpLinkShopPrice
.endarea

.org MakeMoneyDisplaySubtract
.area 0x4
    bl SubLinkShopPrice
.endarea

.org ActuallySubtractMoney
.area 0x4
    bl GetLinkShopPrice
.endarea