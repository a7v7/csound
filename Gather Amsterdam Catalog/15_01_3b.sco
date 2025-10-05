; ************************************************************************
; ACCCI:     15_01_3B.SCO
; coded:     jpg 8/92


; GEN functions **********************************************************
; "Sflib/10_02_1.aiff" contains random noise with center frequency 'fqr'
; changing each second...

;       size GEN  inputfile            start
f73  0  1024  1   "Sflib/10_02_1.aiff"   2.2     0   0       ; fqr =  2500


; score ******************************************************************

;            iamp    ifq   ibuf  if1
i1   0   1   8000    220   1024  73
i1   1    .1  .     2490   .     .
i1   1.1  .1  .     2200   .     .
i1   1.2  .1  .      235   .     .
i1   2    .5  .     7800   .     .

e


