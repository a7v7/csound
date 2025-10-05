;---------------------------------------------------------------------
; TERRAIN MAPPING
; COMPOSITION BY HANS MIKELSON FEBRUARY 1998
; ALL INSTRUMENTS IN THIS COMPOSITION WERE BASED ON TERRAIN MAPPING.
;---------------------------------------------------------------------

f1 0 8192 10 1                     ; SINE
f2 0 1024 -7 0 512 1 512 0         ; FADEIN/OUT/PANRLR
f4 0 1024 -7 1 1024 1              ; CONST 1

;--------------------------------------------------------
; SQUARISH LEAD WITH STEREO DETUNE
;--------------------------------------------------------
;    Sta  Dur   Amp  Fqc   Phase  OutKCh
i3   0    16.0  1    .3    0      4
i3   0    16.0  1    .7    0      5
;    Sta  Dur   Amp    Pitch  ModCh  Petals  Detune  FadeInOut
i14  0    6     6000   5.07   4      4.00    .004    2
i14  4    .     .      7.00   5      4.22    .       .
i14  7    .     .      8.05   4      3.00    .       .
i14  10   .     .      6.10   5      4.01    .       .

;---------------------------------------------------------------------
; CLEAR ZAK
;---------------------------------------------------------------------
;     Sta  Dur
i99   0    16

