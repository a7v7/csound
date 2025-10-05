;---------------------------------------------------------------------------
; A MULTI-EFFECTS SYSTEM
;---------------------------------------------------------------------------
; 3401. SIMPLE SINE WAVE
; 3402. PLUCK
; 3404. NOISE
; 3409. ENHANCER
; 3410. NOISE GATE
; 3411. COMPRESSOR/LIMITER/EXPANDER
; 3412. DE-ESSER
; 3413. TUBE AMP DISTORTION
; 3414. FEEDBACK GENERATOR
; 3415. LOW PASS RESONANT FILTER
; 3416. WAH-WAH
; 3417. TALK-BOX
; 3418. 3 BAND EQUALIZER
; 3419. RESONATOR
; 3420. VIBRATO
; 3421. TREMELO
; 3422. PITCH SHIFTER
; 3423. PANNER
; 3424. RING MODULATOR
; 3426. DISTORTION FEEDBACK
; 3430. FLANGER
; 3435. CHORUS
; 3437. PHASOR
; 3440. STEREO DELAY
; 3445. REVERB
; 3450. SUBMIX
; 3499. MIX
;---------------------------------------------------------------------------
; WAVEFORMS
;---------------------------------------------------------------------------
; SINE WAVE
f 1 0 8192 10 1
; TRIANGLE WAVE
f 2 0 8192 7  -1  4096 1 4096 -1
; SQUARE WAVE
f 3 0 8192 7  1  4096 1 0 -1 4096 -1
; TRIANGLE WAVE
f 4 0 8192 7 0 4096 1 4096 0
; TUBE DISTORTION
f 5 0 8192 7 -.8 934 -.79 934 -.77 934 -.64 1034 -.48 520 .47 2300 .48 1536 .48
;---------------------------------------------------------------------------
; PLAIN PLUCK
;---------------------------------------------------------------------------
;   Sta  Dur  Amp   Fqc   Func  Meth  OutCh
i 3402  2.0  1.6  16000  7.00   0     1    1
i 3402  2.2  1.4  12000  7.05   .     .    .
i 3402  2.4  1.2  10400  8.00   .     .    .
i 3402  2.6  1.0  12000  8.05   .     .    .
i 3402  2.8  0.8  16000  7.00   .     .    .
i 3402  3.0  0.6  12000  7.05   .     .    .
i 3402  3.2  0.4  10400  8.00   .     .    .
i 3402  3.4  0.2  12000  8.05   .     .    .
; Mixer
;    Sta Dur  Ch1  Gain  Pan  Ch2  Gain  Pan  Ch3  Gain  Pan  Ch4  Gain  Pan
i3499 0   2    1    1     1    1    1     0    3    0     1    4    0     0
;---------------------------------------------------------------------------
; Compression
;---------------------------------------------------------------------------
i 3402  2.0  1.6  16000  7.00   0     1    1
i 3402  2.2  1.4  12000  7.05   .     .    .
i 3402  2.4  1.2  10400  8.00   .     .    .
i 3402  2.6  1.0  12000  8.05   .     .    .
i 3402  2.8  0.8  16000  7.00   .     .    .
i 3402  3.0  0.6  12000  7.05   .     .    .
i 3402  3.2  0.4  10400  8.00   .     .    .
i 3402  3.4  0.2  12000  8.05   .     .    .
; Compression Curve
f 6 2 1025 7 1 128 1 128 .4 256 .2 256 .1 257 .01
; Compressor/Limiter
;    Sta  Dur  RMSTime  DelTime  Table  PostGain  InCh  OutCh
i 3411  2    1.6  .02      .01       6     1.5       1     2
; Mixer
;    Sta Dur  Ch1  Gain  Pan  Ch2  Gain  Pan  Ch3  Gain  Pan  Ch4  Gain  Pan
i 3499 2   2    2    1     1    2    1     0    6    0     1    7    0     0
;---------------------------------------------------------------------------
; Noise Gate
;---------------------------------------------------------------------------
i 3402  4.0  .8  8000  7.00   0     1    1
i 3402  4.8  .8  8000  7.00   0     1    2
; Noise Gate Curve
f 6 4 1025 7 0 64 0 64 1 897 1
; Noise Gate
;    Sta  Dur  RMSTime  DelTime  Table  PostGain  InCh  OutCh
i 3410  4    1.6  .02      .01      6      1         2     3
; Mixer
;    Sta Dur  Ch1  Gain  Pan  Ch2  Gain  Pan  Ch3  Gain  Pan  Ch4  Gain  Pan
i 3499 4   2    1    1     1    1    1     0    3    1     1    3    1     0
;---------------------------------------------------------------------------
; De-Esser
;---------------------------------------------------------------------------
i 3402  6.0  1.6  16000  7.00   0     1    1
i 3402  6.2  1.4  12000  7.05   .     .    .
i 3402  6.4  1.2  10400  8.00   .     .    .
i 3402  6.6  1.0  12000  8.05   .     .    .
i 3402  6.8  0.8  16000  7.00   .     .    .
i 3402  7.0  0.6  12000  7.05   .     .    .
i 3402  7.2  0.4  10400  8.00   .     .    .
i 3402  7.4  0.2  12000  8.05   .     .    .
; De-Esser Curve
f 6 6 1025 7 1 128 .5 128 .3 256 .2 256 .1 257 .01
; De-Esser
;    Sta  Dur  RMSTime  DelTime  Table  Frequency  PostGain  InCh  OutCh
i 3412  6    1.6  .02      .01      6      5000       1         1     2
; Mixer
;    Sta Dur  Ch1  Gain  Pan  Ch2  Gain  Pan  Ch3  Gain  Pan  Ch4  Gain  Pan
i 3499 6   2    2    1     1    2    1     0    6    0     1    7    0     0
s
;---------------------------------------------------------------------------
; Plain Pluck
;---------------------------------------------------------------------------
;   Sta  Dur  Amp   Fqc   Func  Meth  OutCh
i 3402  0.0  1.6  16000  7.00   0     1    1
i 3402  0.2  1.4  12000  7.05   .     .    .
i 3402  0.4  1.2  10400  8.00   .     .    .
i 3402  0.6  1.0  12000  8.05   .     .    .
i 3402  0.8  0.8  16000  7.00   .     .    .
i 3402  1.0  0.6  12000  7.05   .     .    .
i 3402  1.2  0.4  10400  8.00   .     .    .
i 3402  1.4  0.2  12000  8.05   .     .    .
; Mixer
;    Sta Dur  Ch1  Gain  Pan  Ch2  Gain  Pan  Ch3  Gain  Pan  Ch4  Gain  Pan
i 3499 0   2    1    1     1    1    1     0    3    0     1    4    0     0
;---------------------------------------------------------------------------
; Pluck with Heavy Distortion & Wah-Wah
;---------------------------------------------------------------------------
i 3402  2.0  1.6  16000  7.00   0     1    1
i 3402  2.2  1.4  12000  7.05   .     .    .
i 3402  2.4  1.2  10400  8.00   .     .    .
i 3402  2.6  1.0  12000  8.05   .     .    .
i 3402  2.8  0.8  16000  7.00   .     .    .
i 3402  3.0  0.6  12000  7.05   .     .    .
i 3402  3.2  0.4  10400  8.00   .     .    .
i 3402  3.4  0.2  12000  8.05   .     .    .
; Tube Distortion
f 5 0 8192 7 -.8 934 -.79 934 -.77 934 -.64 1034 -.48 520 .47 2300 .48 1536 .48
; Tube Amp
;   Sta  Dur  PreGain  PostGain  DutyOffset  SlopeShift  InCh  OutCh
i 3413 2    1.6  .5       1         1           1           1     2
; Wah-Wah
;   Sta  Dur  Rate  Depth  MinFqc  VocalMix  Table  InCh  OutCh
i 3416 2    1.6  2.5   10000  250     1         1      2     3
; Mixer
;    Sta Dur  Ch1  Gain  Pan  Ch2  Gain  Pan  Ch3  Gain  Pan  Ch4  Gain  Pan
i 3499 2   2    3    1     1    3    1     0    3    0     1    4    0    0
;---------------------------------------------------------------------------
; Pluck with Equalizer
;---------------------------------------------------------------------------
i 3402  4.0  1.6  16000  7.00   0     1    1
i 3402  4.2  1.4  12000  7.05   .     .    .
i 3402  4.4  1.2  10400  8.00   .     .    .
i 3402  4.6  1.0  12000  8.05   .     .    .
i 3402  4.8  0.8  16000  7.00   .     .    .
i 3402  5.0  0.6  12000  7.05   .     .    .
i 3402  5.2  0.4  10400  8.00   .     .    .
i 3402  5.4  0.2  12000  8.05   .     .    .
; 3 Band Equalizer
;    Sta  Dur  LoGain  MidGain  HiGain  LoFco  HiFco  InCh  OutCh
i3418  4    1.6  2       .5       1       500    5000   1     2
; Mixer
;    Sta Dur  Ch1  Gain  Pan  Ch2  Gain  Pan  Ch3  Gain  Pan  Ch4  Gain  Pan
i3499 4   2    2    1     1    2    1     0    3    0     1    4    0    0
;---------------------------------------------------------------------------
; Pluck with Heavy Distortion & Resonant Low-Pass Filter
;---------------------------------------------------------------------------
i 3402  6.0  1.6  16000  7.00   0     1    1
i 3402  6.2  1.4  12000  7.05   .     .    .
i 3402  6.4  1.2  10400  8.00   .     .    .
i 3402  6.6  1.0  12000  8.05   .     .    .
i 3402  6.8  0.8  16000  7.00   .     .    .
i 3402  7.0  0.6  12000  7.05   .     .    .
i 3402  7.2  0.4  10400  8.00   .     .    .
i 3402  7.4  0.2  12000  8.05   .     .    .
; Tube Amp
;   Sta  Dur  PreGain  PostGain  DutyOffset  SlopeShift  InCh  OutCh
i3413 6    1.6  .5       1         1           1           1     2
; Resonant Low-Pass Filter
; f3=Fco, f4=Rez
f 20 6 8192 -7 50 1024 300 1024 50 2048 300 4096 40
f 21 6 8192 -7 12 1024 10  1024 12  2048 10  4096 18
;   Sta  Dur  Table1  Table2  LPMix  RzMix  InCh  OutCh
i3415 6    1.6  20      21      1      1.5    2     3
; Mixer
;    Sta Dur  Ch1  Gain  Pan  Ch2  Gain  Pan  Ch3  Gain  Pan  Ch4  Gain  Pan
i3499 6   2    3    1     1    3    1     0    3    0     1    4    0    0
;---------------------------------------------------------------------------
; Pluck with Resonator
;---------------------------------------------------------------------------
i 3402  8.0  1.6  16000  7.00   0     1    1
i 3402  8.2  1.4  12000  7.05   .     .    .
i 3402  8.4  1.2  10400  8.00   .     .    .
i 3402  8.6  1.0  16000  7.10   .     .    .
i 3402  8.8  0.8  16000  7.00   .     .    .
i 3402  9.0  0.6  12000  7.05   .     .    .
i 3402  9.2  0.4  10400  8.00   .     .    .
i 3402  9.4  0.2  16000  7.10   .     .    .
; Resonator
f 7 8 4 -2 100 200 400  1400   ; Acoustic Guitar Body Resonances
f 8 8 4 -2 59  64  62   59     ; Amplitudes in dB.
;   Sta  Dur  ResTab  dBTab  InCh  OutCh
i 3419 8    2    7       8      1     2
; Mixer
;    Sta Dur  Ch1  Gain  Pan  Ch2  Gain  Pan  Ch3  Gain  Pan  Ch4  Gain  Pan
i3499 8   2    2    1.5   1    2    1.5   0    1    1     1    1    1     0
;---------------------------------------------------------------------------
; Talk-Box
;---------------------------------------------------------------------------
i 3402  10.0  2  16000  6.10   0     1    1
i 3402  10.0  2  12000  7.07   .     .    .
i 3402  10.0  2  13000  8.00   .     .    .
i 3402  10.0  2  10400  8.05   .     .    .

