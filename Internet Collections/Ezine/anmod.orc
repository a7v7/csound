;----------------------------------------------
; REAL TIME MIDI CONTROLLED CSOUND
; BY HANS MIKELSON  MARCH 1999
; TESTED WITH MALDONADOS CSOUND ON A 300 MHZ PENTIUM
; I USE THE FOLLOWING ONE LINE BATCH FILE CSM.BAT:
; CSOUND -+K -+Q -B128 -+P4 -+O %1.ORC %1.SCO
; CALLED AS FOLLOWS FOR ANMOD.ORC & ANMOD.SCO:
; CSM ANMOD
;----------------------------------------------
sr             =              44100
kr             =              4410
ksmps          =              10
nchnls         =              2
gifqc          init           440

;-----------------------------------------------------------
; SIMPLE ANALOG SAW
;-----------------------------------------------------------
               instr          1

ivel           veloc                                   ; VELOCITY
iamp           tablei         ivel, 3                  ; CONVERT TO AMPLITUDE
ifqc           cpsmidi                                 ; GET THE NOTE IN CPS

;                             Amp    Rise, Dec, AtDec
kamp           linenr         iamp, .05,  .05, .05     ; DECLICK ENVELOPE

; LOW PASS FILTER FREQUENCY
kfce           expseg         .2, .1, 1, .2, .8, .1, .8     ; FCO ENVELOPE
kfcs           midictrl       50, 10                        ; FCO CONTROLLER
kfco           tablei         kfce*kfcs, 2                  ; CHANGE SCALING FORM 0-127 TO 20-20000

; LOW PASS FILTER RESONANCE
krzs           midictrl       56, 20                        ; Q CONTROLLER
krez           =              krzs*.01                      ; ADJUST 0-127 TO 0-1.27

;                             Amp Fqc   Wave PW   Sine Delay
asig           vco            1, ifqc, 1,   1,   1,   .1    ; OSCILLATOR 1
aout           moogvcf        asig, kfco,   krez            ; FILTER 1

               outs           aout*kamp, aout*kamp          ; OUTPUT

               endin

;-----------------------------------------------------------
; CHORUS SWEEP SAW PAD
;-----------------------------------------------------------
               instr 2

iwave          =              1                             ; SINE
ivel           veloc                                        ; VELOCITY
iamp           tablei         ivel, 3                       ; CONVERT TO AMP
ifqc           cpsmidi                                      ; GET THE NOTE IN CPS
irtfq          =              sqrt(ifqc)                    ; SQRT(FREQUENCY)
iofqc          =              1/ifqc                        ; 1/FREQUENCY
ifqcl          =              ifqc*.998                     ; STEREO DETUNING FOR LEFT OSCILLATOR
ifqcr          =              ifqc*1.002                    ; STEREO DETUNING FOR RIGHT OSCILLATOR

;               Amp   Rise, Dec, AtDec
kamp           linenr     iamp, .2,  .2, .2                 ; DECLICK ENVELOPE

klfo2          oscil          .2, .5, 1                     ; LOW FREQUENCY SWEEP
kfce           expseg         .2, .1, 1, .2, .8, .1, .8     ; FCO ENVELOPE
kfcs           midictrl       50, 10                        ; FCO CONTROLLER
kfc2           tablei         kfce*kfcs*(1+klfo2), 2        ; CHANGE SCALING FORM 0-127 TO 20-20000
kfc3           =              kfce*kfc2*irtfq               ; SWEEP FREQUENCY AND AVOID STEPPING
kfc4           =              (kfc3 <= 10000) ? kfc3 : 10000
kfco           port           kfc4, .01

krzs           midictrl       56                            ; Q CONTROLLER
krezm          =              krzs*.01                      ; ADJUST 0-127 TO 0-1.27

kmw            midictrl 1                                   ; MODWHEEL
klfo1          oscil          kmw*.0001, 6, 1
kvbr           =              1+klfo1

asig2          vco            1, ifqcl*kvbr*1.01, 1,    1,   1,   iofqc    ; OSCILLATOR 1

;                             Amp Fqc        Wave  PW   Sine Delay
asigl          vco            1, ifqcl*kvbr, 1,    1,   1,   iofqc         ; OSCILLATOR 1
aoutl          moogvcf        asigl+asig2, kfco, krezm                     ; FILTER 1

asigr          vco            1,  ifqcr*kvbr, 1,   1,   1,   iofqc         ; OSCILLATOR 2
aoutr          moogvcf        asigr-asig2, kfco, krezm                     ; FILTER 2

               outs           aoutl*kamp, aoutr*kamp                       ; OUTPUT

               endin

;-----------------------------------------------------------
; PULSE WIDTH MODULATION WITH PORTAMENTO
;-----------------------------------------------------------
               instr 3

iwave          =              1                                            ; SINE
iamp           veloc                                                       ; VELOCITY
iamp           =              iamp*200+10000                               ; CONVERT TO AMP
ifqco          init           gifqc
ifqc           cpsmidi                                                     ; GET THE NOTE IN CPS
gifqc          =              ifqc
idfqc          =              abs(ifqco-ifqc)
kfqc           linseg         ifqco, .001*idfqc+.01, ifqc, .1, ifqc        ; LINEAR PITCH PORTAMENTO

krtfq          =              sqrt(kfqc)                                   ; SQRT(FREQUENCY)
kofqc          =              1/kfqc                                       ; 1/FREQUENCY
kfqcl          =              kfqc*.999                                    ; STEREO DETUNING FOR LEFT OSCILLATOR
kfqcr          =              kfqc*1.001                                   ; STEREO DETUNING FOR RIGHT OSCILLATOR

