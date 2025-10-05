;---------------------------------------------------------------------------
; NOISE FEEDBACK
;---------------------------------------------------------------------------
;   Sta  Dur  Amp    OutCh  
i4  0.0  4.0  10000  1

; COMPRESSION CURVE
f6 0 1025 7 1 128 1 128 .8 256 .6 256 .1 257 .01

; FEEDBACK
;   Sta  Dur  PrAmp  PstAmp  Duty  D-Tab  Res  Delay  Fdbk  C-Tab  InCh  OutCh
i14 0    4    1      1       1     5      440  .02    1.4   6      1     3

; MIXER
;     Sta  Dur  Ch1  Gain  Pan  Ch2  Gain  Pan
i100  0    4    1    2     .5   3    2     .5

; CLEAR CHANNELS
;     Sta  Dur
i110  0    4

