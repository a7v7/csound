;====================================================================
; AUTORUN.ORC
;--------------------------------------------------------------------
sr        =         44100
kr        =         441
ksmps     =         100
nchnls    =         2

giwave    =         1

;====================================================================
instr 1  ; EXAMPLE EVENT GENERATING INSTRUMENT: A SIMPLE FRACTAL LOOP
;--------------------------------------------------------------------
;ihold                                                  ; RUN FOREVER
                                                       ;
kx1       init      0                                  ;
kx2       init      0                                  ;
                                                       ;
idur      =         1.5                                ;
ispeed    =         6                                  ;
                                                       ;
ktime     phasor    ispeed                             ; TIMER FOR
ktrig     trigger   ktime, 0.5, 0                      ; EVENT GENERATION
if   (ktrig<0.5)    goto noevent                       ;
                                                       ;
kx1       =         kx1 * kx1 - 1.74                   ; SOME SIMPLE FRACTAL
kx2       =         kx2 * kx2 - 1.7499                 ; PARAMETER GENERATION
kamp      =         0.05 + (kx2+2) / 4 * 0.9           ;
kcps      =         200 + 100 * kx1 / 2                ;
                                                       ;
igoto     noevent                                      ; DON'T SCHEDULE
initsched:                                             ; AT FIRST INIT
          schedule  2, 0, idur, i(kamp), i(kcps)       ;
reinit    initsched                                    ; REINIT SCHEDULE
                                                       ; FOR EACH EVENT
noevent:                                               ;
                                                       ;
endin                                                  ;

;====================================================================
instr 2                                                ; SOUND GENERATING INSTRUMENT
;--------------------------------------------------------------------

kenv      expon     1, 1, 0.01
kamp      =         20000*p4*kenv
asig      oscili    kamp, p5, giwave
          outs      asig, asig

endin
;--------------------------------------------------------------------

