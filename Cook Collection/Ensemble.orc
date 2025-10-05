sr     = 44100
kr     = 4410
ksmps  = 10
nchnls = 2

instr    1 ; Dual 3-Phase BBD Ensemble.

ilevl    = p4/2    ; Output level
idepth   = p5/1000 ; Depth factor
irate1   = p6      ; LFO1 rate
irate2   = p7      ; LFO2 rate
irate3   = p8      ; LFO3 rate
irate4   = p9      ; LFO4 rate
imin     = 1/kr    ; Minimum delay

ain      soundin  "Marimba.aif"

idepth1  = idepth*(1/irate1)
idepth2  = idepth*(1/irate2)
idepth3  = idepth*(1/irate3)
idepth4  = idepth*(1/irate4)
alfo1a   oscil  idepth1, irate1, 1
alfo1b   oscil  idepth1, irate1, 1, .3333
alfo1c   oscil  idepth1, irate1, 1, .6667
alfo2a   oscil  idepth2, irate2, 1
alfo2b   oscil  idepth2, irate2, 1, .3333
alfo2c   oscil  idepth2, irate2, 1, .6667
alfo3a   oscil  idepth3, irate3, 1
alfo3b   oscil  idepth3, irate3, 1, .3333
alfo3c   oscil  idepth3, irate3, 1, .6667
alfo4a   oscil  idepth4, irate4, 1
alfo4b   oscil  idepth4, irate4, 1, .3333
alfo4c   oscil  idepth4, irate4, 1, .6667
ax       delayr  1
abbd1        deltapi  alfo1a + alfo2a + imin
abbd2        deltapi  alfo1b + alfo2b + imin
abbd3    deltapi  alfo1c + alfo2c + imin
abbd4    deltapi  alfo3a + alfo4a + imin
abbd5    deltapi  alfo3b + alfo4b + imin
abbd6    deltapi  alfo3c + alfo4c + imin
         delayw  ain
outs1    (abbd1 + abbd2 + abbd3)*ilevl
outs2    (abbd4 + abbd5 + abbd6)*ilevl

endin
