; Csound orchestra code for carillon:
; from Eastman orchestra library


; CSOUND HEADER
sr        =         44100
kr        =         4410
ksmps     =         10
nchnls    =         1

; Functions needed: 61 100
; p fields:
; p7 attack hardness (.9-1.4) ; p9 = brightness (.5-1.4)
; p9 = % tremolo (c..07)      ; p10 = tremolo rate (c. 5.5-9.)

          instr 34
                                             
p4        =         (p4>0?p4:(abs(p4))/100)  ; FOR MICROTONES: -Q00.050 = QUARTER TONE ABOVE C
i1        =         (p4<14.01? cpspch(p4):p4)
;i2       =         octpch(p4)
i2        =         octcps(i1)
i3        =         (18-i2)*.1               ; c4=1.,c3=1.1,c5=.9, etc.
i4        =         (i3+1)/2
i4        =         (i4*p8<1.4?i4:1.4/p8)    ; PROTECTION AGAINST BOMB OUTS
i5        =         ((12.75-i2)*.4*((p7+1)/2))+3.7 ; DURATION IS FREQUENCY DEPENDENT
i5        =         (i5<p3?i5:p3)            ; FOR SHORTER NOTES
p5        =         p5*((p7+1)/2)*i4
p6        =         i3*p6/p7
p8        =         p8*i4
p10       =         i4*p10

a1        linseg    0,p6,1,((2/(p7+ 1 ))*.05)-p6,(3/(p7+2))*i4*.53,.1 *i5,i4*.26,.15 *i5,i4*.15,.25*i5,i4*.1,(.5 *i5)-.05,0,i5,0
a1        =         a1*p5
k1        rms       a1
k2        linseg    1000,p9,0,p3,0           ; USED ONLY TO AVOID TURNING INSTR OFF AT OUTSET
k2        =         k2+k1
          if        k2 > 20 kgoto contin
turnoff

; TREMOLO
p9        =         p9*i4
contin: 
k2        =         k1*p9                    ; % OF TREMOLO
a1        =         a1-k2
p10       =         p10*(1/i4)               ; FASTER TREMOLO FOR HIGHER NOTES
k3        expon     1.2*p10,p3,.6*p10
;k4       randi     .07*k3,2.1
k4        randi     .09*k3,2.8
k2        oscili    k2,k3+k4,100
; RANDOM AMPLITUDE DEVIATION
;k3       expseg    p7*.18,p9,p7*.09.i5-p6,.04
;k3       randi     k3,50/i4
;k3       expseg    p7*.19,p6,p7*.066,i5-p6,i4*.04
k3        expseg    p7*.9,p6,p7*.073,i5-p6,i4*.046
k3        randi     k3,30/i4
a1        =         a1+k2+(k3*a1)            ; TOTAL AMPLITUDE
                                   
; ATTACK CHIFF
k2        expseg    p7*i3,i4*.1 *p6,i4,((p7+ 1)/2)*(.65 *p6),.004,p3,.002
k2        randi     k2*.5*i1,999
k2        =         k2+i1
k3        expseg    p7*(p8*i2*300),p7*.7*p6,.01,p3,.01
a5        randi     k3,800                   ; 999 BEFORE
a5        =         a5+(p8*420*i2)
k3        expseg    p7*.4,p7*.65 *p9,.001,p3,.0001
a5        oscili    k3*a1,a5,100             ; ATTACK CHIFF


; PITCH OSCILLATORS: 3 FREQ.  MOD.  CARRIERS & 1 SINE WAVE OSCILLATOR (a4)
i8        =         p7*p8*i4*(i2<9?1 :((12.3-i2)*.3))
k4        oscil1i   p7*p8*p6,i8*.3,(i5-p6)*i8*.62,61 ;AMPLITUDE OF CARRIER 2
k5        oscil1i   p7*p8*p6,p8*i4*.28,(i5-p6)*p8*i3*.23,61 ; AMPLITUDE OF CARRIER 3




k6        linseg    .1,p6,.1,(.38*i5)-p6,.2,.6*i5,.05  ; AMPLITUDE FOR a4
k6        =         p8 * k6
k7        expseg    p7*i3*1.6,p6,i4*1.2*p8,i5,i4*p8 ; FILTER MULTIPIER FOR ATTACK CHIFF.


; - - CARRIER 2
k3        expseg    p7*3,p6,2.5,i4*.07 *i5,2.,i4 *.1 *i5,1.2,.8 *i5,.8
k3        =         k3*p8*i4
a2        foscili   k4*a1, k2+.5,.504,.498,k3,100
a2        reson     a2,1.5*i1,k7*3.5*i1,1
; - - CARRIER 3
k3        expseg    p7*i4*2.8,p6,1.8,i3*p8*.06*i5,1.2,i3*p8*.09*i5,1.,p3,.1
k3        =         k3*p8*i3
                                             
i6        =         (4*i1<sr/2?3.996:2.996)  ; FOLDOVER PROTECTION
i7        =         (i1 <1800*(sr/20000)?1.:0) ; O = FOLDOVER PROTECTION
a3        foscili   k5*a1,k2+.7,i6,1.33,k3*i7,100
a3        reson     a3,5.33*i1,k7*2.8*i1,1

a4        oscili    k6*a1,1.22*k2,100
; # - - CARRIER 1
k3        expseg    p7*i4*2.8,p7*.7*p6,p7,1/p7*3*p6,2.2,.12*i5,1.6,.13*i5,1.2,.75*i5-p6,.3
k3        =         k3*p8*i4
a1        foscili   a1-((k4+k5+k6)*a1),k2,1, 1.004,k3,100
a1        reson     a1,2.5*i1,k7*3.1*i1,1

a1        =         1.7*(a1+a2+a3+a4)        ; RESTORE GAIN LOST IN FILTERS
a1        =         a1+a5

; STANDARD OUT STATEMENT

          out       a1
          endin
