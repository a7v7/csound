sr       = 44100
kr       = 4410
ksmps    = 10
nchnls   = 2

instr    1 ; EQ-Based Stereoizer

ilevl    = p4*2.5 ; Output level

ain      soundin  "Sample1"

ain      = ain*ilevl
a01      tonex  ain,    50, 2
a02      atonex  ain,    50, 2
a02      tonex  a02,   100, 2
a03      atonex  ain,   100, 2
a03      tonex  a03,   200, 2
a04      atonex  ain,   200, 2
a04      tonex  a04,   400, 2
a05      atonex  ain,   400, 2
a05      tonex  a05,   800, 2
a06      atonex  ain,   800, 2
a06      tonex  a06,  1600, 2
a07      atonex  ain,  1600, 2
a07      tonex  a07,  3200, 2
a08      atonex  ain,  3200, 2
a08      tonex  a08,  6400, 2
a09      atonex  ain,  6400, 2
a09      tonex  a09, 12800, 2
a10      atonex  ain, 12800, 2
outs1    a01 + a03 + a05 + a07 + a09
outs2    a02 + a04 + a06 + a08 + a10

endin
