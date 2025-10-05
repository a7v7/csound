;JOSEP M COMAJUNCOSAS
;CSOUND ACTIVIST
;gelida@lix.intercom.es

;ORC:

sr        =         44100
kr        =         4410
ksmps     =         1
garev     init      0

;***************************************************************************

          instr 1; SPECTRALIZER, A PSYCHOACUSTIC EXCITER.
                 ; 2ND AND 3RD HARM EQUALLY WEIGHTED (STOLEN FROM A WAVELAB PLUG-IN ;-) )

;***************************************************************************
                                             
imaxamp   =         3000                     ; 32768 MAX. IMAXAMP GIVES FULL EFFECT
ihpfreq   =         p6
idens     =         p5
imix      =         .3                       ; RETAIN 30% OF THE ORIGINAL SIGNAL
ifreq     =         cpspch(p4)
aenv      linen     1, .4, p3, .4*p3
asig      oscili    aenv, ifreq, 3           ; PUT HERE YOUR SIGNAL NORMALIZED

alpfilt   tone      asig, sr/6               ; KIND OF ANTI-ALIAS ...; <- IMPROVE THIS
atreble   butterhp  alpfilt , ihpfreq        ; DON´T AFFECT FREQS BELOW IHPFREQ;
                                             ;   <-WOULD BE BETTER A ATONE?
anorm     balance   atreble, asig ; restitute original power; <-is this the
                                             ;  BEST WAY TO DO IT?

awsh      =         anorm*ftlen(2)/2*idens   ;IDENS FURTHER SCALES THE EFFECT
ahm       tablei    awsh , 2 , 0 , ftlen(2)/2 ; WAVESHAPE (SPLIT INTO 2 & 3RD
                                             ; HARM.)

aout      balance   (imix*asig + (1-imix)*ahm), asig * imaxamp ; <- WHAT HAPPENS
                                             ; WITH FINAL AMPLITUDE...?
          out       .2*aout
garev     =         0
garev     =         garev + aout
endin


;***************************************************************************

          instr 2 ; PHASE-MODULATOR, FROM CLM DOCS
                  ; VERY SIMILAR TO INSTR 1. I´M NOT SURE WHERE THE PHASE MODULATION IS...

;***************************************************************************

imaxamp   =         3000                     ; 32768 MAX. IMAXAMP GIVES FULL EFFECT
ifreq     =         cpspch(p4)
imaxmod   =         p5                       ; KEEP THIS VALUE SMALL

aenv      linen     1, .4, p3, .4*p3
afmindx   =         imaxmod * aenv
asig      oscili    aenv, ifreq, 3           ;PUT HERE YOUR SIGNAL NORMALIZED

asin1     tablei    asig*ftlen(1)/2 , 1 , 0 , ftlen(1)/2
amod      =         afmindx * asin1
asin2     tablei    (.25*asig + amod)*ftlen(1)/2 , 1 , 0 , ftlen(1)/2  
                                             ; AS LONG AS FN1 = SIN THE SIGNAL WILL BE ALIASED...

aout      balance   asin2 , asig * imaxamp
          out       .2*aout
garev     =         0
garev     =         garev + aout
          endin

          instr 3 ; SOME REVERB
asig      reverb2   garev , 5, .8
          out       .5 * asig

          endin

