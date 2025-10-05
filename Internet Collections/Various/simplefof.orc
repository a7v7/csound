instr 1
iamp           =         p4
ifrq           =         p5
iform          =         p6
ioct           =         p7
iband          =         p8
iris           =         p9
idur           =         p10
idec           =         p11
iolaps         =         p12
ifna           =         1
ifnb           =         2
;ar            fof       xamp, xfund, xform, koct, kband, kris, kdur, kdec, iolaps   
asig           fof       iamp,  ifrq, iform, ioct, iband, iris, idur, idec, iolaps, ifna, ifnb, p3
               out       asig
               endin
          
          
               instr     2
iamp           =         p4
ifrq           =         p5
iform          =         p6
ioct           =         p7
iband          =         p8
iris           =         p9
idur           =         p10
idec           =         p11
iolaps         =         p12
ifna           =         1
ifnb           =         2
iatk           =         p13
irel           =         p14
ifrq2          =         p15
iform2         =         p16
ioct2          =         p17
iband2         =         p18
iris2          =         p19
idur2          =         p20
idec2          =         p21
kenv           linen     iamp, iatk, p3, irel          
kfrq           line      ifrq, p3, ifrq2
kform          line      iform, p3, iform2
koct           line      ioct, p3, ioct2
kband          line      iband, p3, iband2
kris           line      iris, p3, iris2
kdur           line      idur, p3, idur2
kdec           line      idec, p3, idec2
;ar            fof       xamp, xfund, xform, koct, kband, kris, kdur, kdec, iolaps   
asig           fof       kenv,  kfrq, kform, koct, kband, kris, kdur, kdec, iolaps, ifna, ifnb, p3
               out       asig
               endin     


