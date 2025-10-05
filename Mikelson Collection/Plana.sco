f1 0 8192 10 1          ; SINE

; SPHERICAL LISSAJOUS
;    Sta  Dur  Amp    Frqc   U    V     OutX  OutY  OutZ
i5   0    .6   5000   7.04   3    2     1     2     3
i5   +    .4   6000   5.11   5.6  .4    .     .     .
i5   .    .4   .      6.07   2    8.5   .     .     .
i5   .    .2   4500   6.02   4    5     .     .     .

; PLANAR ROTATION
; 1=X-Y PLANE, 2=X-Z PLANE, 3=Y-Z PLANE
;    Sta  Dur  Fqc  Phase  Plane  InX  InY  InZ  OutX  OutY  OutZ
i50  0    1.6  1.5  0      2      1    2    3    4     5     6
i50  0    1.6  1.8  0      3      4    5    6    7     8     9

; MIXER
;    Sta  Dur  In1  In2
i100 0    1.6   4    6
