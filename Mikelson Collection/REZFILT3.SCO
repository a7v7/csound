; *********************************************************
; Rezzy Synth
; coded:  Hans Mikelson 2/7/97
;**********************************************************
; f1=Sine, f2=Square, f3=Sawtooth, f4=Triangle, f5=Sqare2, f6=Mandel
;**********************************************************
f1  0  1024  10   1
f2  0   256   7  -1 128 -1   0  1 128  1
f3  0   256   7   1 256 -1
f4  0   256   7  -1 128  1 128 -1
f5  0   256   7   1  64  1   0 -1 192 -1
f6  0  8192   7   0 2048  0   0 -1 2048 -1 0 1 2048 1 0 0 2048 0

; Distortion Table
f7  0   1024    8   -.8     42  -.78    400     -.7     140     .7      400     .78     42  .8

; SCORE ***************************************************

t   0   400

; FM 2 POLE FILTER
;       Start   Dur     Amp     Pitch       Fco     Rez     Table   Carrier     Modulator
i1     0       2       5000    7.05        50      50      1       1           2
s
; 4 POLE FILTER
;       Start   Dur     Amp     Pitch       Fco1    Rez1    Fco2    Rez2        Table   
i2     0       2       4000    8.00        70      20      70      20          3
i2     +       2       2000    8.03        60      25      60      25          2
s
; 6 POLE FILTER
;       Start   Dur     Amp     Pitch       Fco1    Rez1    Fco2    Rez2    Fco3    Rez3    Table   
i3     0       8       1800    7.11        200     5       80      15      30      10      2
i3     +       8       2000    6.05        100     8       40      12      22      10      3
s
; MANDELBROT SNOWFLAKE 4 POLE FILTER
;       Start   Dur     Amp     Pitch       Fco1    Rez1    Amp2    Amp3
i4     0       4       6000    8.00        100     8       0       0
i4     +       4       3000    8.00        100     8       3000    0
i4     .       4       2000    8.00        100     8       2000    2000
s
; KOCH'S SNOWFLAKE 4 POLE FILTER
;       Start   Dur     Amp     Pitch       Fco1    Rez1    Amp2    Amp3    Amp4    Amp5
i5     0       4       6000    7.00        100     10      0       0       0       0
i5     +       4       4000    7.00        80      10      4000    0       0       0
i5     .       4       2200    7.00        100     10      2200    2200    0       0
i5     .       4       1800    7.00        80      10      1800    1800    1800    0
i5     .       4       1500    7.00        100     8       1500    1500    1500    1500
s
;       Start   Dur     Amp     Pitch       Fco1    Rez1    Table   
i7      0       2       4000    8.00        100     10      3
