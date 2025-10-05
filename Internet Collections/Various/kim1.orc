sr        =         44100
kr        =         4410
ksmps     =         10
nchnls    =         1

          instr     21

kamp      line      0 , p3, 10000
a12       oscil     kamp,  p5, p6
          out       a12
          endin

          instr     22

k1        oscil     p4, 1/p3 * p8, p7
k2        line      p11, p3, p12
a11       foscil    k1, p5, p9, p10, k2, p6
          out       a11 
          endin

          instr     23, 24

idur      =         p3
iamp      =         ampdb(p4)
ifrq      =         cpspch(p5)
ifun      =         p6
iatk      =         p7
irel      =         p8
iatkfun   =         p9                  
kenv      envlpx    iamp, iatk, idur, irel, iatkfun, .7, .01
asig3     oscil     kenv, ifrq*.99, ifun
asig2     oscil     kenv, ifrq*1.01, ifun
asig1     oscil     kenv, ifrq, ifun
amix      =         asig1+asig2+asig3
          
          out       amix
          display   kenv, p3
          endin

          instr     1

a1        pluck     p4, p5, p6, p7,p8 
          out       a1
          endin
     
          instr     2

iwave     =         2
ienvp     =         1
inote     =         cpspch( p4)
icar      =         iwave*.8
imod      =         ienvp*.7
index     =         iwave*ienvp
kamp      linseg    p5, p3/2, 1000, p3/2, 500
kop1      oscil     kamp, 2,   ienvp
kop2      oscil     kamp, 2.2, ienvp
kop3      oscil     kamp, 7.2, ienvp
kop4      oscil     kamp, 5.2, ienvp
kop5      oscil     kamp, 3.2, ienvp
kop6      oscil     kamp, 4.2, ienvp
aop1      foscil    kop1, inote,   icar, imod, index,ienvp
aop2      foscil    kop2, inote*2, icar, imod, index,ienvp
aop3      foscil    kop3, inote*3, icar, imod, index,ienvp
aop4      foscil    kop4, inote*4, icar, imod, index,ienvp
aop5      foscil    kop5, inote*5, icar, imod, index,ienvp
aop6      foscil    kop6, inote*6, icar, imod, index,ienvp
aout      =         (aop1+aop2+aop3+aop4+aop5+aop6)

          outs      aout
          endin

          instr     3
     
knos      linseg    1, .01, 0, p3-.01, 0
kamp      expon     1000, 1.5, .0001
a2        oscil     kamp/2, 200, 2
a3        oscil     kamp/5, 150, 3
a4        rand      10000
aout      =         (a2+a3+knos*a4)/.7
          outs aout
          endin

          instr     4

kamp      line      1, p3/.5, 0
ans       rand      200
a2        oscil     2000*kamp, 145, 3
a3        oscil     2000*kamp, 240, 2
afn1      reson     ans, 500, 100
afn2      reson     ans, 1000, 200
afn3      reson     ans, 1500, 400
anss      =         kamp*(afn1 + afn2 + afn3 + 10*ans)
aout      =         (anss + a3 + a2)/75
          outs      aout
          endin

          instr     5

kamp      expon     1, p3/2, .000000001
ans       rand      2000
afn1      reson     ans, 2500, 100
afn2      reson     ans, 3000, 200
afn3      reson     ans, 4000, 400
aout      =         kamp*(afn1 + afn2 + afn3)/75

          outs      aout
          endin

          instr     6

inote     =         cpspch(p4)
kamp      line      1000, p3, 0
aop1      foscil    10*kamp, 1, inote, inote, 1, 4
afil      tone      aop1, kamp
aout      =         afil/4*.5
          outs      aout
          endin

          instr     7

inote     =         cpspch(p4)
kamp      linseg    p5, p3/4, 10000, 3*p3/4, 5000
aop1      foscil    kamp, 1, inote, inote, 2, 4
aop2      foscil    kamp, 1, inote+2, inote+2, 2, 4
aop3      foscil    kamp, 1, inote-2, inote-2, 2, 4
aouf      =         aop1 + aop2 + aop3
kfrs      oscil     200, .2, 3
kfr       =         kfrs + 500
aoul      tone      aouf, kfr
aour      reson     aouf, kfr*4, 100
aout      =         (aour/3 + aoul)/60
     
          outs      aout
          endin

          instr     8

kp        expon     p4, p3,480
ka        line      5000, p3/.5, 0
a2        oscil     ka, kp*3, 3
     
          outs      a2
          endin
