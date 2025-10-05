sr     = 44100
kr     = 4410
ksmps  = 10
nchnls = 1

instr    1 ; Polynominal function distortion

ain      soundin  "Marimba.aif"
ain      = ain/32767         ; Scale input to +/-1
apoly    = ain - ain*ain*ain ; Polynominal function

out      apoly*85196         ; Scale output

endin