i 3402  12.0  2  16000  6.10   0     1    1
i 3402  12.0  2  12000  7.07   .     .    .
i 3402  12.0  2  13000  8.00   .     .    .
i 3402  12.0  2  10400  8.05   .     .    .

i 3402  14.0  2  16000  6.10   0     1    1
i 3402  14.0  2  12000  7.07   .     .    .
i 3402  14.0  2  13000  8.00   .     .    .
i 3402  14.0  2  10400  8.05   .     .    .
; Tube Distortion
f 5 10 8192 7 -.8 934 -.79 934 -.77 934 -.64 1034 -.48 520 .47 2300 .48 1536 .48
; Distortion
;   Sta  Dur  PreGain  PostGain  DutyOffset  SlopeShift  InCh  OutCh
i3413 10    6    .5       1         1           1           1     2
; Talk-Box
;Formants 0="ee", 1="aah", 2="oo", 3="aw", 4="ae"
;Male
f 11 10 16 -2  270 2290 3010 730 1090 2440 300 870 2240 570 840 2410 660 1720 2410 0
;Female
f 11 12 16 -2  310 2790 3310 850 1220 2810 370 950 2670 590 920 2710 760 2050 2850 0
;Child
f 11 14 16 -2  370 3200 3730 1030 1370 3170 430 1170 3260 680 1060 3180 1010 2320 3320 0
;Amplitudes
f 12 10 16 -2  -4 -24 -28 -1 -5 -28 -3 -19 -43 0 -7 -34 -1 -12 -22 0
;0="ee", 1="aah", 2="oo", 3="aw", 4="ae"
f 10 10 8 -2 1 0 0 2 1 1 2 2
;   Sta  Dur  I-Table  F-Table  A-Table  InCh  OutCh
i3417 10    2    10       11       12       2     3
i3417 12    2    10       11       12       2     3
i3417 14    2    10       11       12       2     3
; Mixer
;    Sta Dur  Ch1  Gain  Pan  Ch2  Gain  Pan  Ch3  Gain  Pan  Ch4  Gain  Pan
i3499 10   6    3    1     1    3    1     0    3    0     1    4    0    0
s
;---------------------------------------------------------------------------
; Heavy Distortion
;---------------------------------------------------------------------------
i 3402  0.0  1.6  16000  7.00   0     1   1
i 3402  0.2  1.4  12000  7.05   .     .   .
i 3402  0.4  1.2  10400  8.00   .     .   .
i 3402  0.6  1.0  12000  8.05   .     .   .
i 3402  0.8  0.8  16000  7.00   .     .   .
i 3402  1.0  0.6  12000  7.05   .     .   .
i 3402  1.2  0.4  10400  8.00   .     .   .
i 3402  1.4  0.2  12000  8.05   .     .   .
; Tube Distortion
f 5 0 8192 7 -.8 934 -.79 934 -.77 934 -.64 1034 -.48 520 .47 2300 .48 1536 .48
; Tube Amp
;   Sta  Dur  PreGain PostGain  DutyOffset  SlopeShift  InCh  OutCh
i3413 0    1.6  1       1         1           1           1     2
; Mixer
;    Sta Dur  Ch1  Gain  Pan  Ch2  Gain  Pan  Ch3  Gain  Pan  Ch4  Gain  Pan
i3499 0   2    2    1     1    2    1     0    6    0     1    7    0     0
;---------------------------------------------------------------------------
; Heavy Distortion with Chorus
;---------------------------------------------------------------------------
i 3402  2.0  1.6  16000  7.00   0     1    1
i 3402  2.2  1.4  12000  7.05   .     .    .
i 3402  2.4  1.2  10400  8.00   .     .    .
i 3402  2.6  1.0  12000  8.05   .     .    .
i 3402  2.8  0.8  16000  7.00   .     .    .
i 3402  3.0  0.6  12000  7.05   .     .    .
i 3402  3.2  0.4  10400  8.00   .     .    .
i 3402  3.4  0.2  12000  8.05   .     .    .
; Tube Distortion
f 5 2 8192 7 -.8 934 -.79 934 -.77 934 -.64 1034 -.48 520 .47 2300 .48 1536 .48
; Tube Amp
;   Sta  Dur  PreGain PostGain  DutyOffset  SlopeShift  InCh  OutCh
i3413 2    1.6  1       1         1           1           1     2
; Chorus
;   Sta  Dur  Rate   Depth   Wave  Mix  Delay  Phase  InCh  OutCh
;                   (.1-4)
i3435 2    1.6  .5     2       1     1    25     0      2     3
i3435 2    1.6  .5     2       1     1    20     .25    2     4

