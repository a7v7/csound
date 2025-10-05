sr     = 44100
kr     = 4410
ksmps  = 10
nchnls = 1

instr    1 ; Random interpolation between 8 waveforms

ilevl    = p4*32767   ; Output level
ipitch   = cpspch(p5) ; Pitch
irate    = p6         ; Random rate
idet     = p7         ; Detune

iseed    = rnd(1)
adclick  linseg  0, .002, 1, p3-.004, 1, .002, 0
a0       randi  .5, irate, iseed
a0       = a0 + .5
a11      table  a0, 50, 1, 0, 1
a22      table  a0, 50, 1, .125, 1
a33      table  a0, 50, 1, .25, 1
a44      table  a0, 50, 1, .375, 1
a55      table  a0, 50, 1, .5, 1
a66      table  a0, 50, 1, .625, 1
a77      table  a0, 50, 1, .75, 1
a88      table  a0, 50, 1, .875, 1
ipitch   = ipitch + idet
a1       oscil  a11, ipitch, 1, -1
a2       oscil  a22, ipitch, 2, -1
a3       oscil  a33, ipitch, 3, -1
a4       oscil  a44, ipitch, 4, -1
a5       oscil  a55, ipitch, 5, -1
a6       oscil  a66, ipitch, 6, -1
a7       oscil  a77, ipitch, 7, -1
a8       oscil  a88, ipitch, 8, -1
asum     = a1 + a2 + a3 + a4 + a5 + a6 + a7 + a8
out      asum*adclick*ilevl

endin
