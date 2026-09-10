 Adds the `[pr_h:<x>]` and `[pr_p:<x>]` text codes, for automatically grabbing the pronouns of the hero or partner in dialogue,
 as well as logical tagcodes for dealing with small grammar differences when using the plural pronoun (they/them)

---

# TAG CODES

## Pronoun tag codes:
- `pr_h`: "**PR**onoun **H**ero" – Replaced with the hero's pronoun of the given type.
- `pr_p`: "**PR**onoun **P**artner" – Replaced with the partner's pronoun of the given type.

## Pronoun tag code arguments:
- `they`: The subjective pronoun (he/she/they)
- `them`: The objective pronoun (him/her/them)
- `their`: The possessive pronoun (his/her/their)
- `theirs`: The plural possessive pronoun (his/hers/theirs)

## Grammar tag codes:
- `plif_h`, `plif_p`: "**IF** **PL**ural **H**ero/**P**artner"  – Inserts the contents of the tag parameter to the string <u>*if*</u> the hero or partner (respectively) uses a plural pronoun. Replaced with empty space otherwise.

- `plnot_h`, `plnot_p`: "(if) **NOT** **PL**ural **H**ero/**P**artner" –  Inserts the contents of the tag parameter to the string if the hero or partner <u>*does not*</u> use a plural pronoun. Replaced with empty space otherwise.

- `plrep_h`, `plrep_p`: "**PL**ural **REP**lace **H**ero/**P**artner" –  Requires a dividing character "|" (vertical slash) within the tag parameter. Appends the contents of the tag parameter to the <u>*left*</u> of this divider if the hero or partner  <u>*does not*</u> use a plural pronoun, and the contents of the tag paramter to the <u>*right*</u> of this divider if they do.

<br></br>

---
# USAGE:

This can be used in basic lines of dialogue to avoid needing an unwieldy switch case:

### **Sample sentence**:

 `"Hey, is that... [hero]? But who's the Pokémon next to [pr_h:them]...?"` <br></br>

- (With a male hero) <br></br>
>"Hey, is that... <heroname\>? But who's the Pokémon next to him...?" 

- (With a female hero) <br></br>
>"Hey, is that... <heroname\>? But who's the Pokémon next to her...?" 

- (With a genderless hero) <br></br>
>"Hey, is that... <heroname\>? But who's the Pokémon next to them...?" 

<br></br>

---

<br></br>

Or in more complex lines of dialogue, which would normally require a "nightmare spaghetti mess" of switch cases to account for all possible combinations:

### **Sample sentence 2**:
 `"From the way [partner]'s face dropped when [pr_p:they] found out [hero] wouldn't be there, because of [pr_h:their] injury... [pr_p:they] seemed so heartbroken..."` <br></br>

- (With a genderless hero and female partner) <br></br>
>"From the way <partnername\>'s face dropped when she found out <heroname\> wouldn't be there, because of their injury... she seemed so heartbroken..." 

- (With a male hero and genderless partner) <br></br>
 >"From the way <partnername\>'s face dropped when they found out <heroname\> wouldn't be there, because of his injury... they seemed so heartbroken..." <br></br>

- (With a female hero and female partner) <br></br>
 >"From the way <partnername\>'s face dropped when she found out <heroname\> wouldn't be there, because of her injury... she seemed so heartbroken..." <br></br>

<br></br>

---

<br></br>

To account for the pronoun used for a genderless hero/partner technically being a plural pronoun, the grammar / string-substitution tags can be used, such as to append an "s" to a word when needed:

### **Sample sentence 3**:
`"Oh, [pr_h:they] seem[plnot_h:s] to be coming to..."`

- (With a female hero)
> "Oh, she seems to be coming to..."

- (With a male hero)
> "Oh, he seems to be coming to..."

- (With a genderless hero)
> "Oh, they seem to be coming to..."

<br></br>

---

<br></br>

For more complex sentences– or ones that use irregular plurals– the `plrep` tag can be used to account for either case:

### **Sample sentence 4**:
"Well, `[pr_p:they]` certainly ha`[plrep_p:s|ve]` a funny way of doing things..."

- (With a male partner)
> "Well, he certainly has a funny way of doing things..."

- (With a female partner)
> "Well, she certainly has a funny way of doing things..."

- (With a genderless partner)
> "Well, they certainly have a funny way of doing things..."

<br></br>

---


# NOTES:

- As of 0.1.0, "invalid" gender pokemon will be treated the same way as genderless ones (using neutral pronouns). This most likely affects nothing, since I believe you don't ever encounter the "invalid" gender except in error, but it was more efficient to do it this way regardless.

- Currently, there's no way to capitalize the replaced pronoun to use it at the beginning of a sentence. This is a limitation of the patch itself, and to fix it would be a pretty massive undertaking. I plan to do so eventually, but until then, you must reword your sentences to avoid this. Sorry.
    -  A method of doing this can seen in the examples above– such as in sample 3, where an "Oh," is put before the pronoun tag, to avoid the issue without disrupting the flow of dialogue too much.

<br></br>

# SPACE

- This patch occupies Overlay 36, and thus, requires Skytemple's built-in `ExtraSpace` patch to be applied.

- Due to the (somewhat ambitious) nature of this patch, it's somewhat large– being exactly 562 bytes (0x234) in size! It's located 0x02000 after the common area in Overlay 36 (address 0x32F70), and spans from there to address 0x331A2. 

    - If you aren't certain what this means, then that's okay. Know that its location means that it won't ever conflict with any vanilla Skytemple patches, and it *hopefullly* won't conflict with many community-made patches. 
    
    If you're using a lot of other community patches, I recommend trying to find out where they're located in Overlay 36, and adjusting this patch's offset accordingly (rename the `.skypatch` into a `.zip`, extract it, and change the line at the top of `asm_patches/patch_ov36.asm`. For re-packing it, see the `MakePatch` script file in this patch's repository).

<br></br>

# CONCLUSION

- This is my first ever Skypatch, and my first-ever real program made entirely in ASM. I've tested it quite thoroughly, but not I'm not perfect! <u>**Make a backup of your ROM before applying!!!!!!**</u>

- Additionally, please send reports of any bugs or odd behavior when using this patch– as well as any questions about it or ideas for it– to `@itred12` on discord (direct-message or (preferably) in the Skytemple discord server)! Your feedback means everything!

- This patch was only made possible due to the patience and pointers (literal and metaphorical) of Chesyon, Happylappy, Frostbyte, and Assidion. They are all really cool people whom are wizards in their own right when it comes to ASM!




    

