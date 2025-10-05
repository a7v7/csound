sr        =         44100 
kr        =         4410                                  
ksmps     =         10
nchnls    =         1

; FM INSTRUMENT
 
; THREE PARALLEL CARRIERS
; FOUR INDEPENDENT ENVELOPE GENERATORS
; INDEPENDENT MODULATION INDEX

          instr 3

idur      =         p3             
icaramp   =         (ampdb(p4))/3            ; SCALE THE OUTPUT OF MY THREE CARRIERS
icar1freq =         p5
icar2freq =         p6
icar3freq =         p7
index     =         p8
imodfreq  =         p9
imodindex =         imodfreq * index
icarwave  =         1
imodwave  =         1
imodrise  =         p10
imoddec   =         p11
icar1rise =         p12
icar1dec  =         p13
icar2rise =         p14
icar2dec  =         p15
icar3rise =         p16
icar3dec  =         p17
indexscale1 =       p18                      ; SCALE THE MODULATION INDEX BY A PERCENTAGE 1 = 100%
indexscale2 =       p19
indexscale3 =       p20
 
kmodamp   linen     imodindex, imodrise, idur, imoddec 
amod      oscil     kmodamp, imodfreq, imodwave
 
kcar1amp  linen     icaramp, icar1rise, idur, icar1dec 
acar1     oscil     kcar1amp, icar1freq + (amod * indexscale1), icarwave

kcar2amp  linen     icaramp, icar2rise, idur, icar2dec 
acar2     oscil     kcar2amp, icar2freq + (amod * indexscale2), icarwave

kcar3amp  linen     icaramp, icar3rise, idur, icar3dec 
acar3     oscil     kcar3amp, icar3freq + (amod * indexscale3), icarwave

          out       acar1 + acar2 + acar3    ; SCALING THE OUTPUT 
          endin
