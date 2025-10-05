sr      = 44100
kr      = 4410
ksmps   = 10
nchnls  = 1
 
instr     1 ; 'Streson' resonator bank
 
ilevl     = p4/10                         ; Output level (roughly scaled)
ipitch1   = (p5 < 20 ? cpspch(p5) : p5)   ; Filter 1 freq
ipitch2   = (p6 < 20 ? cpspch(p6) : p6)   ; Filter 2 freq
ipitch3   = (p7 < 20 ? cpspch(p7) : p7)   ; Filter 3 freq
ipitch4   = (p8 < 20 ? cpspch(p8) : p8)   ; Filter 4 freq
ipitch5   = (p9 < 20 ? cpspch(p9) : p9)   ; Filter 5 freq
ipitch6   = (p10 < 20 ? cpspch(p10): p10) ; Filter 6 freq
ifdbk     = p11                           ; Filter bandwidth

ain       soundin  "sing.aif"
ares1     streson  ain, ipitch1, ifdbk
ares2     streson  ain, ipitch2, ifdbk
ares3     streson  ain, ipitch3, ifdbk
ares4     streson  ain, ipitch4, ifdbk
ares5     streson  ain, ipitch5, ifdbk
ares6     streson  ain, ipitch6, ifdbk
aout      = ares1 + ares2 + ares3 + ares4 + ares5 + ares6

out       aout*ilevl       

endin
