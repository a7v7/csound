sr        =         44100
kr        =         4410
ksmps     =         10
nchnls    =         1

          instr 1

kenv      linseg    0,p3*.5,1,p3*.5,0        ; UP-DOWN RAMP ENVELOPE
kran      randh     50,kr                    ; PRODUCE VALUES BETWEEN -50 AND 50
kran      =         kran+200                 ; SHIFT VALUES TO CENTRE OF 200
asig      oscil     kenv*p4,kran,1           ; GENERATE A BAND OF NOISE
          out       asig

          endin
