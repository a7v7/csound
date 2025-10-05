;*************************************************** 
; TONE WHEEL ORGAN WITH ROTATING SPEAKER 
; MIKELSON
;*************************************************** 

sr        =         44100
kr        =         4410
ksmps     =         10
nchnls    =         2

; TONE WHEEL ORGAN
          instr     1 

idur      =         p3
iamp      =         p4
ifqc      =         cpspch(p5)

asrc      oscili    iamp,ifqc,2                        ; ORGAN SOURCE
kenv      linseg    0, .01, 1, idur-.02, 1, .01, 0     ; ENVELOPE 
gasig1    =         asrc*kenv

          endin
          
; TONE WHEEL ORGAN
          instr     2 

idur      =         p3
iamp      =         p4
ifqc      =         cpspch(p5)

asrc      oscili    iamp,ifqc,2                        ; ORGAN SOURCE
kenv      linseg    0, .01, 1, idur-.02, 1, .01, 0     ; ENVELOPE 
gasig2    =         asrc*kenv

          endin
          
; TONE WHEEL ORGAN

          instr     3 

idur      =         p3
iamp      =         p4
ifqc      =         cpspch(p5)

asrc      oscili    iamp,ifqc,2                        ; ORGAN SOURCE
kenv      linseg    0, .01, 1, idur-.02, 1, .01, 0     ; ENVELOPE 
gasig3    =         asrc*kenv

          endin

;ROTATING SPEAKER
          instr     4

isep      =         .2

asig      =         gasig1 +gasig2 + gasig3

; DISTORTION EFFECT
asig      =         asig/40000
aclip     tablei    asig, 5, 1, .5
aclip     =         aclip*30000

aleslie   delayr    .02, 1
delayw    aclip

; ACCELERATION
kenv      linseg    p4, p3+.02, p5

; DOPPLER EFFECT
koscl     oscil     1, kenv, 1, 0
koscr     oscil     1, kenv, 1, isep
kdopl     =         .01-koscl*.0002
kdopr     =         .012-koscr*.0002
aleft     deltapi   kdopl
aright    deltapi   kdopr

; FILTER EFFECT
; DIVIDE INTO THREE FREQUENCY RANGES FOR DIRECTIONAL SOUND. 

; HIGH PASS
alfhi     atone     aleft, 8000
arfhi     atone     aright, 8000
alfhi     tone      alfhi, 12000
arfhi     tone      arfhi, 12000

; BAND PASS
alfmid    atone     aleft, 4000
arfmid    atone     aright, 4000
alfmid    tone      alfmid, 8000
arfmid    tone      arfmid, 8000

; LOW PASS
alflow    tone      aleft, 4000
arflow    tone      aright, 4000

kflohi    oscil     1, kenv, 3, 0
kfrohi    oscil     1, kenv, 3, isep
kflomid   oscil     1, kenv, 4, 0
kfromid   oscil     1, kenv, 4, isep

; AMPLITUDE EFFECT
kalosc    =         koscl * .1 + 1
karosc    =         koscr * .1 + 1


          outs      alfhi*kflohi+alfmid*kflomid+alflow*kalosc,arfhi*kfrohi+arfmid*kfromid+arflow*karosc
          endin
