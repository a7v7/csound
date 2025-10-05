; 1. Noise Click
; 2. Disk Input
; 3. Band-Limited Impulse
; 8. Simple Sum
; 9. Feedback Filter
;10. Delay
;11. Simple All-Pass Filter
;12. Nested All-Pass Filter
;13. Double Nested All-Pass Filter
;15. Output 

f1 0 16384 10 1                               ; Sine

;---------------------------------------------------------------------------
; No Reverb
;---------------------------------------------------------------------------
;   Sta  Dur  Amp  Pitch  SoundIn  OutCh  Fco
i2  0.0  4.0  .8   1      11       1      10000

;---------------------------------------------------------------------------
; Small Room
;---------------------------------------------------------------------------
;   Sta  Dur  Amp    Pitch  OutCh
;i1  4.5  .01  30000     1 
;   Sta  Dur  Amp  Pitch  SoundIn  OutCh  Fco
i2  4.5  4.0  0.5  1      11       1      6000
;   Sta  Dur  Fco   Gain  InCh1  InCh2  OutCh
i9  4.5  4.5  1600  .5    1      5      2
;   Sta  Dur  Time  Gain  InCh  OutCh
i10 4.5  4.5  24    1.0   2     3
;   Sta  Dur  Time1  Gain1  Time2  Gain2  Time3  Gain3  InCh  OutCh
i13 4.5  4.5  35     .15    22     .25    8.3    .30    3     4
;   Sta  Dur  Gain   InCh
i15 4.5  4.5  .6     4
;   Sta  Dur  Time1  Gain1  Time2  Gain2  InCh  OutCh
i12 4.5  4.5  66     .08    30     .3     4     5
;   Sta  Dur  Gain   InCh
i15 4.5  4.5  .6     5

;---------------------------------------------------------------------------
; Medium Room
;---------------------------------------------------------------------------
;   Sta  Dur  Amp  Pitch  SoundIn  OutCh  Fco
i2  9.0  4.0  0.5  1      11       1      6000
;   Sta  Dur  Fco  Gain  InCh1  InCh2  OutCh
i9  9.0  4.5  1000 .4    1      10     2
;   Sta  Dur  Time1  Gain1  Time2  Gain2  Time3  Gain3  InCh  OutCh
i13 9.0  4.5  35     .25    8.3    .35    22     .45    2     3
;   Sta  Dur  Gain   InCh
i15 9.0  4.5  .5     3
;   Sta  Dur  Time  Gain  InCh  OutCh
i10 9.0  4.5  5     1.0   3     4
;   Sta  Dur  Time1  Gain1  InCh  OutCh
i11 9.0  4.5  30     .45    4     5
;   Sta  Dur  Time  Gain  InCh  OutCh
i10 9.0  4.5  67    1.0   5     6
;   Sta  Dur  Gain   InCh
i15 9.0  4.5  .5     6
;   Sta  Dur  Time  Gain  InCh  OutCh
i10 9.0  4.5  15    .4    6     7
;   Sta  Dur  InCh1  InCh2  OutCh
i8  9.0  4.5  1.2    7      8
;   Sta  Dur  Time1  Gain1  Time2  Gain2  InCh  OutCh
i12 9.0  4.5  39     .25    9.8    .35    8     9
;   Sta  Dur  Gain   InCh
i15 9.0  4.5  .5     9
;   Sta  Dur  Time  Gain  InCh  OutCh
i10 9.0  4.5  108   1.0   9     10

;---------------------------------------------------------------------------
; Large Room
;---------------------------------------------------------------------------
;   Sta  Dur  Amp  Pitch  SoundIn  OutCh  Fco
i2  13.5 4.0  0.5  1      11       1      4000
;   Sta  Dur  Fco  Gain  InCh1  InCh2  OutCh
i9  13.5 5.0  1000 .5    1      10     2
;   Sta  Dur  Time1  Gain1  InCh  OutCh
i11 13.5 5.0  8      .3     2     3
;   Sta  Dur  Time1  Gain1  InCh  OutCh
i11 13.5 5.0  12     .3     3     4
;   Sta  Dur  Time  Gain  InCh  OutCh
i10 13.5 5.0  4     1.0   4     5
;   Sta  Dur  Gain   InCh
i15 13.5 5.0  1.5   5
;   Sta  Dur  Time  Gain  InCh  OutCh
i10 13.5 5.0  17    1.0   5     6
;   Sta  Dur  Time1  Gain1  Time2  Gain2  InCh  OutCh
i12 13.5 5.0  87     .5     62     .25    6     7
;   Sta  Dur  Time  Gain  InCh  OutCh
i10 13.5 5.0  31    1.0   7     8
;   Sta  Dur  Gain   InCh
i15 13.5 5.0  .8     8
;   Sta  Dur  Time  Gain  InCh  OutCh
i10 13.5 5.0  3     1.0   8     9
;   Sta  Dur  Time1  Gain1  Time2  Gain2  Time3  Gain3  InCh  OutCh
i13 13.5 5.0  120    .5     76     .25    30     .25    9     10
;   Sta  Dur  Gain   InCh
i15 13.5 5.0  .8     10
