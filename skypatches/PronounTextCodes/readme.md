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

- Currently, "invalid" gender pokemon will not work with the patch. If this behavior causes issues, I adjust it so they're treated the same as genderless pokemon (but I'm not sure "invalid" is ever encountered, except in error of something else?)

- This patch occupies addresses 0x32F70 to 0x33146! If you're able, check to make sure no other patches you're using are within this area, else they may be corrupted. All ASM patches included with Skytemple by default are unaffected by this, as the patch offset accounts for them.

- This is my first ever Skypatch, and my first-ever real program made entirely in ASM. I've tested it as much as I could, but not I'm not perfect! Make a backup of your ROM before applying!

- Additionally, please send reports of any bugs or odd behavior when using this patch– as well as any suggestions or ideas regarding it– to `@itred12` on discord! Your feedback means everything!

- Currently, there's no way to capitalize the replaced pronoun to use it at the beginning of a sentence. This is a limitation of the patch itself, and to fix it would be a pretty massive undertaking. I plan to do so eventually, but until then, you must reword your sentences to avoid needing a pronoun at a beginning of a sentence. Sorry.


    

