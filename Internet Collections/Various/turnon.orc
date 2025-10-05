sr        =         44100
kr        =         4410
ksmps     =         10
nchnls    =         1

ga1       init      0

          turnon 99

          instr 1   
a1        oscil     p4, p5, p6
          out       a1
ga1       =         ga1 + (a1 * .2)
          endin
     
          instr 99
a1        reverb    ga1, 5
          out       a1
ga1       =         0
          endin     
