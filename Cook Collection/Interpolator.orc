sr     = 44100
kr     = 441
ksmps  = 100
nchnls = 1

instr    1 ; Sample1 interpolator - Set kr to rate wanted

ilevl    = p4 ; Output level

ain      soundin  "Piano.aif"
kin      downsamp  ain
aout     interp  kin
out      aout*ilevl

endin
