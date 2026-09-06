Adds the `[pr_hero:<x>]` and `[pr_partner:<x>]` text codes, for automatically grabbing the pronouns of the hero or partner in dialogue. 

---

## Tag codes:
- **pr_hero**: Replaced with the hero's pronoun of the given type.
- **pr_partner**: Replaced with the partner's pronoun of the given type.

## Tag code arguments:
- **subj**: The subjective pronoun (he/she/they)
- **obj**: The objective pronoun (him/her/them)
- **pos**: The possessive pronoun (his/her/their)
- **pos_plr**: The plural possessive pronoun (his/hers/theirs)

---
## Example use:

Sample sentence:
 - "From the way [pr_partner:pos] face dropped when [pr_partner:subj] found out [hero] wouldn't be there, because of [pr_hero:pos] injury... [pr_partner:subj] seemed so heartbroken..." <br></br>

(With a genderless hero and female partner) <br></br>
>"From the way her face dropped when she found out <hero\> wouldn't be there, because of their injury... she seemed so heartbroken..." 

(With a male hero and genderless partner) <br></br>
 >"From the way their face dropped when they found out <hero\> wouldn't be there, because of his injury... they seemed so heartbroken..." <br></br>

 (Etc.)

 ---

## Notes:

- This is my first ever Skypatch, and my first-ever real program made entirely in ASM. I've tested it consierably, but not *super* considerably. Make a backup of your ROM before applying!

- Please send reports of any odd behavior when using this patch, as well as any suggestions or ideas regarding it, to `@itred12` on discord! Your feedback means everything!

- Currently, there's no way to capitalize the replaced pronoun to use it at the beginning of a sentence. This is a limitation of the patch itself, and to fix it would be a pretty massive undertaking, but I plan to do so eventually. At some point, there will be a second tag parameter to specify whether or not the pronoun is capitalized.


    

