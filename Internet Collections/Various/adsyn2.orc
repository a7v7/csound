sr        =         44100
kr        =         4410
ksmps     =         10
nchnls    =         1

          instr     1              
idur      =         p3
iamp      =         p4
ispeed1   =         p5
ispeed2   =         p6
ifrq1     =         p7
ifrq2     =         p8
ifrq3     =         p9
ianal     =         p10                 
kspeed    line      ispeed1, idur, ispeed2
kfreq     linseg    ifrq1, idur*.5, ifrq2, idur*.5, ifrq3
asig      adsyn     1, kfreq, kspeed, "hellorcb.adsyn"
          out       asig
          endin
