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
; HEAVY DISTORTION
;---------------------------------------------------------------------------
i2  0.0  1.6  16000  7.00   0     1   1
i2  0.2  1.4  12000  7.05   .     .   .
i2  0.4  1.2  10400  8.00   .     .   .
i2  0.6  1.0  12000  8.05   .     .   .
i2  0.8  0.8  16000  7.00   .     .   .
i2  1.0  0.6  12000  7.05   .     .   .
i2  1.2  0.4  10400  8.00   .     .   .
i2  1.4  0.2  12000  8.05   .     .   .

; TUBE DISTORTION
f5 0 8192 7 -.8 934 -.79 934 -.77 934 -.64 1034 -.48 520 .47 2300 .48 1536 .48

; TUBE AMP
;   STA  DUR  PREGAIN POSTGAIN  DUTYOFFSET  SLOPESHIFT  INCH  OUTCH
i13 0    1.6  1       1         1           1           1     2

; MIXER
;    STA DUR  CH1  GAIN  PAN  CH2  GAIN  PAN  CH3  GAIN  PAN  CH4  GAIN  PAN
i100 0   2    2    1     1    2    1     0    6    0     1    7    0     0

;---------------------------------------------------------------------------
; HEAVY DISTORTION WITH CHORUS
;---------------------------------------------------------------------------
i2  2.0  1.6  16000  7.00   0     1    1
i2  2.2  1.4  12000  7.05   .     .    .
i2  2.4  1.2  10400  8.00   .     .    .
i2  2.6  1.0  12000  8.05   .     .    .
i2  2.8  0.8  16000  7.00   .     .    .
i2  3.0  0.6  12000  7.05   .     .    .
i2  3.2  0.4  10400  8.00   .     .    .
i2  3.4  0.2  12000  8.05   .     .    .

; TUBE DISTORTION
f5 2 8192 7 -.8 934 -.79 934 -.77 934 -.64 1034 -.48 520 .47 2300 .48 1536 .48

; TUBE AMP
;   STA  DUR  PREGAIN POSTGAIN  DUTYOFFSET  SLOPESHIFT  INCH  OUTCH
i13 2    1.6  1       1         1           1           1     2

; CHORUS
;   STA  DUR  RATE   DEPTH   WAVE  MIX  DELAY  PHASE  INCH  OUTCH
;                   (.1-4)
i35 2    1.6  .5     2       1     1    25     0      2     3
i35 2    1.6  .5     2       1     1    20     .25    2     4

; MIXER
;    STA DUR  CH1  GAIN  PAN  CH2  GAIN  PAN  CH3  GAIN  PAN  CH4  GAIN  PAN
i100 2   2    3    1     1    4    1     0    6    0     1    7    0     0

;---------------------------------------------------------------------------
; HEAVY DISTORTION WITH FLANGER
;---------------------------------------------------------------------------
i2  4.0  1.6  16000  7.00   0     1    1
i2  4.2  1.4  12000  7.05   .     .    .
i2  4.4  1.2  10400  8.00   .     .    .
i2  4.6  1.0  12000  8.05   .     .    .
i2  4.8  0.8  16000  7.00   .     .    .
i2  5.0  0.6  12000  7.05   .     .    .
i2  5.2  0.4  10400  8.00   .     .    .
i2  5.4  0.2  12000  8.05   .     .    .

; TUBE DISTORTION
f5 4 8192 7 -.8 934 -.79 934 -.77 934 -.64 1034 -.48 520 .47 2300 .48 1536 .48

; DISTORTION
;   STA  DUR  PREGAIN POSTGAIN  DUTYOFFSET  SLOPESHIFT  INCH  OUTCH
i13 4    1.6  1       1         1           1           1     2

; FLANGER
;   STA  DUR  RATE   DEPTH   WAVE  FEEDBK  MIX  DELAY  PHASE  INCH  OUTCH
;                   (.1-4)
i30 4    1.6  .5     1       1     .8      1    1      0      2     3
i30 4    1.6  .5     1       1     .8      1    1      .25    2     4

; MIXER
;    STA DUR  CH1  GAIN  PAN  CH2  GAIN  PAN  CH3  GAIN  PAN  CH4  GAIN  PAN
i100 4   2    3    1     1    4    1     0    6    0     1    7    0     0

;---------------------------------------------------------------------------
; PLUCK WITH PHASOR
;---------------------------------------------------------------------------
i2  6.0  1.6  16000  7.00   0     1    1
i2  6.2  1.4  12000  7.05   .     .    .
i2  6.4  1.2  10400  8.00   .     .    .
i2  6.6  1.0  12000  8.05   .     .    .
i2  6.8  0.8  16000  7.00   .     .    .
i2  7.0  0.6  12000  7.05   .     .    .
i2  7.2  0.4  10400  8.00   .     .    .
i2  7.4  0.2  12000  8.05   .     .    .

