; ORCHESTRA
sr        =         44100
kr        =         4410
ksmps     =         10
nchnls    =         2
          zakinit   30, 30

;---------------------------------------------------------------------------
; THE BIRDS
;---------------------------------------------------------------------------
          instr 42

idur      =         p3
iamp      =         p4
ifqc      =         cpspch(p5)
iwrbfm    =         p6
iwrbrt    =         p7
iwrbam    =         p8
iwave     =         p9
ioutch    =         p10

iwbeg     =         (iwrbfm>0 ? 1+iwrbfm         : 1/(1-iwrbfm)) ; DETERMINE WHETHER TO
iwend     =         (iwrbfm>0 ? 1/(1+iwrbfm) : 1-iwrbfm) ; RAMP UP OR DOWN.

kamp      linseg    0, .01, iamp, idur-.02, iamp, .01, 0 ; DECLICK

; FREQUENCY MODULATION
krate     linseg    iwbeg, idur, iwend
kfmod     oscil     iwrbam*krate, iwrbrt*krate, 1
kfmod     =         1+kfmod
kfqc      =         kfmod*ifqc

aout      oscil     kamp*kfmod, kfqc, iwave

          zawm      aout, ioutch

          endin

;---------------------------------------------------------------------------
; MIXER
;---------------------------------------------------------------------------
          instr 100

idur      init      p3
iamp      init      p4
inch      init      p5
ipan      init      p6
ifader    init      p7
ioutch    init      p8
                         
asig1     zar       inch                     ; READ INPUT CHANNEL 1

kfader    oscil     1, 1/idur, ifader
kpanner   oscil     1, 1/idur, ipan

kgl1      =         kfader*sqrt(kpanner)     ; LEFT GAIN
kgr1      =         kfader*sqrt(1-kpanner)   ; RIGHT GAIN

kdclick   linseg    0, .002, iamp, idur-.002, iamp, .002, 0  ; DECLICK

asigl     =         asig1*kgl1               ; SCALE AND SUM
asigr     =         asig1*kgr1

          outs      kdclick*asigl, kdclick*asigr ; OUTPUT STEREO PAIR
          zaw       kdclick*kfader*asig1, ioutch ; OUTPUT POSTFADER

          endin

;---------------------------------------------------------------------------
; CLEAR AUDIO & CONTROL CHANNELS
;---------------------------------------------------------------------------
          instr 110

          zacl      0, 30                    ; CLEAR AUDIO CHANNELS 0 TO 30
          zkcl      0, 30                    ; CLEAR CONTROL CHANNELS 0 TO 30

          endin