; Mixer
;    Sta Dur  Ch1  Gain  Pan  Ch2  Gain  Pan  Ch3  Gain  Pan  Ch4  Gain  Pan
i3499 2   2    3    1     1    4    1     0    6    0     1    7    0     0
;---------------------------------------------------------------------------
; Heavy Distortion with Flanger
;---------------------------------------------------------------------------
i 3402  4.0  1.6  16000  7.00   0     1    1
i 3402  4.2  1.4  12000  7.05   .     .    .
i 3402  4.4  1.2  10400  8.00   .     .    .
i 3402  4.6  1.0  12000  8.05   .     .    .
i 3402  4.8  0.8  16000  7.00   .     .    .
i 3402  5.0  0.6  12000  7.05   .     .    .
i 3402  5.2  0.4  10400  8.00   .     .    .
i 3402  5.4  0.2  12000  8.05   .     .    .
; Tube Distortion
f 5 4 8192 7 -.8 934 -.79 934 -.77 934 -.64 1034 -.48 520 .47 2300 .48 1536 .48
; Distortion
;   Sta  Dur  PreGain PostGain  DutyOffset  SlopeShift  InCh  OutCh
i3413 4    1.6  1       1         1           1           1     2
; Flanger
;   Sta  Dur  Rate   Depth   Wave  Feedbk  Mix  Delay  Phase  InCh  OutCh
;                   (.1-4)
i3430 4    1.6  .5     1       1     .8      1    1      0      2     3
i3430 4    1.6  .5     1       1     .8      1    1      .25    2     4
; Mixer
;    Sta Dur  Ch1  Gain  Pan  Ch2  Gain  Pan  Ch3  Gain  Pan  Ch4  Gain  Pan
i3499 4   2    3    1     1    4    1     0    6    0     1    7    0     0
;---------------------------------------------------------------------------
; Pluck with Phasor
;---------------------------------------------------------------------------
i 3402  6.0  1.6  16000  7.00   0     1    1
i 3402  6.2  1.4  12000  7.05   .     .    .
i 3402  6.4  1.2  10400  8.00   .     .    .
i 3402  6.6  1.0  12000  8.05   .     .    .
i 3402  6.8  0.8  16000  7.00   .     .    .
i 3402  7.0  0.6  12000  7.05   .     .    .
i 3402  7.2  0.4  10400  8.00   .     .    .
i 3402  7.4  0.2  12000  8.05   .     .    .

