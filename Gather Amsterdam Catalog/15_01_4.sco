; ************************************************************************
; ACCCI:     15_01_4.SCO
; coded:     jpg 8/92


; GEN functions **********************************************************
; "Sflib/10_02_1.aiff" contains random noise with center frequency 'fqr'
; changing each second...

;       size GEN  inputfile            start
f71  0  1024  1   "Sflib/10_02_1.aiff"    .2    0  0         ; fqr = 10000
f72  0  1024  1   "Sflib/10_02_1.aiff"   1.2    0  0         ; fqr =  5000
f73  0  1024  1   "Sflib/10_02_1.aiff"   2.2    0  0         ; fqr =  2500
f74  0  1024  1   "Sflib/10_02_1.aiff"   3.2    0  0         ; fqr =  2000
f75  0  1024  1   "Sflib/10_02_1.aiff"   4.2    0  0         ; fqr =  1000
f76  0  1024  1   "Sflib/10_02_1.aiff"   5.2    0  0         ; fqr =   500
f77  0  1024  1   "Sflib/10_02_1.aiff"   6.2    0  0         ; fqr =   250
f78  0  1024  1   "Sflib/10_02_1.aiff"   7.2    0  0         ; fqr =   125
f79  0  1024  1   "Sflib/10_02_1.aiff"   8.2    0  0         ; fqr =    50
f80  0  1024  1   "Sflib/10_02_1.aiff"   9.2    0  0         ; fqr =    25


; score ******************************************************************

;            iamp    ipch  ibuf   if1    if2    igliss
i1  0   .5   8000    8.00  1024   73     75       3         ; major second
i1  1   .5   .       8.02  1024   73     75       4         ; no name

e
