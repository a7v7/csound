sr             =         44100
kr             =         4410
ksmps          =         10
nchnls         =         2

instr 1                            ;GLOBAL INITIALIZATION

  gi2fqc       init      cpspch(p4)
  gi3fqc       init      cpspch(p5)

endin

instr 2                            ; EPICYCLOID OR SPIROGRAPH CURVE
                                   ; THIS SET OF PARAMETRIC EQUATIONS DEFINES THE PATH TRACED BY
                                   ; A POINT ON A CIRCLE OF RADIUS B ROTATING OUTSIDE A CIRCLE OF
                                   ; RADIUS A.

ifqc           init      cpspch(p5)
ifqci          init      gi2fqc
gi2fqc         init      ifqc
ia             init      p6
ib             init      p7
ihole          init      p8
iscale         init      1/(ia+2*ib)

kampenv        linseg    0, .02, p4*iscale, p3-.04, p4*iscale, .02, 0
kptchenv       linseg    ifqci, .2*p3, ifqc, .8*p3, ifqc
kvibenv        linseg    0, .5, 0, .2, 1, .2, 1
kvibr          oscil     20, 8, 1
kfqc           =         kptchenv+kvibr*kvibenv

; SINE AND COSINE
acos1          oscil     ia+ib, kfqc, 1, .25
acos2          oscil     ib*ihole, (ia-ib)/ib*kfqc, 1, .25
ax             =         acos1 + acos2

asin1          oscil     ia+ib, kfqc, 1
asin2          oscil     ib, (ia-ib)/ib*kfqc, 1
ay             =         asin1 - asin2

outs           kampenv*ax, kampenv*ay

endin

instr 3 ; HYPOCYCLOID OR SPIROGRAPH CURVE
        ; THIS SET OF PARAMETRIC EQUATIONS DEFINES THE PATH TRACED BY
        ; A POINT ON A CIRCLE OF RADIUS B ROTATING INSIDE A CIRCLE OF
        ; RADIUS A.

ifqc           =         cpspch(p5)
ifqci          init      gi3fqc
gi3fqc         init      ifqc
ia             =         p6
ib             =         p7
ihole          =         p8
iscale         =         (ia<ib ? 1/ib:1/ia)

kampenv        linseg    0, .1, p4*iscale, p3-.2, p4*iscale, .1, 0
kptchenv       linseg    ifqci, .2*p3, ifqc, .8*p3, ifqc
kvibenv        linseg    0, .5, 0, .2, 1, .2, 1
kvibr          oscil     20, 8, 1
kfqc           =         kptchenv+kvibr*kvibenv

; SINE AND COSINE
acos1          oscil     ia-ib, kfqc, 1, .25
acos2          oscil     ib*ihole, (ia-ib)/ib*kfqc, 1, .25
ax             =         acos1 + acos2

asin1          oscil     ia-ib, kfqc, 1
asin2          oscil     ib, (ia-ib)/ib*kfqc, 1
ay             =         asin1 - asin2

               outs      kampenv*ax, kampenv*ay

endin

instr          4                                  ; BANCHOFF KLEIN BOTTLE

ifqc           init      cpspch(p5)
iu             init      p6
iv             init      p7
irt2           init      sqrt(2)

kampenv        linseg    0, .02, p4, p3-.04, p4, .02, 0

; COSINES
acosu          oscil     1, iu*ifqc,      1, .25
acosu2         oscil     1, iu*ifqc/2, 1, .25
acosv          oscil     1, iv*ifqc,      1, .25

; SINES
asinu          oscil     1, iu*ifqc,      1
asinu2         oscil     1, iu*ifqc/2, 1
asinv          oscil     1, iv*ifqc,      1

; COMPUTE X AND Y
ax             =         acosu*(acosu2*(irt2+acosv)+asinu2*asinv*acosv)
ay             =         asinu*(acosu2*(irt2+acosv)+asinu2*asinv*acosv)

; LOW FREQUENCY ROTATION IN SPHERICAL COORDINATES Z, PHI, THETA.
  klfsinth     oscil     1,4,1
  klfsinph     oscil     1,1,1
  klfcosth     oscil     1,4,1,.25
  klfcosph     oscil     1,1,1,.25

  aox          =         -ax*klfsinth+ay*klfcosth
  aoy          =         -ax*klfsinth*klfcosph-ay*klfsinth*klfcosph+klfsinph


outs           kampenv*aox, kampenv*aoy

endin
