;---------------------------------------------------------------
; BEGINNERS OSCILLATOR DEMO
; BY HANS MIKELSON MARCH 1999
;---------------------------------------------------------------
sr        =         44100     ; SAMPLE RATE
kr        =         4410      ; CONTROL RATE
ksmps     =         10        ; NUMBER OF SAMPLES PER CONTROL PERIOD
nchnls    =         2         ; NUMBER OF CHANNELS
;---------------------------------------------------------------
; OSCIL 1
; STEREO DETUNED OSCILATORS WITH VIBRATO
;---------------------------------------------------------------         
          instr     1
idur      =         p3                                 ; DURATION
iamp      =         p4                                 ; AMPLITUDE
ifqc      =         cpspch(p5)                         ; CONVERT PITCH TO FREQUENCY
itable    =         p6                                 ; WAVEFORM NUMBER
ienv      =         p7                                 ; ENVELOPE SHAPE NUMBER
klfo      oscil     .01, 6, 1                          ; LOW FREQUENCY OSCILLATOR FOR VIBRATO
asigl     oscil     iamp, ifqc*0.999*(1+klfo), itable  ; LEFT SIGNAL
asigr     oscil     iamp, ifqc*1.001*(1+klfo), itable  ; RIGHT SIGNAL
kenv      oscili    1, 1/idur, ienv                    ; GENERATE THE ENVELOPE
          outs      asigl*kenv, asigr*kenv             ; SHAPE THE SIGNAL WITH THE ENVELOPE BEFORE OUTPUT
                    endin
;---------------------------------------------------------------
; SCI FI 1
;---------------------------------------------------------------         
          instr     2
idur      =         p3                                 ; DURATION
iamp      =         p4                                 ; AMPLITUDE
ifqc      =         cpspch(p5)                         ; CONVERT PITCH TO FREQUENCY
itable    =         p6                                 ; WAVEFORM NUMBER
ienv      =         p7                                 ; ENVELOPE SHAPE NUMBER
klfo      oscil     .5, 3, 2                           ; LOW FREQUENCY OSCILLATOR FOR FREQUENCY SWEEP
asigl     oscil     iamp, ifqc*0.998*(1+klfo), itable  ; LEFT AUDIO SIGNAL
asigr     oscil     iamp, ifqc*1.002*(1+klfo), itable  ; RIGHT AUDIO SIGNAL
kenv      oscili    1, 1/idur, ienv                    ; GENERATE THE ENVELOPE
          outs      asigl*kenv, asigr*kenv             ; SHAPE THE SIGNAL WITH THE ENVELOPE BEFORE OUTPUT
          endin
;---------------------------------------------------------------
; SCI FI 2
;---------------------------------------------------------------
          instr     3
idur      =         p3                                 ; DURATION
iamp      =         p4                                 ; AMPLITUDE
ifqc      =         cpspch(p5)                         ; CONVERT PITCH TO FREQUENCY
itable    =         p6                                 ; WAVEFORM NUMBER
ienv      =         p7                                 ; ENVELOPE SHAPE NUMBER
klfo      oscil     .1, 4, 3                           ; LOW FREQUENCY OSCILLATOR FOR PITCH WARBLE
asigl     oscil     iamp, ifqc*0.998*(1+klfo), itable  ; LEFT AUDIO SIGNAL
asigr     oscil     iamp, ifqc*1.002*(1+klfo), itable  ; RIGHT AUDIO SIGNAL
kenv      oscili    1, 1/idur, ienv                    ; GENERATE THE ENVELOPE
          outs      asigl*kenv, asigr*kenv             ; SHAPE THE SIGNAL WITH THE ENVELOPE BEFORE OUTPUT
          endin
;---------------------------------------------------------------
; AUTO PANNING
;---------------------------------------------------------------
          instr     4  
idur      =         p3                                 ; DURATION
iamp      =         p4                                 ; AMPLITUDE
ifqc      =         cpspch(p5)                         ; CONVERT PITCH TO FREQUENCY
itable    =         p6                                 ; WAVEFORM NUMBER
ienv      =         p7                                 ; ENVELOPE SHAPE NUMBER
klfo      oscil     .2, 8, 2                           ; LOW FREQUENCY OSCILLATOR FOR PITCH SWEEP
klfo2     oscil     .5, 2, 3                           ; LOW FREQUENCY OSCILLATOR FOR AUTOPANNING
asigl     oscil     iamp, ifqc*0.998*(1+klfo), itable  ; LEFT AUDIO SIGNAL
asigr     oscil     iamp, ifqc*1.002*(1+klfo), itable  ; RIGHT AUDIO SIGNAL
kenv      oscili    1, 1/idur, ienv                    ; GENERATE THE ENVELOPE
          outs      asigl*kenv*(klfo2+.4), asigr*kenv*(.4-klfo2) ; SHAPE WITH THE ENVELOPE AND PAN
          endin
