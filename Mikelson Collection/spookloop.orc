sr        =         44100
kr        =         4410
ksmps     =         10
nchnls    =         2

          
          ; SPOOKLOOP
          
          instr 1
i1        =         cpspch(p4)
i2        =         cpspch(p5)
i3        =         cpspch(p6)
kvib1     oscil     2,i1/50,1
kvib2     oscil     3,i1/30,4
kvlow     oscil     2,cpspch(p4-1)/15,5
khp1      =         cpspch(p4)/2
khp2      =         cpspch(p4)*0.01
kamp      envlpx    5000,.01,p3,.008,2,2,.01
klamp     linenr    kamp,p3,.005,.05
krimp     linenr    5000,.0005,p3,.05
klip1     line      5000,p3,7000
klip2     line      7000,p3,0
kiss      line      0,p3,5000
kbend     expseg    i1,p3/4,i1*2,p3/4,i1,p3/4,i1*2,p3/4,i1
kp        phasor    1   
ktab      table     kp*6,8
a1        oscil     klamp,(p3<1.99?i1:kbend),1
a2        oscil     klamp*0.67,(p3>1.99?i1*1.875:i1*1.67)+kvib1,3
a3        oscil     klamp*0.33,(i1*1.5)+kvib2,4
a4        oscil     krimp,(p3<1.99?i1:kbend),1
a5        oscil     krimp*0.67,(p3>1.99?i1*1.875:i1*1.67)+kvib1,3
a6        oscil     krimp*0.33,(i1*1.5)+kvib2,4
a7        pluck     klip1,cpspch(p4-2),i1,5,4,1,2
aa        pluck     klip2,cpspch(p4-1)*0.997+kvlow,i1,6,4,1,2
ab        pluck     klip2,i2,i2,5,1     
ac        pluck     klip2,i3,i3,6,1
az1       buzz      kiss,cpspch(ktab),6,7
az2       buzz      kiss,cpspch(ktab+1),6,7
at        pluck     klip2,50,20,5,4,.5,2
all       =         a1+a2+a3+aa+ab+az1+at
arr       =         a4+a5+a6+a7+ac+az2+at
          outs      all,arr
          endin

