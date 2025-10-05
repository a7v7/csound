; ************************************************************************
; ACCCI:      60_22_1C.ORC
; synthesis:  phase vocoder(60)
;             ktimpnt variable(22)
;             pointer control by LINE, snap1.pvc(1C)
; coded:      jpg 12/93


sr = 44100
kr  =  441
ksmps= 100
nchnls = 1


instr 1; *****************************************************************
idur = p3

   ktimpnt   line   .71, idur, .75
   aout      pvoc   ktimpnt, 1.0, "snap1.pvc"
             out    aout
endin

