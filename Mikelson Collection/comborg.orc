sr        =         44100
kr        =         4410
ksmps     =         10
nchnls    =         2

          zakinit   30, 30

;---------------------------------------------------------------------------------
; LOW FREQUENCY OSCILLATOR
          instr      1

iamp      =         p4
ilfo      =         p5
iwave     =         p6
ioutch    =         p7

klfo      oscil     iamp, ilfo, iwave
          zkw       klfo, ioutch

          endin

;---------------------------------------------------------------------------------
; RECTANGLE ADDITIVE WAVE (BAND LIMITED IMPULSE TRAIN)
          instr      10

idur      =         p3
iamp      =         p4
ifqc      =         cpspch(p5)
ifqc2     =         ifqc*p6
iamp2     =         p7
ifqc3     =         ifqc*p8
iamp3     =         p9
ifqc4     =         ifqc*p10
iamp4     =         p11
ifco      =         p13

kdclik    linseg    0, .002, iamp, idur-.004, iamp, .002, 0
klfo      zkr       p12
kfqc      =         ifqc*(1+klfo)
kfqc2     =         kfqc*p6
kfqc3     =         kfqc*p8
kfqc4     =         kfqc*p10
                                             
apulse1   buzz      1, kfqc, sr/2/ifqc, 1         ; AVOID ALIASING BY NOT GOING OVER SR/2/FQC
apulsd1   delay     apulse1, .5/ifqc
asquar1   =         apulse1 - apulsd1             ; TWO INVERTED PULSES AT VARIABLE DISTANCE

apulse2   buzz      iamp2, kfqc2, sr/2/ifqc2, 1   ; AVOID ALIASING
apulsd2   delay     apulse2, .5/ifqc2
asquar2   =         apulse2 - apulsd2             ; TWO INVERTED PULSES AT VARIABLE DISTANCE

apulse3   buzz      iamp3, kfqc3, sr/2/ifqc3, 1   ; AVOID ALIASING
apulsd3   delay     apulse3, .5/ifqc3
asquar3   =         apulse3 - apulsd3             ; TWO INVERTED PULSES AT VARIABLE DISTANCE

apulse4   buzz      iamp4, kfqc4, sr/2/ifqc4, 1   ; AVOID ALIASING
apulsd4   delay     apulse4, .5/ifqc4
asquar4   =         apulse4 - apulsd4             ; TWO INVERTED PULSES AT VARIABLE DISTANCE

asquare   integ     asquar1+asquar2+asquar3+asquar4

aout      butterlp  asquare, ifco


          outs      kdclik*aout, kdclik*aout
          endin


