sr        =         44100
kr        =         4410
ksmps     =         10
nchnls    =         2

;------------------------------------------------------------------
; EXAMPLE OF LUCY TUNING
;------------------------------------------------------------------
          instr          1

p3        =         p3+p6
idur      =         p3
iamp      =         p4
ifqc      cps2pch   p5, -2 

kamp      linseg    0, .02, 1, .05, .8, .1, .7, idur-.27, .5, .1, 0

aout1     foscil    kamp*iamp, ifqc,     1, 2, kamp*2, 1
aout2     foscil    kamp*iamp, ifqc*2, 1, 1, kamp*2, 1

;aout     pluck     kamp*iamp, ifqc, ifqc, 0, 1

          outs      aout1+aout2*.5, aout1+aout2*.5

          endin
