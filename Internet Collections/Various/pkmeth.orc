sr        =         44100
kr        =         4410
ksmps     =         10
nchnls    =         1

          instr 1
a1        pluck     p4,p5,p5,0,1,0,0         ; p4=AMP, p5=FREQ
          out       a1
          endin
                                             
          instr 2
a1        pluck     p4,p5,p5,0,2,p6,0        ; p4=AMP, p5=FREQ, p6=SMOOTHFAC
          out       a1
          endin

          instr 3
a1        pluck     p4,p5,p5,0,3,p6,0        ; p4=AMP, p5=FREQ, p6=GRAINFAC
          out       a1
          endin

          instr 4
a1        pluck     p4,p5,p5,0,4,p6,p7
          out       a1
          endin

          instr 5
a1        pluck     p4,p5,p5,0,5,p6,p7
          out       a1
          endin

          instr 6
a1        pluck     p4,p5,p5,0,6,0,0
          out       a1
          endin
