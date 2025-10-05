
;---------------------------------------------------------
; SIMPLE ENVELOPES
; CODED BY HANS MIKELSON JUNE 25, 1999
;---------------------------------------------------------

sr        =         44100                                             ; Sample rate
kr        =         4410                                              ; Control rate
ksmps     =         10                                                ; Sample in each control period
nchnls    =         2                                                 ; Number of output channels

;---------------------------------------------------------
; AMPLITUDE ENVELOPE EXAMPLE
;---------------------------------------------------------
          instr  1

idur      =         p3                                                ; Duration
iamp      =         p4                                                ; Amplitude
ifqc      =         cpspch(p5)                                        ; Convert pitch to frequency
itable    =         p6                                                ; Waveform table
iattack   =         p7                                                ; Attack time
idecay    =         p8                                                ; Decay time
isustain  =         p9                                                ; Sustain level
irelease  =         p10                                               ; Release time
     
; THE FOLLOWING CODE DEFINES THE AMPLITUDE ENVELOPE
aenv     linseg     0, iattack, iamp, idecay, isustain*iamp, idur-iattack-idecay-irelease, isustain*iamp, irelease, 0

asig      oscil     aenv, ifqc, itable                                ; Generate the audio signal

          outs      asig, asig                                        ; Output the result

          endin

;---------------------------------------------------------
; AMPLITUDE ENVELOPE EXAMPLE
;---------------------------------------------------------
         instr  2

idur      =         p3                                                ; Duration
iamp      =         p4                                                ; Amplitude
ifqc      =         cpspch(p5)                                        ; Convert pitch to frequency
itable    =         p6                                                ; Waveform table
iattack   =         p7                                                ; Attack time
idecay    =         p8                                                ; Decay time
isustain  =         p9                                                ; Sustain level
irelease  =         p10                                               ; Release time

p3        =         p3 + irelease                                     ; The p3 time is extended by the release time so that the release will
                                                                      ; take place after the note has ended.

; THE FOLLOWING CODE DEFINES THE AMPLITUDE ENVELOPE

aenv      linseg    0, iattack, iamp, idecay, isustain*iamp, idur-iattack-idecay, isustain*iamp, irelease, 0
adeclick  linseg    0, .002, 1, idur-.004, 1, .002, 0

asig   oscil        aenv, ifqc, itable                                ; Generate the audio signal

       outs         asig*adeclick, asig*adeclick                      ; Output the result

       endin

;---------------------------------------------------------
; PITCH ENVELOPE EXAMPLE
;---------------------------------------------------------
          instr  3

idur      =         p3                                                ; Duration
iamp      =         p4                                                ; Amplitude
ifqc      =         cpspch(p5)                                        ; Convert pitch to frequency
itable    =         p6                                                ; Waveform table

; THE FOLLOWING CODE DEFINES THE AMPLITUDE ENVELOPE
adeclick  linseg    0, .002, 1, idur-.004, 1, .002, 0

afqc      expseg    100, .1, ifqc, idur-.2, ifqc, .1, 200

asig      oscil     iamp, afqc, itable                                ; Generate the audio signal

          outs      asig*adeclick, asig*adeclick                      ; Output the result

          endin

;---------------------------------------------------------
; FCO ENVELOPE EXAMPLE
;---------------------------------------------------------
          instr  4

idur      =         p3                                                ; Duration
iamp      =         p4                                                ; Amplitude
ifqc      =         cpspch(p5)                                        ; Convert pitch to frequency
itable    =         p6                                                ; Waveform table

; THE FOLLOWING CODE DEFINES THE AMPLITUDE ENVELOPE

adeclick  linseg    0, .002, 1, idur-.004, 1, .002, 0

kfco      expseg    400, .1, 2000, .2, 1500, idur-.4, 1000, .1, 400   ; Filter cut off frequency

asig      oscil     iamp, ifqc, itable                                ; Generate the audio signal
aflt      rezzy     asig, kfco, 10

          outs      aflt*adeclick, aflt*adeclick                      ; Output the result

          endin
