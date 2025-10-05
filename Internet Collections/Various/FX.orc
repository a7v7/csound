
;CROSS CHORUS (WORKS GOOD)

sr        =         44100
kr        =         4410
ksmps     =         10
nchnls    =         1

          instr     101

idur      =         p3
iamp      =         p4
ifrq      =         p5
ifun      =         p6
iatt      =         P7
irel      =         p8

kenv      oscil     p4,1/p3,6
kup       line      1*0.99, idur, 1*1.01
kdown     line      1*1.01, idur, 1*0.99
asig3     oscil     kenv, ifrq*kup, ifun               ; DETUNED FROM FLAT TO SHARP
asig2     oscil     kenv, ifrq*kdown, ifun             ; DETUNED FROM SHARP TO FLAT
asig1     oscil     kenv, ifrq, ifun ; real note
amix      =         asig1 + asig2 +asig3
     
          out       amix

          display   kenv, idur
          endin 

;FOR SOME REASON IT MAKES THE COMPUTER CRASH BIG TIME.

          instr     102

idur      =         p3
iamp      =         ampdb(p4)
ifrq      =         cpspch(p5)
ifun      =         p6
iatt      =         p7
irel      =         p8
iattfun   =         p9
icar      =         p10
imod      =         p11
index1    =         p12
index2    =         p13
kenv      oscil     p4,1/p3,6                          ; ENVELOPE
kmodswp   expon     index1, i dur, index2              ; INDEX OF MOD SWEEP IN FOSCIL OPCODE
kbuzswp   expon     20 ,idur, 1                        ; MOD OF NUMBER OF HARMONICS IN THE BUZZ OPCODE
asig3     foscil    kenv, ifrq, p10, p11, kmodswp, ifun      
asig2     buzz      kenv, ifrq*0.99, kbuzswp+1, ifun    
asig1     pluck     kenv, ifrq*0.5, ifrq, 0, 1 

amix      =         asig1 + asig2 + asig3
          out       amix
          dispfft   amix, 0.25, 1024
          endin 
