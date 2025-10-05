sr     = 44100
kr     = 4410
ksmps  = 10
nchnls = 1

instr    1 ; Random Vowel Reson Filter.

ilevl    = p4/550
irate    = p5
iseed    = p6

a0       soundin  "Sample1"

k1       randi  .5, irate, iseed
k1       = k1 + .5
k1f      table  k1, 11, 1
k2f      table  k1, 12, 1
k3f      table  k1, 13, 1
k4f      table  k1, 14, 1
k5f      table  k1, 15, 1
k1b      table  k1, 21, 1
k2b      table  k1, 22, 1
k3b      table  k1, 23, 1
k4b      table  k1, 24, 1
k5b      table  k1, 25, 1
a1       reson  a0, k1f, k1b
a2       reson  a0, k2f, k2b
a3       reson  a0, k3f, k3b
a4       reson  a0, k4f, k4b
a5       reson  a0, k5f, k5b
out      (a1 + a2 + a3 + a4 + a5)*ilevl

endin
