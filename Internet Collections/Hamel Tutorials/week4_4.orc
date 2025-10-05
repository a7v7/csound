sr        =         44100
kr        =         4410
ksmps     =         10
nchnls    =         1

          instr 1
                                   
ifund     =         cpspch(p5)                         ; FUNDAMENTAL

kenv1     expseg    .0001,.01,1,.01,.5,p3-.02,.0001    ; ENVELOPE 1
asig1     oscil     p4*kenv1,ifund,1                   ; OSCILLATOR 1

kenv2     expseg    .0001,.01,.7,.03,.4,p3-.04,.0001   ; ENVELOPE 2
asig2     oscil     p4*kenv2,ifund*2,1                 ; OSCILLATOR 2

          out       (asig1+asig2)/2                    ; OUTPUT MIX

          endin
