;---------------------------------------------------------------------------
; A MULTI-EFFECTS SYSTEM
;---------------------------------------------------------------------------
; 2. PLUCK
; 10. NOISE GATE
; 11. COMPRESSOR/LIMITER
; 12. DE-ESSER
; 13. TUBE AMP DISTORTION
; 15. RESONANT FILTER
; 16. WAH-WAH
; 17. TALK BOX
; 18. 3 BAND EQUALIZER
; 20. VIBRATO
; 21. TREMELO
; 22. PITCH SHIFTER
; 23. PANNER
; 30. STEREO FLANGER
; 31. CROSS FEEDBACK FLANGER
; 35. CHORUS
; 40. DELAY
; 45. REVERB

;---------------------------------------------------------------------------
; WAVEFORMS
;---------------------------------------------------------------------------
; SINE WAVE
f1 0 8192 10 1
; TRIANGLE WAVE
f2 0 8192 7     -1   4096 1 4096 -1
; TRIANGLE WAVE
f4 0 8192 7 0 4096 1 4096 0
; TUBE DISTORTION
f5 0 8192 7 -.8 934 -.79 934 -.77 934 -.64 1034 -.48 520 .47 2300 .48 1536 .48

;---------------------------------------------------------------------------
; STEREO DELAY
;---------------------------------------------------------------------------
i2  0.0  1.6  16000  7.00   0     1   1
i2  0.0  1.6  16000  8.07   0     1   2

; STEREO DELAY
;   STA  DUR  DELAY1  FEEDBK1  XFEEDBK1  DELAY2  FEEDBK2  XFEEDBK2  INCH1  INCH2  OUTCH1  OUTCH2
i40 0    2    .15     .1       .6        .25     .1       .6        1      2      3       4

; MIXER
;    STA DUR  CH1  GAIN  PAN  CH2  GAIN  PAN  CH3  GAIN  PAN  CH4  GAIN  PAN
i100 0   2    1    1     1    2    1     0    3    .8    1    4    .8    0

;---------------------------------------------------------------------------
; TREMELO/GATE
;---------------------------------------------------------------------------
i2  2.0  2    16000  7.00   0     1   1
i2  2.0  2    16000  7.07   0     1   1
i2  4.0  2    16000  7.00   0     1   1
i2  4.0  2    16000  7.07   0     1   1

; DISTORTION
;   STA  DUR  PREGAIN POSTGAIN  DUTYOFFSET  SLOPESHIFT  INCH  OUTCH
i13 2    4    1       1         1           1           1     2

; TREMELO
;   STA  DUR  AMP  FREQ  TABLE  PHASE INCH  OUTCH
i21 2.0  2    .9   4     1      0     2     3
i21 4.0  2    .9   4     3      0     2     3

; MIXER
;    STA DUR  CH1  GAIN  PAN  CH2  GAIN  PAN  CH3  GAIN  PAN  CH4  GAIN  PAN
i100 2   4    3    1     1    3    1     0    4    0     1    5    0    0


;---------------------------------------------------------------------------
; PANNER
;---------------------------------------------------------------------------
i2  6.0  2    16000  7.00   0     1   1
i2  6.0  2    16000  7.07   0     1   1
i2  8.0  2    16000  7.00   0     1   1
i2  8.0  2    16000  7.07   0     1   1

; DISTORTION
;   STA  DUR  PREGAIN POSTGAIN  DUTYOFFSET  SLOPESHIFT  INCH  OUTCH
i13 6    4    1       1         1           1           1     2

; TREMELO
;   STA  DUR  AMP  FREQ  TABLE  PHASE INCH  OUTCH1  OUTCH2
i23 6.0  2    .9   4     1      0     2     3       4
i23 8.0  2    .9   4     3      0     2     3       4

; MIXER
;    STA DUR  CH1  GAIN  PAN  CH2  GAIN  PAN  CH3  GAIN  PAN  CH4  GAIN  PAN
i100 6   4    3    1     1    4    1     0    4    0     1    5    0    0

;---------------------------------------------------------------------------
; REVERB
;---------------------------------------------------------------------------
i2  10.0  .2   16000  7.00   0     1   1
i2  10.0  .2   16000  7.07   0     1   1
i2  10.6  .2   16000  7.00   0     1   1
i2  10.6  .2   16000  7.05   0     1   1
i2  11.2  .6   16000  6.10   0     1   1
i2  11.2  .6   16000  7.07   0     1   1

; DISTORTION
;   STA  DUR  PREGAIN POSTGAIN  DUTYOFFSET  SLOPESHIFT  INCH  OUTCH
i13 10   2    1       1         1           1           1     2

; STEREO DELAY
;   STA  DUR  DELAY1  FEEDBK1  XFEEDBK1  DELAY2  FEEDBK2  XFEEDBK2  INCH1  INCH2  OUTCH1  OUTCH2
i40 10   3    .15     .3       .2        .25     .4       .2        2      2      3       4

; REVERB
;   STA  DUR  REVTIME  HIFDIFF  INCH  OUTCH
i45 10   4    3        .3       2     5
i45 10   4    2.8      .6       2     6

; SUBMIX
;   STA  DUR  INCH1  GAIN1  INCH2  GAIN2  OUTCH
i50 10   4    2      .5     3      .2     7
i50 10   4    2      .5     4      .2     8

; MIXER
;    STA DUR  CH1  GAIN  PAN  CH2  GAIN  PAN  CH3  GAIN  PAN  CH4  GAIN  PAN
i100 10  4    7    1     1    8    1     0    5    .8    1    6    .8    0

;---------------------------------------------------------------------------
; ENHANCER
;---------------------------------------------------------------------------
i2  14.0  2.0  16000  6.10   0     1    1
i2  14.1  1.9  12000  7.07   .     .    .
i2  14.2  1.8  13000  8.00   .     .    .
i2  14.3  1.7  10400  8.05   .     .    .

; ENHANCER
;   STA  DUR  LOGAIN  MIDGAIN  HIGAIN  LOFCO  HIFCO  DELLOW  DELMID  DELHI  INCH  OUTCH
i9  14   2    1.0     1.0      1.0     200    2000   .01     .03     .08    1     2

; MIXER
;    STA DUR  CH1  GAIN  PAN  CH2  GAIN  PAN  CH3  GAIN  PAN  CH4  GAIN  PAN
i100 14  2    2    1.8   .5   3    0     .5   3    0     1    3    0     0

;---------------------------------------------------------------------------
; RING MODULATOR
;---------------------------------------------------------------------------
i2  16.0  2.0  16000  6.00   0     1    1
i2  16.0  2.0  16000  7.00   0     1    2

; RING MOD
;    STA  DUR  INCH1  INCH2  OUTCH
i24  16   2    1      2      3

; MIXER
;    STA DUR  CH1  GAIN  PAN  CH2  GAIN  PAN  CH3  GAIN  PAN  CH4  GAIN  PAN
i100 16  2    3    2     .5   3    0     .5   3    0     1    3    0     0

