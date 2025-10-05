sr        =         44100
kr        =         4410
ksmps     =         10
nchnls    =         1

          instr     1


a1        oscili    30000,p4,1
kenv      expseg    p4,p3/2,11000,p3/2,p4
a1        resonx    a1,kenv,400,4,1
          out       a1*2
          endin



