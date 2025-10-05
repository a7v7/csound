f1 0 8192 10 1                     ; SINE
f2 0 1024 -7 0 512 1 512 0         ; FADEIN/OUT/PANRLR
f4 0 1024 -7 1 1024 1              ; CONST 1

;   Sta  Dur  Amp  Fqc   Phase  OutKCh
i3  0.0  4.0  .15  .25   0      5
i3  2    6.0  .15  .50   .5     6
i3  6   12.0  .15  .25   0      7
;
f85 0 1024 -7 1 1024 0             ; PANLR
f86 0 1024 -7 0 1024 1             ; PANLR
f75 0 1024 -7 0 256 1 512 1 256 0 ; FadeInOut
;    Sta  Dur  Amp    Freq  ModCh  Pan  Fader
i8   0    4.0  30000  4.0   5      85   75
i8   2    6.0  50000  8.0   6      86   75
i8   6   12.0  50000 16.0   7      86   75

