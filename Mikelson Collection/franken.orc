sr        =         44100
kr        =         4410
ksmps     =         10
nchnls    =         2

zakinit 50, 50

;------------------------------------------------------------------
; FRANKENSTEIN'S BLENDER
;------------------------------------------------------------------
          instr     10

idur      =          p3
isndin    =          p4
ilptim    =          p5
ioffst    =          p6

klptim    oscili    1, 1/idur, ilptim
koffs     rand      ioffst
kdclick   linseg    0, .002, 1, idur-.004, 1, .002, 0

loop1:

iloop     =          i(rnd(klptim))

kamp      linseg     0, iloop/2, 1, iloop/2, 0

a1, a2    soundin   isndin, i(koffs+ioffst+.01)
aout1     =          a1*kamp
aout2     =          a2*kamp

;       WHEN THE TIME RUNS OUT REINITIALIZE
          timout     0, iloop, cont1
          reinit     loop1
cont1:
          outs       aout1*kdclick, aout2*kdclick

          endin

;------------------------------------------------------------------
; FRANKENSTEIN'S BLENDER STEREO
;------------------------------------------------------------------
          instr        11

idur      =         p3
isndin    =         p4
ilptimtab =         p5
ioffst    =         p6
ichan     =         p7
azero     init      0
icount    init      0
icntp1    init      1

koffs     rand      ioffst
kdclick   linseg    0, .002, 1, idur-.004, 1, .002, 0
icount    =         frac((icount+1)/256)*256
icntp1    =         frac((icntp1+1)/256)*256

loop1:
;iloop    =         i(rnd(klptim))
ilptim1   table     icount, ilptimtab
ilptim    =         (ilptim1+1)/2
ilptmp11  table     icntp1, ilptimtab
ilptmp1   =         (ilptmp11+1)/2
iloop     =         ilptim
kamp      linseg    0, .01, 1, iloop-.02, 1, .01, 0

a1, a2    soundin   isndin, i(koffs+ioffst+.01)
a1        =         (ichan=0 ? a1 : azero)
a2        =         (ichan=1 ? a2 : azero)
aout1     =         a1*kamp
aout2     =         a2*kamp

;       WHEN THE TIME RUNS OUT REINITIALIZE
          timout    0, ilptmp1, cont1
          reinit    loop1
cont1:

          outs      aout1*kdclick, aout2*kdclick

          endin

;------------------------------------------------------------------
; SAMPLER EFFECTS
;------------------------------------------------------------------
          instr         7

idur      =           p3
iamp      =           p4
ifqc      =           p5
irattab   =           p6
iratrat   =           p7
ipantab   =           p8
imixtab   =           p9
ilptab    =           p10
isndin    =           p11

kpan      oscil       1, 1/idur, ipantab               ; Panning
kmix      oscil       1, 1/idur, imixtab               ; Fading
kloop     oscil       1, 1/idur, ilptab                ; Looping

loop1:
kprate    oscil       1, iratrat/kloop, irattab              ; Pulse Rate
kamp      linseg      0, .01, 1, i(kloop)-.02, 1, .01, 0

;                     Amp     Fqc
;a1, a2   diskin      isndin, ifqc
a1, a2    soundin     isndin
aout      =           (a1+a2)/2*kamp

;       WHEN THE TIME RUNS OUT REINITIALIZE
          timout      0, i(kloop), cont1
          reinit      loop1
cont1:

          outs        aout*sqrt(kpan)*kmix, aout*sqrt(1-kpan)*kmix ; Output pan & fade

          endin

