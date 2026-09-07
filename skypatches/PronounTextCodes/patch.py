
# Copyright 2026 Itred12
#
# This source code, as well as the template it was made from, is licensed under the MIT license: https://github.com/itred12/itred-eos-asm/blob/main/LICENSE_MIT
# Owner of the original template is Chesyon: https://github.com/Chesyon, whom provided it under this license.
# The distribution is licensed under GPLv3: https://github.com/itred12/itred-eos-asm/blob/main/LICENSE_GPLv3


from typing import Callable

from ndspy.rom import NintendoDSRom

from skytemple_files.common.util import read_u32, get_binary_from_rom
from skytemple_files.common.ppmdu_config.data import Pmd2Data, GAME_VERSION_EOS, GAME_REGION_US
from skytemple_files.patch.category import PatchCategory
from skytemple_files.patch.handler.abstract import AbstractPatchHandler, DependantPatch#, DependantPatch # <- uncomment this if the patch uses overlay 36.
from skytemple_files.common.i18n_util import f, _

# the following variables are used in the is_applied check below.
# hex representation of the instruction you're overwriting. note that in ghidra the bytes are shown in reverse order! ex: 58 07 c1 05 -> 0x05C10758
ORIGINAL_INSTRUCTION = 0x0A000007
# address of the instruction you're overwriting minus the start point of the overlay'
#OFFSET_EU = 0x22ED1C8-0x22DCB80 # Will implement eventually
OFFSET_US = 0x02022DE4-0x02000000 # arm9 starts at 0x02000000




class PatchHandler(AbstractPatchHandler, DependantPatch): 

    @property
    def name(self) -> str:
        return 'PronounTextCodes'

    @property
    def description(self) -> str:
        return """
(PMD if it was WOKE!!!) \n
Adds the [pr_h:<x>] and [pr_p:<x>] text codes, for automatically grabbing the pronouns of the hero or partner in dialogue. \n
<x> can be \"they\" for subjective pronouns (he/she/they), \"them\" for objective pronouns (him/her/them), \"their\" for possessive pronouns (his/her/their), or \"theirs\", for plural possessives (his/hers/theirs) \n
I.e., [pr_h:them], [pr_p:theirs]

Only made possible thanks to help from Chesyon, Happylappy, and Assidion \n
Greatly reduced patch size in 0.1.0 with the help of literal and metaphorical pointers from Frostbyte
    """

    @property
    def author(self) -> str:
        return 'Itred12'

    @property
    def version(self) -> str:
        return '0.1.0'

    
    def depends_on(self) -> list[str]:
        # Needed for ov36
        return ["ExtraSpace"]


    def is_applied(self, rom: NintendoDSRom, config: Pmd2Data) -> bool:
        
         # PreprocessString is an arm9 function, so we patch into it there
         arm9 = get_binary_from_rom(rom, config.bin_sections.arm9) 
         
         if config.game_version == GAME_VERSION_EOS:
            if config.game_region == GAME_REGION_US:
                return read_u32(arm9, OFFSET_US) != ORIGINAL_INSTRUCTION 
                 
           
            
         raise NotImplementedError()

    def apply(self, apply: Callable[[], None], rom: NintendoDSRom, config: Pmd2Data) -> None:
         apply() # Apply the patch

    def unapply(self, unapply: Callable[[], None], rom: NintendoDSRom, config: Pmd2Data):
        raise NotImplementedError()
