;HAEYON KIM     5/15 1989
;BEESORT ORCHESTRA
;ECHO ORCHESTRA
;PLUCK+ECHO INSTRUMENT
;***************************************************************;
;p3=dur(sec),p4=pch,p5=amp,p6=pch bend(oct),p7=roughness factor ;
;p8=panning factor,p9=loop# per sec,p10=reverb  time            ;
;***************************************************************;

        sr          =         44100
        kr          =         4410
        ksmps       =         10
        nchnls      =         2
                    instr     1,2,3,4,5
        iamp        =         (p5*5000/127)+500        ;ACTUAL540-5500/SCORE1-127
        irvt        =         p10
        ilpt        =         1/p9
        ifreq       =         cpspch(p4)
        ishft1      =         ifreq*0.9999
        ishft2      =         ifreq*0.5555
        ishft3      =         ifreq*1.0009
        koctf       init      octcps(ifreq)
        kocts1      init      octcps(ishft1)
        kocts2      init      octcps(ishft2)
        kocts3      init      octcps(ishft3)
        kshape      oscil1    .17,p6,p3,4
        kfreq       =         cpsoct(koctf+kshape)
        kshft1      =         cpsoct(kocts1+kshape)
        kshft2      =         cpsoct(kocts2+kshape)
        kshft3      =         cpsoct(kocts3+kshape)

          if       (p8 != 0)  igoto panning

        ilfac       =         .707
        irfac       =         .707

                    igoto     perform

panning:

        ilfac       =         sqrt(p8)
        irfac       =         sqrt(1-p8)

perform:

        ating       pluck     iamp*.3,kfreq, ifreq, 5,1
        ating1      pluck     iamp*.3,kshft1,ishft1,13,1
        ating2      pluck     iamp*.3,kshft2,ishft2,5,3,p7
        ating3      pluck     iamp*.3,kshft3,ishft3,14,3,p7

continue:

        asum        =         ating+ating1+ating2+ating3
        acomb       comb      asum,irvt,ilpt
        asig        envlpx    acomb,.0001,p3,p3*.1,2,.888,.009
                    outs      asig*ilfac,asig*irfac
                    endin

