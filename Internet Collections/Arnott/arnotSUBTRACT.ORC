; JOHN M. ARNOTT II
; SUBTRACTIVE SYNTHESIS
; SIMPLE SUBTRACTIVE INSTRUMENT


        sr          =         44100
        kr          =         4410
        ksmps       =         10
        nchnls      =         2

        instr       1,2,3,4

        imincf      =         26.6
        ibwmin      =         .05
        ibwrange    =         .45
        iratio      =         2.828

        kgate       linen     p4,p6,p3,p7    
        aw1         buzz      kgate,p5,5,2
        klin        linseg    ibwmin, 1/p3, ibwrange+ibwmin, 1, ibwrange+ibwmin
        ksum        =         ibwmin + klin

        kcf         =         p5
        kbw         =         kcf * ksum
                
        aw2         reson     aw1,kcf,kbw,1
        
        aleft       =         sqrt(p8)*aw2
        aright      =         sqrt(p9)*aw2
        outs        aleft,aright
        endin   
