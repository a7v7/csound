sr        =         44100
kr        =         4410
ksmps     =         10
nchnls    =         1

          instr 1
 
ist       =         cpspch(p5)                         ; START PITCH
iend      =         cpspch(p5+1.00)                    ; END PITCH

kpitch    line      ist,p3,iend                        ; GLISS FROM START TO END
kenv      linseg    0,p3/2,p4,p3/2,0                   ; UP-DOWN ENVELOPE 
krand     randi     kpitch*.03,kr                      ; A BAND OF FREQUENCIES
aindex1   phasor    kpitch
aindex2   phasor    kpitch+2
aindex3   phasor    kpitch-2
aindex4   phasor    kpitch+5
aindex5   phasor    kpitch-5
asig1     table     aindex1*1024,1;
asig2     table     aindex2*1024,1;
asig3     table     aindex3*1024,1;
asig4     table     aindex4*1024,1;
asig5     table     aindex5*1024,1;
asig      =         (asig1+asig2+asig3+asig4+asig5)*.2

          out       asig * kenv                        ; OUTPUT SIGNAL
          
          endin
