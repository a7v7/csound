f1 0 8192 10 1

; PULSE TABLES
f10  0 1024   7  0 256 0 256 1 256 0 256 0
f11 0 1024   7  0 256 0 128 0 128 1 128 0 128 0 256 0
f12 0 1024   7  0 512 1 512 0
; RATE TABLES
f29  0 1024  -7  .5   1024 .5
; PAN TABLES
f31  0 1024  7  1  1024  0
; MIX TABLES
f41  0 1024  5  .01 128 1 768 1 128 .01

f53 0 1024 -7  .1 1024 .02
;   Sta  Dur  Amp   Pitch  RtTab  RtRt  PanTab  MixTab  Loop  SoundIn
i7  0    1    1     1      29     1     31      41      53    13

