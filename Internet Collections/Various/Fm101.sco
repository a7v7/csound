
; Simple FM Pair with Independnet Envelope Generators
;  idur = p3
;  icaramp =  p4
;  icarfreq = p5
;  icarwave = p6
;  index = p7
;    imodfreq = p8
;  imodindex = imodfreq * index
;    imodwave = p9
;  icarrise = p10
;  icardec = p11
;  imodrise = p12
;  imoddec = p13


; func#   start    size           gen routine    arguments

  ; f1 = sine wave 
 f1     0     4096          10                  1
     
 f2     1     4096          10                  1     0   .3   0   .5   0   .7   0

 f3     1     4096          10                 .1     .3   .4   .5   .6 .1    .8  .1 

f0 2

i1     0     .5   15000      220     1    2000   220    1     .1    .0     0    .5

s

f0 2

i1     0      .5     15000      300     1    2000   300    1    .1    .0     0    .5

s
f0 2

i1     2      .5    15000    280    1      2000    280    1     .1    .5     2     .5

s
f0 2

i1     03       3      15000      240     1    2000  240     1  .1   .5    2      .5

s

e