; Distortion
;   Sta  Dur  PreGain  PostGain  DutyOffset  SlopeShift  InCh  OutCh
i3413 6    1.6  .5       1         1           1           1     2

; Phasor
;   Sta  Dur  Rate   Depth   Wave  Feedbk  Mix  Delay  Phase  InCh  OutCh
i3437 6    1.6  .5     1       1     .8      1    2      0      2     3
i3437 6    1.6  .5     1       1     .8      1    2      .25    2     4

; Mixer
;    Sta Dur  Ch1  Gain  Pan  Ch2  Gain  Pan  Ch3  Gain  Pan  Ch4  Gain  Pan
i3499 6   2    3    1     1    4    1     0    3    0     1    4    0    0
;---------------------------------------------------------------------------
; Light Distortion with Vibrato
;---------------------------------------------------------------------------
i 3402  8.0  1.6  16000  7.00   0     1    1
i 3402  8.01 1.6  16000  7.07   0     1    1
i 3402  8.02 1.6  16000  8.07   0     1    1

; Slight Distortion
f 5 8 8192   8 -.8 336 -.78  800 -.7 5920 .7  800 .78 336 .8

; Tube Amp
;   Sta  Dur  PreGain PostGain  DutyOffset  SlopeShift  InCh  OutCh
i3413 8    1.7  1       1         .1          .1          1     2

