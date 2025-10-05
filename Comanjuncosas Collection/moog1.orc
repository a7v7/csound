; ORCHESTRA
sr        =         44100
kr        =         4410
ksmps     =         10
nchnls    =         1

          instr 1
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; BANDLIMITED SAWTOOTH GENERATOR
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

ibound    =         sr/2
kfreq     =         100

apulse1   buzz      1, kfreq, ibound/kfreq, 1
asawdc    filter2   apulse1, 1, 1, 1, -.99   ; LEAKY INTEGRATOR
asaw      =         asawdc - .5

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; RESONANT FILTER (4-POLE LPF)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; YOU CAN REPLACE THIS FILTER WITH ANY OTHER YOU LIKE

ax        =         asaw

; CUTOFF AND RESONANCE ENVELOPES
; QUICK TEST CURVES
kres      init      p4
kfco      expseg    p6, p3/2, p5, p3/2, p6


ay1       init      0
ay2       init      0
ay3       init      0
ay4       init      0

kfcon     =         kfco/(sr/2)              ; USE FREQ NORMALIZED DC TO NYQUIST
kp        tablei    kfcon, 21, 1             ; (APPROXIMATED) TUNING TABLE
kscale    tablei    (kp+1)/2, 20, 1          ; ADJUST FEEDBACK (APPROXIMATION)
kk        =         kres*kscale

; INVERTED FEEDBACK FOR CORNER PEAKING
ax        =         ax - kk*ay4

; 4 CASCADED ONEPOLE FILTERS (BILINEAR TRANSFORM)
ax1       delay1    ax
ay1       =         ax * (kp+1)/2 + ax1 * (kp+1)/2 - kp*ay1

ay11      delay1    ay1
ay2       =         ay1 * (kp+1)/2 + ay11 * (kp+1)/2 - kp*ay2

ay21      delay1    ay2
ay3       =         ay2 * (kp+1)/2 + ay21 * (kp+1)/2 - kp*ay3

ay31      delay1    ay3
ay4       =         ay3 * (kp+1)/2 + ay31 * (kp+1)/2 - kp*ay4

; CLIPPER/DISTORTER VIA WAVESHAPING
; TO ALLOW AUTOOSCILLATION WITHOUT OVERDRIVING
; CERTAINLY MORE EFFICIENT WITH TABLE LOOK-UP,
; BUT IT DIDN«T WORK. ANY IDEA?
ay4       =         ay4-ay4*ay4*ay4/6        ; KIND OF BANDLIMITED SIGMOID

; FILTER OUTPUT
; ENVELOPE
kenv      linen     1, .1,p3, .1
          out       ay4*20000*kenv
          endin
