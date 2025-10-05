sr        =         44100
kr        =         4410
ksmps     =         10
nchnls    =         1

          instr 1

ivar      =         10000                    ; ivar SET TO 10000
icps      =         cpspch(p5)               ; icps SET TO CPS VALUE OF PITCH
ivib      =         icps*.01                 ; ivib (VIBRATO SPEED) IS SET TO 1/100 OF CPS
kenv      linseg    1,p3,0                   ; RAMP FROM 1 TO 0 IN DURATION p3 
kenv      =         kenv*ivar                ; SCALE THE AMPLITUDE OF THE ENVELOPE
asig      oscil     kenv,icps,1              ; SINE WAVE OSCILATOR
          out       asig                     ; OUTPUT 
        
          endin