; Vibrato
;   Sta  Dur  Amp  Fqc  Table  Phase  Delay  RampTime  InCh  OutCh
i3420 8    1.7  1    5    1      0      .5     .5        2     3

; Mixer
;    Sta Dur  Ch1  Gain  Pan  Ch2  Gain  Pan  Ch3  Gain  Pan  Ch4  Gain  Pan
i3499 8   2    3    1     1    3    1     0    6    0     1    7    0     0

;---------------------------------------------------------------------------
; Pitch Shifter
;---------------------------------------------------------------------------
i 3402  10.0  .8  16000  7.00   0     1    1
i 3402  10.8  .4  16000  7.00   0     1    1
i 3402  11.2  .8  16000  7.00   0     1    1
; Saw Wave
f 9 10 1024 7 1 1024 0
; Pitch Shifter NewFqc=Shift*Fqc
;   Sta  Dur  Shift  Table  InCh  OutCh
i 3422 10.0  .8   .995   9      1     2       ; Stereo Detune
i 3422 10.8  .4   1.5    9      1     2       ; Up a fifth
i 3422 11.2  .8   .5     9      1     2       ; Down an octave
; Mixer
;    Sta Dur  Ch1  Gain  Pan  Ch2  Gain  Pan  Ch3  Gain  Pan  Ch4  Gain  Pan
i3499 10   2.0  1    1     1    2    1     0    6    0     1    7    0     0
;---------------------------------------------------------------------------
; Distortion Feedbacker
;---------------------------------------------------------------------------
i 3402  12.0  2.0  16000  7.00   0     1    1
i 3402  12.0  2.0  12000  7.05   .     .    .
i 3402  12.0  2.0  10400  8.00   .     .    .
i 3402  14.0  2.0  16000  7.10   .     .    .
i 3402  14.0  2.0  16000  7.00   .     .    .
i 3402  14.0  2.0  12000  7.05   .     .    .
; Tube Distortion
f 5 12 8192 7 -.8 934 -.79 934 -.77 934 -.64 1034 -.48 520 .47 2300 .48 1536 .48
; Compression Curve
f 6 12 1025 7 1 128 1 128 .8 256 .6 256 .1 257 .01
; Distortion
;   Sta  Dur  PreGain PostGain  DutyOffset  SlopeShift  InCh  OutCh
i3413 12   4    1       1         1           1           1     2
; Distortion Feedback
;   Sta  Dur  PrAmp  PstAmp  Duty  D-Tab  Res  Delay  Fdbk  C-Tab  InCh  OutCh
i3414 12   4    1      1       1     5      440  .02    1.4   6      1     3
i3414 14   2    1      1       1     5      330  .02    1.3   6      1     3
; Mixer
;    Sta Dur  Ch1  Gain  Pan  Ch2  Gain  Pan  Ch3  Gain  Pan  Ch4  Gain  Pan
i3499 12  4    2    1     1    2    1     0    3    1     1    3    1     0
s
;---------------------------------------------------------------------------
; Stereo Delay
;---------------------------------------------------------------------------
i3402  0.0  1.6  16000  7.00   0     1   1
i3402  0.0  1.6  16000  8.07   0     1   2
; Stereo Delay
;   Sta  Dur  Delay1  Feedbk1  XFeedbk1  Delay2  Feedbk2  XFeedbk2  InCh1  InCh2  OutCh1  OutCh2
i3440 0    2    .15     .1       .6        .25     .1       .6        1      2      3       4
; Mixer
;    Sta Dur  Ch1  Gain  Pan  Ch2  Gain  Pan  Ch3  Gain  Pan  Ch4  Gain  Pan
i3499 0   2    1    1     1    2    1     0    3    .8    1    4    .8    0
;---------------------------------------------------------------------------
; Tremelo/Gate
;---------------------------------------------------------------------------
i 3402  2.0  2    16000  7.00   0     1   1
i 3402  2.0  2    16000  7.07   0     1   1
i 3402  4.0  2    16000  7.00   0     1   1
i 3402  4.0  2    16000  7.07   0     1   1
; Distortion
;   Sta  Dur  PreGain PostGain  DutyOffset  SlopeShift  InCh  OutCh
i3413 2    4    1       1         1           1           1     2
; Tremelo
;   Sta  Dur  Amp  Freq  Table  Phase InCh  OutCh
i3421 2.0  2    .9   4     1      0     2     3
i3421 4.0  2    .9   4     3      0     2     3
; Mixer
;    Sta Dur  Ch1  Gain  Pan  Ch2  Gain  Pan  Ch3  Gain  Pan  Ch4  Gain  Pan
i3499 2   4    3    1     1    3    1     0    4    0     1    5    0    0
;---------------------------------------------------------------------------
; Panner
;---------------------------------------------------------------------------
i 3402  6.0  2    16000  7.00   0     1   1
i 3402  6.0  2    16000  7.07   0     1   1
i 3402  8.0  2    16000  7.00   0     1   1
i 3402  8.0  2    16000  7.07   0     1   1

