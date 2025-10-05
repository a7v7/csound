sr     = 44100
kr     = 4410
ksmps  = 10
nchnls = 1

instr    1 ; Barberpole flanger

ilevl    = p4*.25                           ; Output level
idepth   = p5/1000                          ; Depth in ms
irate    = p6                               ; Rate
ifeed    = p7                               ; Feedback
imode    = p8 + 1                           ; Mode: 0=Up 1=Down

ain      soundin  "Marimba.aif"

asaw1    oscili  idepth, irate, imode       ; Saw 0 degrees
asaw2    oscili  idepth, irate, imode, .25  ; Saw 90 degrees
asaw3    oscili  idepth, irate, imode, .5   ; Saw 180 degrees
asaw4    oscili  idepth, irate, imode, .75  ; Saw 270 degrees

asin1    oscili  1, irate, 3                ; 1/2 Sine 0 degrees
asin2    oscili  1, irate, 3, .25           ; 1/2 Sine 90 degrees
asin3    oscili  1, irate, 3, .5            ; 1/2 Sine 180 degrees
asin4    oscili  1, irate, 3, .75           ; 1/2 Sine 270 degrees

adel1    flanger  ain, asaw1, ifeed, idepth ; Flanger 1
adel2    flanger  ain, asaw2, ifeed, idepth ; Flanger 2
adel3    flanger  ain, asaw3, ifeed, idepth ; Flanger 3
adel4    flanger  ain, asaw4, ifeed, idepth ; Flanger 4

aflange  = adel1*asin1 + adel2*asin2 + adel3*asin3 + adel4*asin4
aflange  dcblock  aflange
adirect  = ain*(asin1 + asin2 + asin3 + asin4)

out      aflange*ilevl + adirect*ilevl      ; Output

endin
