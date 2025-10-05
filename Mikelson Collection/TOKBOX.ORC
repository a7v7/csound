sr             =         44100
kr             =         4410
ksmps          =         10
nchnls         =         1

               instr     1

  ifqc         =         cpspch(p5)
  itab         =         p6

  kampenv      linseg    0, .02, p4, p3-.04, p4, .02, 0
  ksweep       linseg    .5, 1, 6, .5, .5, .2, .4

  kform1       oscil     1, ksweep, 10
  kform2       oscil     1, ksweep, 11
  kform3       oscil     1, ksweep, 12
  kform4       oscil     1, ksweep, 13

  asig         oscil     kampenv, ifqc, itab

  ares1        reson     asig, kform1, 100
  ares2        reson     asig, kform2, 150
  ares3        reson     asig, kform3, 300
  ares4        reson     asig, kform4, 500

  aresbal1     balance   ares1, asig
  aresbal2     balance   ares2, asig
  aresbal3     balance   ares3, asig
  aresbal4     balance   ares4, asig

               out       aresbal1*25.4+aresbal2*22.5+aresbal3*9.2+aresbal4*7.9

endin
