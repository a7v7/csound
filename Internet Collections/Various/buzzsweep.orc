                    instr     1
iduration           =         p3
iamp                =         p4
ifreqstart          =         p5
ifreqend            =         p6
iattacktime         =         p7
ireleasetime        =         p8
istartnh            =         p9
iendnh              =         p10
kline               line      40, p3, 2
kfiltmod            oscil     250, kline, 1  
kadsr               adsr      .5, .2, 30, 4, 2
kfreq               line      ifreqstart, iduration,  ifreqend 
kamp                linen     iamp,iattacktime, iduration, ireleasetime
knh                 linseg    istartnh, p3/2, 10, p3/2, iendnh
abuzz               buzz      kamp, kfreq, knh, 1
afm                 foscil    kamp, kfreq, 1, 2, kadsr, 1
amix                =         abuzz+afm
afilt               butterbp  amix, 500+kfiltmod, kfiltmod*.2
arvb                reverb2   afilt, 2.9, .2
                    out       afilt+arvb
                    endin
