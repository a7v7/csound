sr        =         44100
kr        =         4410
ksmps     =         10
nchnls    =         2

; SIMPLE PLUCK WORKING ?
          instr 1
icps      =         p4
kcps      =         icps
aout      pluck     15000, kcps, icps, 0, 1
          outs      aout, aout
          endin
