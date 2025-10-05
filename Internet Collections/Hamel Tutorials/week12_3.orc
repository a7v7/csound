sr        =         44100
kr        =         4410
ksmps     =         10
nchnls    =         1

          instr 1
 
ist       =         cpspch(p5)               ; START PITCH
iend      =         cpspch(p5+1.00)          ; END PITCH
kpitch    line      ist,p3,iend              ; GLISS FROM START TO END
kenv      linseg    0,p3/2,p4,p3/2,0         ; UP-DOWN ENVELOPE 
krand     randi     kpitch*.03,kr            ; A BAND OF FREQUENCIES
aindex    phasor    kpitch+krand             ; READ TABLE AT PITCH RATE
asig      table     aindex*1024,1            ; INDEX TABLE
          out       asig*kenv                ; OUTPUT SIGNAL

          endin
