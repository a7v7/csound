sr        =         44100
kr        =         4410
ksmps     =         10
nchnls    =         1

          instr 1
; iloop   =         1/p6
; itime   =         p5
kenv      linen     1,.05,p3,.1
a1        soundin   5    
a2        comb      a1*.8*p4*kenv, p5, p6, 0
          out       a1+a2
          endin
