; HANS MIKELSON

; ORCHESTRA
sr        =         44100
kr        =         4410
ksmps     =         10
nchnls    =         2
                    
;------------------------------------------------------------------
; FROGS?
;------------------------------------------------------------------
          instr     8
idur      =         p3
iamp      =         p4*2
ifqc      =         cpspch(p5)
iplstab   =         p6
irattab   =         p7
iratrat   =         p8
ipantab   =         p9
imixtab   =         p10
imaxd     =         p11
ideltab	=		p12
ifdbk     =         .98
abal      init      0                   
kpan      oscil     1, 1/idur, ipantab       ; PANNING
kmix      oscili    1, 1/idur, imixtab       ; FADING
kprate    oscil     1, iratrat, irattab      ; PULSE RATE
kamp      oscil     iamp, kprate, iplstab    ; AMPLITUDE PULSE
kdtime    expseg    imaxd*.9, idur*.75, imaxd*.5, idur*.25, imaxd*.4
asig      rand      kamp                     ; NOISE SOURCE
adel      vdelay    (asig+abal)*ifdbk, kdtime, imaxd ; VARIABLE DELAY RESONATOR
aflt      butterbp  adel, ifqc, ifqc/4       ; BAND FILTER
abal      balance   aflt, adel               ; ADJUST LEVEL
aout      =         abal
          outs      aout*sqrt(kpan)*kmix, aout*sqrt(1-kpan)*kmix ; OUTPUT PAN & FADE
          endin
