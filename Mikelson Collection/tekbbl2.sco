;---------------------------------------------------------------------------
; TEKNOBUBBLE
; THIS SONG IS BASED AROUND DRUM MACHINE AND SEQUENCER BASED SOUNDS.
; CODED: FEBRUARY-MAY 1998 BY HANS MIKELSON
;---------------------------------------------------------------------------

t0  60

f1  0 8193 10 1                                                  ; SINE
f2  0 1025  7 1  1025 1                                          ; 1?
f3  0 1025 -7 8  1025 8                                          ; SPEED
f4  0 1025 10 1  0  .333  0  .2  0  .143  0 .111  0   .0909      ; SQUARE ?

f90 0 1025 -7 0  1025 1                      ; RAMP, FADEIN, PANRL
f91 0 1025 -7 1  1025 0                      ; SAW, FADEOUT, PANLR
f92 0 1025 -7 1  1025 1                      ; CONST 1, PANL
f93 0 1025 -7 .5 1025 .5                     ; CONST .5, PANC
f94 0 1025 -7 0  1025 0                      ; CONST 0, PANR
f95 0 1025 -7 .8  513 .2 512 .8              ; PANRLR
f96 0 1025 -7 .2  513 .8 512 .2              ; PANLRL
f97 0 1025 -7 1   1025 .7                    ; FADEDOWN
f98 0 1025 -7 .5  1025 1                     ; FADEUP
f99 0 1025 -7 0  513 1 512 1                 ; FADEIN & HOLD

;---------------------------------------------------------------------------
; DRUMS
;---------------------------------------------------------------------------
; ENVELOPE
f11  0 1025 -7 .4  256 3 513 6.2             ; ACCENT ENVELOPE
;   STA  DUR  AMP  RATE  TABLE  OUTKCH
i5  0    6    1    1     10     2
; DRUMS :  0=HIHAT, 1=TAP, 2=BASS, 3=KS SNARE, 4=FMBOINK, 5=SWEEP, 6=RINGMOD1
f26  0 16  -2  1     1     1     1     1     1     1     1       ; DURATION
f27  0 16  -2  0     0     0     0     0     0     0     0       ; DRUM
f28  0 16  -2  4     3.5   2.5   3     2.8   1.6   4     3.5     ; ACCENT
f29  0 16  -2  2     1.8   1.5   1.4   1.2   1.0   0     0       ; AMP
f30  0 16  -2  0     1.0   1.2   1.4   1.5   1.8   2     2       ; AMP
;   STA  DUR  AMP  DURTAB  DRUMTAB  ACCENT  AMPTAB  SPEED  STEPS  INKCH  OUTCH
i30 0    6   8000  26      27       28      29      3      8      2      3
i30 0    6   8000  26      27       28      30      3      8      2      4
; MIXER
;    STA  DUR  AMP  CH  PAN  FADER
i190 0    6    1    3   92   92
i190 0    6    1    4   94   92

;---------------------------------------------------------------------------
; DRUMS
;---------------------------------------------------------------------------
; ENVELOPE
f10  0 1025 -7 .4  256 3 256 .2 513 6.2                          ; ACCENT ENVELOPE
;   STA  DUR  AMP  RATE  TABLE  OUTKCH
i5  0    6    1    1     10     1
; DRUMS :  0=HIHAT, 1=TAP, 2=BASS, 3=KS SNARE, 4=FMBOINK, 5=SWEEP, 6=RINGMOD1
f21  0 16  -2  1     1     1     1     2     1     2     1     2     2     2    ; DURATION
f22  0 16  -2  5     5     5     5     5     5     5     5     5     5     5    ; DRUM
f23  0 16  -2  4     3.5   2.5   3     2.8   1.6   4     3.5   2.5   3     3    ; ACCENT
f24  0 16  -2  1.3   0     1.2   1.1   1     0     0     0     0     0     0    ; AMP
f25  0 16  -2  1.3   0     .5    1.1   1     0     0     0     0     0     0    ; AMP
;   STA  DUR  AMP  DURTAB  DRUMTAB  ACCENT  AMPTAB  SPEED  STEPS  INKCH  OUTCH
i30 0    6   8000  21      22       23      24      3      12     1      1
i30 0    6   8000  21      22       23      25      3      12     1      2
; MIXER
;    STA  DUR  AMP  CH  PAN  FADER
i190 0    6    1    1   92   92
i190 0    6    1    2   94   92


; CLEAR ZAK
;     STA  DUR
i195  0    6

