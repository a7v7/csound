sr        =         44100
kr        =         4410
ksmps     =         10
nchnls    =         1

          instr 1

amod      oscil     p4*.2,cpspch(p5),1            ; MODULATOR
asig      oscil     p4*.8,cpspch(p5)+amod,1       ; CARRIER

          out       asig

          endin
