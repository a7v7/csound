sr             =         44100
kr             =         4410
ksmps          =         10
nchnls         =         2

;ALIEN WEAPONRY 1

               instr     1

;--------------------------------------------------------------------
idur           init      p3
iamp           init      p4
ifqc           init      p5
ifqc2          init      p6
ax             init      p7
ay             init      p8
az             init      p9
is             init      p10
ir             init      p11
ib             init      p12
ih             init      p13
ilfo           init      p14
ipantab        init      p15

kclkold        init      -1
kpan           oscil     1, 1/idur, ipantab
kclknew        oscil     1, ilfo/p3/2, 3
if   (kclkold==kclknew)  goto next
  ax           =         p7
  ay           =         p8
  az           =         p9
next:
kclkold        =         kclknew

;--------------------------------------------------------------------
;kamp          linseg     0, .2, iamp, idur-.21, iamp, .01, 0
kamp           oscil     1, ilfo/p3, 4
kamp           =         kamp*iamp
krez           oscil     1, ilfo/p3, 2
krez           =         1000; (krez+1)*4000+1000
kfqc           oscil     1, ilfo/p3, 2
kfqc           =         (kfqc+1)*(ifqc-ifqc2)+ifqc


axnew          =         ax+ih*is*(ay-ax)
aynew          =         ay+ih*(-ax*az+ir*ax-ay)
aznew          =         az+ih*(ax*ay-ib*az)

;--------------------------------------------------------------------
ax             =         axnew
ay             =         aynew
az             =         aznew

;--------------------------------------------------------------------

aoutx          oscil     1, kfqc*(1+ax), 1
aouty          oscil     1, kfqc*(1+ay), 1

;arezx         reson     asigx, krez, krez/8
;aoutx         balance   arezx, asigx
;arezy         reson     asigy, krez, krez/8
;aouty         balance   arezy, asigy

               outs      aoutx*kamp*sqrt(kpan), aouty*kamp*sqrt(1-kpan)


endin
