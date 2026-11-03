#  Copyright 2025-2026 Chesyon
#
#  This source code is licensed under the MIT license: https://github.com/Chesyon/chesyon-eos-asm/blob/main/LICENSE_MIT
#  However, the distribution is licensed under GPLv3: https://github.com/Chesyon/chesyon-eos-asm/blob/main/LICENSE_GPLv3
#  For a non-legalese version of what this means, see https://chesyon.me/eos-licenses.html.

# For your own patches, you will want to remove the above legal notice in favor of your own (unless you're the template author, me, Chesyon). Do keep in mind that you at the very least must distribute under GPLv3, as this file uses skytemple-files. You can probably get away with just having the following:
# Copyright [year] [your name]
# This patch is distributed under GPLv3: https://www.gnu.org/licenses/gpl-3.0.html

from typing import Callable

from ndspy.rom import NintendoDSRom

from skytemple_files.common.util import read_u32, get_binary_from_rom
from skytemple_files.common.ppmdu_config.data import Pmd2Data, GAME_VERSION_EOS, GAME_REGION_EU, GAME_REGION_US, GAME_REGION_JP
from skytemple_files.patch.category import PatchCategory
from skytemple_files.patch.handler.abstract import AbstractPatchHandler#, DependantPatch # <- uncomment this if the patch uses overlay 36.
from skytemple_files.common.i18n_util import f, _

# the following variables are used in the is_applied check below.
# hex representation of the instruction you're overwriting. note that in ghidra the bytes are shown in reverse order! ex: 58 07 c1 05 -> 0x05C10758
ORIGINAL_INSTRUCTION = 0x05C10758
# address of the instruction you're overwriting minus the start point of the overlay'
#OFFSET_EU = 0x22ED1C8-0x22DCB80


OVERLAY10_START = 0x22BCA80

# Tryin something...
# Treat patch as unapplied if all statuses are set back to their defaults (it does literally nothing else)
def AnyStatusModified(binary) -> bool:
    status_addresses: dict[int, int] = {
        0x22C4830: 0x000A000A, # Cross-eyed: [10, 10)
        0x22c4828: 0x000A000A, # Blinker: [10, 10)
        0x22C47A0: 0x007F007F, # Petrified (NPC): [127, 127)
        0x22C479C: 0x0014000A, # Petrified (Player): [10, 20)
        0x22C4894: 0x00020001, # Paralysis: [1, 2)
        0x22C487C: 0x00320028, # Dropeye: [40, 50)
        0x22C47C8: 0x001E0014, # Invisible: [20, 30)
        0x22C4804: 0x00060004, # Infatuated: [4, 6)
        0x22C47d8: 0x000A000A, # Encore: [10, 10)
        0x22C47BC: 0x000C000A, # Taunt: [10, 12)
    }
    
    for addr, value in status_addresses.items():
        if read_u32(binary, addr - OVERLAY10_START) != value:
            return True
        
    return False
    


class PatchHandler(AbstractPatchHandler):
#class PatchHandler(AbstractPatchHandler, DependantPatch): # If the patch uses overlay 36, comment the above line and uncomment this line.

    @property
    def name(self) -> str:
        return 'EditStatusDuration'

    @property
    def description(self) -> str:
        return '''
Allows for editing the minimum/maximum duration of status effects not listed in the Symbols tab.
Can be applied more than once to modify these to these ranges again.

NOTES:
- The minimum range for statuses is inclusive, and the maximum range is exclusive. Setting a status to have a minimum of 3 turns and a maximum of 5 turns means it'll effect the target for anywhere from 3 - 4 turns.

- Setting a minimum greater than its maximum will effectively swap them– the minium becomes the maximum and vice-versa, including the exclusive/inclusive range rule mentioned above.

- A minimum and maximum equal to each-other will have the corrosponding status always be inflicted for that duration (i.e.,  a range of [10, 10) will just become 10 turns).
    
- The maximum range you can set a status to is 127, which makes it last forever.    

- The minimum range you can set a status to is 1, which makes it fade on the turn after it was inflicted.
    '''

# (Note 1 source: CalcStatusDuration, DungeonRandRange)
# (Note 2 source: DungeonRandRange)
# (Note 3 source: DungeonRandRange)
# (Note 4 source: TickStatusTurnCounter)
# (Note 5 source: CalcStatusDuration)
# (Note 6 source: most XREFs to CalcStatusDuration)


    @property
    def author(self) -> str:
        return 'Itred12'

    @property
    def version(self) -> str:
        return '1.0.0'

    # Uncomment the below lines if the patch uses overlay 36.
    #def depends_on(self) -> list[str]:
        #return ["ExtraSpace"] # (if the patch has any additional dependencies, those can be listed here too. ex: ["ExtraSpace", "ExpandPokeList", "TeamStatsPain"])

    # Change all instances of overlay29 in this function to the desired overlay to check.
    def is_applied(self, rom: NintendoDSRom, config: Pmd2Data) -> bool:
         ov10 = get_binary_from_rom(rom, config.bin_sections.overlay10)
         if config.game_version == GAME_VERSION_EOS:
            
            if config.game_region == GAME_REGION_US:
                return AnyStatusModified(ov10)
            
         raise NotImplementedError()

    def apply(self, apply: Callable[[], None], rom: NintendoDSRom, config: Pmd2Data) -> None:
         apply() # Apply the patch

    def unapply(self, unapply: Callable[[], None], rom: NintendoDSRom, config: Pmd2Data):
        raise NotImplementedError()
