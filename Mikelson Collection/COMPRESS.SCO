; AN ATTEMPT AT EMULATING TUBE DISTORTION.

; SINE WAVE
f1 0 8192 10 1
; TRIANGLE WAVE
f2 0 8192 7  -1  256 1 256 -1 512 0 7168 0
; EXP WAVE
f3 0 8192 7  .001  4096 1 4096 .001

; COMPRESSION CURVE
f5 0 1025 7 1 512 1 513 .5

; COMPRESSOR
;  Sta Dur  Frqc  Table  PostGain
;i3 0   1.6  10    5      1

; RING MODULATOR
;  Sta Dur
i5 0   1.6

;i1 0   .5  20000 8.00

; PLUCK USE FUNC 2 FOR DISTORTION
;   Sta  Dur  Amp    Fqc   Func  Meth
i2  0.0  1.6  30000  7.00   0     1
i2  0.2  1.4  24000  7.05   .     .
i2  0.4  1.2  11000  8.00   .     .
i2  0.6  1.0  20000  8.05   .     .
i2  0.8  0.8  30000  7.00   .     .
i2  1.0  0.6  24000  7.05   .     .
i2  1.2  0.4  11000  8.00   .     .
i2  1.4  0.2  20000  8.05   .     .
