sr             =         44100
kr             =         22050
ksmps          =         2
nchnls         =         2
               zakinit   30,30

; SPHERICAL LISSAJOUS FIGURES
               instr     5

ifqc           init      cpspch(p5)
iu             init      p6
iv             init      p7
irt2           init      sqrt(2)
iradius        init      1
ioutx          init      p8
iouty          init      p9
ioutz          init      p10

kampenv        linseg    0, .001, p4, p3-.002, p4, .001, 0       ; DECLICK

; COSINES
acosu          oscil     1, iu*ifqc,      1, .25
acosv          oscil     1, iv*ifqc,      1, .25

; SINES
asinu          oscil     1, iu*ifqc,      1
asinv          oscil     1, iv*ifqc,      1

; COMPUTE X AND Y FOR SPHERICAL LISSAJOUS
ax             =         iradius*asinu*acosv
ay             =         iradius*asinu*asinv
az             =         iradius*acosu

; OUTPUT TO ZAK CHANNELS
               zawm      kampenv*ax, ioutx
               zawm      kampenv*ay, iouty
               zawm      kampenv*az, ioutz

endin

               instr     50

ifqc           =         p4
iphase         =         p5
iplane         =         p6
inx            =         p7
iny            =         p8
inz            =         p9
ioutx          =         p10
iouty          =         p11
ioutz          =         p12

kcost          oscil     1, ifqc,   1, .25+iphase
ksint          oscil     1, ifqc,   1, iphase

ax             zar       inx
ay             zar       iny
az             zar       inz

; ROTATION IN X-Y PLANE
  if      (iplane!=1)    goto next1
    axr        =         ax*kcost + ay*ksint
    ayr        =         -ax*ksint + ay*kcost
    azr        =         az
    goto       next3

; ROTATION IN X-Z PLANE
next1:
  if      (iplane!=2)    goto next2
    axr        =         ax*kcost + az*ksint
    ayr        =         ay
    azr        =         -ax*ksint + az*kcost
    goto       next 3

; ROTATION IN Y-Z PLANE
next2:
    axr        =         ax
    ayr        =         ay*kcost + az*ksint
    azr        =         -ay*ksint + az*kcost

; OUTPUT TO ZAK CHANNELS
next3:
               zaw       axr, ioutx
               zaw       ayr, iouty
               zaw       azr, ioutz

endin

; MIXER
instr          100

in1            =         p4
in2            =         p5

; READ THE ZAK CHANNELS
a1             zar       in1
a2             zar       in2

; OUTPUT THE RESULTS
               outs      a1, a2

; CLEAR THE AUDIO CHANNELS
               zacl      0,30
endin
