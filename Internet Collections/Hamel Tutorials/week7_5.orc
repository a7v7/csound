sr        =         44100
kr        =         4410
ksmps     =         10
nchnls    =         1

          instr 1

kenv      linseg    0,p3*.5,1,p3*.5,0        ; UP-DOWN RAMP ENVELOPE
kband     line      50,p3,5                  ; RAMP BANDWIDTH FROM 100 TO 10
kran      randh     kband,kr                 ; PRODUCE VALUES BETWEEN - AND + kband
kran      =         kran+200                 ; SHIFT VALUES TO CENTRE OF 200
asig      oscil     kenv*p4,kran,1           ; GENERATE A BAND OF NOISE
          out       asig

          endin
