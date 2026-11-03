# EditStatusDuration
Allows for editing the minimum/maximum duration of status effects not listed in the Symbols tab.
Can be applied more than once to modify these to these ranges again.

## NOTES:
- The minimum range for statuses is inclusive, and the maximum range is exclusive. Setting a status to have a minimum of 3 turns and a maximum of 5 turns means it'll effect the target for anywhere from 3 - 4 turns. (Source: CalcStatusDuration, DungeonRandRange)

- Setting a minimum greater than its maximum will effectively swap them– the minium becomes the maximum and vice-versa, including the exclusive/inclusive range rule mentioned above. (Source: DungeonRandRange)

- A minimum and maximum equal to each-other will have the corrosponding status always be inflicted for that duration (i.e.,  a range of [10, 10) will just become 10 turns). (Source: DungeonRandRange)
    
- The maximum range you can set a status to is 127, which makes it last forever. (Source: TickStatusTurnCounter)

- The minimum range you can set a status to is 1, which makes it fade on the turn after it was inflicted. (Source: CalcStatusDuration, most XREFs to CalcStatusDuration)
