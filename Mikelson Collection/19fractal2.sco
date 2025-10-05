;************************************************************
; AN ASSORTMENT OF CHAOTIC, FRACTAL AND RELATED INSTRUMENTS
; CODED BY HANS MIKELSON  MARCH 9, 1997
;************************************************************
; 1. THE LORENZ ATTRACTOR
; 2. DUFFINGS SYSTEM OR CUBIC OSCILLATOR
; 3. PLANET ORBITING IN A BINARY STAR SYSTEM
; 4. THE ROSSLER ATTRACTOR
; 5. K A OSCILLATOR
; 6. FEATHER FRACTALS
; 7. SIMPLE CHAOS 1
; 8. SIMPLE CHAOS 2


f1 0 8192 10 1

t 0 400

;  START  DUR AMP  X   Y   Z    S    R   B      H
i1  0     8   600  .6  .6  .6  10   28  2.667  .01
i1  +     .   600  .6  .6  .6  22   28  2.667  .01
i1  .     .   600  .6  .6  .6  32   28  2.667  .01
s
f0 1
s
; PLANETARY ORBIT IN A BINARY STAR SYSTEM
;  START  DUR  AMP    FREQ MASS1 MASS2 SEPARATION
i3  0      8   6000    .5   .4    .34     1.1
i3  +      .   5000    .4   .5    .6      2    
i3  .      .   6000    .3   .5    .5      1
s
f0 1
s
; ROSSLER ATTRACTOR
;  START  DUR  AMP   FREQ  B  C
i4  0     8    3000   .1   2  4
i4  +     .    4000   .1   3  4
i4  .     .    8000   .04  4  4
s
f0 1
s
; K A OSCILLATOR
;  START  DUR  AMP   FREQ    X    B
i5  0      8  30000  7.00   .5   3.5
i5  +      8  30000  8.00   .4   3.6
i5  .      8  30000  7.05   .3   3.7
s
f0 1
s
; FEATHER FRACTAL
i6 0  8  1000  .1
s
f0 1
s
; DUFFINGS SYSTEM OR CUBIC OSCILLATOR
;   START  DUR  AMP   FREQ  A     B    C   H
i2   0      1  100  6.00  1    .2   40  .01
i2   +      1  100  5.08  1    .2    .  .01
i2   .      1  100  5.04  1    .2    .  .01
i2   .      1  100  5.00  1    .2    .  .01
i2   .      1  100  4.08  1    .2    .  .01
s
f0 1
s
; SIMPLE ATTRACTOR
;  START  DUR  AMP   FREQ
i7  0     16   6000  8.00
i7  +      2   .     8.02
i7  .      .   .     8.04
i7  .      .   .     8.05
i7  .      .   .     8.07
i7  .      .   .     8.09
i7  .      .   .     8.11
i7  .     12   .     9.00
s
f0 1
s
; SIMPLE ATTRACTOR
;  START  DUR  AMP   FREQ
i8  0      8   4000  8.00
i8  +      2   .     7.00
i8  .      .   .     7.07
i8  .      .   .     7.07
i8  .      .   .     7.09
i8  .      .   .     7.09
i8  .      4   .     7.07
i8  .      2   .     7.05
i8  .      2   .     7.05
i8  .      2   .     7.04
i8  .      2   .     7.04
i8  .      2   .     7.02
i8  .      2   .     7.02
i8  .      4   .     7.00
s
f0 1
s
; SIMPLE ATTRACTOR
;  START  DUR  AMP   FREQ  LOOPS
i9  0     4   3000   6.05  20
i9  +     2   .      5.00  .
i9  .     .   .      5.07  .
s
f0 1
s
; SIMPLE ATTRACTOR
;   START  DUR  AMP   FREQ  LOOPS
i10  0     4   3000   6.05  4
i10  +     2   .      7.00  .
i10  .     .   .      7.07  .
s
f0 1
s
; SIMPLE ATTRACTOR
;   START  DUR  AMP   FREQ  LOOPS
i11  0     4   3000   6.05  20
i11  +     2   .      5.00  .
i11  .     .   .      5.07  .
