; fof2.orc
; AN EXAMPLE OF VOCAL IMITATION WITH VOWEL CHANGES AND PITCH CHANGES

sr        =         44100
kr        =         4410
ksmps     =         10
nchnls    =         2

          instr 1
i14       =          2.7
i15       =          .3
i16       =         .7
i17       =         .78
i18       =         .18
; FORMANT FUNCTIONS
k40       linseg    325 ,p3*.3 ,600 ,p3*.1 ,370 ,p3*.6 ,238
k41       linseg    700 ,p3*.3 ,1050 ,p3*.1 ,1450 ,p3*.6 ,1741
k42       linseg    2550 ,p3*.3 ,2400 ,p3*.1 ,2300 ,p3*.6 ,2450
k43       linseg    2850 ,p3*.3 ,2700 ,p3*.1 ,2500 ,p3*.6 ,2900
k44       linseg    3100 ,p3*.3 ,3100 ,p3*.1 ,3100 ,p3*.6 ,4000
k36       linseg    p8 ,p14-.1 ,p8 ,.1 ,p9 ,p15-.1 ,p9 ,.1 ,p10 ,p16-.1 ,p10 ,.1 ,p11 ,p17-.1,p11 ,.1 ,p12 ,p18-.1 ,p12 ,.1 ,p13 ,p19 ,p13 ; FUNDAMENTAL
i1        =         1/(i14+i15+i16+i17+i18)  ; AMPLITUDE FACTOR FOR ALL FORMANTS
a1        linseg    0 ,.01 ,p4 ,p3-(.2+.01) ,p4 ,.2 ,0 ; ENV
; VIBRATO AND RANDOM VARIATIONS OF FUNDAMENTAL
k2        oscili     .02   ,5.1  ,1          ; VIBRATO
a2        randi     .01*.5  ,1/.05           ; FUNDAMENTAL FREQUENCY JITTER
a3        randi     .01*.5  ,1/.1111         ;
a4        randi     .01*.5  ,1/1.2186        ;
a5        =    k36* (1+k2) * (1+a2+a3+a4)    ; ADJUSTED FUNDAMENTAL FREQUENCY
; FOF UNIT-GENERATORS
;                   AMP FUND FMA..B OCT TEX  BAND DEBAT ATTEN OLPS FA..B DUR
a9        fof       i14 ,a5 ,k40  ,0 ,77   ,.003 ,.01 ,.007 ,10 ,1  ,1 ,p3
a10       fof       i15 ,a5 ,k41  ,0 ,88   ,.003 ,.01 ,.007 ,10 ,1  ,1 ,p3
a11       fof       i16 ,a5 ,k42  ,0 ,122  ,.003 ,.01 ,.007 ,10 ,1  ,1 ,p3
a12       fof       i17 ,a5 ,k43  ,0 ,127  ,.003 ,.01 ,.007 ,10 ,1  ,1 ,p3
a13       fof       i18 ,a5 ,k44  ,0 ,137  ,.003 ,.01 ,.007 ,10 ,1  ,1 ,p3
; SUMMATION OF FORMANTS AND OUTPUT
a15       =         a9+a10+a11+a12+a13
          outs      (a15*i1*a1)/2 ,(a15*i1*a1)/2
          endin



