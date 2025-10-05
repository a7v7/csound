;----------------------------------------------------------------------
; MULTI-FEEDBACK REVERBS
; CODED SEPTEMBER 1998
; BY HANS MIKELSON
;----------------------------------------------------------------------

f1 0 8192 10 1

a0 0  47

;----------------------------------------------------------------------
; IMPULSE RESPONSE
;----------------------------------------------------------------------
;  Sta  Dur  Amp    OutCh  Fco
;i1 0    .1   30000  1      5000

;----------------------------------------------------------------------
; DRY SOUND
;----------------------------------------------------------------------
;  Sta  Dur  Amp  Rate  Soundin  OutCh1  OutCh2
i3 0    2.4  .8   1     11       1       2

;----------------------------------------------------------------------
; ECHO REVERB
;----------------------------------------------------------------------
;  Sta  Dur  Amp  Rate  Soundin  OutCh1  OutCh2
i3 5    2.4  .8   1     11       1       2
;    Sta  Dur   Amp  InCh  FdBack  Fco   Fadj   Time1  Time2  OutCh
i38  5.0  5.0   1    1     .45     8070  .8     259    453    5
i38  5.0  5.0   1    2     .45     8070  .8     241    451    6
;    Sta  Dur   Amp  InCh1  InCh2
i91  5.0  5.0   .5   5      6

;----------------------------------------------------------------------
; BATHROOM REVERB
;----------------------------------------------------------------------
;  Sta  Dur  Amp  Rate  Soundin  OutCh1  OutCh2
i3 10   2.4  .8   1     11       1       2
;    Sta  Dur  Amp  InCh  FdBack   Fco   Fadj  Time1  Time2  Time3  Time4  OutCh  HPFco
i36 10.0  5.0  1    1     1.1      8000  .8    25     45     58     73     3      200
i36 10.0  5.0  1    2     1.1      8000  .8    22     41     53     77     4      200
;    Sta  Dur   Amp  InCh1  InCh2
i91 10.0  5.0   .4   3      4

;----------------------------------------------------------------------
; LIVE ROOM REVERB
;----------------------------------------------------------------------
; Impulse Response
;  Sta  Dur  Amp    OutCh  Fco
;i1 15   .1   15000  1      5000
;i1 15   .1   15000  2      5000
;  Sta  Dur  Amp  Rate  Soundin  OutCh1  OutCh2
i3 15   2.4  .8   1     11       1       2
;    Sta  Dur  Amp  InCh  FdBack   Fco   Fadj  Time1  Time2  Time3  Time4  OutCh  HPFco
i36 15.0  4.0  1    1     1.1      8010  .8    45     73     104    163    3      200
i36 15.0  4.0  1    2     1.1      8200  .8    42     74     103    154    4      200
;    Sta  Dur   Amp  InCh1  InCh2
i91 15.0  4.0   2    3      4

;----------------------------------------------------------------------
; MEDIUM ROOM REVERB
;----------------------------------------------------------------------
;  Sta  Dur  Amp  Rate  Soundin  OutCh1  OutCh2
;i3 20   2.4  .8   1     11       1       2
;    Sta  Dur  Amp  InCh  FdBack   Fco1  Fadj  Time1  Time2  Time3  Time4  OutCh  HPFco
;i27 20.0  5.0  1    1     1.0      4010  .8    45     73     104    163    3      200
;i27 20.0  5.0  1    2     1.0      4200  .8    42     74     103    154    4      200
;    Sta  Dur   Amp  InCh1  InCh2
;i91 20.0  5.0   .4   3      4

;----------------------------------------------------------------------
; DEAD ROOM REVERB
;----------------------------------------------------------------------
;  Sta  Dur  Amp  Rate  Soundin  OutCh1  OutCh2
;i3 25   2.4  .8   1     11       1       2
;    Sta  Dur  Amp  InCh  FdBack   Fco   Fadj  Time1  Time2  Time3  Time4  OutCh  HPFco
;i27 25.0  5.0  1    1     .25      2010  .8    45     73     104    163    3      100
;i27 25.0  5.0  1    2     .25      2200  .8    42     74     103    154    4      100
;    Sta  Dur   Amp  InCh1  InCh2
;i91 25.0  5.0   .4   3      4

