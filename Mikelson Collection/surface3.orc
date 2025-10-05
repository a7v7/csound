sr             =              44100
kr             =              22050
ksmps          =              2
nchnls         =              2
zakinit        50, 50

;-----------------------------------------------------------
; RADIUS MODULATOR
;-----------------------------------------------------------
               instr          3

idur           =              p3
iamp           =              p4
ifqc           =              p5
iphase         =              p6
ioutch         =              p7

krad1          oscili         iamp, ifqc, 1, iphase    ; MODULATION
kout           =              krad1+2*iamp             ; MAKE IT POSITIVE
               zkw            kout, ioutch             ; SEND IT OUT ON THE K-CHANNEL

               endin

;-----------------------------------------------------------
; 4D
; w=sin^2*(sqrt(x^2+y^2+z^2))
;-----------------------------------------------------------
               instr          5

idur           =              p3
iamp           =              p4
ifqc           =              cpspch(p5)
iwamp          =              p6
ioutch1        =              p7
ioutch2        =              p8
ioutch3        =              p9
ioutch4        =              p10

kdclick        linseg         0, .02, iamp, idur-.04, iamp, .02, 0
;krminor       linseg         .5, idur/2, 5, idur/2, .5
krminor        oscil          5, .2, 1
krminor        =              krminor+6
krmajor        =              krminor+1

asin1          oscil          krminor, ifqc, 1
acos1          oscil          krminor, ifqc, 1, .25
asin2          oscil          krmajor, ifqc/4, 1
acos2          oscil          krmajor, ifqc/4, 1, .25
          
ax             =              asin1+acos2
ay             =              acos1
az             =              asin2

aw1            =              sin(sqrt(ax*ax+ay*ay+az*az))       ; COMPUTE THE SURFACE
aw             =              aw1*aw1-.5

               zawm           ax*kdclick, ioutch1
               zawm           ay*kdclick, ioutch2
               zawm           az*kdclick, ioutch3
               zawm           aw*kdclick*iwamp, ioutch4

               endin

;-----------------------------------------------------------
; TERRAIN MAPPED BASS
; z=sqrt(x^4+y^4-x^2-y^2-x^2Y^2+1)
;-----------------------------------------------------------
               instr          19

idur           =              p3
iamp           =              p4
aamp1          init           iamp
ifqc           =              cpspch(p5)
ikch1          =              p6
ikch2          =              p7
ibndtab        =              p8

kamp           linseg         0, .01, 2, .1, 1.5, idur-.21, 1, .1, 0

krad1          zkr            ikch1
krad2          zkr            ikch2

kbend          oscil          1, 1/idur, ibndtab
kfqc           =              kbend*ifqc

asin1          oscil          krad1, kfqc, 1
acos1          oscil          krad1, kfqc, 1, .25  ; 
asin2          oscil               krad2, kfqc, 1, .5
acos2          oscil          krad2, kfqc, 1, .75  ; 

ax1            =              asin1+.35
ay1            =              acos1-.80
ax2            =              asin2+.5
ay2            =              acos2-.20

axsq1          =              ax1*ax1
aysq1          =              ay1*ay1
axsq2          =              ax2*ax2
aysq2          =              ay2*ay2

; COMPUTE THE SURFACE
az1            =              sqrt(axsq1*axsq1+aysq1*aysq1-axsq1-aysq1-axsq1*aysq1+1)
az2            =              sqrt(axsq2*axsq2+aysq2*aysq2-axsq2-aysq2-axsq2*aysq2+1)

abal1          balance        az1, aamp1
abal2          balance        az2, aamp1

aout1          atone          abal1, 10
aout2          atone          abal2, 10

               outs           aout1*kamp, aout2*kamp

               endin

;-----------------------------------------------------------
; 3 SPACE PLANAR ROTATIONS
;-----------------------------------------------------------
               instr          50

ifqc           =              p4
iphase         =              p5
iplane         =              p6
inx            =              p7
iny            =              p8
inz            =              p9
ioutx          =              p10
iouty          =              p11
ioutz          =              p12

