sr        =         44100
kr        =         4410
ksmps     =         10
nchnls    =         1

        instr 1
a1      soundin 5
a2      comb        a1*p4*.5, p5, p6, 0
        out     a2
        endin
