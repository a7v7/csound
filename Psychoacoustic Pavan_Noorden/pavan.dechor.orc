;=====================================================================
;=== De-correlation of audio signals in a stereophonic environment ===
;===                     Luca Pavan - 1999                         ===
;===             Input :  a mono or stereo soundfile               ===
;===      Output:  a stereo file with de-correlated channels       ===
;  http://www.patents.ibm.com/details?pn=US05235646__&language=en 
;=====================================================================

;Orchestra
sr = 44100
kr = 44100
ksmps  = 1
nchnls = 2

instr 1
idur   = p3
iamp   = p4  ;amplitude [1 = original amplitude]
ipan   = p5  ;panning (0 = left, .5 = center, 1 = right) 
iatt   = p6  ;attack time
idec   = p7  ;decay time
kdec   = p8  ;de-correlation level (0-1) [1=maximum]

kamp linen iamp, iatt, p3, idec
ilev  = .01          ;feedback level
id    = 0            ;no delay
icomp = 1.3          ;amplitude compensatory factor

;==== ch1 ====
;asig1  soundin "test.wav", 0        ;use this line for mono input
;asig2 = asig1                        ;use this line for mono input
asig1, asig1a soundin "allOfMeStereo.aif", 0  ;use this line for stereo input
afil1   butterbp asig1, 50, 60
adel1   alpass afil1, id, ilev 
afil2   butterbp asig1, 200, 240
afil3   butterbp asig1, 800, 960
adel3   alpass afil3, id, ilev
afil4   butterbp asig1, 3200, 3840
afil5   butterbp asig1, 12800, 15360
adel5   alpass afil5, id, ilev
;==== ch2 ====
asig2a, asig2 soundin "allOfMeStereo.aif", 0  ;use this line for stereo input
afil1a  butterbp asig2, 50, 60
afil2a  butterbp asig2, 200, 240
adel2a  alpass afil2a, id, ilev
afil3a  butterbp asig2, 800, 960
afil4a  butterbp asig2, 3200, 3840
adel4a  alpass afil4a, id, ilev
afil5a  butterbp asig2, 12800, 15360
;===========================================
aoutch1 = adel1+afil2+adel3+afil4+adel5
aoutch2 = afil1a+adel2a+afil3a+adel4a+afil5a
aoutch1m = (asig1 * (1 - kdec)) + (aoutch1 * kdec)
;aoutch2m = (asig1 * (1 - kdec)) + (aoutch2 * kdec) ;use this line for mono input
aoutch2m = (asig2 * (1 - kdec)) + (aoutch2 * kdec) ;use this line for stereo 
 outs  aoutch1m * sqrt(ipan) * kamp * icomp, aoutch2m * sqrt(1 - ipan) * kamp * icomp
     endin
