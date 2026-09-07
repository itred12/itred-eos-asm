.org 0x023A7080 ; Beginning of overlay 36
// HEY!!!! MODIFY THIS LINE (after the "+") IF YOU'RE HAVING ISSUES WITH THIS PATCH CLASHING WITH ANY OTHERS YOU'RE USING!!!
.orga 0x30F70 + 0x02000 ; Little ways into the common area to try and alleviate patch clashes
.area 0x1D6 ; should be 470 bytes large (0x32F70 to 0x33146)

    
HookPLetter: 
    
    ; Retrieve the tag_string (the part before the ":") from register 13 at 0xb4
    ldr r0, [r13, #0xB4] 
    
    ; Load our first tag_string to match for
    ldr r1, =TAG_HEROPR
    bl StrcmpTag ; StrcmpTag overwrites r0 with the result!
    cmp r0,#0x0
    bne LoadHero

    ; If that isn't it, try the partner
    ldr r0, [r13, #0xB4]
    ldr r1, =TAG_PARTNERPR
    bl StrcmpTag
    cmp r0,#0x0
    bne LoadPartner

    ; If we haven't entered either of these branches, it's probably an invalid tag
    b PTagFailedBranch

LoadHero: 
    bl GetHero ; Hero now in r0
    b GetPronoun

LoadPartner: 
    bl GetPartner ; Partner now in r0
    b GetPronoun

GetPronoun: 
    ; Grab the ID of the hero/partner, which should be in r0
    ldrh r0, [r0, #0x4]
    ; Pass it to GetMonsterGender, now we have that in r0 instead
    bl GetMonsterGender
    ; invalid: 0x0
    ; male: 0x1
    ; female: 0x2
    ; genderless: 0x3

    ; We'll need to use r0 in a moment, so copy it to r5 instead (first register not touched by any of the following functions we call)
    mov r5, r0 


    ; Find the pronoun being used
    ldr r0, [r13, #0xB8]
    ldr r1, =TAGPARAM_OBJ 
    bl StrcmpTag
    cmp r0,#0x0
    bne GetPronounObj

    ldr r0, [r13, #0xB8]
    ldr r1, =TAGPARAM_SUBJ
    bl StrcmpTag
    cmp r0,#0x0
    bne GetPronounSubj

    
    ldr r0, [r13, #0xB8]
    ldr r1, =TAGPARAM_POS_PLR
    bl StrcmpTag
    cmp r0,#0x0
    bne GetPronounPosPlr

    ; This would get matched before pos_plr if not put after it, I think
    ldr r0, [r13, #0xB8]
    ldr r1, =TAGPARAM_POS 
    bl StrcmpTag
    cmp r0,#0x0
    bne GetPronounPos

    ; If we went into none of these branches, it's an unrecognized tag param
    b PTagFailedBranch



GetPronounSubj: 
    ; r5 is now the gender
    cmp r5, #0x1 ; Target is male
    ldreq r1, =SUB_HE
    cmp r5, #0x2 ; Target is female
    ldreq r1, =SUB_SHE
    cmp r5, #0x3 ; Target is neutral
    ldreq r1, =SUB_THEY
    cmp r5, #0x0 ; Target is invalid
    beq PTagFailedBranch ; Not sure what else we'd do here
    ; If it's not invalid we can go to the end
    b AppendToBuf
    

GetPronounObj: 
    cmp r5, #0x1 ; Target is male
    ldreq r1, =SUB_HIM
    cmp r5, #0x2 ; Target is female
    ldreq r1, =SUB_HER
    cmp r5, #0x3 ; Target is neutral
    ldreq r1, =SUB_THEM
    cmp r5, #0x0 ; Target is invalid
    beq PTagFailedBranch 
    
    b AppendToBuf

GetPronounPos: 
    cmp r5, #0x1 ; Target is male
    ldreq r1, =SUB_HIS
    cmp r5, #0x2 ; Target is female
    ldreq r1, =SUB_HER
    cmp r5, #0x3 ; Target is neutral
    ldreq r1, =SUB_THEIR
    cmp r5, #0x0 ; Target is invalid
    beq PTagFailedBranch 
    
    b AppendToBuf

GetPronounPosPlr: 
    cmp r5, #0x1 ; Target is male
    ldreq r1, =SUB_HIS
    cmp r5, #0x2 ; Target is female
    ldreq r1, =SUB_HERS
    cmp r5, #0x3 ; Target is neutral
    ldreq r1, =SUB_THEIRS
    cmp r5, #0x0 ; Target is invalid
    beq PTagFailedBranch 
    
    b AppendToBuf

AppendToBuf: 
    ; r1: correct proper noun for target
   add r0,r13,#0x1C8 ; Grab the buffer (adding in this way makes r0 now a pointer to this address in r13, give or take)

    ; Copy it into the buffer
    bl strcpy 
    add r7,r13,#0x1C8 ; (Ah, that would make this..) Put a pointer to the buffer into r7 after we modify it, where I assume it'll be accessed by the code displaying the text
    ; And we're done!
    b AfterTagIsFound




.pool ; Set up the tags to match for. This'll use a lot of space...
    TAG_HEROPR:
        .asciiz "pr_hero"
    TAG_PARTNERPR:
        .asciiz "pr_partner" 
    TAGPARAM_SUBJ: ; he/she/they
        .asciiz "subj" 
    TAGPARAM_OBJ: ; him/her/them
        .asciiz "obj" 
    TAGPARAM_POS: ; his/her/their
        .asciiz "pos" 
    TAGPARAM_POS_PLR: ; his/hers/theirs
        .asciiz "pos_plr" 
    SUB_HE:
        .asciiz "he" 
    SUB_SHE:
        .asciiz "she" 
    SUB_THEY:
        .asciiz "they" 
    SUB_HIM:
        .asciiz "him" 
    SUB_HER:
        .asciiz "her" 
    SUB_THEM:
        .asciiz "them" 
    SUB_HIS:
        .asciiz "his" 
    SUB_THEIR:
        .asciiz "their" 
    SUB_HERS:
        .asciiz "hers" 
    SUB_THEIRS:
        .asciiz "theirs" 
    SUB_FORMAT:
        .asciiz "%d" 
        

.endarea
