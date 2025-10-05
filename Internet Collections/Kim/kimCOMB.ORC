;HAEYON KIM 10:54AM  5/02/1989
;COMB TRUMPET ORCHESTRA
;***************************************************;
;P4=AMP P5=PCH P6=LOOP # PER SECOND P7=REVERB TIME  ;
;P8=LOOP DATA SPACE                                 ;
;***************************************************;

sr                  =         44100
kr                  =         4410
ksmps               =         10
nchnls              =         2

instr               5,6,7,8

        ilpt        =         1/p6
        irvt        =         p7
        istor       =         p8
        iamp        =         p4
        ifc1        =         cpspch(p5)
        ifc2        =         ifc1*6
        ifm         =         ifc1
        index1      =         2.66*ifm
        iratio      =         1.8/2.6

;VIBRATO AND PORTAMENTO

        kvbct       linen     1,.02,1,.01         ;VIBRATO
        kvib        oscili    kvbct*.007,7,1      ;VIBRATO GENERATOR
        kvib        =         1+kvib
        krand       randi     .007,125            ;RANDOM DEVIATION IN VIB WIDTH
        krand       =         1+krand
        kport       linen     .03,.01,1,.01       ;PORTAMENTO
        kport       =         1+kport
        kresult     =         kvib*krand*kport
perform:
        kamp        linseg    0,.03,index1,p3-0.3-.04,index1,0.05,0,1,0
        amod        oscili    kamp,ifm*kresult,6
        kamp        linseg    0,.0003,iamp,p3-0.3-.04,iamp,0.05,0,1,0
        acar1       oscili    kamp,amod+ifc1*kresult,6
        kamp        linseg    0,.0003,iamp*.2,p3-0.3-.04,iamp*.2,0.05,0,1,0
        acar2       oscili    kamp,(amod*iratio)+(ifc2*kresult),6
        asig1       =         acar1+acar2
continue:
        acomb       comb      asig1,irvt,ilpt,istor
        adelsig     delay     asig1,ilpt
        abal        balance   acomb,adelsig
                    ;display  adelsig,.005
                    ;display  acomb,.005
                    ;display  abal,.005
        kamp        linen     1,0.2,p3,0.05
        asig2       =         abal*kamp
                    outs      asig2,asig2
                    endin