;----------------------------------------------------------------------
; LIVE LARGE ROOM REVERB
;----------------------------------------------------------------------
;  Sta  Dur  Amp    OutCh  Fco
;i1 30   .1   15000  1      5000
;i1 30   .1   15000  2      5000
;    Sta  Dur  Amp  Rate  Soundin  OutCh1  OutCh2
i3   30   2.4  .8   1     11       1       2
;    Sta  Dur   Amp  InCh  FdBack   Fco   Fadj  Time1  Time2  Time3  OutCh
i37  30.0 4.0   1    1     1.2     4070  .9    68     151    273    3
i37  30.0 4.0   1    2     1.2     4260  .9    62     133    231    4
;    Sta  Dur   Amp  InCh1  InCh2
i91  30.0 4.0   .5   3      4

;----------------------------------------------------------------------
; DEAD LARGE ROOM REVERB
;----------------------------------------------------------------------
;    Sta  Dur  Amp  Rate  Soundin  OutCh1  OutCh2
i3   35   2.4  .8   1     11       1       2
;    Sta  Dur   Amp  InCh  FdBack   Fco   Fadj  Time1  Time2  Time3  OutCh
i37  35.0 5.0   1    1     1.2      1070  .8    68     154     273   3
i37  35.0 5.0   1    2     1.2      1260  .8    61     152     277   4
;    Sta  Dur   Amp  InCh1  InCh2
i91  35.0 5.0   .2   3      4

;----------------------------------------------------------------------
; CATHEDRAL REVERB
;----------------------------------------------------------------------
;    Sta   Dur  Amp   Rate  Soundin  OutCh1  OutCh2
i3   40    2.4  .8    1     11       1       2
;    Sta   Dur  Amp   InCh  FdBack   Fco1  Fadj  Time1  Time2  Time3  Time4  OutCh  HPFco
i36  40.0  7.0  1     1     1.1      8010  .8    75     163    294    493    3      200
i36  40.0  7.0  1     2     1.1      8200  .8    72     164    293    474    4      200
;    Sta   Dur   Amp  InCh  FdBack1  Fco   Fadj  Time1  Time2  Time3  OutCh
i37  40.0  7.0   1    3     1.2      6070  .8    68    204    373     5
i37  40.0  7.0   1    4     1.2      6260  .8    61    202    377     6
;    Sta   Dur   Amp  InCh1  InCh2
i91  40.0  7.0   .5   3      4
i91  40.0  7.0   .5   5      6

;----------------------------------------------------------------------
; CAVEMAN
;----------------------------------------------------------------------
; IMPULSE RESPONSE
;  Sta  Dur  Amp    OutCh  Fco
i1 47   .1   30000  1      8000
i1 47   .1   30000  2      8000
;    Sta  Dur  Amp  Rate  Soundin  OutCh1  OutCh2
;i3   47   2.5  .8   1     11       1       2
;    Sta  Dur  Amp  InCh  FdBack  Fco   Fadj  Time1  Time2  Time3  Time4  OutCh  HPFco
i36  47.0 2.0  1    1     1.5     3000  .8    5      18     24     30     3      400
i36  47.0 2.0  1    2     1.5     3000  .8    7      11     29     34     4      400
;    Sta  Dur  Amp  InCh  FdBack  Fco   Fadj  Time1  Time2  Time3  OutCh  FcHP
i37  47.0 2.0  1    3     1.0     2000  .7    48     57     83     5      ;1000
i37  47.0 2.0  1    4     1.0     2000  .7    52     62     87     6      ;1000
;    Sta  Dur  Amp  InCh  FdBack  Fco   Fadj Time1  Time2  Time3  OutCh  FcHP
;i37  47.0 2.0  1    3     1.1     2200  .9   90     134    253    7      ;1300
;i37  47.0 2.0  1    4     1.1     2200  .9   95     132    217    8      ;1300
;    Sta  Dur  Amp  InCh  FdBack  Fco   Fadj  Time1  Time2  OutCh  FcHP
;i38  47.0 2.0  1    5     0.8     1000  .8    183    353    9      ;1800
;i38  47.0 2.0  1    6     0.8     1000  .8    181    321    10     ;1800
;    Sta  Dur  Amp  InCh1  InCh2
i91  47.0 2.0  .75  3      4
i91  47.0 2.0  .76  5      6
;i91  47.0 2.0  .72  7      8
;i91  47.0 2.0  .85  9      10


