; Overlay 25 (Xatu appraisal)
.org XATU_ENTRYPOINT_IMMEDIATE
.area 0x4
    bl GETMON_APPRAISAL_XATU_R3
.endarea

org XATU_MAYBEINIT_IMMEDIATE
.area 0x4
    bl GETMON_APPRAISAL_XATU_R1
.endarea