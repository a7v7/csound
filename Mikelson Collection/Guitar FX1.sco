;--------------------------------------------------------------------------- 
; A MULTI-EFFECTS SYSTEM
;--------------------------------------------------------------------------- 
; 1. SIMPLE SINE WAVE
; 2. PLUCK
; 3. MONO SAMPLER
; 4. NOISE
; 10. COMPRESSOR
; 11. TUBE AMP DISTORTION
; 15. WAH-WAH: THIS ONE SUCKS BUT THE TALK-BOX MAKES A PRETTY GOOD WAH-WAH. 
; 16. TALK-BOX
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
f2 0 8192 7 -1 4096 1 4096 -1
; SAMPLE
;f3 0 0 1 "harp.wav" 0 4 0
; TRIANGLE WAVE
f4 0 8192 7 0 4096 1 4096 0

; DISTORTION TABLES
; HEAVY DISTORTION
;f5 0 8192 8 -.8 336 -.76 3000 -.7 1520 .7 3000 .76 336 .8 
; SLIGHT DISTORTION
;f5 0 8192 8 -.8 336 -.78 800 -.7 5920 .7 800 .78 336 .8 
; TUBE DISTORTION
;f5 0 8192 7 -.8 834 -.79 834 -.77 834 -.64 834 -.48 1520 .47 2000 .48 1336 .48
f5 0 8192 7 -.8 934 -.79 934 -.77 934 -.64 1034 -.48 520 .47 2300 .48 1536 .48

; WAH-WAH
f7 0 1024 -7 100 512 10000 512 100

; PITCH SHIFT WINDOW SHAPE (1/2 SINE)
f8 0 16384 9 .5 1 0

; FORMANTS
; AHH/OOOH
f10 0 1024 -7 722  256 722  256 266  256 266  256 722 
f11 0 1024 -7 1216 256 1216 256 1292 256 1292 256 1216 
f12 0 1024 -7 2433 256 2433 256 2281 256 2281 256 2433 
f13 0 1024 -7 3193 256 3193 256 3421 256 3421 256 3193 

; NOISE
;  Sta  Dur  Amp    OutCh
i4 0    2    10000  1

; RESONANT FILTER
; f3=Fco, f4=Rez
f20 0 8192 -7 400 2048 20 0 400 2048 20 0 400 2048 20 0 400 2048 20
f21 0 8192 -7 10 8192 10
;   Sta  Dur  Table1  Table2  LPMix  RzMix  InCh  OutCh
i15 0    2    20      21      1      1      1     2

; FLANGER
;   Sta  Dur  Rate   Depth   Wave  Feedbk  Mix  DelayOff  InCh  OutChL  OutChR
;                   (1-40)
i30 0    2    2      20      1     .8      1    10        2     3       4

; MIXER
;    Sta Dur  Ch1  Gain  Pan  Ch2  Gain  Pan  Ch3  Gain  Pan  Ch4  Gain  Pan
i100 0   2    3    1     1    4    1     0    5    0     1    5    0     0