; Distortion
;   Sta  Dur  PreGain PostGain  DutyOffset  SlopeShift  InCh  OutCh
i3413 6    4    1       1         1           1           1     2
; Tremelo
;   Sta  Dur  Amp  Freq  Table  Phase InCh  OutCh1  OutCh2
i3423 6.0  2    .9   4     1      0     2     3       4
i3423 8.0  2    .9   4     3      0     2     3       4
; Mixer
;    Sta Dur  Ch1  Gain  Pan  Ch2  Gain  Pan  Ch3  Gain  Pan  Ch4  Gain  Pan
i3499 6   4    3    1     1    4    1     0    4    0     1    5    0    0
;---------------------------------------------------------------------------
; Reverb
;---------------------------------------------------------------------------
i 3402  10.0  .2   16000  7.00   0     1   1
i 3402  10.0  .2   16000  7.07   0     1   1
i 3402  10.6  .2   16000  7.00   0     1   1
i 3402  10.6  .2   16000  7.05   0     1   1
i 3402  11.2  .6   16000  6.10   0     1   1
i 3402  11.2  .6   16000  7.07   0     1   1
; Distortion
;   Sta  Dur  PreGain PostGain  DutyOffset  SlopeShift  InCh  OutCh
i3413 10   2    1       1         1           1           1     2
; Stereo Delay
;   Sta  Dur  Delay1  Feedbk1  XFeedbk1  Delay2  Feedbk2  XFeedbk2  InCh1  InCh2  OutCh1  OutCh2
i3440 10   3    .15     .3       .2        .25     .4       .2        2      2      3       4
; Reverb
;   Sta  Dur  RevTime  HiFDiff  InCh  OutCh
i3445 10   4    3        .3       2     5
i3445 10   4    2.8      .6       2     6
; SubMix
;   Sta  Dur  InCh1  Gain1  InCh2  Gain2  OutCh
i3450 10   4    2      .5     3      .2     7
i3450 10   4    2      .5     4      .2     8
; Mixer
;    Sta Dur  Ch1  Gain  Pan  Ch2  Gain  Pan  Ch3  Gain  Pan  Ch4  Gain  Pan
i3499 10  4    7    1     1    8    1     0    5    .8    1    6    .8    0
;---------------------------------------------------------------------------
; Enhancer
;---------------------------------------------------------------------------
i 3402  14.0  2.0  16000  6.10   0     1    1
i 3402  14.1  1.9  12000  7.07   .     .    .
i 3402  14.2  1.8  13000  8.00   .     .    .
i 3402  14.3  1.7  10400  8.05   .     .    .

; Enhancer
;   Sta  Dur  LoGain  MidGain  HiGain  LoFco  HiFco  DelLow  DelMid  DelHi  InCh  OutCh
i3409  14   2    1.0     1.0      1.0     200    2000   .01     .03     .08    1     2

; Mixer
;    Sta Dur  Ch1  Gain  Pan  Ch2  Gain  Pan  Ch3  Gain  Pan  Ch4  Gain  Pan
i3499 14  2    2    1.8   .5   3    0     .5   3    0     1    3    0     0

;---------------------------------------------------------------------------
; Ring Modulator
;---------------------------------------------------------------------------
i 3402  16.0  2.0  16000  6.00   0     1    1
i 3402  16.0  2.0  16000  7.00   0     1    2

; Ring Mod
;    Sta  Dur  InCh1  InCh2  OutCh
i3424  16   2    1      2      3

; Mixer
;    Sta Dur  Ch1  Gain  Pan  Ch2  Gain  Pan  Ch3  Gain  Pan  Ch4  Gain  Pan
i3499 16  2    3    2     .5   3    0     .5   3    0     1    3    0     0


