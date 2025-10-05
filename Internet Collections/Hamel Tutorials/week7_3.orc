sr        =         44100
kr        =         4410
ksmps     =         10
nchnls    =         1

          instr 1

kran      randi     50,2205                  ; PRODUCE VALUES BETWEEN -50 AND 50
kran      =         kran+200                 ; SHIFT VALUES TO CENTRE FREQ OF 200
asig      oscil     p4,kran,1                ; GENERATE A BAND OF NOISE
          out asig

          endin
