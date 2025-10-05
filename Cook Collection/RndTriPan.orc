sr     = 44100
kr     = 4410
ksmps  = 10
nchnls = 2

instr    1 ; Autopan with 'Random Triangle' LFO

ilevl    = p4      ; Output level
kramp    init p5   ; Initial position (0=L 1=R)
islope   = p6/kr   ; LFO rate
irate    = p7      ; LFO reversing rate

ain      soundin  "Marimba.aif"

iseed    = rnd(1)
krnd     randi  1, irate, iseed
if       krnd > 0 goto up
kramp    = kramp + islope
goto     lfo
up:
kramp    = kramp - islope
goto     lfo
lfo:
klfo1    mirror  kramp, 0, 1
klfo2    = 1 - klfo1
outs1    ain*sqrt(klfo1)
outs2    ain*sqrt(klfo2)

endin