kcost          oscil          1, ifqc,   1, .25+iphase
ksint          oscil          1, ifqc,   1, iphase

ax             zar            inx
ay             zar            iny
az             zar            inz
          
; ROTATION IN X-Y PLANE
  if           (iplane!=1)    goto next1
    axr        =              ax*kcost + ay*ksint
    ayr        =              -ax*ksint + ay*kcost
    azr        =              az
    goto       next3

; ROTATION IN X-Z PLANE
next1:
  if           (iplane!=2)    goto next2
    axr        =              ax*kcost + az*ksint
    ayr        =              ay
    azr        =              -ax*ksint + az*kcost
    goto       next 3

; ROTATION IN Y-Z PLANE
next2:
    axr        =              ax
    ayr        =              ay*kcost + az*ksint
    azr        =              -ay*ksint + az*kcost

next3:
               zaw            axr, ioutx
               zaw            ayr, iouty
               zaw            azr, ioutz

endin

;-----------------------------------------------------------
; 4 SPACE PLANAR ROTATIONS
;-----------------------------------------------------------
               instr          51

ifqc           =              p4
iphase         =              p5
iplane         =              p6
inx            =              p7
iny            =              p8
inz            =              p9
inw            =              p10
ioutx          =              p11
iouty          =              p12
ioutz          =              p13
ioutw          =              p14

kcost          oscil          1, ifqc,   1, .25+iphase
ksint          oscil          1, ifqc,   1, iphase

ax             zar            inx
ay             zar            iny
az             zar            inz
aw             zar            inw

; ROTATION IN X-Y PLANE
  if           (iplane!=1)    goto next1
    axr        =              ax*kcost + ay*ksint
    ayr        =              -ax*ksint + ay*kcost
    azr        =              az
    awr        =              aw
    goto       nextend

; ROTATION IN X-Z PLANE
next1:
  if           (iplane!=2)    goto next2
    axr        =              ax*kcost + az*ksint
    ayr        =              ay
    azr        =              -ax*ksint + az*kcost
    awr        =              aw
    goto       nextend

; ROTATION IN Y-Z PLANE
next2:
  if           (iplane!=3)    goto next3
    axr        =              ax
    ayr        =              ay*kcost + az*ksint
    azr        =              -ay*ksint + az*kcost
    awr        =              aw
    goto       nextend

; ROTATION IN X-W PLANE
next3:
  if           (iplane!=4)    goto next4
    axr        =              ax*kcost + aw*ksint
    ayr        =              ay
    azr        =              az
    awr        =              -ax*ksint + aw*kcost
    goto       nextend

; ROTATION IN Y-W PLANE
next4:
  if           (iplane!=5)    goto next5
    axr        =              ax
    ayr        =              ay*kcost + aw*ksint
    azr        =              az
    awr        =              -ay*ksint + aw*kcost
    goto       nextend

; ROTATION IN Z-W PLANE
next5:
  if           (iplane!=6)    goto nextend
    axr        =              ax
    ayr        =              ay
    azr        =              az*kcost + aw*ksint
    awr        =              -az*ksint + aw*kcost

nextend:
               zaw            axr, ioutx
               zaw            ayr, iouty
               zaw            azr, ioutz
               zaw            awr, ioutw

endin

;---------------------------------------------------------------------------
; MIXER SECTION
;---------------------------------------------------------------------------
               instr          100

idur           =              p3
iamp           =              p4
ifadtab        =              p5
inch1          =              p6
inch2          =              p7

ain1           zar            inch1
ain2           zar            inch2

kamp           oscili         iamp, 1/idur, ifadtab
               outs           ain1*kamp, ain2*kamp

               endin

;---------------------------------------------------------------------------
; CLEAR AUDIO & CONTROL CHANNELS
;---------------------------------------------------------------------------
               instr          110

               zacl           0, 50               ; CLEAR AUDIO CHANNELS 0 TO 30
               zkcl           0, 50               ; CLEAR CONTROL CHANNELS 0 TO 30

               endin
