
; HANS MIKELSON

; ORCHESTRA

sr        =         44100
kr        =         4410
ksmps     =         10
nchnls    =         2

gaout     init      0

; PLUCK INSTRUMENT
          instr     10

iamp      =         p4
ifqc      =         cpspch(p5)

aamp      linseg    0, .005, 1, p3-.015, 1, .005, 0, .005, 0

aplk      pluck     iamp, ifqc, ifqc, 0, 1


aout      =         aplk*aamp

          outs      aout, aout

gaout     =         gaout + aout

          endin

;     REVERB
          instr     50

afltl     init      0
afltr     init      0

adcbk     butterhp  gaout, 20

avrbl1    nestedap  adcbk+.3*afltl, 3, 1, .153, .2, .075, .2, .031, .1
avrbr1    nestedap  adcbk+.3*afltr, 3, 1, .151, .2, .071, .2, .029, .1

avrbl     nestedap  avrbl1, 2, 1, .241, .32, .125, .2
avrbr     nestedap  avrbr1, 2, 1, .245, .34, .121, .2

afltl     butterlp  avrbl, 1000
afltr     butterlp  avrbr, 1020
          outs      afltl*.5, afltr*.5
gaout     =         0

          endin
