; FEEDBACK FILTER ORCHESTRA BY HANS MIKELSON 

sr        =         44100
kr        =         4410
ksmps     =         10
nchnls    =         2

; FEEDBACK FILTER 1
          instr 1

idur      =         p3
iamp      =         p4
ifqc      =         cpspch(p5)
itab      =         p6
itabc     =         p7
ifeedbk   =         p8

kdclick   linseg    0, .002, 1, idur-.004, 1, .002, 0 
kfco      linseg    500, .1*idur, 5000, .4*idur, 1000, .4*idur, 500, .1*idur, 500

asig      oscil     kdclick, ifqc, itab
afilt     tone      asig, kfco

afdbk     =         afilt/10                 ; REDUCE ORIGINAL SIGNAL
adeli     delayr    .2                       ; FEED BACK DELAY
adel1     deltapi   1/kfco
afilt2    butterbp  adel1, kfco, kfco/4      ; FILTER THE DELAYED SIGNAL
kamprms   rms       afilt2                   ; FIND RMS LEVEL
kampn     =         kamprms/6                ; NORMALIZE RMS LEVEL 0-1.
kcomp     tablei    kampn,itabc,1,0          ; LOOK UP COMPRESSION VALUE IN TABLE
          delayw    afdbk+kcomp*ifeedbk*afilt2 ; ADD LIMITED FEEDBACK 
aout      =         adel1*10*kdclick*iamp

          outs      aout, aout

          endin
