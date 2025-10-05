;------------------------------------------------------------------
; INDUSTRY
; BY HANS MIKELSON APRIL 1998
;------------------------------------------------------------------
; ORCHESTRA
          
sr        =         44100
kr        =         4410
ksmps     =         10
nchnls    =         2

;------------------------------------------------------------------
; SCIFI EFFECTS
;------------------------------------------------------------------
          instr      6

idur      =          p3
iamp      =          p4
ifqc      =          cpspch(p5)
irattab   =          p6
iratrat   =          p7
ipantab   =          p8
imixtab   =          p9
ilptab    =          p10
imodf     =          p11
imodl     =          p12

kpan      oscil      1, 1/idur, ipantab                     ; PANNING
kmix      oscil      1, 1/idur, imixtab                     ; FADING
kloop     oscil      1, 1/idur, ilptab                      ; LOOPING

loop1:
kprate    oscil      1, iratrat/kloop, irattab              ; PULSE RATE

;                Amp   Fqc          Car   Mod    MAmp    Wave
aout      foscil   iamp, ifqc*kprate, 1,    imodf, imodl,  1    ; FM SOURCE

;       WHEN THE TIME RUNS OUT REINITIALIZE
          timout     0, i(kloop), cont1
          reinit     loop1
cont1:

          outs       aout*sqrt(kpan)*kmix, aout*sqrt(1-kpan)*kmix ; OUTPUT PAN & FADE

          endin

