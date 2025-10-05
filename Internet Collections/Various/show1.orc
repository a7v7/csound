sr        =         44100
kr        =         4410
ksmps     =         10
nchnls    =         1

          instr     101
kamp      linen     p4, .7, p3, .05
kvib      oscil     2.75, 15, 1
a1        oscil     kamp, cpspch(p5)+kvib,1
          out       a1
          endin


