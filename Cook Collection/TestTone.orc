sr     = 44100
kr     = 44100
ksmps  = 1
nchnls = 1

instr    1 ; Sine/Triangle/Square Sweep Oscillator

ilevl    = ampdb(90 + p4) ; Level in dB (0dB = Peak-.3dB)
ifreq1   = p5             ; Sweep start
ifreq2   = p6             ; Sweep end
imode    = p7             ; Sweep mode: 0=Exp, 1=Lin
iwave    = p8             ; Waveform

if       imode = 1 goto lin
asweep   expseg  ifreq1, p3, ifreq2
goto     osc
lin:
asweep   linseg  ifreq1, p3, ifreq2
goto     osc
osc:
aosc     oscil3  ilevl, asweep, iwave
out      aosc

endin
