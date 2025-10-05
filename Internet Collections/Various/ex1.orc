sr        =         44100
kr        =         4410
ksmps     =         10
nchnls    =         1
          
          instr 1
kpitcheg  linseg    1,p3/2,p6,p3/2,1
kenv      linen     p4, 1, p3, .25
asig1     oscil     kenv, p5*kpitcheg,1
asig2     oscil     kenv, (p5+10)*kpitcheg,1
asig3     oscil     kenv, (p5-10)*kpitcheg,1
amix      =         asig1 + asig2 + asig3
          out       amix
          endin
