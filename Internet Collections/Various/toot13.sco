                                             ; TOOT13.SCO
f1  0  8192  10  1                           ; SINE WAVE
f2  0  2048  19  .5  1  270 1                ; SINE QUADRANT RISE

;  pluckamp = p6     -  % OF TOTAL AMPLITUDE, 1=DB AMP AS SPECIFIED IN P4
;  pluckdur = p7*p3  -  % OF TOTAL DURATION, 1=ENTIRE DURATION OF NOTE

;  fmamp =  p8       -  % OF TOTAL AMPLITUDE, 1=DB AMP AS SPECIFIED IN P4
;  fmrise = p9*p3    -  % OF TOTAL DURATION, 1=ENTIRE DURATION OF NOTE
;  fmdec = p10*p3    -  % OF TOTAL DURATION
;  index = p11       -  NUMBER OF SIGNIFICANT SIDEBANDS: P11 + 2
;  vibdepth = p12
;  vibrate = p13
;  formantamp = p14  -  % OF TOTAL AMPLITUDE, 1=DB AMP AS SPECIFIED IN P4
;  formantrise = p15*p3  - % OF TOTAL DURATION, 1=ENTIRE DURATION OF NOTE
 f0 1
 f0 2
 f0 3
 f0 4
 f0 6
 f0 7
 f0 8
 f0 9
 f0 10
 f0 11
 f0 12
 f0 14
 f0 15
 f0 16
 f0 17
 f0 18
 f0 19
 f0 20
 f0 21
 f0 22
 f0 23
 f0 24
 f0 25
;ins st dur   amp frq  plkmp    plkdr  fmmp  fmrs fmdc indx vbdp vbrt frmp fris
i13  0   5    80  200  .8      .3       .7   .2 .35    8     1      5      3     .5
i13  5   8    80  100  .        .4       .7  .35    .35    7     1      6      3     .7
i13 13  13    80   50   .        .3       .7     .2 .4      6     1     4      3     .6
 e
