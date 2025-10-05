f1 0 16384 10 1
f2 0 1024  -7 1 256 1 56 2 200 2 56 1.5 200 1.5 56 1 200 1
f3 0 1024  -7 1 1024 1


; LFO NOTE 0<PWM<1
;   STA  DUR  AMP  FQC  WAVE  OFFSET  OUTCH
i5  0    2    .9   .5   1     .5       1

; SYNTH WAVE 1=SAW, 2=SQUARE/PWM, 3=TRI/SAW-RAMP-MOD
;   STA  DUR  AMP   PITCH  FCO   REZ  WAVE  PULSEWCH  PBEND  MODE
i12 0.0  .6   10000 7.00   8000  10   1     1         3      0
i12 0.5  .    .     6.03   .     .    2     .         .      0
i12 1.0  .    .     8.05   .     .    2     .         .      0
i12 1.5  .    .     7.07   .     .    3     .         .      0

