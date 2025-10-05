sr       = 44100
kr       = 4410
ksmps    = 10
nchnls   = 1

instr    1 ; DUY 'Shape' ProTools plugin emulator

ilevl    = p4*32767 ; Output level
icut1    = p5       ; Low/Mid crossover freq
icut2    = p6       ; Mid/High crossover freq
itabl1   = p7       ; Low waveshape table
itabl2   = p8       ; Mid waveshape table
itabl3   = p9       ; High waveshape table

ain      soundin  "Sample1"

ain      = ain/65536
alo      tone  ain, icut1
atm      tone  ain, icut2
amd      atone  atm, icut1
ahi      atone  ain, icut2
alo      tablei  alo, itabl1, 1, .5
amd      tablei  amd, itabl2, 1, .5
ahi      tablei  ahi, itabl3, 1, .5
amix     sum  alo, amd, ahi
amix     dcblock  amix
out      amix*ilevl

endin
