sr        =         44100
kr        =         4410
ksmps     =         10
nchnls    =         1
          
          instr     1
adry      diskin    "speech1.aif", 1
awet      convolve  adry,"fiveEchos.con"
          out       awet
          endin
                              
