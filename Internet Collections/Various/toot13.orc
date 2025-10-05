sr             =         44100
kr             =         4410
ksmps          =         10
nchnls         =         2
               instr 13
iamp           =         ampdb(p4) / 2       ;AMP SCALED FOR TWO SOURCES
ipluckamp      =         p6                  ;P6: % OF TOTAL AMPLITUDE, 1=DB AMP AS IN P4
ipluckdur      =         p7*p3               ;P7: % OF TOTAL DURATION, 1=ENTIRE NOTE DURATION
ipluckoff      =         p3 - ipluckdur

ifmamp         =         p8                  ;P8: % OF TOTAL AMPLITUDE, 1=DB AMP AS IN P4
ifmrise        =         p9*p3               ;P9: % OF TOTAL DURATION, 1=ENTIRE NOTE DURATION
ifmdec         =         p10*p3              ;P10: % OF TOTAL DURATION
ifmoff         =         p3 - (ifmrise + ifmdec)
index          =         p11
ivibdepth      =         p12
ivibrate       =         p13
iformantamp    =         p14                 ;P14: % OF TOTAL AMPLITUDE, 1=DB AMP AS IN P4
iformantrise   =         p15*p3              ;P15: % OF TOTAL DURATION, 1=ENTIRE NOTE DURATION
iformantdec    =         p3 - iformantrise

kpluck         linseg    ipluckamp, ipluckdur, 0, ipluckoff, 0
apluck1        pluck     iamp, p5, p5, 0, 1
apluck2        pluck     iamp, p5*1.003, p5*1.003, 0, 1
apluck         =         kpluck * (apluck1+apluck2)

kfm            linseg    0, ifmrise, ifmamp, ifmdec, 0, ifmoff, 0
kndx           =         kfm * index
afm1           foscil    iamp, p5, 1, 2, kndx, 1
afm2           foscil    iamp, p5*1.003, 1.003, 2.003, kndx, 1
afm            =         kfm * (afm1+afm2)

kformant       linseg     0, iformantrise, iformantamp, iformantdec, 0
kvib           oscil     ivibdepth, ivibrate, 1
afrmt1         fof       iamp, p5+kvib, 650, 0, 40, .003,.017,.007,4,1,2,p3
afrmt2         fof       iamp, (p5*1.001)+kvib*.009, 650, 0, 40, .003,.017,.007,10,1,2,p3
aformant       =         kformant * (afrmt1+afrmt2)

               outs      apluck + afm + aformant, apluck + afm + aformant
               endin
