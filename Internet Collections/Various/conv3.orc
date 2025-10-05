sr        =         44100
kr        =         4410
ksmps     =         10
nchnls    =         1

          instr 1
inch      =         p4
irtime    =         p5
idel1     =         (int(irtime*kr)+1)/kr*2
asig      diskin    "hellorcb.aif", 1
awet      convolve  asig, "piano.con"
asig      delay     asig, idel1
          out       asig+awet*.005
          endin
              
          instr 2
inch      =         p4
irtime    =         p5
idel1     =         (int(irtime*kr)+1)/kr*2
asig      diskin    "hellorcb.aif", 1
awet      convolve  asig, "violin.con"
asig      delay     asig, idel1
          out       asig+awet*.005
          endin
       
          instr 3
inch      =         p4
irtime    =         p5
idel1     =         (int(irtime*kr)+1)/kr*2
asig      diskin    "hellorcb.aif", 1
awet      convolve  asig, "marimba.con"
asig      delay     asig, idel1
          out       asig*.5+awet*.005
          endin


