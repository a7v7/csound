sr        =         44100
kr        =         4410
ksmps     =         10
nchnls    =         1
          
          instr 1 
insnd     =         1 
kfund     =         p5
iolaps    =         p5 * 2
ktrans    linseg    1, p3*.25, 1, p3*.25, 1.5, p3*.25, .5
kdur      =         .23
aspd      line      0, p3, 1
;  ar     fog       xamp, xdens, xtrans, xspd, koct, kband, kris, kdur, kdec, iolaps, ifna, ifnb, itotdur[, iphs][, itmode]
a1        fog       p4, kfund, ktrans, aspd, 0, 0, kdur*.1, kdur, kdur*.1, iolaps, insnd, 2, p3, 0, 1
          out a1
          endin
