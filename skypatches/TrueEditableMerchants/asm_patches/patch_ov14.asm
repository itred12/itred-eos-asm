; Overlay 14 (Sentry duty)

.org LOUDRED_HWORD
.area 0x4
    .word SENTRY_DUTY_LOUDRED
.endarea

.org CHATOT_HWORD
.area 0x4
    .word SENTRY_DUTY_CHATOT
.endarea

.org GROVYLE_HWORD
.area 0x4
    .word SENTRY_DUTY_GROVYLE
.endarea

.org IMMEDIATE_DIGLETT_END
.area 0x4
    bl GETMON_SENTRY_DUTY_DIGLETT
.endarea

.org IMMEDIATE_DIGLETT_SORRYTOKEEPYOUWAITING ; It's my sentryona!
.area 0x4
    bl GETMON_SENTRY_DUTY_DIGLETT
.endarea

