; Fm instrument 5
; One Carrier and a Four Modulator Stack
; Five Independent Envelope Generators
; Four Independent Modulation Index

;  idur = p3

;  icaramp =  ampdb(p4) 
;    icarfreq = p5
 
;  imod1freq = p6
;  imod2freq = p7
;  imod3freq = p8
;  imod4freq = p9

;  index1 = p10
;  index2 = p11
;  index3 = p12
;  index4 = p13

;  icarrise = p14
;  icardec =  p15

;  imod1rise =  p16
;  imod1dec =   p17
;  imod2rise =  p18
;  imod2dec =   p19
;  imod3rise =  p20
;  imod3dec =   p21
;  imod4rise =  p22
;  imod4dec =   p23

f1 0  4096  10  1
   
i5 0  .5  80 100 102  97 1327 1486  4  1 4 6  .001  .002  .25  .05  .01 .09 .024 .06 .02 .1 
i5 +  .     80     >     >     >       >        >   >  > > >        >      >       >    >  .01 .09 .024 .06 .02 .1 
i5 +  .    80   50  51   47 1876   196  8 4 1 1       .1    2        5   3  .01 .09 .024 .06 .02 .1 
s
i5 0  10  80 100 100 200 300 400 4 3 2 1  .1  2   3  5  8 10 12 6 14 6 
e


