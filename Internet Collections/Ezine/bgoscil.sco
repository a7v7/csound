;-------------------------------------------------------------------------
; BEGINNERS OSCILLATOR DEMO
; BY HANS MIKELSON MARCH 1999
;-------------------------------------------------------------------------
f1 0 16384 10 1                                    ; SINE WAVE
f2 0 16384 10 1 .5 .333333 .25 .2 .166667 .142857 .125 .111111 .1 .090909 .083333 .076923   ; BANDLIMITED SAWTOOTH WAVE
f3 0 16384 10 1 0  .333333 0   .2 0       .142857 0    .111111 0  .090909 0       .076923   ; BANDLIMITED SQUARE WAVE
f4 0 16384 7  1 16385 -1                           ; ARITHMETIC SAWTOOTH WAVE
f5 0 16384 7  1 8192   1 0 -1 8192 -1              ; ARITHMETIC SQUARE WAVE
f6 0 1025  7  0 128 1 128 .8 256 .6 256 .6 257 0   ; ADSR TYPE ENVELOPE
f7 0 1025  7  0 13 1 1000 1 12 0                   ; SIMPLE ENVELOPE
; DETUNED BAND-LIMITED OSCILATORS WITH VIBRATO
;    Sta  Dur  Amp    Pitch  Table  Env
i1   0    .5   20000  8.00   1      6
i1   +    .5   .      8.03   1      .
i1   .    .5   .      8.05   1      .
i1   .    .5   .      8.00   1      .
i1   .    .5   .      7.00   2      .
i1   .    .5   .      8.00   2      .
i1   .    1    .      7.07   2      .
i1   .    .5   .      7.00   3      .
i1   .    .5   .      8.03   3      .
i1   .    .5   .      8.05   3      .
i1   .    .5   .      8.00   3      .
i1   .    .5   .      7.00   2      .
i1   .    .5   .      7.07   2      .
i1   .    1    .      7.00   2      .
; ALGEBRAIC SAW AND SQUARE WAVES
;    Sta  Dur  Amp    Pitch  Table  Env
i1   9    1    .      7.00   4      .
i1   +    .    .      8.00   4      .
i1   .    .    .      7.00   5      .
i1   .    .    .      8.00   5      .
; Sci Fi sound;    Sta  Dur  Amp    Pitch  Table  Env
i2  14    2    20000  8.00   2      7
i3  16    2    20000  7.07   3      7
; Panning sound effect
i4  18    2    20000  7.07   2      7
