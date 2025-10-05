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
f10 0 1024 -7 722 256 722 256 266 256 266 256 722 
f11 0 1024 -7 1216 256 1216 256 1292 256 1292 256 1216 
f12 0 1024 -7 2433 256 2433 256 2281 256 2281 256 2433 
f13 0 1024 -7 3193 256 3193 256 3421 256 3421 256 3193 

; SAMPLE
;     Sta Dur   Amp   Fqc Table Begin End(n-1) OutCh
;i3   0   21.6  10000 440 3     0     4     74670 1

; SINE WAVE
;i1 0 1 10000 1000
;i1 1 1 10000 500

; PITCH SHIFTER THIS HAS NOT BEEN TESTED. 
;   Sta Dur Fqc Wave WinFun OutCh
;i19 0  1.6 2   3    8      1

; NOISE
;   Sta Dur Amp
;i4 0   4   5000

; WAH-WAH
;   Sta Dur Frqc Table InChL InChR OutChL OutChR 
;i15 0 1.6  2       7   2       2   3       3

; VIBRATO
;   Sta Dur Amp Fqc Table MaxDelay InChL InChR OutChL OutChR 
;i20 0 2.5  1   5   1       3       1       1   2       2

; TREMELO
;   Sta Dur Amp Fqc Table InChL InChR OutChL OutChR 
;i21 0  2.5 .5   5   1    1     1     2      2

;--------------------------------------------------------------------------- 
; PLAIN PLUCK
;--------------------------------------------------------------------------- 
;  Sta Dur Amp  Fqc Func Meth OutCh
i2 0.0 1.6 4000 7.00 0      1 1
i2 0.2 1.4 3000 7.05 .      . .
i2 0.4 1.2 2600 8.00 .      . .
i2 0.6 1.0 3000 8.05 .      . .
i2 0.8 0.8 4000 7.00 .      . .
i2 1.0 0.6 3000 7.05 .      . .
i2 1.2 0.4 2600 8.00 .      . .
i2 1.4 0.2 3000 8.05 .      . .

; MIXER
;   Sta Dur Ch1 Gain Pan Ch2 Gain Pan Ch3 Gain Pan Ch4 Gain Pan 
i100 0  2   1   4    1   1   4    0   3   2    1   4    2   0

;--------------------------------------------------------------------------- 
; PLUCK WITH HEAVY DISTORTION
;--------------------------------------------------------------------------- 
i2 2.0 1.6 4000 7.00 0  1 1
i2 2.2 1.4 3000 7.05 .  . .
i2 2.4 1.2 2600 8.00 .  . .
i2 2.6 1.0 3000 8.05 .  . .
i2 2.8 0.8 4000 7.00 .  . .
i2 3.0 0.6 3000 7.05 .  . .
i2 3.2 0.4 2600 8.00 .  . .
i2 3.4 0.2 3000 8.05 .  . .

; TUBE AMP
;  Sta Dur PreGain PostGain DutyOffset SlopeShift InCh OutCh 
i11 2  1.6 2        1       1           1           1   2

; MIXER
;  Sta Dur Ch1 Gain Pan Ch2 Gain Pan Ch3 Gain Pan Ch4 Gain Pan 
i100 2 2    2   1   1   2   1    0   3   2    1   4   2    0

;--------------------------------------------------------------------------- 
; PLUCK WITH DISTORTION & FLANGING
;--------------------------------------------------------------------------- 
i2 4.0 1.6 4000 7.00 0  1 1
i2 4.2 1.4 3000 7.05 .  . .
i2 4.4 1.2 2600 8.00 .  . .
i2 4.6 1.0 3000 8.05 .  . .
i2 4.8 0.8 4000 7.00 .  . .
i2 5.0 0.6 3000 7.05 .  . .
i2 5.2 0.4 2600 8.00 .  . .
i2 5.4 0.2 3000 8.05 .  . .

; TUBE AMP
; Sta Dur PreGain PostGain DutyOffset SlopeShift InCh OutCh 
i11 4 1.6 2       1        1          1           1   2

; FLANGER
; Sta Dur Rate Depth Wave Feedbk Mix DelayOff InCh OutChL OutChR
;   (1-40)
i30 4 1.61 .5   20   1   .8      1   10        2    3     4

; MIXER
;  Sta Dur Ch1 Gain Pan Ch2 Gain Pan Ch3 Gain Pan Ch4 Gain Pan 
i100 4 2    3  .5   1    4   .5  0    3   0   1    4   0      0

;--------------------------------------------------------------------------- 
; DISTORTION & CHORUS
;--------------------------------------------------------------------------- 
i2 6.0 1.6 4000 7.00 0  1 1
i2 6.2 1.4 3000 7.05 .  . .
i2 6.4 1.2 2600 8.00 .  . .
i2 6.6 1.0 3000 8.05 .  . .
i2 6.8 0.8 4000 7.00 .  . .
i2 7.0 0.6 3000 7.05 .  . .
i2 7.2 0.4 2600 8.00 .  . .
i2 7.4 0.2 3000 8.05 .  . .

; TUBE AMP
;  Sta Dur PreGain PostGain DutyOffset SlopeShift InCh OutCh 
i11 6  1.6 2        1       1           1         1    2

; CHORUS
; Sta Dur Rate Depth Wave Mix DelayOff InCh OutChL OutChR 
;   (.1-2)
i35 6 1.61 1    1    1    1     30      2   3      4

