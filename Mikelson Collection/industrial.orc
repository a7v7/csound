;------------------------------------------------------------------
; Industry
; by Hans Mikelson April 1998
;------------------------------------------------------------------
; ORCHESTRA
sr        =         44100
kr        =         4410
ksmps     =         10
nchnls    =         2
          
          instr     2
idur      =         p3
iamp      =         p4*2
ifqc      =         cpspch(p5)
iplstab   =         p6
irattab   =         p7
iratrat   =         p8
ipantab   =         p9
imixtab   =         p10
iloop     =         p11
adel      init      0                        
kprate    oscil     1, iratrat, irattab      ; PULSE RATE
kamp      oscil     iamp, kprate, iplstab    ; AMPLITUDE PULSE
kloop     linseg    0, .005, 1, iloop-.01, 1, .005,  0, p3-iloop-.01, 0 ; GATE IN DELAY LOOP
kpan      oscil     1, 1/idur, ipantab       ; PANNING
kmix      oscil     1, 1/idur, imixtab       ; FADING
asig      rand      kamp                     ; NOISE SOURCE
aflt      butterbp asig, ifqc, ifqc/4        ; BAND FILTER
abal      balance   aflt, asig               ; BRING LEVEL BACK UP
aout      =         abal*kloop+adel          ; GATE IN WITH FEEDBACK
adel      delay     aout, iloop              ; DELAY
          outs      aout*sqrt(kpan)*kmix, aout*sqrt(1-kpan)*kmix ; OUTPUT PAN & FADE
          endin
