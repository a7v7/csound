sr        =         44100
kr        =         4410
ksmps     =         10
nchnls    =         1

          instr     101
k1        line      1, p3, 150     
a1        foscil    p4, p5, p6, p7, k1, p9, p10
          out       a1
          endin                      
 
          instr     102
kenv      linen     p4, .01 , p3, .5
abs       buzz      kenv, cpspch(p5), p6, p7, p8 
          out       abs
          endin
           
          instr     103
kenv      linen     p4, .01 , p3, .5
kpch      oscil     1, 1/p3, 3
abs       buzz      kenv, cpspch(p5*kpch), p6, p7, p8 
          out       abs
          endin
           
          instr     104
ar        shaker    p4, cpspch(p5), p6 ,p7 ,p8 ,p9 p10
          out       ar
          endin

