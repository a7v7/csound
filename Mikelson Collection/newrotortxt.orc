;------------------------------------------------------------------------
; Tone Wheel Organ with Rotating Speaker
;------------------------------------------------------------------------

sr     = 44100
kr     = 2205
ksmps  = 20
nchnls = 2

;------------------------------------------------------------------------
; Global initialization
;------------------------------------------------------------------------

         instr 1
gispeedf init  p4           ;Initialize rotor speed
         endin
        
;------------------------------------------------------------------------
; This instrument acts as the foot switch controlling rotor speeds.
;------------------------------------------------------------------------
         instr 2

gispeedi init   gispeedf    ;Save old speed
gispeedf init   p4          ;update new speed

gkenv    linseg gispeedi*.8,1,gispeedf*.8,.01,gispeedf*.8 ;High freq. rotor acceleration
gkenvlow linseg gispeedi*.7,2,gispeedf*.7,.01,gispeedf*.7 ;Low freq. rotor acceleration

         endin

;------------------------------------------------------------------------
; Tone Wheel Organ
;------------------------------------------------------------------------
         instr 3

gaorgan  init  0                       ;Global send to speaker
iphase   init  p2                      ;Continuous phase change based on p2
ikey     init  12*int(p5-6)+100*(p5-6) ;Keyboard key pressed.
ifqc     init  cpspch(p5)              ;Convert to cycles/sec.
iwheel1  init  ((ikey-12) > 12 ? 1:2)  ;The lower 12 tone wheels have
iwheel2  init  ((ikey+7)  > 12 ? 1:2)  ;increased odd harmonic content.
iwheel3  init  (ikey      > 12 ? 1:2)
iwheel4  init  1                       
  
;------------------------------------------------------------------------
kenv     linseg 0,.01,p4,p3-.02,p4,.01,0 ;Amplitude envelope.

;------------------------------------------------------------------------
asubfund oscil  p6,  .5*ifqc,      iwheel1, iphase/(ikey-12)  ;The organ tone is
asub3rd  oscil  p7,  1.4983*ifqc,  iwheel2, iphase/(ikey+7)   ;made from adding
afund    oscil  p8,  ifqc,         iwheel3, iphase/ikey       ;the weighted output
a2nd     oscil  p9,  2*ifqc,       iwheel4, iphase/(ikey+12)  ;of 9 equal temperament
a3rd     oscil  p10, 2.9966*ifqc,  iwheel4, iphase/(ikey+19)  ;tone wheels.
a4th     oscil  p11, 4*ifqc,       iwheel4, iphase/(ikey+24)
a5th     oscil  p12, 5.0397*ifqc,  iwheel4, iphase/(ikey+28)
a6th     oscil  p13, 5.9932*ifqc,  iwheel4, iphase/(ikey+31)
a8th     oscil  p14, 8*ifqc,       iwheel4, iphase/(ikey+36)

gaorgan  =      gaorgan+kenv*(asubfund+asub3rd+afund+a2nd+a3rd+a4th+a5th+a6th+a8th)

         endin

;------------------------------------------------------------------------
;Rotating Speaker
;------------------------------------------------------------------------
         instr  4

iioff    init   p4
isep     init   p5             ;Phase separation between right and left
iradius  init   .00025         ;Radius of the rotating horn.
iradlow  init   .00035         ;Radius of the rotating scoop.
ideleng  init   .02            ;Length of delay line.

;------------------------------------------------------------------------
asig     =      gaorgan        ;Global input from organ

;------------------------------------------------------------------------
asig     =      asig/40000     ;Distortion effect using waveshaping.
aclip    tablei asig,5,1,.5    ;A lazy "S" curve, use table 6 for increased
aclip    =      aclip*16000    ;distortion.

;------------------------------------------------------------------------
aleslie delayr  ideleng,1      ;Put "clipped" signal into a delay line.
        delayw  aclip

;------------------------------------------------------------------------
koscl   oscil   1,gkenv,1,iioff            ;Doppler effect is the result
koscr   oscil   1,gkenv,1,iioff+isep       ;of delay taps oscillating
kdopl   =       ideleng/2-koscl*iradius   ;through the delay line.  Left
kdopr   =       ideleng/2-koscr*iradius   ;and right are slightly out of phase
aleft   deltapi kdopl                     ;to simulate separation between ears
aright  deltapi kdopr                     ;or microphones

;------------------------------------------------------------------------
koscllow  oscil   1,gkenvlow,1,iioff           ;Doppler effect for the
koscrlow  oscil   1,gkenvlow,1,iioff+isep      ;lower frequencies.
kdopllow  =       ideleng/2-koscllow*iradlow
kdoprlow  =       ideleng/2-koscrlow*iradlow
aleftlow  deltapi kdopllow
arightlow deltapi kdoprlow

;------------------------------------------------------------------------
alfhi     butterbp aleft,8000,3000     ;Divide the frequency into three
arfhi     butterbp aright,8000,3000    ;groups and modulate each with a
alfmid    butterbp aleft,3000,2000     ;different width pulse to account
arfmid    butterbp aright,3000,2000    ;for different  dispersion
alflow    butterlp aleftlow,1000       ;of different frequencies.
arflow    butterlp arightlow,1000

kflohi    oscil    1,gkenv,3,iioff
kfrohi    oscil    1,gkenv,3,iioff+isep
kflomid   oscil    1,gkenv,4,iioff
kfromid   oscil    1,gkenv,4,iioff+isep
  
;------------------------------------------------------------------------
; Amplitude Effect on Lower Speaker
kalosc    = koscllow*.6+1
karosc    = koscrlow*.6+1

; Add all frequency ranges and output the result.
outs alfhi*kflohi+alfmid*kflomid+alflow*kalosc, arfhi*kfrohi+arfmid*kfromid+arflow*karosc

gaorgan = 0

endin

