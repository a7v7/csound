sr     = 44100
kr     = 44100
ksmps  = 1
nchnls = 2

instr    1 ; Random wavecycle delete - complementary outputs

ilevl    = p4       ; Output level
iline1   = p5*2 - 1 ; Fraction deleted - start
iline2   = p6*2 - 1 ; Fraction deleted - end

ain      soundin  "monks.1"

kin      downsamp  ain                 ; Convert input to kr
kline    line  iline1, p3, iline2      ; Generate control line
krand    rand  1                       ; Generate random signal
kzero    trigger  kin, 0, 0            ; Detect zero crossings
if       kzero = 0 goto output         ; Do nothing if not zero
if       krand + kline < 0 goto delete ; Goto delete if random < 0
adelete  = 1                           ; Don't delete wavecycle
goto     output
delete:
adelete  = 0                           ; Delete wavecycle
output:
outs1    ain*adelete*ilevl             ; Output, delete and level
outs2    ain*(1 - adelete)*ilevl       ; Output, -delete and level

endin
