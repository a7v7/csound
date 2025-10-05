; TABLE FOR REED PHYSICAL MODEL
f1 0 256 7 1 80 1 156 -1 20 -1

; SINE
f3 0 1024 10 1

t 0 600

; PLUCKED BASS
;  START DUR    AMP        PITCH  PLUCKDUR
i2  0    4    1400        6.00     .25
i2  +    2    1200        6.01     .25
i2  .    4    1000        6.05     .5
i2  .    2     500        6.04     1
i2  .    4    1000        6.03     .5
i2  .   16    1000        6.00     .5

; SLIDE FLUTE
;  START  DUR  AMPLITUDE PITCH  PRESSURE  BREATH  FEEDBK1  FEEDBK2
i3  32    16   6000      8.00    .9      .036     .4       .4
i3  +      4    .        8.01    .95         .       .        .
i3  .      4    .        8.03    .97     .       .        .
i3  .      4    .        8.04    .98       .       .        .
i3  .      4    .        8.05    .99      .       .        .
i3  .     16    .        9.00    1.0         .       .        .

; CLARINET
;   START  DUR    AMP      PITCH   PRESS  FILTER     EMBOUCHURE  REED TABLE
;               (20000) (8.00-9.00) (0-2) (500-1200)   (0-1)      
i4   80    16     6000      8.00     1.5  1000         .2            1
i4    +     4     .         8.01     1.8  1000         .2            1
i4    .     2     .         8.03     1.6  1000         .2            1
i4    .     2     .         8.04     1.7  1000         .2            1
i4    .     2     .         8.05     1.7  1000         .2            1
i4    .     2     .         8.07     1.7  1000         .2            1
i4    .     4     .         8.10     1.7  1000         .2            1
i4    .    16     .         9.00     1.8  1000         .2            1


; DRUM 1
;  START  DUR  AMP    PITCH PREFILTER  TUBELENGTH  FEEDBACK1  FEEDBACK2  LENGTH  WIDTH
; WOOD BLOCK
i9 128    1  500     9.00   1000           4          3.0       4.8       1       .5
i9  +     1  500     9.00   1000           4          3.0       4.8       1       .5
; BELL
i9  .     4  500     8.05   1500           4          3.1       4.1       1       .2 
i9  .     4  400     8.00   1500           4          3.1       4.1       1       .2 
; HEAVY GLASS
i9  .     2  450     8.05   700            4          3.2       4.5       1       .5 
; RESONANT TONE
i9  .     .  500     8.05  1500            4          3.1       4.0       1       .8 
i9  .     .  .       8.05  1500            4          3.1       4.0       1       .8 
; LATIN DRUM
i9  .     .  .       8.00  1000            4          3.2       4.3       1       .7

; DRUMSTICK
;  START  DUR  AMP  PITCH  PREFILTER
; WOOD BLOCK
i8 128     1   2    9.00      400
i8  +      1  1.5   9.00     400
; BELL
i8  .      4  .7    9.06      700
i8  .      4  .7    9.00      700
; HEAVY GLASS
i8  .      2   1.7   10.00      600
; RESONANT TONE
i8  .      2  1.2    9.06      600
i8  .      2  1.1    8.06      700
; LATIN DRUM
i8  .      2  .5     7.06      850
