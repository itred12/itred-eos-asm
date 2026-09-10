.org 0x023A7080 ; Beginning of overlay 36
// HEY!!!! MODIFY THIS LINE (after the "+") IF YOU'RE HAVING ISSUES WITH THIS PATCH CLASHING WITH ANY OTHERS YOU'RE USING!!!
.orga 0x30F70 + 0x02000 ; Little ways into the common area to try and alleviate patch clashes
.area 0x234
; 470 -> 314!!

; After new tag set: 314 -> 562
; Not nearly as bad as I was expecting
; + potentially some room for more optimization



; ------------------------------------------------------------------------------
;                                Utility functions
; ------------------------------------------------------------------------------



NextString:
    ; r1: array of strings
    ; returns: r1, offset to the next string in the array
    ; Does not do bounds checking! Be aware!
    mov r3, lr ; Grab the return address and put it somewhere that nds_strchr doesn't mess with, so we can return after its call

    mov r0, r1
    mov r1, #0x0 ; Load the byte "0" to search for the string terminator
    bl nds_strchr
    ; r0 now is the address pointing to the end of this string (terminator char)

    ; Check for nullptr (pointer itself should be >0 if character is found)
    cmp r0, #0x0
    beq PTagFailedBranch

    ; Now is address pointing to the start of the *next* string
    add r0, #0x1
    mov r1, r0 ; Move it back
    bx r3 ; Return to the address we stored before


NextNStrings:
    
    ; r1: the string array to index
    ; r2: the element # in the string array to find (n)
    ; returns: r1, as the same array offset to the (n)th index

    mov r7, lr ; We'll need this to return later, this return will be used in the following loop
    mov r6, #0x0 ; also initalize this
    mov r4, r2 ; Can't use r2 because nextString's call to nds_strchr uses it
    
    b _NextNStringsLoop

    
_NextNStringsLoop:

    cmp r6, r4
    bxeq r7 ; Return to the link we stored at the beginning if we're at the target index

    bl NextString
    
    ; If this returns, we found a terminator character, and have reached the next string in the array
    add r6, #0x1
    b _NextNStringsLoop
    

