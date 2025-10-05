sr        =         44100
kr        =         4410
ksmps     =         10
nchnls    =         1
                                             
          instr 12       
aph       phasor    100                      ; PHASES 0-1 100 TIMES/SECOND
ilength   =         ftlen(p4)
aph       =         aph*ilength
a1        table     aph, p4
kph       downsamp  aph
k1        downsamp  a1
          out       a1*20000
          printks   "address=%6.4f\t value=%6.4f\n", .01, kph, k1, 0, 0
          display   a1, .01
          endin

          instr 13       
aph       phasor    100                      ; PHASES 0-1 100 TIMES/SECOND
ilength   =         ftlen(p4)
aph       =         aph*ilength
a1        tablei    aph, p4
kph       downsamp  aph
k1        downsamp  a1
          out       a1*20000
          printks   "address=%6.4f\t value=%6.4f\n", .01, kph, k1, 0, 0
          display   a1, .01
          endin
