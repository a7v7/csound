sr        =         44100
kr        =         4410
ksmps     =         10
nchnls    =         1

          instr 1
afm1      init      0
afm2      init      0    
isine     =         1
icaramp   =         p4
icarfreq  =         p5
ifeedscale =        p6   
kamp      linseg    0, p3*.01,1, p3*.98, 1,p3*.01,0
kfeedamp  linseg    0, p3*.03,1, p3*.97, 0
kfeedampinv linseg  1, p3*.03,0, p3*.97, 1
afm1      oscili    icaramp, (icarfreq+afm2)+kfeedampinv,isine
afm2      =         (afm1*ifeedscale)*kfeedamp
asig      =         afm1*kamp
;         display   afm1, .25
;         display   afm2, .25
          out       asig
          endin
