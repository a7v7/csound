;SCORE

; a sine wave
f1 0 8193 10 1

; feedback adjusting curve
f20 0 8193 -25 0 4 8192 1

; tuning curve
f21 0 8193 -27 0 -1 2048 -.22 4096 .4 6144 .83 7168 .92 8192 1

;      resonance max fco initial & final fco
i1 0 1   .1       1000     200
i1 1 5    .8     5000    500
i1 6 5   .5      10000      50
i1 11 5  .99        8000     20
e
