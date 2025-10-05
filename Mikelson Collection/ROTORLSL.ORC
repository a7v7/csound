;------------------------------------------------------------------------
; Tone Wheel Organ with Rotating Speaker
;------------------------------------------------------------------------

sr     = 44100
kr     = 2205
ksmps  = 20
nchnls = 2

; Shaft
         instr 5
gkphase  oscil 1, p4, 7      
         endin



;------------------------------------------------------------------------
; Global Rotorspeed/Drawbar Initialization
;------------------------------------------------------------------------

         instr 1
gispeedf   init p4
gksubfund  init p5
gksub3rd   init p6
gkfund     init p7
gk2nd      init p8
gk3rd      init p9
gk4th      init p10
gk5th      init p11
gk6th      init p12
gk8th      init p13
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
;iphase   init  p2                      ;Continuous phase change based on p2
ikey     init  12*int(p5-6)+100*(p5-6) ;Keyboard key pressed.
ifqc     init  cpspch(p5)              ;Convert to cycles/sec.
iwheel1  init  ((ikey-12) > 12 ? 1:2)  ;The lower 12 tone wheels have
iwheel2  init  ((ikey+7)  > 12 ? 1:2)  ;increased odd harmonic content.
iwheel3  init  (ikey      > 12 ? 1:2)
iwheel4  init  1                       
  
;------------------------------------------------------------------------
kenv     linseg 0,.01,p4,p3-.02,p4,.01,0 ;Amplitude envelope.

;------------------------------------------------------------------------
asubfund oscil  gksubfund, .5*ifqc,      iwheel1, i(gkphase)/(ikey-12)  ;The organ tone is
asub3rd  oscil  gksub3rd,  1.4983*ifqc,  iwheel2, i(gkphase)/(ikey+7)   ;made from adding
afund    oscil  gkfund,    ifqc,         iwheel3, i(gkphase)/ikey       ;the weighted output
a2nd     oscil  gk2nd,     2*ifqc,       iwheel4, i(gkphase)/(ikey+12)  ;of 9 equal temperament
a3rd     oscil  gk3rd,     2.9966*ifqc,  iwheel4, i(gkphase)/(ikey+19)  ;tone wheels.
a4th     oscil  gk4th,     4*ifqc,       iwheel4, i(gkphase)/(ikey+24)
a5th     oscil  gk5th,     5.0397*ifqc,  iwheel4, i(gkphase)/(ikey+28)
a6th     oscil  gk6th,     5.9932*ifqc,  iwheel4, i(gkphase)/(ikey+31)
a8th     oscil  gk8th,     8*ifqc,       iwheel4, i(gkphase)/(ikey+36)

gaorgan  =      gaorgan+kenv*(asubfund+asub3rd+afund+a2nd+a3rd+a4th+a5th+a6th+a8th)

         endin

;------------------------------------------------------------------------
;Rotating Speaker
;------------------------------------------------------------------------
         instr  4

iofff     init   p4
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
koscl   oscil   1,gkenv,1,iofff            ;Doppler effect is the result
koscr   oscil   1,gkenv,1,iofff+isep       ;of delay taps oscillating
kdopl   =       ideleng/2-koscl*iradius   ;through the delay line.  Left
kdopr   =       ideleng/2-koscr*iradius   ;and right are slightly out of phase
aleft   deltapi kdopl                     ;to simulate separation between ears
aright  deltapi kdopr                     ;or microphones

;------------------------------------------------------------------------
koscllow  oscil   1,gkenvlow,1,iofff           ;Doppler effect for the
koscrlow  oscil   1,gkenvlow,1,iofff+isep      ;lower frequencies.
kdopllow  =       ideleng/2-koscllow*iradlow
kdoprlow  =       ideleng/2-koscrlow*iradlow
aleftlow  deltapi kdopllow
arightlow deltapi kdoprlow

;------------------------------------------------------------------------
alfhi     butterbp aleft,5000,4000     ;Divide the frequency into three
arfhi     butterbp aright,5000,4000    ;groups and modulate each with a
alfmid    butterbp aleft,2000,1500     ;different width pulse to account
arfmid    butterbp aright,2000,1500    ;for different  dispersion
alflow    butterlp aleftlow,500        ;of different frequencies.
arflow    butterlp arightlow,500

kflohi    oscil    1,gkenv,3,iofff
kfrohi    oscil    1,gkenv,3,iofff+isep
kflomid   oscil    1,gkenv,4,iofff
kfromid   oscil    1,gkenv,4,iofff+isep
  
;------------------------------------------------------------------------
; Amplitude Effect on Lower Speaker
kalosc    = koscllow*.4+1
karosc    = koscrlow*.4+1

; Add all frequency ranges and output the result.
outs alfhi*kflohi+2*alfmid*kflomid+alflow*kalosc, arfhi*kfrohi+2*arfmid*kfromid+arflow*karosc

gaorgan = 0

endin

