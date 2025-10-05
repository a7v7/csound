sr     = 44100
kr     = 4410
ksmps  = 10
nchnls = 2

instr    1 ; Ring Modulator

ilevl    = p4                          ; Output level
ifreq1   = (p5 < 19 ? cpspch(p5) : p5) ; L start frequency in cpspch or Hz
ifreq2   = (p6 < 19 ? cpspch(p6) : p6) ; L end frequency in cpspch or Hz
ifreq3   = (p7 < 19 ? cpspch(p7) : p7) ; R start frequency in cpspch or Hz
ifreq4   = (p8 < 19 ? cpspch(p8) : p8) ; R end frequency in cpspch or Hz
idepth   = p9                          ; Depth
iwave    = p10                         ; Waveform

ain      soundin  "monks.1"

ksweep1  expon  ifreq1, p3, ifreq2
ksweep2  expon  ifreq3, p3, ifreq4
aosc1    oscili  1, ksweep1, iwave, -1
aosc2    oscili  1, ksweep2, iwave, -1
outs1    ain*(aosc1*idepth + 1*(1 - idepth))
outs2    ain*(aosc2*idepth + 1*(1 - idepth))

endin