; MIXER
;   Sta Dur Ch1 Gain Pan Ch2 Gain Pan Ch3 Gain Pan Ch4 Gain Pan 
i100 6  2   3   1    1   4   1    0   3   0    1   4   0    0

;--------------------------------------------------------------------------- 
; DISTORTION & TALK-BOX
;--------------------------------------------------------------------------- 
i2 8.0 1.6 4000 7.07 0  1 1
i2 8.4 1.2 3000 7.00 .  . .
i2 8.8 .8 2600 9.05 .   . .
i2 9.2 .4 3000 9.00 .   . .

; TUBE AMP
;  Sta Dur PreGain PostGain DutyOffset SlopeShift InCh OutCh 
i11 8  1.6 2       1        1          1          1    2

; TALK BOX
; Sta Dur InCh OutCh
i16 8 1.6  2    3

; MIXER
;   Sta Dur Ch1 Gain Pan Ch2 Gain Pan Ch3 Gain Pan Ch4 Gain Pan 
i100 8  2   3   1    1   3   1    0   3   0    1   4   0    0

;--------------------------------------------------------------------------- 
; DIGITAL DELAY WITH MODERATE DISTORTION 
;--------------------------------------------------------------------------- 
i2 10.0 1.6 4000 7.07 0 1 1
i2 10.4 1.2 3000 7.00 . . .
i2 10.8 .8 2600 9.05 .  . .
i2 11.2 .4 3000 9.00 .  . .

; TUBE DISTORTION
f5 10 8192 7 -.8 834 -.79 834 -.77 834 -.64 834 -.48 1520 .47 2000 .48 1336 .48

; TUBE AMP
;   Sta Dur PreGain PostGain DutyOffset SlopeShift InCh OutCh 
i11 10 1.6  2       1        .2         0          1    2

; DELAY
;  Sta Dur Time Feedbk InChL InChR OutChL OutChR 
i40 10 3   .2   .5      2     2     3     3

; MIXER
;   Sta Dur Ch1 Gain Pan Ch2 Gain Pan Ch3 Gain Pan Ch4 Gain Pan 
i100 10 3   2   1    1   2   1    0   3   1    1   3   1    0

;--------------------------------------------------------------------------- 
; COMPRESSION & AUTO PAN
;--------------------------------------------------------------------------- 
i2 13.0 1.6 4000 7.07 0 1 1
i2 13.4 1.2 3000 7.00 . . .
i2 13.8 .8 2600 9.05 .  . .
i2 14.2 .4 3000 9.00 .  . .

; COMPRESSION CURVE
f6 13 1025 7 1 256 1 256 .1 256 .1 257 .1 

; COMPRESSOR
;   Sta Dur RespFrqc Table PreGain PostGain InCh OutCh 
i10 13 1.6  100      6      1      20       1    2

; TUBE DISTORTION
f5 13 8192 7 -.8 834 -.79 834 -.77 834 -.64 834 -.48 1520 .47 2000 .48 1336 .48

; TUBE AMP
;  Sta Dur PreGain PostGain DutyOffset SlopeShift InCh OutCh 
i11 13 1.6 2        1       .2          0           2   3

; PANNER
;  Sta Dur Amp Fqc Table InCh OutChL OutChR 
i23 13 1.6 1    5   1    3    4      5

; REVERB
;  Sta Dur gain %orig inputdur atk InCh1 InCh2 OutChL OutChR 
i45 13 3    1   .5    1.61     .2   4     5    6      7

; MIXER
;   Sta Dur Ch1 Gain Pan Ch2 Gain Pan Ch3 Gain Pan Ch4 Gain Pan 
i100 13 3   4   1    1   5   1    0   6   1    1   7   1    0

;---------------------------------------------------------------------------
; REZ FILTER
;---------------------------------------------------------------------------
i2  16.0  1.6  4000  7.07   0     1    1
i2  16.4  1.2  3000  7.00   .     .    .
i2  16.8   .8  2600  9.05   .     .    .
i2  17.2   .4  3000  9.00   .     .    .

; COMPRESSION CURVE
f6 16 1025 7 1 256 1 256 .1 256 .1 257 .1

; COMPRESSOR
;    Sta  Dur  RespFrqc  Table  PreGain PostGain  InCh  OutCh
i10  16   1.6  100       6      1       20        1     2

; TUBE AMP
; TUBE DISTORTION
f5 16 8192 7 -.8 934 -.79 934 -.77 934 -.64 1034 -.48 520 .47 2300 .48 1536 .48
;   Sta  Dur  PreGain PostGain  DutyOffset  SlopeShift  InCh  OutCh
i11 16   1.6  2       1         .5          .2          2     3

; RESONANT FILTER
; f3=Fco, f4=Rez
f20 16 8192 -5 10 1024 90 1024 400 2048 300 4096 20
f21 16 8192 -7 40 1024 60  1024 40  2048 40  4096 30
;   Sta  Dur  Table1  Table2  LPMix  RzMix  InCh  OutCh
i15 16   1.6  20      21      1      1      3     4

; MIXER
;    Sta Dur  Ch1  Gain  Pan  Ch2  Gain  Pan  Ch3  Gain  Pan  Ch4  Gain  Pan
i100 16  1.6  4    1     1    4    1     0    6    0     1    7    0     0

