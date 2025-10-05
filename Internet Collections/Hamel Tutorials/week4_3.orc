sr        =         44100
kr        =         4410
ksmps     =         10
nchnls    =         1

          instr 1

istart    =         cpspch(p5)               ; STARTING PITCH
ifin      =         cpspch(p5-1.00)          ; END PITCH OCTAVE DOWN
kgliss    line      istart,p3,ifin           ; LINE FROM 1200 TO 400
asig      oscil     p4,kgliss,1              ; OSCILLATOR

          out       asig

          endin
