; INSTRUMENT IN THE STYLE OF THE TB303 WITH BUILT IN SEQUENCER.

f10 0  1024   8  1  256 .2  128 0 256 -.2 256  -1

; DISTORTION TABLE
;----------------------------------------------------------------------
f7 0 1024   8 -.8 42 -.78  200 -.74 200 -.7 140 .7  200 .74 200 .78 42 .8

; 16 STEP SEQUENCER
;----------------------------------------------------------------------
; STEP          1     2     3     4     5     6     7     8     9     10    11    12    13    14    15    16
; PITCH TABLE
f20  0  16  -2  7.00  7.00  7.00  7.00  7.05  7.00  7.00  7.00  7.05  6.00  7.07  7.00  7.05  7.00  7.00  7.00
f20  4   8  -2  7.00  6.00  7.00  6.00  6.05  6.00  6.05  6.00  6.10  6.07  6.05  6.03  6.02  6.00  7.00  7.00

; DUR TABLE
f21  0 16  -2   .5    .5    .5    1     .5    1     1     .5    1     1     .5    .5    .5    .5    1     .5
f21  4 16  -2   .5    .5    .5    .5    .5    .5    1     .5    .5    .5    .5    .5    .5    1.5   1     2

; PANNING AMPLITUDE TABLE  22=LEFT 23=RIGHT
f22  0 16  -2   1     0     1     1     0     0     1     1    1     0     1     1     1     0     1     1
f23  0 16  -2   0     1     1     0     0     1     1     0    0     1     1     0     1     1     1     0

; SLIDE TABLE
f24  0  8  -2   0     0     0     1     0     0     0     1    0     0     0     0     1     0     0     0

; FREQUENCY SWEEP TABLE USED TO SIMULATE "REAL TIME" TWISTING OF THE KNOB.
f30  0  256  -7  50 128 2000 128 50
f30  1  256  -7  100 64 500 64 50 64 200 64 1000

; RESONANCE SWEEP TABLE USED TO SIMULATE "REAL TIME" TWISTING OF THE KNOB.
f31  0  256  -7  40 128 80 128 40

; SCORE
;----------------------------------------------------------------------
; ENVELOPED DISTORTION FILTER
;        Dur  Amp   Wave  Accent  EnvDepth  FreqDecay  AmpDecay
i15  0   4    6000  10    0       1         .1         .5
i15  +   4    6000  10    0       .99       .2         .2
