; Fm instrument
 
; Three Parallel Carriers
; Four Independent Envelope Generators
; Independent Modulation Index

;  idur = p3
;  icaramp =  (ampdb(p4))/3            
;  icar1freq = p5
;  icar2freq = p6
 ; icar3freq = p7
;  index = p8
;    imodfreq = p9
;  imodrise = p10
 ; imoddec =  p11
 ; icar1rise =  p12
 ; icar1dec =   p13
 ; icar2rise =  p14
 ; icar2dec =   p15
 ; icar3rise =  p16
 ; icar3dec =   p17
 ; indexscale1 = p18            
 ; indexscale2 = p19
 ; indexscale3 = p20

f1 0  4096  10  1
   
i3  0  10   90 100 103  98  5  100  5  1  .1    .5    4  2  7  1  1   1.5  2
s
i3  0  10   90 100 200  400 10  200  7  2  4    1    1  6  9  1  .5   1  .3
e

