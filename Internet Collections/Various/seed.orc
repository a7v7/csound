sr        =         44100
kr        =         4410
ksmps     =         10
nchnls    =         1

          instr 1
seed                p7
k1        gauss_k   p5
k2        gauss_k   p6
aenv      linseg    1, p3-.05, 1, .05, 0, .01, 0
a1        oscili    p4/2, 333, 1
a2        oscili    p4/2, 333+k1, 1
a3        oscili    p4/2, 333+k2, 1
          out       (a1+a2+a3)*aenv
          endin
