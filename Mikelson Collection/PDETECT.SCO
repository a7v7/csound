;---------------------------------------------------------------------------
; WAVEFORMS
;---------------------------------------------------------------------------
; SINE WAVE
f1 0 8192 10 1

; TRIANGLE WAVE -1 TO 1
f2 0 8192 7  -1  4096 1 4096 -1

; TRIANGLE WAVE 0 TO 1
f4 0 8192 7 0 4096 1 4096 0

; PLUCK
;i2  0.0  1.0  16000  220   0     1    1
i1  0   1  20000  220  1

; PITCH DETECTOR
;    STA  DUR  MINFQC  MAXFQC  INCH  OUTCH
i10  0    1    50      2000    1     2

; SINE
;    STA  DUR  OUTCH
i20  0    1    3

; MIXER
;    STA DUR  CH1  GAIN  PAN  CH2  GAIN  PAN  CH3  GAIN  PAN  CH4  GAIN  PAN
i100 0   1.1  1    1     1    2    1     0    3    0     1    3    0     0
