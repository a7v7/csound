        ; Sine Wave
f1 0 8192 10 1
        ; ADSR Trumpet Envelope  - fig 1.11
f2 0 513 7 0 85.33 1 85.33 .75 85.33 .65  170.66 .50  85.33 0
        ; AR Woodwind Envelope for Carrier - fig 1.12
f3 0 513 7 0 100 1 392 .9 20 0
        ; Gated Woodwind Envelope for Modulator - fig 1.13
f4 0 513 7 0 100 1 412 1
        ; Exponential decaying envelope for bell-like timbres.
f5 0 513 5 1 512 .001
        ; Modification of Exponential envelope for drumlike sounds
f6 0 513 5 .7 16 .8 48 1 64 .8 128 .2 256 .001
        ; Modulator envelope for wood-drum sounds
f7 0 513 7 0 12 1 52 0 460 0
;  st  dur  amp     Fc    Fm1  Fm2 Ceg M1eg M2eg M1ndx1 M1ndx2 M2ndx1 M2ndx2

i1 0   .6   10000   440   440  220   2   2   2     0      4     2      6
i. 1    6
i. 8   .6     .     220   440  880   3   5   5     2      6     0      6
i. 9    6
s
i1 0   .6   10000   110   880   55   3   6   6     0      8     2     12
i. 1    6
i. 8   .6     .     220   440  110   6   7   7     2     22     5     16
i. 9    6
e
