

; SCORE
f1      0       8192    9       1 1 0 2.5 .5 0 3.5 .333 0 4.5 .25 0 5.5 .20

;inst   start   dur   ratio  OutCh
i1      0       8     1.125  1
i1      0       8     1.875  2
i1      0       8     1.5    3
;
i1      8       8     1.2    1
i1      8       8     1.7778 2
i1      8       8     1.5    3
;
i1     16       8     1.125  1
i1     16       8     1.875  2
i1     16       8     1.5    3

; Just turn on instr 2 and leave it on
; use instr 1 to change the ratios.
;inst   start   dur   amp     freq  InitRatio  InCh
i2      0       24    10000   220   1.125      1
i2      0       24    10000   110   1.875      2
i2      0       24    10000   110   1.5        3

e
