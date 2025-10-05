sr        =         44100
kr        =         4410
ksmps     =         10
nchnls    =         1

          instr 1
 
aindex    phasor    (.894/1.5)/p3       ; READ THROUGH ONCE IN THE TOTAL DURATION 
asig      table     aindex*32768,1      ; READ TABLE 1 (WITH RAW VALUES) 
          out       asig                ; OUTPUT 

          endin
