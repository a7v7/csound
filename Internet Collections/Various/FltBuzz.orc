     sr             =         44100
     kr             =         4410
     ksmps          =         10
     nchnls         =         1

                    instr 1
   iattack          =         .01
   irelease         =         .2
   iwhite           =         10000
   idur             =         p3
   iamp             =         ampdb(p4)
   ifund            =         p5
   isweepstart      =         p6
   isweepend        =         p7
   ibandwidth       =         p8
   inoh             =         sr/2/ifund               ; CREATES A BANDLIMITED PULSE
   ifun             =         1
                                              
   kamp             linen     iamp, iattack, idur, irelease
   ksweep           line      isweepstart, idur, isweepend
   asig             buzz      1, ifund, inoh, ifun 
   afltsig          reson     asig, ksweep, ibandwidth
   arampsig         =         kamp * afltsig
                    out       arampsig
                    endin
