sr     = 44100
kr     = 44100
ksmps  = 1
nchnls = 1

instr    1 ; Gate - passes signal over threshold

ilevl    = p4       ; Level
ithresh  = p5*32768 ; Threshold

ain      soundin  "Sample1"
kin      downsamp  ain

kpos     limit  kin, 0, 32768
kneg     limit  kin,-32768, 0

kgate1   = (kpos > ithresh ? kpos : 0)
kgate2   = (kneg <-ithresh ? kneg : 0)

kgate    = kgate1 + kgate2
agate    upsamp  kgate

out      agate*ilevl

endin

instr    2 ; Gate - passes signal under threshold

ilevl    = p4/p5    ; Level scaled to compensate for clipping
ithresh  = p5*32768 ; Threshold

ain      soundin  "Sample1"
kin      downsamp  ain

kpos     limit  kin, 0, 32768
kneg     limit  kin,-32768, 0

kgate1   = (kpos < ithresh ? kpos : 0)
kgate2   = (kneg >-ithresh ? kneg : 0)

kgate    = kgate1 + kgate2
agate    upsamp  kgate

out      agate*ilevl

endin