GetUsableGender: 
    
    ; For a ground monster in r0, 
    ; returns their gender in r1, offset in the way we need it as:
    ; male: 0x0
    ; female: 0x1
    ; genderless, invalid: 0x2
    mov r3, lr ; Store the current return address, as it'll be overwritten otherwise

    ; Grab the ID
    ldrh r0, [r0, #0x4]
    bl GetMonsterGender
    ; r0 now holds their gender, as:
    ; invalid: 0x0
    ; male: 0x1
    ; female: 0x2
    ; genderless: 0x3

    ; Process "invalid" just as we would "genderless"
    mov r1, r0 ; Move it for safe-keeping
    cmp r1, #0x0
    moveq r1, #0x3
    sub r1, #0x1 ; Subtract one now to shift it all down
    ; male: 0x0
    ; female: 0x1
    ; genderless, invalid: 0x2

    bx r3 ; return


ReplaceWithTerminator:
    ; Places a terminator character (0x0) into the pointer to a string r0
    mov r5, lr ; Need to return after the call to nds_memset

    mov r1, #0x0 ; terminator char
    mov r2, #0x1 ; Fill one
    bl nds_memset

    bx r5

; ------------------------------------------------------------------------------
;                                Main functions
; ------------------------------------------------------------------------------



HookPLetter: 

    ; Retrieve the tag_string (the part before the ":") from register 13 at 0xb4
    ldr r1, =TAG_STRING
    mov r6, #0x0 ; as well as an arbitrary counter
    ; Start da loop
    b FindTag


FindTag:    
    ; r1 should be our tag string
    ; r6 should be an arbitrary counter
    ldr r0, [r13, #0xB4]
    bl StrcmpTag
    cmp r0, #0x0
    bne FoundTag

    ; If no tag is found, increment the counter
    add r6, #0x1

    ; if the counter exceeds the amount of tags we're checking for (8, >#0x7), fail
    cmp r6, #0x8
    beq PTagFailedBranch

    ; Go to the next string and repeat
    bl NextString
    b FindTag

    

FoundTag:
    ; Because the partner tag is only every other tag, then if the counter has the first bit set, it's a partner tag (if r6 is odd)
    tst r6, #1
    bleq GetHero
    
    tst r6, #1  ; These functions also update the condition flags, so the test has to be done after each
    blne GetPartner
    
    bl GetUsableGender

    ; "updates the condition flags based on the result of subtracting the second value from the first"
    ; this means the minus (MI) condition now returns true if the counter is 0 or 1 (pr tag)
    cmp r6, #0x2
    bmi StartPronounTag
    cmp r6, #0x4 ; 2 or 3 (ifpl tag)
    bmi StartIfPluralTag
    cmp r6, #0x6 ; 4 or 5 (notpl tag)
    bmi StartNotPluralTag

    ; and if no others,
    b StartPluralRepTag
                 

; ------------------------------------------------------------------------------
;                                "pr" pronoun tag
; ------------------------------------------------------------------------------

StartPronounTag:

    ; multiply gender by four to get the offset in the substitution table
    mov r0, #0x4
    mul r5, r1, r0
    ; r5 is now:
    ; male: 0x0
    ; female: 0x4
    ; genderless, invalid: 0x8
    
    
    ; Get the substitution table at the beginning of the they/them set, which we use as our tag_string_params
    mov r2, #0x8
    ldr r1, =TAG_STRING_REPLACEMENT
    bl NextNStrings
    mov r4, r1
    mov r6, #0x0
    
    b PronounTagSelectInOffset


PronounTagSelectInOffset:
    ; r4: table offset to beginning of they/them set
    ; r5: numerical offset to the beginning index in the table of our target set of four

    ldr r0, [r13, #0xB8] ; Load the tag param
    
    add r1, r4, #0x0 ; Load one string of "they", "them", "their", or "theirs" into r1
    bl StrcmpTag
    cmp r0, #0x0
    bne PronounTagFoundPronoun

    ; If we didnt find the pronoun, add 1 to the r5 index and skip to the next string in r4
    add r5, #0x1 
    mov r1, r4
    bl NextString
    mov r4, r1
   
    ; Loop
    b PronounTagSelectInOffset


PronounTagFoundPronoun: 
    ; r4: table offset to correct proper noun for target in the they/them set
    ; r5: numerical index, from the start of the table, to get to the correct proper noun in the target set
    mov r2, r5
    ldr r1, =TAG_STRING_REPLACEMENT
    bl NextNStrings
    ; r1 is now the correct string
    
    b AppendToBuf

    
; ------------------------------------------------------------------------------
;                     "plurif" string-substitution tag
; ------------------------------------------------------------------------------

    ; Now we do things a bit differently:
    ; the tag_string_param of this tag is instead the *contents* to be appended to the message *if* the hero/partner uses the plural pronoun (they/them/their/theirs)
    ; hence the name, "plif" and "plnot– "if plural" / "(if) not plural"
    ; i.e., "[pr_p:they] seem[plnot_p:s] so heartbroken..." becomes "(s)he seems so heartbroken..." or "they seem so heartbroken...",

    ; To handle irregular plurals, we also have some extra functionality...
    ; for the "plurrep" ("plural replace") tag, the contents to the left of a dividing character "|" (ascii 0x7C) will be inserted if the target does not use a plural pronoun,
    ; and the contents to the right of that character if the target *does* use a plural pronoun

    ; i.e., "Yes, [pr_h:they] ha[plrep_h:s|ve] one." becomes "Yes, (s)he has one" or "Yes, they have one",
    ; appending either an "s" or a "ve", depending on which one is needed

StartIfPluralTag:
    
    ; Do nothing if gender is not plural
    cmp r1, #0x2
    bne AfterTagIsFound 

    b BasicPluralTag


StartNotPluralTag:

    ; Do nothing if gender is plural
    cmp r1, #0x2
    beq AfterTagIsFound ; If the target does not use a plural pronoun, skip everything

    b BasicPluralTag
    

BasicPluralTag:
    
    ; Put the tag_string_param as the string to be added
    ldr r0, [r13, #0xB8] 
    mov r1, #0x5D ; character "]"
    bl nds_strchr
    ; Overwrite it with a terminator
    bl ReplaceWithTerminator
    
    ldr r1, [r13, #0xB8] 
    b AppendToBuf

 
StartPluralRepTag: 

    ; Store gender for safekeeping
    mov r6, r1 

    ldr r0, [r13, #0xB8] 
    mov r1, #0x7C ; Character "|"

    bl nds_strchr
    cmp r0, #0x0 ; If we don't find one, then fail
    beq PTagFailedBranch

    bl ReplaceWithTerminator
    
    ldr r1, [r13, #0xB8]

    ; Now there's two strings, one to the left and one to the right
    ; If we're using the one to the right, use NextString to get to it from the pointer to tag_string_param
    ; otherwise, return to the start of the tag_string_param
    cmp r6, #0x2
    beq PluralRepRight
    
    b AppendToBuf



PluralRepRight:
    
    bl NextString 
    mov r6, r1 ; Copy the address of the start of this string for use later
    mov r1, #0x5D ; character "]"
    bl nds_strchr

    bl ReplaceWithTerminator

    mov r1, r6 ; Move it back
    b AppendToBuf


; ------------------------------------------------------------------------------

AppendToBuf:
    ; r1 should contain the string to be placed into the buffer

    add r0, r13, #0x1C8 ; Grab a pointer to the buffer 
    bl nds_strcpy ; Copy r1 into it
    add r7, r13, #0x1C8 ; Put another pointer to the buffer into r7 after we modify it, where I assume it'll be accessed by the code displaying the text
    
    ; And we're done!
    b AfterTagIsFound


    

.pool ; Set up the tags to match for 
    TAG_STRING:
        ; Pronoun tags, "pronoun hero" and "pronoun partner"
        .asciiz "pr_h"
        .asciiz "pr_p" 
        ; String-tweaking tags, 
        ; "if plural hero", "if plural partner", 
        ; "(if) not plural hero", "(if) not plural partner",
        ; "plural replace hero", and "plural replace partner",
        .asciiz "plif_h"
        .asciiz "plif_p"
        .asciiz "plnot_h"
        .asciiz "plnot_p"
        .asciiz "plrep_h"
        .asciiz "plrep_p"
        
    TAG_STRING_REPLACEMENT: 
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
