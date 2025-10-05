sr          =           44100
kr          =           4410
ksmps       =           10
nchnls      =           1

            instr       1
            
iduration   =           p3
iamp        =           p4
inoiseamp   =           22050
istartfilt  =           p5
iendfilt    =           p6
iattack     =           .01
irelease    =           .1
            
kenvelope   linen       iamp, iattack, iduration, irelease
kcutoffrq   line        istartfilt, iduration, iendfilt

anoise      rand        inoiseamp
afilter1    butterbp    anoise, kcutoffrq, kcutoffrq / 10
afilter2    butterbp    afilter1, kcutoffrq, kcutoffrq  / 10
asignal     =           afilter2 * kenvelope

            out         asignal
            endin
