; DONT FORGET TO FIX THE TABLES.

f1  0 8192 10 1
f2  0 1024  7 1 1024 1
; INSTRUMENT IN THE STYLE OF THE TB303 WITH BUILT IN SEQUENCER.

f10 0  1024   8  1  256 .2  128 0 256 -.2 256  -1

; DISTORTION TABLE
;----------------------------------------------------------------------
f7 0 1024   8 -.8 42 -.78  200 -.74 200 -.7 140 .7  200 .74 200 .78 42 .8

; 16 STEP SEQUENCER
;----------------------------------------------------------------------
; STEP          1     2     3     4     5     6     7     8     9     10    11    12    13    14    15    16
; PITCH TABLE
f120  0  16  -2  7.00  7.00  7.00  7.00  7.05  7.00  7.00  7.00  7.05  6.00  7.07  7.00  7.05  7.00  7.00  7.00
f120  4   8  -2  7.00  6.00  7.00  6.00  6.05  6.00  6.05  6.00  6.10  6.07  6.05  6.03  6.02  6.00  7.00  7.00

; DUR TABLE
f121  0 16  -2   .5    .5    .5    1     .5    1     1     .5    1     1     .5    .5    .5    .5    1     .5
f121  4 16  -2   .5    .5    .5    .5    .5    .5    1     .5    .5    .5    .5    .5    .5    1.5   1     2

; PANNING AMPLITUDE TABLE  22=LEFT 23=RIGHT
f122  0 16  -2   1     0     1     1     0     0     1     1    1     0     1     1     1     0     1     1
f123  0 16  -2   0     1     1     0     0     1     1     0    0     1     1     0     1     1     1     0

; SLIDE TABLE
f124  0  8  -2   0     0     0     1     0     0     0     1    0     0     0     0     1     0     0     0

; FREQUENCY SWEEP TABLE USED TO SIMULATE "REAL TIME" TWISTING OF THE KNOB.
f130  0  256  -7  50 128 2000 128 50
f130  1  256  -7  100 64 500 64 50 64 200 64 1000

; RESONANCE SWEEP TABLE USED TO SIMULATE "REAL TIME" TWISTING OF THE KNOB.
f131  0  256  -7  40 128 80 128 40


; DURATION
f21  0  8  -2  1     1     1     1     1     1     1     1
f25  0  8  -2  4     1     1     2     4     1     1     2
f29  0  8  -2  4     1     1     1     1     4     2     2

; DRUMS :  0=HIHAT, 1=TAP, 2=BASS, 3=KS SNARE, 4=SWEEP, 5=FMBOINK
f22  0  8  -2  0     1     0     1     2     1     0     1
f26  0  8  -2  4     3     3     2     4     2     3     4
f30  0  8  -2  4     2     1     5     4     5     5     4

; PANNING 
f23  0  8  -2   1    0     1     0     1     0     1     1
f24  0  8  -2   0    1     0     1     1     1     1     0

f27  0  8  -2   1    0     1     1     0     1     1     0
f28  0  8  -2   0    1     0     0     1     1     0     1

f31  0  8  -2   0    0     0     0     0     1     1     0
f32  0  8  -2   1    1     1     1     1     0     1     1

; DRUMS
;  STA  DUR AMP        TABLES
;                 DUR DRUM PANL PANR
i1 0    6   6000  21  22   23   24
i1 0    6   6000  25  26   27   28
i1 0    6   6000  29  30   31   32

; BASS
; ENVELOPED DISTORTION FILTER
;        DUR  AMP   WAVE  ACCENT  ENVDEPTH  FREQDECAY  AMPDECAY
i15  0   4    4000  10    0       1         .1         .5
i15  +   4    4000  10    0       .99       .2         .2
