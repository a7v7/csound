sr        =         44100
kr        =         4410
ksmps     =         10
nchnls    =         1
                    
          instr 1             
;ar       repluck   iplk, xam, icps, kpick, krefl, axcite
a1        diskin    "hellorcb.aif", 1
asig      repluck    p6, p4, cpspch(p5), p7, p8, a1         
          out       asig
          endin
