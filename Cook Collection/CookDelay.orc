sr     = 44100
kr     = 4410
ksmps  = 10
nchnls = 1

instr    1 ; Delay negative half of signal

ilevel   = p4*2
idelay   = p5/1000 ; Delay in ms
ibal     = p6

ain      soundin  "Marimba.aif"

apos     limit  ain, 0, 32768
aneg     limit  ain, -32768, 0

adel     delay  aneg, idelay

amix     = apos*ibal + adel*(1 - ibal)

out      amix*ilevel
  
endin