; DISTORTION
;   STA  DUR  PREGAIN  POSTGAIN  DUTYOFFSET  SLOPESHIFT  INCH  OUTCH
i13 6    1.6  .5       1         1           1           1     2

; PHASOR
;   STA  DUR  RATE   DEPTH   WAVE  FEEDBK  MIX  DELAY  PHASE  INCH  OUTCH
i37 6    1.6  .5     1       1     .8      1    2      0      2     3
i37 6    1.6  .5     1       1     .8      1    2      .25    2     4

; MIXER
;    STA DUR  CH1  GAIN  PAN  CH2  GAIN  PAN  CH3  GAIN  PAN  CH4  GAIN  PAN
i100 6   2    3    1     1    4    1     0    3    0     1    4    0    0


;---------------------------------------------------------------------------
; LIGHT DISTORTION WITH VIBRATO
;---------------------------------------------------------------------------
i2  8.0  1.6  16000  7.00   0     1    1
i2  8.01 1.6  16000  7.07   0     1    1
i2  8.02 1.6  16000  8.07   0     1    1

; SLIGHT DISTORTION
f5 8 8192   8 -.8 336 -.78  800 -.7 5920 .7  800 .78 336 .8

; TUBE AMP
;   STA  DUR  PREGAIN POSTGAIN  DUTYOFFSET  SLOPESHIFT  INCH  OUTCH
i13 8    1.7  1       1         .1          .1          1     2

; VIBRATO
;   STA  DUR  AMP  FQC  TABLE  PHASE  DELAY  RAMPTIME  INCH  OUTCH
i20 8    1.7  1    5    1      0      .5     .5        2     3

; MIXER
;    STA DUR  CH1  GAIN  PAN  CH2  GAIN  PAN  CH3  GAIN  PAN  CH4  GAIN  PAN
i100 8   2    3    1     1    3    1     0    6    0     1    7    0     0

;---------------------------------------------------------------------------
; PITCH SHIFTER
;---------------------------------------------------------------------------
i2  10.0  .8  16000  7.00   0     1    1
i2  10.8  .4  16000  7.00   0     1    1
i2  11.2  .8  16000  7.00   0     1    1

; SAW WAVE
f9 10 1024 7 1 1024 0

; PITCH SHIFTER NEWFQC=SHIFT*FQC
;   STA  DUR  SHIFT  TABLE  INCH  OUTCH
i22 10.0  .8   .995   9      1     2       ; STEREO DETUNE
i22 10.8  .4   1.5    9      1     2       ; UP A FIFTH
i22 11.2  .8   .5     9      1     2       ; DOWN AN OCTAVE

; MIXER
;    STA DUR  CH1  GAIN  PAN  CH2  GAIN  PAN  CH3  GAIN  PAN  CH4  GAIN  PAN
i100 10   2.0  1    1     1    2    1     0    6    0     1    7    0     0

;---------------------------------------------------------------------------
; DISTORTION FEEDBACKER
;---------------------------------------------------------------------------
i2  12.0  2.0  16000  7.00   0     1    1
i2  12.0  2.0  12000  7.05   .     .    .
i2  12.0  2.0  10400  8.00   .     .    .

i2  14.0  2.0  16000  7.10   .     .    .
i2  14.0  2.0  16000  7.00   .     .    .
i2  14.0  2.0  12000  7.05   .     .    .

; TUBE DISTORTION
f5 12 8192 7 -.8 934 -.79 934 -.77 934 -.64 1034 -.48 520 .47 2300 .48 1536 .48
; COMPRESSION CURVE
f6 12 1025 7 1 128 1 128 .8 256 .6 256 .1 257 .01

; DISTORTION
;   STA  DUR  PREGAIN POSTGAIN  DUTYOFFSET  SLOPESHIFT  INCH  OUTCH
i13 12   4    1       1         1           1           1     2

; DISTORTION FEEDBACK
;   STA  DUR  PRAMP  PSTAMP  DUTY  D-TAB  RES  DELAY  FDBK  C-TAB  INCH  OUTCH
i14 12   4    1      1       1     5      440  .02    1.4   6      1     3
i14 14   2    1      1       1     5      330  .02    1.3   6      1     3

; MIXER
;    STA DUR  CH1  GAIN  PAN  CH2  GAIN  PAN  CH3  GAIN  PAN  CH4  GAIN  PAN
i100 12  4    2    1     1    2    1     0    3    1     1    3    1     0
