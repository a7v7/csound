;************************************************************
; An assortment of chaotic, fractal and related instruments
; Coded by Hans Mikelson  March 27, 1997
;************************************************************
; 1. The Lorenz Attractor
; 2. The Rossler Attractor
; 3. Planet Orbiting in a Binary Star System

f1 0 8192 10 1

t 0 400

;  Start  Dur Amp  X   Y   Z    S    R   B      h
i1  0     8   600  .6  .6  .6  10   28  2.667  .01
i1  +     .   600  .6  .6  .6  22   28  2.667  .01
i1  .     .   600  .6  .6  .6  32   28  2.667  .01

; Rossler Attractor
;  Start  Dur  Amp   Freq  B  C
i2  24     8   3000   .1   2  4
i2  +      .   4000   .1   3  4
i2  .      .   8000   .04  4  4

; Planetary orbit in a binary star system
;  Start  Dur  Amp      h Mass1 Mass2 Separation
i3  48    16   3000    .5   .4    .34     1.1
i3  60    .    2500    .2   .5    .6      2    
i3  72    .    3000    .3   .5    .5      1

