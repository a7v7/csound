;---------------------------------------------------------------------------
; TEKNOBUBBLE
; THIS SONG IS BASED AROUND DRUM MACHINE AND SEQUENCER BASED SOUNDS.
; CODED: FEBRUARY-MAY 1998 BY HANS MIKELSON
;---------------------------------------------------------------------------
f1  0 8193 10 1              									; Sine
f2  0 1025  7 1  1025 1      									; 1?
f3  0 1025 -7 10  1025 10    									; Speed
f4  0 1025 10 1  0  .333  0  .2  0  .143  0 .111  0   .0909  	; Square ?

f90 0 1025 -7 0  1025 1   										; Ramp, FadeIn, PanRL
f91 0 1025 -7 1  1025 0   										; Saw, FadeOut, PanLR
f92 0 1025 -7 1  1025 1   										; Const 1, PanL
f93 0 1025 -7 .5 1025 .5  										; Const .5, PanC
f94 0 1025 -7 0  1025 0   										; Const 0, PanR
f95 0 1025 -7 .8  513 .2 512 .8   								; PanRLR
f96 0 1025 -7 .2  513 .8 512 .2   								; PanLRL
f97 0 1025 -7 1   1025 .7         								; FadeDown
f98 0 1025 -7 .5  1025 1          								; FadeUp
f99 0 1025 -7 0  513 1 512 1      								; FadeIn & Hold

;---------------------------------------------------------------------------
; WARBLE FIFTHS
;---------------------------------------------------------------------------
f62  0 1025 -7 2500 256 800 256 3000 256 700 256 2500 			; Fco Envelope
f56  0 16  -2  1     1     1     1     1     1     1     1     1     1     1     1     1     1     1     1    ;  Duration
f57  0 16  -2  7.03  8.03  7.02  8.07  7.00  8.00  7.11  8.07  7.00  8.00  7.11  7.07  7.02  7.03  7.07  7.09 ;  Pitch
f58  0 16  -2  1     1     1     1     1     1     1     1     1     1     1     1     1     1     1     1    ;  Accent
f59  0 16  -2  1     1     1     1     1     1     1     1     1     1     1     1     1     1     1     1    ;  Amp
; ENVELOPE
;    Sta  Dur   Amp  Rate  Table  OutKCh
i5   0    12.8  1    1     62     4
i5   0    12.8  8    1     92     5
; WARBLE FIFTHS
;    Sta    Dur   Amp   DurTab  DrumTab  Accent  AmpTab  Speed  Steps  FcoKCh  RezKCh  OutCh  Distort
i41  0      12.8  12000 56      57       58      59      3      16     4       5       6      15
; MIXER
;    Sta   Dur   Amp  Ch  Pan  Fader
i190 0     12.8  2    6   93   92
; CLEAR ZAK
;    Sta  Dur
i195  0    12.8

