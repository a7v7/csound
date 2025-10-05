sr        =         44100
kr        =         4410
ksmps     =         10
nchnls    =         1

          instr 1
 
k1        expseg    .0001,.01,1,.01,.5,p3-.02,.001     ; DECAYING EXPSEG
k2        linseg    1,.02,1,p3-.02,2.5                 ; RISING LINSEG
k3        =         k1*k2
asig      oscil     k3*p4,cpspch(p5),1                 ; AMP ARGUMENT MULTIPLIED BY MAX AMPLITUDE (p4) 

          out       asig

          endin
