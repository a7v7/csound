;ORCHESTRA
sr        =         44100     ; sr MUST EQUAL kr FOR THIS ORCHESTRA
kr        =         4410
ksmps     =         10
nchnls    =         2

;---------------------------------------------------------------
; VCO WITH Sync
;---------------------------------------------------------------
          instr   11

idur      =         p3                       ; DURATION
iamp      =         p4                       ; AMPLITUDE
ifqc      =         cpspch(p5)               ; FREQUENCY
ifqc2     =         ifqc*p6                  ; FREQUENCY OF PSEUDO SYNCHED OSCILLATOR WRT BASE FREQUENCY
ifco      =         p7*ifqc/500              ; FILTER CUT-OFF FREQUENCY BASED, HIGHER PITCHES GET A HIGHER CUT OFF

krez      init      p8                       ; krez IS NOT CHANGING
kfco      expseg    100+.01*ifco, .2*idur, ifco+100, .5*idur, ifco*.1+100,.3*idur, .001*ifco+100 ; FILTER ENVELOPE
kamp      linseg    0, .01*idur, iamp, .2*idur, .8*iamp, .49*idur, .5*iamp, .2*idur, 0 ; AMP ENVELOPE

asaw2     init      0

apulse1   buzz      1, ifqc, sr/2/ifqc, 1    ; BAND-LIMITED IMPULSE TRAIN
apulse2   buzz      1, ifqc2, sr/2/ifqc2, 1  ; BAND-LIMITED IMPULSE TRAIN

asaw      integ     apulse1                  ; INTEGRATE THE PULSE FOR A SQUARE WAVE

aamp1     oscili    1, ifqc,  3              ; TURN ON THE GATE IN SYNC WITH THE IMPULSES
aamp2     oscili    1, ifqc2, 3

asaw2     =         (apulse1 + apulse2*aamp2*(1-aamp1))*(1.2-asaw2) + (1-ifqc/sr)*asaw2 ; BASICALLY DON'T ADD TWO IMPULSES

;aout     rezzy     asaw2-.5, kfco, krez

          outs      (asaw2-.5)*iamp, (asaw2-.5)*iamp
          
          endin
