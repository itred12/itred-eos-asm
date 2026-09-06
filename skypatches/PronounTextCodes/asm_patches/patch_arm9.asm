.org BranchCallToFailedPTag
.area 0x4 ; 4 bytes per opcode
    beq HookPLetter ; Instead of erroring if the check for the last P tag fails, go to our custom function first
.endarea
