; 1. NOISE CLICK
; 2. DISK INPUT
; 3. BAND-LIMITED IMPULSE
; 8. SIMPLE SUM
; 9. FEEDBACK FILTER
;10. DELAY
;11. SIMPLE ALL-PASS FILTER
;12. NESTED ALL-PASS FILTER
;13. DOUBLE NESTED ALL-PASS FILTER
;15. OUTPUT 

f1 0 16384 10 1                               ; SINE

;-------------------------------------------------------------------------------
; NO REVERB
;-------------------------------------------------------------------------------
;   STA   DUR       AMP       PITCH          SOUNDIN        OUTCH     FCO
i2  0.0   4.0       .8        1              11             1         10000

;-------------------------------------------------------------------------------
; SMALL ROOM
;-------------------------------------------------------------------------------
;   STA   DUR       AMP       PITCH          OUTCH
;i1 4.5  .01        30000     1

;   STA   DUR       AMP       PITCH          SOUNDIN        OUTCH     FCO
i2  4.5   4.0       0.5       1              11             1         6000

;   STA   DUR       FCO       GAIN           INCH1          INCH2     OUTCH
i9  4.5   4.5       1600      .5             1              5         2

;   STA   DUR       TIME      GAIN           INCH           OUTCH
i10 4.5   4.5       24        1.0            2              3

;   STA   DUR       TIME1     GAIN1          TIME2          GAIN2     TIME3  GAIN3        INCH  OUTCH
i13 4.5   4.5       35        .15            22             .25       8.3    .30          3     4

;   STA   DUR       GAIN      INCH
i15 4.5   4.5       .6        4

;   STA   DUR       TIME1     GAIN1          TIME2          GAIN2     INCH      OUTCH
i12 4.5   4.5       66        .08            30             .3        4         5

;   STA   DUR       GAIN      INCH
i15 4.5   4.5       .6        5

;-------------------------------------------------------------------------------
; MEDIUM ROOM
;-------------------------------------------------------------------------------
;   STA   DUR       AMP       PITCH          SOUNDIN        OUTCH     FCO
i2  9.0   4.0       0.5       1              11             1         6000

;   STA   DUR       FCO       GAIN           INCH1          INCH2     OUTCH
i9  9.0   4.5       1000      .4             1              10        2

;   STA   DUR       TIME1     GAIN1          TIME2          GAIN2     TIME3  GAIN3    INCH  OUTCH
i13 9.0   4.5       35        .25            8.3            .35       22     .45      2     3

;   STA   DUR       GAIN      INCH
i15 9.0   4.5       .5        3

;   STA   DUR       TIME      GAIN           INCH           OUTCH
i10 9.0   4.5       5         1.0            3              4

;   STA   DUR       TIME1     GAIN1          INCH           OUTCH
i11 9.0   4.5       30        .45            4              5

;   STA   DUR       TIME      GAIN           INCH           OUTCH
i10 9.0   4.5       67        1.0            5              6

;   STA   DUR       GAIN      INCH
i15 9.0   4.5       .5        6

;   STA   DUR       TIME      GAIN           INCH           OUTCH
i10 9.0   4.5       15        .4             6              7

;   STA   DUR       INCH1     INCH2          OUTCH
i8  9.0   4.5       1.2       7              8

;   STA   DUR       TIME1     GAIN1          TIME2          GAIN2     INCH      OUTCH
i12 9.0   4.5       39        .25            9.8            .35       8         9

;   STA   DUR       GAIN      INCH
i15 9.0   4.5       .5        9

;   STA   DUR       TIME      GAIN           INCH           OUTCH
i10 9.0   4.5       108       1.0            9              10

;-------------------------------------------------------------------------------
; LARGE ROOM
;-------------------------------------------------------------------------------
;   STA   DUR       AMP       PITCH          SOUNDIN        OUTCH     FCO
i2  13.5  4.0       0.5       1              11             1         4000

;   STA   DUR       FCO       GAIN           INCH1          INCH2     OUTCH
i9  13.5  5.0       1000      .5             1              10        2

;   STA   DUR       TIME1     GAIN1          INCH           OUTCH
i11 13.5  5.0       8         .3             2              3

;   STA   DUR       TIME1     GAIN1          INCH           OUTCH
i11 13.5  5.0       12        .3             3              4

;   STA   DUR       TIME      GAIN           INCH           OUTCH
i10 13.5  5.0       4         1.0            4              5

;   STA   DUR       GAIN      INCH
i15 13.5  5.0       1.5       5

;   STA   DUR       TIME      GAIN           INCH           OUTCH
i10 13.5  5.0       17        1.0            5              6

;   STA   DUR       TIME1     GAIN1          TIME2          GAIN2     INCH      OUTCH
i12 13.5  5.0       87        .5             62             .25       6         7

;   STA   DUR       TIME      GAIN           INCH           OUTCH
i10 13.5  5.0       31        1.0            7              8

;   STA   DUR       GAIN      INCH
i15 13.5  5.0       .8        8

;   STA   DUR       TIME      GAIN           INCH           OUTCH
i10 13.5  5.0       3         1.0            8              9

;   STA  DUR  TIME1  GAIN1  TIME2  GAIN2  TIME3  GAIN3  INCH  OUTCH
i13 13.5 5.0  120    .5     76     .25    30     .25    9     10

;   STA  DUR  GAIN   INCH
i15 13.5 5.0  .8     10




