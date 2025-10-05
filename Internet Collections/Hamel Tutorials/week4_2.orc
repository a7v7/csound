sr        =         44100
kr        =         4410
ksmps     =         10
nchnls    =         1

          instr 1

kgliss    line      1200,p3,400              ; LINE FROM 1200 TO 400 
asig      oscil     p4,kgliss,1              ; OSCILLATOR
          out       asig                        

          endin
