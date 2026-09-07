.org 0x023A7080 ; Beginning of overlay 36
// HEY!!!! MODIFY THIS LINE (after the "+") IF YOU'RE HAVING ISSUES WITH THIS PATCH CLASHING WITH ANY OTHERS YOU'RE USING!!!
.orga 0x30F70 + 0x02000 ; Little ways into the common area to try and alleviate patch clashes
.area 0x13A
; 470 -> 314!!



// Utility functions
GetElementAtIndex:
    
    ; r1: the index of the element to find (n)
    ; r2: the table to index
    ; returns: r2, as the same table offset to the (n)th index

    mov r7, lr ; We'll need this to return later, this return will be used in the following loop
    mov r6, #0x0 ; also initalize this
    b _GetElementAtIndexLoop

    
_GetElementAtIndexLoop:

    cmp r6, r1  
    bxeq r7 ; Return to the link we stored at the beginning if we're at the target index

    bl NextString ; We'll need to return to this branch from NextString, which is why we need to juggle lr to have two returns
    add r6, #0x1
    b _GetElementAtIndexLoop
    
    
NextString:
    ; r2: the table at the starting mem address
    ; Goes to the start of the next string in r2
    ldrb r0, [r2]
    add r2, #0x1 ; Term + 1 = start of next strh 

    cmp r0, #0x0 ; Find terminating character
    bxeq lr ; return 
    
    b NextString

    
// Main functions

HookPLetter: 

    ; Retrieve the tag_string (the part before the ":") from register 13 at 0xb4
    ldr r0, [r13, #0xB4] 
    ; Load our first tag_string to match for
    ldr r1, =TAG_HEROPR
    bl StrcmpTag ; StrcmpTag overwrites r0 with the result!
    cmp r0,#0x0
    blne GetHero
    bne StartPronounCheck

    ; If that isn't it, try the partner
    ldr r0, [r13, #0xB4]
    ldr r1, =TAG_PARTNERPR
    bl StrcmpTag
    cmp r0,#0x0
    blne GetPartner
    bne StartPronounCheck


    ; If we haven't entered either of these branches, it's probably an invalid tag
    b PTagFailedBranch


StartPronounCheck: 
    ; Grab the ID of the hero/partner, which should be in r0
    ldrh r0, [r0, #0x4]
    ; Pass it to GetMonsterGender, now we have that in r0 instead
    bl GetMonsterGender
    ; invalid: 0x0
    ; male: 0x1
    ; female: 0x2
    ; genderless: 0x3

    mov r1, r0

    ; Process "invalid" just as we would "genderless"
    cmp r1, #0x0
    moveq r1, #0x3
    sub r1, #0x1 ; Subtract one now to shift it all down
    ; male: 0x0
    ; female: 0x1
    ; genderless, invalid: 0x2
    ; Conveniently matches the indexing of our PR_SUB table


    ; Multiply by four to get the offset in the substitution table
    mov r2, #0x4
    mul r1, r1, r2
    ; male: 0x0
    ; female: 0x4
    ; genderless, invalid: 0x8


    ; Get the element at the index of r1, to get the start of our target set
    ldr r2, =SUB_PR
    bl GetElementAtIndex 
    mov r5, r2

    ; Also the offset of the 8th element (our tag param matches)
    mov r1, #0x8
    ldr r2, =SUB_PR
    bl GetElementAtIndex
    mov r4, r2
    
    b SelectPronounInOffset


SelectPronounInOffset:
   
    ; r4: table offset to beginning of they/them set
    ; r5: table offset to beginning of target pronoun set

    ldr r0, [r13, #0xB8] ; Load the tag param
    
    add r1, r4, #0x0 ; Load one string of "they", "them", "their", or "theirs" into r1
    bl StrcmpTag
    cmp r0, #0x0
    bne FoundPronoun
    
    ; We have to do it like this since registers 2 and 3 are used by StrcmpTag, and would be overwritten otherwise
    mov r2, r4
    bl NextString ; Go to next string in r2 and start again
    mov r4, r2
    mov r2, r5
    bl NextString ; Also increment the target pronoun set
    mov r5, r2

    b SelectPronounInOffset



FoundPronoun: 
    ; r5: table offset to correct proper noun for target
    add r0, r13, #0x1C8 ; Grab a pointer to the buffer 
    add r1, r5, #0x0
    
    bl strcpy
    add r7,r13,#0x1C8 ; Put the pointer to the buffer into r7 after we modify it, where I assume it'll be accessed by the code displaying the text
    ; And we're done!
    b AfterTagIsFound


.pool ; Set up the tags to match for 
    TAG_HEROPR:
        .asciiz "pr_h"
    TAG_PARTNERPR:
        .asciiz "pr_p" 
    SUB_PR: 
        .asciiz "he"
        .asciiz "him"
        .asciiz "his"
        .asciiz "his"
        .asciiz "she"
        .asciiz "her"
        .asciiz "her"
        .asciiz "hers"
        .asciiz "they"
        .asciiz "them"
        .asciiz "their"
        .asciiz "theirs"
        .byte 0x0 ; Terminator, just to be eeeextra sure...
    
        

.endarea
