sr        =         44100
kr        =         4410
ksmps     =         10
nchnls    =         2

          zakinit   50, 50

          instr     5

idur      =         p3
iamp      =         p4
irate     =         p5
itab1     =         p6
ioutch    =         p7

klfo      oscil     iamp, irate/idur, itab1
          zkw       klfo, ioutch

          endin


          instr     10

idur      =         p3+.2
p3        =         p3+.2
iamp      =         p4
ifqc      =         cpspch(p5)
itab1     =         p6
iactch    =         p7

kact1     zkr       iactch

iatk1     =         .04
idec1     =         .2
idl1      =         .8
isl1      =         .6
irel1     =         .2

iatk2     =         .2
idec2     =         .2
idl2      =         .4
isl2      =         .1
irel2     =         .2

iatk3     =         .1
idec3     =         .1
idl3      =         .8
isl3      =         .6
irel3     =         .2
     
iatk4     =         .01
idec4     =         .1
idl4      =         .1
isl4      =         .01
irel4     =         .1

iatk5     =         .01
idec5     =         .1
idl5      =         .05
isl5      =         .001
irel5     =         .2

iatk6     =         .01
idec6     =         .1
idl6      =         .5
isl6      =         .1
irel6     =         .1

ifa       =         1
aop1      init      0
aop2      init      0
aop3      init      0

kenv1     linseg    0, iatk1, 1  , idec1, idl1,     idur-iatk1-idec1-irel1, isl1,     irel1, 0 
kenv2     linseg    0, iatk2, ifa, idec2, idl2*ifa, idur-iatk2-idec2-irel2, isl2*ifa, irel2, 0 
kenv3     linseg    0, iatk3, ifa, idec3, idl3*ifa, idur-iatk3-idec3-irel3, isl3*ifa, irel3, 0 
kenv4     linseg    0, iatk4, ifa, idec4, idl4*ifa, idur-iatk4-idec4-irel4, isl4*ifa, irel4, 0 
kenv5     linseg    0, iatk5, ifa, idec5, idl5*ifa, idur-iatk5-idec5-irel5, isl5*ifa, irel5, 0 
kenv6     linseg    0, iatk6, ifa, idec6, idl6*ifa, idur-iatk6-idec6-irel6, isl6*ifa, irel6, 0 

;                   Amp            Fqc   Car                    Mod                 Env      Table Phase
aop3      foscil    kenv5*3,       ifqc, (1+aop2*2)*2.5,       (1+aop1*3)*.5,       kenv6*4, itab1
aop2      foscil    kenv3*kact1,   ifqc, 2,                    (1+aop3*3)*4,        kenv4*4, itab1
aop1      foscil    kenv1,         ifqc, 1+aop3,               (1+aop2)*.333*kact1, kenv2*6, itab1

aout      rezzy     aop1, 100+kenv2*500+aop2*20, 10

          outs      aout*iamp, aout*iamp

          endin

          instr     11

idur      =         p3+.2
p3        =         p3+.2
iamp      =         p4
ifqc      =         cpspch(p5)
itab1     =         p6
iactch    =         p7
ipan      =         p8

kact1     zkr       iactch

iatk1     =         2.4
idec1     =         2.2
idl1      =         .8
isl1      =         .6
irel1     =         1.2

iatk2     =         1.2
idec2     =         1.2
idl2      =         .4
isl2      =         .1
irel2     =         1.2

iatk3     =         1.1
idec3     =         1.1
idl3      =         .8
isl3      =         .6
irel3     =         .2

iatk4     =         .1
idec4     =         .1
idl4      =         .1
isl4      =         .01
irel4     =         .1

iatk5     =         .1
idec5     =         .1
idl5      =         .05
isl5      =         .01
irel5     =         .2

iatk6     =         .1
idec6     =         .1
idl6      =         .5
isl6      =         .1
irel6     =         .1

ifa       =         1
aop1      init      0
aop2      init      0
aop3      init      0

