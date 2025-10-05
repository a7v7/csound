; Mikelson Cymbal ORCHESTRA
sr      =        44100                      ; Sample rate
kr      =        44100                      ; Kontrol rate
ksmps   =        1                          ; Samples/Kontrol period
nchnls  =        2                          ; Normal stereo

;---------------------------------------------------------
; Cymbal
;---------------------------------------------------------
       instr     17

idur   =         p3            ; Duration
iamp   =         p4/(1+sqrt(p3))*.3*sqrt(p8) ; Amplitude
ifqc   =         cpspch(p5)
ipanl  =         sqrt(p6)      ; Pan left
ipanr  =         sqrt(1-p6)    ; Pan right
iqfqc  =         p7            ; Primary resonance
iqq    =         p8            ; Resonance Q
iqact  =         p9*.02        ; Resonance accent
iotfqc =         p10           ; Overtone frequency
iotq   =         p10*.25       ; Overtone bandwidth
iotact =         .02           ; Overtone accent
ilpfco =         p10*1.25      ; Lowpass
iaact  =         p11*.001      ; Amplitude accent
ipbend =         p12
iptim  =         p13

adclck linseg    0, .002, 1, idur-.004, 1, .002, 0 ; Declick envelope
kamp   expseg    1, idur, iaact
kamp2  expseg    2, idur, iqact
kamp3  expseg    1, idur, iotact
kptch  expseg    ipbend, iptim, 1, idur-iptim, 1

arnd   rand      kamp2

asig1  vco       1, ifqc*kptch,     2, .5, 1, 2/ifqc     ; Genrate impulse
asig2  vco       1, ifqc*1.3*kptch, 2, .5, 1, 2/ifqc     ; Genrate impulse
;asig3  vco       1, ifqc*.573, 2, .5, 1, 2/ifqc     ; Genrate impulse
asig   =         (asig1*asig2*(1+arnd))*iamp*adclck*kamp

aout1  rezzy    asig, iqfqc, iqq, 1  ; Apply amp envelope and declick
aout2  butterbp aout1*kamp3, iotfqc, iotq   ; Apply amp envelope and declick
aout   butterlp aout1+aout2*4, ilpfco       ; Apply amp envelope and declick

       outs      aout*ipanl, aout*ipanr            ; Output the sound

       endin
