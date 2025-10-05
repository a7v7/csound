sr     = 44100
kr     = 4410
ksmps  = 10
nchnls = 1

instr    1 ; "Valve" distortion using variable power

idrive   = p4/100

a1       soundin  "Sample1"
a2       = a1/2 + 16384
k0       downsamp  a1
k1       = (abs(k0)/4096)*idrive + 1
k2       pow  32767, k1, 32767
a3       pow  a2, k1
out      (a3/k2 - 16384)*2

endin