;                             Amp    Rise, Dec, AtDec
kamp           linenr         iamp, .05,  .05, .05                         ; DECLICK ENVELOPE
kfce           expseg         .2, .1, 1, .2, .8, .1, .8                    ; FCO ENVELOPE
kfcs           midictrl       50, 10                                       ; FCO CONTROLLER
kfc2           =              exp(kfcs*.05)                                ; EXPONENTIAL CONTROLLER
krzs           midictrl       56, 20                                       ; Q CONTROLLER
krezm          =              krzs*.01                                     ; ADJUST 0-127 TO 0-1.27

kfco           port           kfce*kfc2*krtfq,.01                          ; SWEEP FREQUENCY AND AVOID STEPPING

klfo1          oscil          .4, kfqc*.005, 1
kpw            =              1+klfo1

;                             Amp Fqc   Wave PW   Sine Delay
asigl          vco            1, kfqcl, 2,   kpw, 1,   .1                  ; OSCILLATOR 1
aoutl          moogvcf        asigl, kfco, krezm                           ; FILTER 1

asigr          vco            1,  kfqcr, 2,   kpw, 1,   .1                 ; OSCILLATOR 2
aoutr          moogvcf        asigr, kfco, krezm                           ; FILTER 2

               outs           aoutl*kamp, aoutr*kamp                       ; OUTPUT

               endin

;-----------------------------------------------------------
; SIMPLE ANALOG SQUARE WITH REZZY
;-----------------------------------------------------------
               instr 4

ivel           veloc                                        ; VELOCITY
iamp           tablei         ivel, 3                       ; CONVERT TO AMPLITUDE
ifqc           cpsmidi                                      ; GET THE NOTE IN CPS

;                             Amp    Rise, Dec, AtDec
kamp           linenr         iamp, .05,  .05, .05          ; DECLICK ENVELOPE

; LOW PASS FILTER FREQUENCY
kfce           expseg         .2, .1, 1, .2, .8, .1, .8     ; FCO ENVELOPE
kfcs           midictrl       50, 10                        ; FCO CONTROLLER
kfco           tablei         kfce*kfcs, 2                  ; CHANGE SCALING FORM 0-127 TO 20-20000

; LOW PASS FILTER RESONANCE
krez           midictrl       56                            ; Q CONTROLLER

; Mod wheel vibrato
kmw            midictrl       1                             ; MODWHEEL
klfo1          oscil          kmw*.0002, 6, 1
kvbr           =              1+klfo1

;                             Amp  Fqc        Wave PW   Sine Delay
asig           vco            1,   ifqc*kvbr, 2,   1,   1,   .1       ; OSCILLATOR 1
aout           rezzy          asig, kfco,  krez                       ; FILTER 1

               outs           aout*kamp, aout*kamp                    ; OUTPUT

               endin

;-----------------------------------------------------------
; SIMPLE ANALOG SAW
;-----------------------------------------------------------
               instr          5

; GET NOTE VELOCITY AND PITCH
ivel           veloc                                        ; VELOCITY
iamp           tablei         ivel, 3                       ; CONVERT TO AMPLITUDE
ifqc           cpsmidi                                      ; GET THE NOTE IN CPS

;                             Amp    Rise, Dec, AtDec
kamp           linenr         iamp, .05,  .05, .05          ; DECLICK ENVELOPE

; LOW PASS FILTER FREQUENCY
kfce           expseg         .2, .1, 1, .2, .8, .1, .8     ; FCO ENVELOPE
kfcs           midictrl       50, 10                        ; FCO CONTROLLER
kfco           tablei         kfce*kfcs, 2                  ; CHANGE SCALING FORM 0-127 TO 20-20000

; LOW PASS FILTER RESONANCE
krez           midictrl       56                            ; Q CONTROLLER

; MOD WHEEL VIBRATO
kmw            midictrl 1                                   ; MODWHEEL
klfo1          oscil          kmw*.0002, 6, 1
kvbr           =              1+klfo1

;                             Amp  Fqc        Wave PW   Sine Delay
asig           vco            1,   ifqc*kvbr, 1,   1,   1,   .1       ; OSCILLATOR 1
aout           rezzy          asig, kfco,  krez, 1                    ; FILTER 1

               outs           aout*kamp, aout*kamp                    ; OUTPUT

               endin

;-----------------------------------------------------------
; SIMPLE ANALOG SAW WITH PAREQ
;-----------------------------------------------------------
               instr 6

; GET NOTE VELOCITY AND PITCH
ivel           veloc                                        ; VELOCITY
iamp           tablei         ivel, 3                       ; CONVERT TO AMPLITUDE
ifqc           cpsmidi                                      ; GET THE NOTE IN CPS

;                             Amp    Rise, Dec, AtDec
kamp           linenr         iamp, .05,  .05, .05          ; DECLICK ENVELOPE

; LOW PASS FILTER FREQUENCY
kfce           expseg         .2, .1, 1, .2, .8, .1, .8     ; FCO ENVELOPE
kfcs           midictrl       50, 10                        ; FCO CONTROLLER
kfco           tablei         kfce*kfcs, 2                  ; CHANGE SCALING FORM 0-127 TO 20-20000

; LOW PASS FILTER RESONANCE
krzs           midictrl       56                            ; Q CONTROLLER
krez           =              krzs*.1

; MOD WHEEL VIBRATO
kmw            midictrl       1                             ; MODWHEEL
klfo1          oscil          kmw*.0002, 6, 1
kvbr           =              1+klfo1

;                             Amp  Fqc        Wave PW   Sine Delay
asig           vco            1,   ifqc*kvbr, 1,   1,   1,   .1       ; OSCILLATOR 1
aout           pareq          asig, kfco, .01, krez, 2                ; HIGH SHELF

               outs           aout*kamp*.5, aout*kamp*.5              ; OUTPUT

               endin


