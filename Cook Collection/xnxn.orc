sr     = 44100
kr     = 4410
ksmps  = 10
nchnls = 1

instr    1 ; x*2 - x^2 function (Even harmonic distortion)

ain      soundin  "Sample1"
ain      = ain/32767
afunc    = ain*2 - ain*ain
out      afunc*32767/3

endin

instr    2 ; x*3 - x^3 distortion (Compresses Signal)

ain      soundin  "Sample1"
ain      = ain/32767
afunc    = ain*3 - ain*ain*ain
out      afunc*16384

endin
