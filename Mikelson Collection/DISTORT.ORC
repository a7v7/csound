sr        =         44100
kr        =         4410
ksmps     =         10
nchnls    =         1

          instr     1

iamp      =         p4
ifqc      =         cpspch(p5)
itab1     =         p6

asig      oscil     iamp, ifqc, itab1
aout      distort1  asig, 1, 1, .5, .5

          outs      aout

          endin
