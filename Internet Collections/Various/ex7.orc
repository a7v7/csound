;-- ex7.orc   
sr        =         44100
kr        =         4410
ksmps     =         10
nchnls    =         1

          instr     1
arand     rand      0.5,0.213
asig      table     0.5 + arand,1,1,0,0
          out       asig
          endin
