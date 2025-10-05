sr        =         44100
kr        =         4410
ksmps     =         10
nchnls    =         2

          instr  1

iamp      =         p4
ifqc      =         cpspch(p5)
itab      =         p6
itim1     =         p7/sr

asig      oscil     iamp, ifqc, itab
alfo1     oscil     10, 2, 1

alfo      =         alfo1+19

atmp      delayr    itim1
adel      deltapn   alfo
          delayw    asig

          outs      asig, adel

          endin
