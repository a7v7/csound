nchnls = 2
; ORC
;---------------------------------------------------------
; Percussion
;---------------------------------------------------------
       instr     18

idur   =         p3            ; Duration
iamp   =         p4            ; Amplitude
ifqc   =         cpspch(p5)    ; Pitch to frequency
ipanl  =         sqrt(p6)      ; Pan left
ipanr  =         sqrt(1-p6)    ; Pan right
itime  =         p7            ; Reverb time
ifdbk  =         p8            ; Feedback level
idecay =         p9            ; Impulse decay time
isweep =         p10           ; Delay sweep
iq     =         p11           ; Resonance/Q

adel   init      0

kdclck linseg    1, idur-.002, 1, .002, 0 ; Declick envelope
kclk   linseg    1, idecay, 0, idur-idecay, 0 ; Generate a click
ktime  expseg    itime, idur, itime*isweep

anois  rand      kclk                         ; Genrate impulse
asig   rezzy     anois*5, ifqc, iq, 1         ; High pass rezzy



adel   vdelay3    (asig+adel)*ifdbk, ktime*1000, 1000

aout   =         (adel+asig)*iamp*kdclck
       outs      aout*ipanl, aout*ipanr            ; Output the sound

       endin
