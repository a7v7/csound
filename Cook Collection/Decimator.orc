sr     = 44100
kr     = 44100
ksmps  = 1
nchnls = 1

instr    1 ; Bit depth reducer - "Decimator"

ibit1    = p4 ; Start bit depth (1 to 16)
ibit2    = p5 ; End bit depth (1 to 16)

ain      soundin  "Marimba.aif"

kin      downsamp  ain                ; Convert to kr
kin      = kin + 32768                ; Add DC to avoid (-)
kbits    expon  ibit1, p3, ibit2      ; Generate curve
kbits    = 2^kbits                    ; Calc divide factor
kin      = kin*(kbits/65536)          ; Divide signal level
kin      = int(kin)                   ; Quantise
aout     upsamp  kin                  ; Convert to sr
aout     = aout*(65536/kbits) - 32768 ; Scale and remove DC
out      aout

endin
