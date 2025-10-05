sr     = 44100
kr     = 44100
ksmps  = 1
nchnls = 1

instr    1 ; Tape / Record stop simulator

ilevl    = p4*32767          ; Output level
idelay   = p5                ; Delay before stopping
itime    = p6                ; Stopping time
iaccel   = p7                ; Decceleration curve 
ileng    = ftlen(1)/ftsr(1)  ; Sample1 length

kdclick  linseg  0, .001, 1, p5 + p6 - .101, 1, .1, 0
kstop    oscil1  idelay, 1, itime, iaccel ; Generate decceleration curve
kline    phasor  (1/ileng)*kstop          ; Index
ain      table3  kline, 1, 1              ; Index Sample table
out      ain*kdclick*ilevl                ; Level declick and output

endin
