sr        =         44100
kr        =         4410
ksmps     =         10
nchnls    =         1
                                             
          instr 1 ; test fof2
insnd     =         10                       ; ifna, INPUT SOUND FILE THROUGH gen 01
ibas      =         sr / ftlen(insnd)        ; 1:1 PLAYBACK RATE
kfund     =         p5
iolaps    =         p5 * 2
kform     linseg    ibas, p3/4, ibas, p3/4, ibas*.5, p3/4, ibas*2
kdur      =         .75
kphs      line      0, p3, 1
;ar       fof2      xamp, xfund, xform, koct, kband, kris, kdur, kdec, iolaps, ifna, ifnb, itotdur, kphs, kgliss
a1        fof2      p4, kfund, kform, 0, 0, kdur/10, kdur, kdur/10, iolaps, insnd, 2, p3, kphs, 0
          out       a1
          endin


          instr 2 ; test FOG
insnd     =         10                       ; ifna, INPUT SOUND FILE THROUGH gen 01
ibas      =         sr / ftlen(insnd)        ; 1:1 PLAYBACK RATE
kfund     =         p5
iolaps    =         p5 * 2
kform     linseg    1, p3/4, 1, p3/4, .8, p3/4, 1.2
kdur      =         .19
aspd      line      0, p3, 1              ; MUST BE A-RATE, ERROR IN DOCUMENTATION (or code)
;ar       fog       xamp, xdens, xtrans, xspd, koct, kband, kris, kdur, kdec, iolaps, ifna, ifnb, itotdur[, iphs][, itmode]
a1        fog       p4, kfund, kform, aspd, 0, 0, kdur/10, kdur, kdur/10, iolaps, insnd, 2, p3, 0, 1
          out       a1
          endin
