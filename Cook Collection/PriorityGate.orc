sr     = 44100
kr     = 44100
ksmps  = 1
nchnls = 1

instr    1 ; Gate - passes louder input

ilevl    = p4

ain1     soundin  "Marimba.aif"
ain2     soundin  "sing.aif"

kin1     downsamp  ain1
kin2     downsamp  ain2
kpos1    limit  kin1, 0, 32768
kneg1    limit  kin1,-32768, 0
kpos2    limit  kin2, 0, 32768
kneg2    limit  kin2,-32768, 0
kgate1   = (kpos1 > kpos2 ? kpos1 : kpos2)
kgate2   = (kneg1 < kneg2 ? kneg1 : kneg2)
kgate    = kgate1 + kgate2
agate    upsamp  kgate
out      agate*ilevl

endin

instr    2 ; Gate - passes quieter input

ilevl    = p4

ain1     soundin  "Marimba.aif"
ain2     soundin  "sing.aif"

kin1     downsamp  ain1
kin2     downsamp  ain2
kpos1    limit  kin1, 0, 32768
kneg1    limit  kin1,-32768, 0
kpos2    limit  kin2, 0, 32768
kneg2    limit  kin2,-32768, 0
kgate1   = (kpos1 < kpos2 ? kpos1 : kpos2)
kgate2   = (kneg1 > kneg2 ? kneg1 : kneg2)
kgate    = kgate1 + kgate2
agate    upsamp  kgate
out      agate*ilevl

endin
