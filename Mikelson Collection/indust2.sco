; SCORE
f1 0 8192 10 1      ; SINE

; PULSE TABLES
f10  0 1024   7  0 512 1 512 0
f11  0 1024   7  0 256 0 256 1 256 0 256 0
f12  0 1024   7  0 256 0 128 0 128 1 128 0 128 0 256 0
; RATE TABLES
f20  0 1024  -5  100  512  1000  512 100
f21  0 1024  -5  10  1024 1000
f22  0 1024  -5  100  512  10000 512  30
f23  0 1024  -5  25  1024  62
f24  0 1024  -7  500  1024  62
f25  0 1024  -5  5000 1024  1000
f26  0 1024  -7  50   512  500 512 50
f27  0 1024  -5  .5   512  2 512 .5
f28  0 1024  -5  .5   1024 4
f29  0 1024  -7  .5   250 .5 6 2 250 2 6 1 250 1 6 4 256 .5
; PAN TABLES
f30  0 1024  7  0  1024  1
f31  0 1024  7  1  1024  0
f32  0 1024  7  1 512  0 512 1
f33  0 1024  -7 .5 1024 .5
; MIX TABLES
f40  0 1024  5  .01 256 1 512 1 256 .01
f41  0 1024  5  .01 128 1 768 1 128 .01
f42  0 1024  5  1 1024 1
; LOOP TABLE
f50  0 1024 -7  .1 1024 .1
f51  0 1024 -7  .4 1024 .4

; FILTER FCO TABLE
f60  0 1024  -7 .01 512 4 512 .01
f61  0 1024  -5 .1 512 2 512 10
f62  0 1024  -5 .1 256 2 256 .5 256 10 256 .1
f63  0 1024  -5 .2 128 2 128 .2 128 3 128 .2 128 4 128 .2 128 5 128 .2

; GENERATE INDUSTRIAL LOOPS
;   Sta  Dur   Amp    Pitch  PulsTab  RtTab  RtRt  PanTab  MixTab  Loop   
i2   0   0.8  10000   9.00    12       21     2    32      42      50    

; GENERATE SCI-FI SOUNDS
;   Sta  Dur  Amp   Pitch  RtTab  RtRt  PanTab  MixTab  Loop  FMFqc FMAmp
i3  10   4   8000   8.00   27     1     31      41      .1    2     6
i3  15   8   7000   7.00   28     4     33      41      .2    2     3
i3  18   5   5000   8.00   29     3     30      41      .45   .5    4
i3  24   6   8000   8.05   27     1     31      40      .05   2.53  4
i3  28   4   4000   9.00   29     2     32      41      .3    1.21  7

; LOOP TABLES
f50 30 1024 -5  .41 50 .021 206 .45 56 .012 200 .58 56 .43 200 .025 56 .11 200 .32
; GENERATE INDUSTRIAL LOOPS
;   Sta  Dur  Amp   Pitch  PulsTab  RtTab  RtRt  PanTab  MixTab  Loop
;i4  30   32   6000  8.00   12       25     1     31      41      50

; LOOP TABLES
;f51 36 1024 -5  .11 50 .11 206 .15 56 .12 200 .18 56 .13 200 .15 56 .13 200 .12
; GENERATE INDUSTRIAL LOOPS
;   Sta  Dur  Amp   Pitch  PulsTab  RtTab  RtRt  PanTab  MixTab  Loop
;i4  36   12   6000  9.00   12       25     2     31      41      51

;f52 42 1024 -7  .21 50 .21 206 .15 56 .12 200 .028 56 .023 200 .015 56 .0041 200 .052
;   Sta  Dur  Amp   Pitch  PulsTab  RtTab  RtRt  PanTab  MixTab  Loop
;i4  42   32   4000  7.00   10       20     1     31      41      52

;f53 60 1024 -7  .12 512 .15 512 .24
;   Sta  Dur  Amp   Pitch  RtTab  RtRt  PanTab  MixTab  Loop  SoundIn
;i7  60   8    1     1      29     1     31      41      53    13

; GENERATE SCI-FI SOUNDS
;   Sta  Dur  Amp   Pitch  RtTab  RtRt  PanTab  MixTab  Loop  FMFqc FMAmp
;i6  68   4   8000   6.07   50     2     30      41      42    2     6
;i6  70   4   8000   8.00   29     2     31      41      42    2     6


