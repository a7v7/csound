sr             =         44100
kr             =         22050
ksmps          =         2    
nchnls         =         2

instr          1

  kamp1i       linseg    0, .01, p4, p3-.02, p4, .01, 0
  ifqc         =         cpspch(p5)
  itabl1       =         p6
  ik1          =         1500
  ik2          =         1600
  ik3          =         1400

  aosc1i       oscil     kamp1i, ifqc, itabl1
  krms1        rms       aosc1i
  kamp1        =         kamp1i - exp(krms1/ik1)
  aosc1        oscil     kamp1, ifqc, itabl1

  kamp2i       =         exp(krms1/ik1)
  aosc2i       oscil     kamp2i, ifqc*2, itabl1
  krms2        rms       aosc2i
  kamp2        =         kamp2i - exp(krms2/ik2)
  aosc2        oscil     kamp2, ifqc*2, itabl1

  kamp3i       =         exp(krms2/ik2)
  aosc3i       oscil     kamp3i, ifqc*3, itabl1
  krms3        rms       aosc3i
  kamp3        =         kamp3i - exp(krms3/ik3)
  aosc3        oscil     kamp3, ifqc*3, itabl1

               outs      aosc1+aosc2+aosc3, aosc2

endin

instr          2

  kamp1i       linseg    0, .1, p4, p3-.11, p4, .01, 0
  ifqc         =         cpspch(p5)
  itabl1       =         p6
  ik1          =         400
  ik2          =         400
  ik3          =         1800

  aosc1i       pluck     kamp1i, ifqc, ifqc, itabl1, 1
  krms1        rms       aosc1i
  kamp1        =         kamp1i - exp(krms1/ik1)
  aosc1        pluck     kamp1,  ifqc, ifqc, itabl1, 1

  kamp2i       =         exp(krms1/ik1)
  aosc2i       pluck     kamp2i, ifqc*2, ifqc*2, itabl1, 1
  krms2        rms       aosc2i
  kamp2        =         kamp2i - exp(krms2/ik2)
  aosc2        pluck     kamp2,  ifqc*2, ifqc*2, itabl1, 1

  kamp3i       =         exp(krms2/ik2)
  aosc3i       pluck     kamp3i, ifqc*3, ifqc*3, itabl1, 1
  krms3        rms       aosc3i
  kamp3        =         kamp3i - exp(krms3/ik3)
  aosc3        pluck     kamp3, ifqc*3, ifqc*3, itabl1, 1

               outs      aosc2, aosc3

endin
