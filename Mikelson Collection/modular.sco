;===========================================================================
; MODULAR SYNTHESIZER
;===========================================================================
; WAVEFORMS
f1  0  8192  10  1                                 ;SINE
f2  0   256  7  -1  128  -1    0     1  128   1    ;SQUARE
f3  0  8192  7   1 8192  -1                        ;SAWTOOTH

; SIMPLE TRIGGER FOR VCF ENVELOPES
;    STA  DUR  DURCH
i1   0.0  3.2  9

; KEYBOARD TRIGGERS
;    STA  DUR  AMP    PCH   DURCH  AMPCH  PCHCH
i2   0.0  0.2  9000   7.00  1      2      3
i2   +    0.2  8000   7.00  1      2      3
i2   .    0.2  6000   7.07  1      2      3
i2   .    0.2  6000   7.00  1      2      3
i2   .    0.4  8000   7.06  1      2      3
i2   .    0.2  8000   7.00  1      2      3
i2   .    0.2  9000   7.09  1      2      3
i2   .    0.2  8000   7.09  1      2      3
i2   .    0.2  9000   7.00  1      2      3
i2   .    0.2  8000   7.00  1      2      3
i2   .    0.4  6000   7.07  1      2      3
i2   .    0.2  8000   7.05  1      2      3
i2   .    0.2  9000   7.09  1      2      3
i2   .    0.2  9000   7.09  1      2      3

f20 0 1024  7 0  128 1 256 .7 384 .7 128 .3 128 0         ; AMP 
f21 0 1024 -7 420 256 160 256  120  256   80  256  420    ; FCO
f22 0 1024 -7 100 512 130   256  80   256  40             ; REZ

; ENVELOPE
;   STA  DUR  DURCH  AMP  TABLE  OUTKCH
i5  0.0  3.2  1      1    20     4      ; AMP
i5  0.0  3.2  9      1    21     5      ; FCO
i5  0.0  3.2  9      1    22     6      ; REZ

; LFO
;   STA  DUR  AMP  FQC  TABLE  OFFSET  OUTCH
i6  0    1.6  .8   1    1      0       11

; VCO
;INS  STA  DUR  FQCCH  SYNCIN  PWMCH  AUDIOOUT  SYNCOUT  SHAPE  PWIDTH  FQCADJ
i15   0.0  1.6  3      0       11     2         8        1      0       1
i15   1.6  1.6  3      0       0      1         7        0      0       .7
i15   1.6  1.6  3      7       0      2         8        0      .9      1

; VCF
;    STA  DUR  FREQCH  REZCH   RZMIX  INACH  OUTACH
i20  0    3.2  5       6       .5     2      3

; CONTROLLED AMPLIFIER
;    STA  DUR  MAXCH  CONTCH  INCH  OUTCH
i25  0    3.2  2      4       3     4

; FINAL MIXER
;     STA  DUR  CH1  GAIN  PAN  CH2  GAIN  PAN
i100  0    3.2  4    2     .5   4    0     0

; CLEAR AUDIO
i110  0  3.2

