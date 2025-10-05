sr        =         44100
kr        =         4410
ksmps     =         10
nchnls    =         1

          instr 1
 
kenv      linseg    0,p3/2,p4,p3/2,0         ; UP-DOWN ENVELOPE 
aindex    phasor    cpspch(p5)               ; READ TABLE AT PITCH RATE
asig      table     aindex*1024,1            ; INDEX TABLE
          out       asig*kenv                ; OUTPUT SIGNAL

          endin
