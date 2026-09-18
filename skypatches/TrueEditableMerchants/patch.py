
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

ORIGINAL_INSTRUCTION = 0xE3A01F7F # Electivire immediate– I think I just want to check only one of the instructions changed instead of all of them

# address of the instruction you're overwriting minus the start point of the overlay'

#OFFSET_EU = 0x22ED1C8-0x22DCB80 # Will implement eventually
OFFSET_US = 0x238b164 - 0x238A140 # ov18 starts at 0x238A140




class PatchHandler(AbstractPatchHandler, DependantPatch): 

    @property
    def name(self) -> str:
        return 'TrueEditableMerchants'

    @property
    def description(self) -> str:
        return """
Requires ExtraSpace. Allows the portraits and names that show up in the various merchant and merchant-adjacent menus to be modified.
Make sure to check that these replacement pokemon have the needed portraits! (Typically at least "normal" and "happy")
You can re-apply this patch to select new values for these pokemon.

Initial research into modifying merchant portraits (as well as pointers and advice for this patch) by Happylappy
Further research into modifying names, bug-fixing, + cleanup into a Skypatch done by Itred12
    """

    @property
    def author(self) -> str:
        return 'Happylappy, Itred12'

    @property
    def version(self) -> str:
        return '0.0.1'

    
    def depends_on(self) -> list[str]:
        # Needed for ov36
        return ["ExtraSpace"]


    def is_applied(self, rom: NintendoDSRom, config: Pmd2Data) -> bool:
        
         
         ov18 = get_binary_from_rom(rom, config.bin_sections.overlay18) 
         
         if config.game_version == GAME_VERSION_EOS:
            if config.game_region == GAME_REGION_US:
                return read_u32(ov18, OFFSET_US) != ORIGINAL_INSTRUCTION 
                 
           
            
         raise NotImplementedError()

    def apply(self, apply: Callable[[], None], rom: NintendoDSRom, config: Pmd2Data) -> None:
         apply() # Apply the patch

    def unapply(self, unapply: Callable[[], None], rom: NintendoDSRom, config: Pmd2Data):
        raise NotImplementedError()
