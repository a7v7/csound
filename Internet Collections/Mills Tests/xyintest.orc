sr        =         44100
kr        =         4410
ksmps     =         10
nchnls    =         1

          instr     1
kx, ky    xyin      .1, 0, 320, 0, 240
;         display   ky,1
aout      oscili    ky * 500, 200 + kx, 1
          out       aout
          endin
