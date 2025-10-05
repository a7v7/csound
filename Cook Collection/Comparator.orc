sr     = 44100
kr     = 44100
ksmps  = 1
nchnls = 1

instr    1 ; Comparator (Input > 0)

ilevl    = p4
ibal     = p5

ain      soundin  "Marimba.aif"

kin      downsamp  ain
kcom     = (kin > 0 ? 32768 : -32768)
acom     upsamp  kcom
out      acom*ibal + ain*(1 - ibal)

endin

instr    2 ; Comparator (Input1 > Input2)

ilevl    = p4

ain1     soundin  "Marimba.aif"
ain2     soundin  "oboe.mf.C4B4.aiff"

kin1     downsamp  ain1
kin2     downsamp  ain2
kcom     = (kin1 > kin2 ? 32768 : -32768)
acom     upsamp  kcom
out      acom*ilevl

endin
