sr        =         44100
kr        =         4410
ksmps     =         10
nchnls    =         1

         instr 2
asig      oscil     10000, 440, 3
          out       asig
          endin

;""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
          instr 1             ; MASS LINKED TO GROUND (DAMPED SINE WAVE)
; coded by Josep M Comajuncosas / gelida@intercom.es
;""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

i2pi2     =         39.47841760436; (2pi)^2

; SET INITIAL POSITION AND VELOCITY OF THE MASS
iv0       =         0
ix0       =         10000

; SET FREQUENCY, Z AND M
ifreq     =         cpspch(p4)
iz        =         p5
im1       =         30

; NORMALIZE (DON´T TOUCH THIS!)
iz        =         iz/(1000000000*sr)       ; Z GIVEN IN N*s/(kg*10e-9)
im1       =         im1/1000000000           ; MASS GIVEN IN kg*10e-9

; CALCULATE K ACCORDING TO GIVEN FREQ
ik        =         i2pi2*ifreq*ifreq*im1
ik        =         ik/(sr*sr)

ax1       init      ix0
axprev1   init      ix0-1000*iv0/sr

; CALCULATE ACTUAL FORCE AND THEN NEXT POSITION
af1       =         ik*(-ax1) + iz*(-(ax1-axprev1))
anext1    =         af1/im1 + 2*ax1-axprev1

          out       anext1

; PREPARE FOR NEXT PASS
axprev1   =         ax1
ax1       =         anext1

          endin
