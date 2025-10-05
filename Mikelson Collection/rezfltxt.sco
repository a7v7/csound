; ---------------------------------------------------------
; REZZY SYNTH
; CODED:  HANS MIKELSON 2/7/97
; ---------------------------------------------------------
; 1. TABLE BASED REZZY SYNTH
; 2. TABLE BASED PWM REZZY SYNTH
; 3. TABLE BASED REZZY SYNTH WITH DISTORTION
; 4. NOISE BASED REZZY SYNTH
; 5. BUZZ  BASED REZZY SYNTH
; 6. 4 POLE REZZY
;**********************************************************
; f1=SINE, f2=SQUARE, f3=SAWTOOTH, f4=TRIANGLE, f5=SQARE2 
;**********************************************************
f1   0    1024   10   1
f2   0    256    7    -1      128  -1   0    1    128  1
f3   0    256    7    1       256  -1
f4   0    256    7    -1      128  1    128  -1
f5   0    256    7    1       64   1    0    -1   192  -1
f6   0    8192   7    0       2048 0    0    -1   2048 -1   0    1    2048          1  0  0 2048 0

; DISTORTION TABLE
f7   0    1024   8    -.8     42   -.78 400  -.7  140  .7   400  .78  42   .8     

; SCORE ***************************************************

t    0    400

; PWM FILTER
;         DUR   AMP      PITCH     FILTER    CUT-OFF   RESONANCE      TABLE
i2        0     8        5000      8.05      100       20             2

; TABLE FILTER
;         DUR  AMP       PITCH     FILTER    CUT-OFF   RESONANCE      TABLE
i1        8    1         5000      8.02      90        30             3
i1        +    .         .         8.03      80        35             3
i1        .    .         .         8.00      70        40             3
i1        .    .         .         7.10      60        45             3

; DISTORTION FILTER
;         DUR  AMP       PITCH     FILTER    CUT-OFF   RESONANCE      TABLE
i3        12   1         5000      6.05      5         50             3
i3        +    .         <         6.02      <         .              3
i3        .    .         <         7.03      <         .              3
i3        .    .         <         6.05      <         .              3
i3        .    .         <         6.03      <         .              3
i3        .    .         <         6.03      <         .              3
i3        .    .         <         6.02      <         .              3
i3        .    .         8000      6.00      100       20             3

; FILTERED NOISE
i4        20   8         5000      100       100

; FILTERED BUZZ
i5        28   4         10000     8.03      100       20             10

; 4 POLE FILTER     
;    START     DUR  AMP  PITCH     FCO1      REZ1      FCO2 REZ2  TABLE   
i7   32        2    3000 8.00      70        20        50   10    3
i7   +         4    1800 8.03      60        22        60   12    2
