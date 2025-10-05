sr        =         44100
kr        =         4410
ksmps     =         10
nchnls    =         1

          instr 1

aindex    line      p6,2,p7                  ; READ FROM p6 TO p7 (BETWEEN 0 AND 1) 
asig      table     aindex*32768,1           ; READ TABLE 1 (WITH RAW VALUES) 
          out       asig                     ; OUTPUT 
                              
          endin
