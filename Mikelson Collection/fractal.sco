;************************************************************
; An assortment of chaotic, fractal and related instruments
; Coded by Hans Mikelson  March 9, 1997
;************************************************************
; 1. The Lorenz Attractor
; 2. Duffings System or Cubic Oscillator
; 3. Planet Orbiting in a Binary Star System
; 4. The Rossler Attractor
; 5. K A Oscillator


f1 0 8192 10 1

t 0 400

;  Start Dur   A1   B1    C1     Time (dT)  Amplitude  KZoom  A2  B2  C2
i1  0     4    22   28   2.667      .01       600     3      5   0    0
i1  4     4    26   28   2.667      .01       600     4      0   10   0

; Planetary orbit in a binary star system
;  Start  Dur  Amp    Freq Mass1 Mass2 Separation
i3  8      4   6000    .5   .4    .34     1.1
i3  +      .   5000    .4   .5    .6      2    
i3  .      .   6000    .3   .5    .5      1

; Rossler Attractor
;  Start  Dur  Amp   Freq  B  C
i4  20     4   2000   .1   2  4
i4  +      .   2000   .1   3  4
i4  .      .   2000   .04  4  4

; K A Oscillator
;  Start  Dur  Amp    X     B
i5  32    4  30000    .5   3.5
i5  +     4  30000    .4   3.6
i5  .     4  30000    .3   3.7
