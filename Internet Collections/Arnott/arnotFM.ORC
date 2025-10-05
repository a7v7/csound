; BASIC CHOWNING FM INSTRUMENT
; JOHN M. ARNOTT II
; 2/16/90

sr                  =              44100
kr                  =              4410
ksmps               =              10
nchnls              =              1



; p3=duration   p4=fundamental  p5=amplitude p6=fn#1    p7=peakIndex
; p8=fn#2       p9=carrierfact p10=modfactor 

                    instr          1

        ifc         =              p4*p9
        ifm         =              p4*p10
        kindex      oscil1i        0,p7,p3,p8
        kgate       oscil1i        0,p5,p3,p6
        amodsig     oscili         kindex*ifm, ifm, 1
        asig        oscili         kgate, ifc+amodsig, 1
                    out            asig 
                    endin      



        