kenv1     linseg    0, iatk1, 1  , idec1, idl1,     idur-iatk1-idec1-irel1, isl1,     irel1, 0 
kenv2     linseg    0, iatk2, ifa, idec2, idl2*ifa, idur-iatk2-idec2-irel2, isl2*ifa, irel2, 0 
kenv3     linseg    0, iatk3, ifa, idec3, idl3*ifa, idur-iatk3-idec3-irel3, isl3*ifa, irel3, 0 
kenv4     linseg    0, iatk4, ifa, idec4, idl4*ifa, idur-iatk4-idec4-irel4, isl4*ifa, irel4, 0 
kenv5     linseg    0, iatk5, ifa, idec5, idl5*ifa, idur-iatk5-idec5-irel5, isl5*ifa, irel5, 0 
kenv6     linseg    0, iatk6, ifa, idec6, idl6*ifa, idur-iatk6-idec6-irel6, isl6*ifa, irel6, 0 

anz       rand      1/10
afnz      butterbp  anz, ifqc/2/kact1, ifqc/2/kact1/200

;                   Amp            Fqc   Car                    Mod                 Env      Table Phase
aop3      foscil    kenv5*3,       ifqc, (1+aop2*2)*2.5,       (1+aop1*3)*.5+afnz,  kenv6*4, itab1
aop2      foscil    kenv3*kact1,   ifqc, 2,                    (1+aop3*3)*4,        kenv4*4, itab1
aop1      foscil    kenv1,         ifqc, 1+aop3,               (1+aop2)*.333*kact1, kenv2*6, itab1

aout      rezzy     aop1, 200+kenv2*900+aop2*50, 40
     
          outs      (aout+afnz)*iamp*sqrt(ipan), (aout+afnz)*iamp*sqrt(1-ipan)

          endin

          instr     12

idur      =         p3+.1
p3        =         p3+.1
iamp      =         p4
ifqc      =         cpspch(p5)
itab1     =         p6
iactch    =         p7
ipan      =         p8

kact1     zkr       iactch

iatk1     =         0.04
idec1     =         0.1
idl1      =         .8
isl1      =         .6
irel1     =         0.2

iatk2     =         0.02
idec2     =         0.1
idl2      =         .4
isl2      =         .1
irel2     =         0.2

iatk3     =         0.01
idec3     =         0.1
idl3      =         .8
isl3      =         .6
irel3     =         .2

iatk4     =         .01
idec4     =         .1
idl4      =         .1
isl4      =         .01
irel4     =         .1

iatk5     =         .01
idec5     =         .1
idl5      =         .05
isl5      =         .01
irel5     =         .2

iatk6     =         .01
idec6     =         .1
idl6      =         .5
isl6      =         .1
irel6     =         .1

ifa       =         1
aop1      init      0
aop2      init      0
aop3      init      0

kenv1     linseg    0, iatk1, 1  , idec1, idl1,     idur-iatk1-idec1-irel1, isl1,     irel1, 0 
kenv2     linseg    0, iatk2, ifa, idec2, idl2*ifa, idur-iatk2-idec2-irel2, isl2*ifa, irel2, 0 
kenv3     linseg    0, iatk3, ifa, idec3, idl3*ifa, idur-iatk3-idec3-irel3, isl3*ifa, irel3, 0 
kenv4     linseg    0, iatk4, ifa, idec4, idl4*ifa, idur-iatk4-idec4-irel4, isl4*ifa, irel4, 0 
kenv5     linseg    0, iatk5, ifa, idec5, idl5*ifa, idur-iatk5-idec5-irel5, isl5*ifa, irel5, 0 
kenv6     linseg    0, iatk6, ifa, idec6, idl6*ifa, idur-iatk6-idec6-irel6, isl6*ifa, irel6, 0 

anz       rand      1/2
afnz      butterbp  anz, ifqc/2/kact1, ifqc/2/kact1/200

;                   Amp            Fqc   Car                    Mod                 Env      Table Phase
aop3      foscil    kenv5*3,       ifqc, (1+aop2*2)*2.5,       (1+aop1*3)*.5,  kenv6*4, itab1
aop2      foscil    kenv3*kact1,   ifqc, 2,                    (1+aop3*3)*4,        kenv4*4, itab1
aop1      foscil    kenv1,         ifqc, 1+aop3,               (1+aop2)*.333*kact1, kenv2*6, itab1

aout      rezzy     aop1, 150+kenv2*400+aop2*10, 20

aamp      linseg    0, .005, iamp, idur-.01, iamp, .005, 0
          outs      aout*sqrt(ipan)*aamp, aout*sqrt(1-ipan)*aamp

          endin

