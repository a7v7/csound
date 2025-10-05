
sr        =         44100
kr        =         22050
ksmps     =         2
nchnls    =         2

;-------------------------------------------------------------
; SINGLE TRIGGER DRUM SAMPLES
;-------------------------------------------------------------
          instr     3

idur      =         p3+p9
p3        =         p3+p9
iamp      =         p4
ifqc      =         cpspch(p5)
ibase     =         cpspch(8.09)
iwav      =         p6
iatk      =         p7
idcy      =         p8
irel      =         p9

kamp      linseg    0, iatk, 1, idur-iatk-idcy, 1, idcy,0
asamp1    loscil    iamp, ifqc, iwav, ibase

          outs      asamp1*kamp, asamp1*kamp

          endin

