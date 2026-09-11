.relativeinclude on
.nds
.arm





; add more labels using the same syntax as above if desired.

; Floating addresses
.defineLabel BranchCallToFailedPTag, 0x02022de4
.defineLabel PTagFailedBranch, 0x02022e08
.definelabel AfterTagIsFound, 0x020232f0

; Function-reference addresses 
.defineLabel StrcmpTag, 0x020208C8
.defineLabel GetHero, 0x02055770
.defineLabel GetPartner, 0x02055798
.defineLabel GetMonsterGender, 0x020527A8

.defineLabel nds_strcpy, 0x02089694
.defineLabel nds_strcmp, 0x0208982c
;.defineLabel nds_sprintf, 0x02089584
.defineLabel nds_strchr, 0x2089974
;.defineLabel nds_strncpy, 0x0208975c
;.defineLabel nds_strlen, 0x02089678
;.defineLabel nds_strcat, 0x020897ac
;.defineLabel nds_memset, 0x02087308 ; Sortof like a weird version of string.repeat() in other languages

