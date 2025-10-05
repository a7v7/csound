; TABLE FOR REED PHYSICAL MODEL
f1 0 256 7 1 80 1 156 -1 40 -1
f2 0 256 7 1 80 1 156 -1 40 -1

; TABLE FOR VIOLIN
;f4 0 256 7 0 40 0 50 1 76 1 50 0 40 0

f3 0 1024 10 1
;f4 0 1024 10 1 1 1 1 1 1

t 0 800

; PLUCKED STRING
;  START  DUR   AMP        PITCH
i1  0      2    30000      7.11
i1  +      .    30000      7.11
i1  .      .    30000      7.06
i1  .      .    30000      7.11
i1  .      .    30000      7.06
i1  .      .    30000      7.06
i1  .      .    30000      7.11
i1  .      4    30000      7.06

; PLUCKED BASS
;  START DUR    AMP        PITCH
i2  18    6     47000      5.11
i2  +     4     43000      6.11
i2  .     2     45000      6.06
i2  .     6     38000      5.11
i2  .     6     .          5.06
i2  .     6     .          5.09
i2  .     6     .          5.11
i2  .     6     47000      6.02

; CLARINET
;   START  DUR    AMP      PITCH   PRESS  FILTER     EMBOUCHURE  REED TABLE
;               (20000) (8.00-9.00) (0-2) (500-1200)   (0-1)      
i4    60    30    8000      8.11     1.8  1000         .2            1
i4    +     6     8000      7.11     1.8  1000         .2            1
i4    .     6     8000      9.02     1.8  1000         .2            1

; SLIDE FLUTE
;  START  DUR  AMPLITUDE PITCH  PRESSURE  BREATH
;i3  0      4    10000     8.00    1        .05
;i3  +      .    <         8.02    <         .
;i3  .      .    <         8.04    <         .
;i3  .      .    <         8.05    <         .
;i3  .      .    <         8.07    <         .
;i3  .      .   10000      8.09    1.2       .

