;------------------------------------------------------------------------------
; MODIFIED HYPERBOLIC DISTORTION
; CODED BY HANS MIKELSON DECEMBER 1998
;------------------------------------------------------------------------------
sr             =              44100
kr             =              4410
ksmps          =              10
nchnls         =              2
               zakinit        50, 50

;------------------------------------------------------------------------------
; PLUCKED INSTRUMENT
;------------------------------------------------------------------------------
               instr          1

idur           =              p3                            ; DURATION
iamp           =              p4                            ; AMPLITUDE
ipch           =              cpspch(p5)                    ; PITCH
itab1          =              p6
ioutch         =              p7                            ; OUT CHANNEL

asig           pluck          iamp, ipch, ipch, itab1, 1    ; GENERATE A PLUCKED TONE
               zawm           asig, ioutch                  ; MIX TO THE ZAK CHANNEL

               endin

;------------------------------------------------------------------------------
; SINE WAVE
;------------------------------------------------------------------------------
               instr          2

idur           =              p3                                 ; DURATION
iamp           =              p4                                 ; AMPLITUDE
ifqc           =              cpspch(p5)                         ; PITCH
itab1          =              p6
ioutch         =              p7                                 ; OUT CHANNEL

asig           oscil          iamp, ifqc, itab1                  ; GENERATE A PLUCKED TONE
               zawm           asig, ioutch                       ; MIX TO THE ZAK CHANNEL

               endin

;------------------------------------------------------------------------------
; TANH DISTORTION
;------------------------------------------------------------------------------
               instr          11

idur           =              p3
kpregn         =              p4/8000                            ; PREGAIN/OVERDRIVE
kpostg         =              p5*20000                           ; POSTGAIN/VOLUME
ka1            =              p6/8000                            ; SHAPE 1 0=FLAT
ka2            =              p7/8000                            ; SHAPE 2
irect          =              p8                                 ; RECTIFICATION
iinch          =              p9                                 ; INPUT CHANNEL
ioutch         =              p10                                ; OUTPUT CHANNEL
ioutlvl        =              p11                                ; OUTPUT LEVEL

kdclick        linseg         0, .002, 1, idur-.004, 1, .002, 0  ; DECLICK ENVELOPE

asig           zar            iinch
krms           rms            asig, 10
asig           =              asig + irect*krms

koffs1         =              irect*krms*(p4/1000+(p6-.5)/8000)
koffs2         =              -irect*krms*(p4/1000+(p7-.5)/8000)
koffs3         =              irect*krms*p4/1000
koffs          =              (exp(koffs1)-exp(koffs2))/(exp(koffs3)+exp(-koffs3))


ax1            =              asig*(kpregn+ka1)   ; PRECALCULATE A FEW VALUES TO SAVE TIME
ax2            =              -asig*(kpregn+ka2)
ax3            =              asig*kpregn

aout           =              ((exp(ax1)-exp(ax2))/(exp(ax3)+exp(-ax3))-koffs)*kpostg                                        ; MODIFIED TANH DISTORTION

               zaw            aout*kdclick, ioutch                         ; OUTPUT THE RESULT
               outs           aout*kdclick*ioutlvl, aout*kdclick*ioutlvl   ; OUTPUT THE RESULT

               endin

;------------------------------------------------------------------------------
; CLEAR ZAK
;------------------------------------------------------------------------------
               instr          99
               zacl           0, 50
               zkcl           0, 50
               endin
     
