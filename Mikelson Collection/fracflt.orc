sr        =         44100
kr        =         4410
ksmps     =         10
nchnls    =         2

          instr     1

idur      =         p3

axn       init      0
axnm1     init      0
axnm2     init      0
ayn       init      0
aynm1     init      0
aynm2     init      0

kc1       linseg    .2, idur*.5, .8, idur*.5, .1
kc2       linseg    3.5, idur*.2, .4, idur*.8, 3.1

ax1n, ax2n diskin   "hellorcb2.aif", 1
;axn       =         ax1n/32000
axn       rand      1

; DIGITAL FILTER WITH ARBITRARILY COMPLEX FUNCTION.
ayn       =         kc1*sin(axn*2+3*cos(kc2*aynm2))-.3*axnm1*aynm1+.1*ayn*axnm2*sqrt(ayn*ayn+axnm1*axnm1)

axnm2     =         axnm1
axnm1     =         axn
aynm2     =         aynm1
aynm1     =         ayn

          outs      ayn*32000, ayn*32000

          endin
