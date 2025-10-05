sr        =         44100
kr        =         4410
ksmps     =         10
nchnls    =         2

          instr      1

idur      =         p3
iamp      =         p4
ifqc      =         cpspch(p5)
irate     =         p6
ipulse1   =         p7
ipulse2   =         p8

krate     oscil     1, 1/idur, p6
kamp1     oscil     iamp, krate, ipulse1
kamp2     oscil     iamp, krate, ipulse2

;                   Amp     Fqc   Car   Mod   MAmp           Wave
afout     foscil    kamp1, ifqc, 1,     2.72, 1+3*(1+kamp2), 1
arnd1     rand      kamp2
arout     butterbp  arnd1, ifqc, ifqc/2

          outs      afout+arout*16, afout+arout*16

          endin
