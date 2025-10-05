
;------------------------------------------------------------------
; INDUSTRY
; BY HANS MIKELSON APRIL 1998
;------------------------------------------------------------------
; ORCHESTRA

sr        =         44100
kr        =         22050
ksmps     =         2
nchnls    =         2


          instr 2

idur      =         p3
iamp      =         p4*2
ifqc      =         cpspch(p5)
iplstab   =         p6
irattab   =         p7
iratrat   =         p8
ipantab   =         p9
imixtab   =         p10
iloop     =         p11
adel      init      0

kprate    oscil     1, iratrat, irattab
kamp      oscil     iamp, kprate, iplstab
kloop     linseg    0, .005, 1, iloop-.01, 1, .005, 0, p3-iloop-.01, 0
kpan      oscil     1, 1/idur, ipantab
kmix      oscil     1, 1/idur, imixtab

asig      rand      kamp
aflt      butterbp  asig, ifqc, ifqc/4
abal      balance   aflt, asig

aout      =         abal*kloop+adel
adel      delay     aout, iloop

          outs      aout*sqrt(kpan)*kmix, aout*sqrt(1-kpan)*kmix

          endin

