;ORC
; Coded by Hans Mikelson October 1999

sr      =        44100                      ; Sample rate
kr      =        4410                       ; Kontrol rate
ksmps   =        10                         ; Samples/Kontrol period
nchnls  =        2                          ; Normal stereo
        zakinit  50,50                      ; May need this later

;---------------------------------------------------------
; Terrain Lead 1
;---------------------------------------------------------
       instr     1

idur   =         p3            ; Duration
iamp   =         p4            ; Amplitude
ifqc   =         cpspch(p5)    ; Pitch to frequency
ipanl  =         sqrt(p6)      ; Pan left
ipanr  =         sqrt(1-p6)    ; Pan right
iplsf  =         p7            ; Frequency modifier
iwahrt =         p8            ; Wah rate
iwahtb =         p9            ; Wah table
ipbnd  =         p10           ; Pitch Bend Table

kpbnd  oscili    1, 1/idur, ipbnd                      ; Pitch bend
kwrt   linseg    1, idur*.3, 1.5, idur*.7, .2          ; Pulse width rate
kdclk  linseg    0, idur*.3, 1, idur*.4, 1, idur*.3, 0 ; Declick

asin   oscili    1, iplsf, 1         ; Sine wave pulse frequency
ar     =         asin*asin           ; Make it positive

armp   oscili    100, iwahrt*kwrt, iwahtb ; PWM
ayi    oscili    ar*armp, iplsf, 1   ; Y
ayf    =         .1/(.1+ayi*ayi)     ; Sort of a square pulse wave at this point

asig   oscili    1, ifqc*kpbnd, 1    ; Sine oscillator with pitch bend

       outs      ayf*iamp*asig*kdclk*ipanl, ayf*iamp*asig*kdclk*ipanr ; Output the sound

       endin
