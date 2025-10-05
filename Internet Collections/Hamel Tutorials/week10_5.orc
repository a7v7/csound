sr        =         44100
kr        =         4410
ksmps     =         10
nchnls    =         1

          instr 1
 
itrans    =         cpspch(8.00)/cpspch(p5)  ; RATIO OF ORIG TO NEW PITCH
aindex    phasor    (.894/1.5)/(1.5*itrans)  ; READ ONCE IN TABLE DURATION
asig      table     aindex*32768,1           ; READ TABLE 1
          out       asig                     ; OUTPUT 

          endin
