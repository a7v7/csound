sr      = 44100
kr      = 4410
ksmps   = 10
nchnls  = 1
 
instr     1 ; 'Reson' filter bank - Based on the 'FilterBank' plug-in by
; Michael Norris for SoundEffects/SoundMaker.
 
ilevl     = p4/1000                       ; Output level (roughly scaled)
ipitch1   = (p5 < 20 ? cpspch(p5) : p5)   ; Filter 1 freq
ipitch2   = (p6 < 20 ? cpspch(p6) : p6)   ; Filter 2 freq
ipitch3   = (p7 < 20 ? cpspch(p7) : p7)   ; Filter 3 freq
ipitch4   = (p8 < 20 ? cpspch(p8) : p8)   ; Filter 4 freq
ipitch5   = (p9 < 20 ? cpspch(p9) : p9)   ; Filter 5 freq
ipitch6   = (p10 < 20 ? cpspch(p10): p10) ; Filter 6 freq
iband     = p11                           ; Filter bandwidth

ain       soundin  "Marimba.aif"
ares1     reson  ain, ipitch1, iband
ares2     reson  ain, ipitch2, iband
ares3     reson  ain, ipitch3, iband
ares4     reson  ain, ipitch4, iband
ares5     reson  ain, ipitch5, iband
ares6     reson  ain, ipitch6, iband
aout      = ares1 + ares2 + ares3 + ares4 + ares5 + ares6

out       aout*ilevl       

endin
