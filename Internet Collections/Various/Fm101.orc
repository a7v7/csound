sr        =         44100 
kr        =         4410                                  
ksmps     =         10
nchnls    =         1

; SIMPLE FM INSTRUMENT WITH ENVELOPE GENERATORS.

          instr 1

idur      =         p3
icaramp   =         p4
icarfreq  =         p5
icarwave  =         p6
imodamp   =         p7
imodfreq  =         p8
imodwave  =         p9
icarrise  =         p10
icardec   =         p11
imodrise  =         p12
imoddec   =         p13

; OUTPUT  UNITGEN    AMPLITUDE   FREQUENCY WAVESHAPE

kmodamp   linen     imodamp, imodrise, idur, imoddec 
amod      oscil     kmodamp, imodfreq, imodwave
 
kcaramp   linen     icaramp, icarrise,   idur, icardec 
acar      oscil     kcaramp, icarfreq + amod, icarwave


; UNITGEN INPUT
          out        acar
          endin
