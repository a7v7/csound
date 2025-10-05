; SCORE
f1 0 16384 10 1                          ; Sine
f3 0 1024  -7 1 12 1 0 0 1000 0 0 1 12 1 ; Pulse: Wider pulses make softer syncs.

; Synth with sync
;   Sta  Dur  Amp   Pitch  SyncFqc  Fco   Rez
i11 0    1    20000 6.00   .9      5000  20
i11 +    .    .     7.00   .        .     .
i11 .    .    .     8.00   .        .     .
i11 .    .    .     9.00   .        .     .
