sr        =         44100
kr        =         4410
ksmps     =         10
nchnls    =         1


          instr     1


a1        oscili    5000,p4,1
kenv      expseg    10,p3/2,500,p3/2,10
a1        lowresx    a1,kenv,p5,4
          out       a1
          endin



