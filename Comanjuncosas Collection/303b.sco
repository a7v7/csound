f1 0 16384 10 1
f2  0 1025  19  .5  .5  270  .5
f4  0  16  -2  0 12 0 0 3 0 0 0 0 15 12 0 6 15 1 4; sequencer (pitches are 6.00 + p/100)
f5  0  16  -2  0  1 0 0 0 0 0 0 0  1  0 1 1  1 0 0; accent sequence
f3  0 8193   8  0 512 1 1024 1 512 .5 2048 .2 4096  0; accent curve
f7 0 1024   8 -.8 42 -.78  200 -.74 200 -.7 140 .7  200 .74 200 .78 42 .8
; f7 borrowed from H.Mikelson«s TB-303 emulator. Tnx!

;------------ KNOB POSITION : INITIAL AND FINAL VALUES FROM 0 TO 1--------------------
;   cutoff freq resonance envelope mod. decay       accent     bpm
;     0   -   1  0 ~ 1  ~ .1 - 1  0 - 1       0 - 1   40-300
;       start    end  st  end   st  end  st  end     st  end

i1   0 6  .01       .3      .2  .2   .1   .4   .05          .8      0   0       80
i1   7 6  .95     1       .1  1    .8   1    .1        .01     0      1       70
i1  14 6       0         1         .5  1    .1   1     1    .05     1   1       60
i1  21 6  .5      1       .95 1    1    .9   .01  0         1   1       80
i1  28 6       0         1         .5  1    .1   1     .05  0       .5  1       120
