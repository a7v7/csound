;------------------------------------------------------------------------------
; HEAVY GUITAR BY HANS MIKELSON
;------------------------------------------------------------------------------
f1 0 8192 10 1
f2 0 8192 11 20

; PLUCK
;    Sta  Dur  Amp    Pitch  Table  OutCh
i1   0    .4  10000  7.00   0      1
i1   0    .4  10000  7.07   .      .
;i1   0    .4  10000  8.05   .      .

; DISTORTION
;    Sta  Dur  PreGain  PostGain  Shape1  Shape2  InCh  OutCh  Output
i10  0    .4   1        .5        .01     0       1     2      .5

; AUTO-WAH
;    Sta  Dur  Rate  Depth  MinFqc  FmntMix  WaveShape  InCh
i16  0    .4   1.25  4000   200     .5       1          2

; ZAK CLEAR
i99  0    .4

