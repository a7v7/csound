
; PLUCKED MULTI-FOF WITH STEREO NOISE ORC

sr        =         44100
kr        =         4410
ksmps     =         10
nchnls    =         2



          instr 1
i1        table     p4,3
i2        table     p5,4
i3        table     p7,6 
i4        table     p8,6
i5        table     p10,6
i6        table     p11,6
k2        linseg    i1,p3,0
k3        table     p5,4
kbw1      table     p6,5 
kbw2      table     p9,5 
kcf1      line      i3,p3,i4
kcf2      line      i5,p3,i6
aa        fof       k2,k3*1.00,250,0,40,.003,.02,.007,4,1,2,p3
ab        fof       k2,k3*1.01,250,0,40,.003,.02,.007,4,1,2,p3
ac        fof       k2,k3*1.02,250,0,40,.003,.02,.007,4,1,2,p3
ad        fof       k2,k3*0.99,250,0,40,.003,.02,.007,4,1,2,p3
ae        fof       k2,k3*0.98,250,0,40,.003,.02,.007,4,1,2,p3
af        fof       k2,k3*0.97,250,0,40,.003,.02,.007,4,1,2,p3
ag        fof       k2,k3*0.96,250,0,40,.003,.02,.007,4,1,2,p3
al        =         aa+ab+ac+ad+ae+af+ag
ap1       pluck     k2,i2,i2,0,1
ap2       pluck     k2,i2*1.005,i2*1.005,0,1
as        rand      10000
at1       reson     as,kcf1,kbw1
at2       reson     as,kcf2,kbw2
azl       balance   at1,ap1+al
azr       balance   at2,ap2+al
          outs      ap1+al+azr,ap2+al+azl
          endin
