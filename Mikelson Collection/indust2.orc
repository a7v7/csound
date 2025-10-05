;------------------------------------------------------------------
; INDUSTRY
; BY HANS MIKELSON APRIL 1998
;------------------------------------------------------------------
; ORCHESTRA

sr             =              44100
kr             =              4410
ksmps          =              10
nchnls         =              2

;------------------------------------------------------------------
; INDUSTRIAL LOOPS
;------------------------------------------------------------------
               instr          2

idur           =              p3
iamp           =              p4*2
ifqc           =              cpspch(p5)
iplstab        =              p6
irattab        =              p7
iratrat        =              p8
ipantab        =              p9
imixtab        =              p10
iloop          =              p11
adel           init           0

kprate         oscil          1, iratrat, irattab                                    ; PULSE RATE
kamp           oscil          iamp, kprate, iplstab                                  ; AMPLITUDE PULSE
kloop          linseg         0, .005, 1, iloop-.01, 1, .005,  0, p3-iloop-.01, 0    ; GATE IN DELAY LOOP
kpan           oscil          1, 1/idur, ipantab                                     ; PANNING
kmix           oscil          1, 1/idur, imixtab                                     ; FADING

asig           rand           kamp                                                   ; NOISE SOURCE
aflt           butterbp       asig, ifqc, ifqc/4                                     ; BAND FILTER
abal           balance        aflt, asig                                             ; BRING LEVEL BACK UP

aout           =              abal*kloop+adel                                        ; GATE IN WITH FEEDBACK
adel           delay          aout, iloop                                            ; DELAY

               outs           aout*sqrt(kpan)*kmix, aout*sqrt(1-kpan)*kmix ; Output pan & fade

               endin

;------------------------------------------------------------------
; SCIFI LOOPS
;------------------------------------------------------------------
               instr          3

idur           =              p3
iamp           =              p4
ifqc           =              cpspch(p5)
irattab        =              p6
iratrat        =              p7
ipantab        =              p8
imixtab        =              p9
iloop          =              p10
imodf          =              p11
imodl          =              p12
adel           init            0

krate          oscil          1, iratrat, irattab                                    ; PULSE RATE
kloop          linseg         0, .005, 1, iloop-.01, 1, .005,  0, p3-iloop-.01, 0    ; GATE IN DELAY LOOP
kpan           oscil          1, 1/idur, ipantab                                     ; PANNING
kmix           oscil          1, 1/idur, imixtab                                     ; FADING
kmodl          linseg         0, iloop/2, imodl, iloop/2, imodl/2, .01, 0, .01, 0

;                             Amp   Fqc      Car   Mod    MAmp    Wave
abal           foscil         iamp, ifqc*krate, 1,      imodf, imodl,  1             ; FM SOURCE

aout           =              abal*kloop+adel                                        ; GATE IN WITH FEEDBACK
adel           delay          aout, iloop                                            ; DELAY

               outs           aout*sqrt(kpan)*kmix, aout*sqrt(1-kpan)*kmix           ; OUTPUT PAN & FADE

               endin



