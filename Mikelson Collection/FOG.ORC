sr        =         44100
kr        =         4410
ksmps     =         10
nchnls    =         1

          instr  1

insnd     =         10
ibas      =         sr/ftlen(insnd)
kfund     =         38
kform     =         ibas

kphs      line      0, p3, 1
kgliss    line      0, p3, .5

kdur      =         2.5/kfund
kris      =         kdur/2.1
kdec      =         kris
iolaps    =         20
a1        fof2      23000, kfund, kform, 0, 0, kris, kdur, kdec, iolaps, insnd, 7, p3, kphs, kgliss
          out       a1

          endin

          instr   2

p3        =         1
iamp      =         p4
ifqc      =         cpspch(p5)

a1        vibes     iamp, ifqc, .5, .561, 1, 6, .05, 1, .1

          out       a1
          endin
