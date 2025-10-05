sr = 44100
kr = 4410
ksmps = 10
nchnls=2
zakinit             30,30

 
 ;   F O F
 
 
 		instr   1      ;   ADDIcTIVE Synth!!!

ifun	=		14	
;ifrq = p5
;iamp = p4		
ifrq   cpsmidi
iamp    ampmidi   127 
kenv	linsegr 0, .02, iamp, .02, 0
asig 	oscil 	kenv, ifrq*1.01, ifun 
asig2 	oscil 	kenv, ifrq*.99, ifun 
asig3 	oscil 	kenv, ifrq, ifun 
 zaw       (asig+asig2+asig3)*.4, 2      ;Reverb
 zaw       (asig+asig2+asig3)*.4, 3
 zaw       (asig+asig2+asig3)*.4, 20     ;Chorus
 zaw       (asig+asig2+asig3)*.4, 21    ;Distortion

outs      (asig+asig2+asig3)*.8,  (asig+asig2+asig3)*.8

		endin


instr 10
inote=cpspch(p5)
irvbgain = p8
k2 	linseg  	0, p3*.9, 0, p3*.1, 1  			; octaviation coefficient
a1	oscil 	7, .15,1					;Rubato for vibrato
a3	linen		a1, (p3-p3*.05), p3, .2			;delay for vibrato
a2	oscil 	a3, 5,1					;vibrato
a5	linen		1250, p7, p3, (p3*.1)			;amp envelope

a21	line	456, p6, 1030					; p6: morph-time,0=instant aah					
a5	linen		10000, p7, p3, (p3*.1)			;amp envelope
a11 fof	a5,inote+a2, a21*(p4/100), k2, 200, .003, .017, .005, 10, 1,2, inote, 0, 1

a31	line	4000, p6, 6845
a32	line	2471, p6, 1370										
a6	linen		a31, p7, p3, (p3*.1)			;amp envelope
a12 fof      a6,inote+a2, a32*(p4/100), k2, 200, .003, .017, .005, 20, 1,2, inote, 0, 1

a41	line	2813, p6, 3170
a42	line	1650, p6, 1845										
a7	linen		a42, p7, p3, (p3*.1)			;amp envelope
a13 fof      a7,inote+a2, a41*(p4/100), k2, 200, .003, .017, .005, 20, 1,2, inote, 0, 1

a71	line	1347, p6, 1726 	;amp line
a72	line	3839, p6, 3797	; form line										
a8	linen		a71, p7, p3, (p3*.1)			;amp envelope
a14 fof      a8,inote+a2, a72*(p4/100), k2, 200, .003, .017, .005, 30, 1,2, inote, 0, 1

a51	line	1, p6, 1250										
a9	linen		a51, p7, p3, (p3*.1)			;amp envelope
a15 fof      a5,inote+a2, 4177*(p4/100), k2, 200, .003, .017, .005, 30, 1,2, inote, 0, 1

a61	line	1, p6, 5833
a10	linen		a51, p7, p3, (p3*.1)			;amp envelope
a16 fof      a10,inote+a2,  428*(p4/100), k2, 200, .003, .017, .005, 10, 1,2, inote, 0, 1
a7 =        (a11 + a12 + a13 + a14 + a15 + a16) * p9 / 10
outs  a7*p6,a7*(1-p6)

 zaw        (a7*p6),      2   
 zaw        (a7*(1-p6)),  3
endin

          	instr 100
      kfreq     =          p5
ipanfrq   =  		 p6
irandfrq  =      	 p7
irandamp  =     	 p8   
iyesno	  = 		 p10                                     
kenv1	   linseg	5, 5, 10, 5, 100, 5 , 10000, 5 , 50000
kenv1 		linseg 50000, 5 , 1000, 5 , 100, 5 , 10 , 5 , 5, 5, 1, 5, 1
kpitch      randh     1000, kenv1, p11 
kpitch2     randh     1000, kenv1, p12 
kpitch3     randh     1000, kenv1, p13
kpitch4     randh     1000, kenv1, p14 
anoise     randh	     10000, 5
 
ao  		oscil	10000, kpitch, 11
aoo  		oscil	10000, kpitch2, 11
aooo  		oscil	10000, kpitch3, 11
aoooo  		oscil	10000, kpitch4, 11

a1	    oscil ao, 1/p3, 25
a2     oscil aoo, 1/p3, 25
a3     oscil aooo, 1/p3, 25
a4     oscil aooo, 1/p3, 25

 		outs a1+a3*.7+a4*.4,a2+a3*.3+a4*.7
 zaw     2* (a1+a3*.7+a4*.4),  2  ;ioutch
 zaw     2*(a2+a3*.3+a4*.7),  3
          endin    


;---------------------------------------------------------------------------
; DISTORTION
;---------------------------------------------------------------------------
        instr   3013
igaini  =       p4                  ; PRE GAIN
igainf  =       p5                  ; POST GAIN
iduty   =       p6                  ; DUTY CYCLE OFFSET
islope  =       p7                  ; SLOPE OFFSET
izin    =       p8                  ; INPUT CHANNEL
izout   =       p9                  ; OUTPUT CHANNEL
asign   init    0                   ; DELAYED SIGNAL
kamp    linseg  0, .002, 1, p3-.004, 1, .002, 0   ; DECLICK
asig    zar     izin                ; READ INPUT CHANNEL
aold    =       asign               ; SAVE THE LAST SIGNAL
asign   =       igaini*asig/60000   ; NORMALIZE THE SIGNAL
aclip   tablei  asign,5,1,.5        ; READ THE WAVESHAPING TABLE
aclip   =       igainf*aclip*15000  ; RE-AMPLIFY THE SIGNAL
atemp   delayr  .1                  ; AMPLITUDE AND SLOPE BASED DELAY
aout    deltapi (2-iduty*asign)/1500 + islope*(asign-aold)/300
        delayw  aclip
        zaw     aout, izout         ; WRITE TO OUTPUT CHANNEL
        endin
;---------------------------------------------------------------------------
; CHORUS
;---------------------------------------------------------------------------
        instr   3035
irate   =       p4
idepth  =       p5/1000
iwave   =       p6
imix    =       p7
ideloff =       p8/1000
iphase  =       p9
izin    =       p10
izout   =       p11
kamp    linseg  0, .002, 1, p3-.004, 1, .002, 0
asig    zar     izin
aosc1   oscil   idepth, irate, iwave, iphase
aosc2   =       aosc1+ideloff
atemp   delayr  idepth+ideloff
adel1   deltapi aosc2
        delayw  asig
aout     =       (adel1*imix+asig)/2*kamp
         zaw     aout, izout
         endin         
;---------------------------------------------------------------------------
; MIXER SECTION
;---------------------------------------------------------------------------
        instr   3099    
asig1   zar     p4                  ; p4 = ch1 IN
igl1    init    p5*p6               ; p5 = ch1 GAIN
igr1    init    p5*(1-p6)           ; p6 = ch1 PAN
asig2   zar     p7                  ; p7 = ch2 IN
igl2    init    p8*p9               ; p8 = ch2 GAIN
igr2    init    p8*(1-p9)           ; p9 = ch2 PAN
asig3   zar     p10                 ; p10 = ch3 IN
igl3    init    p11*p12             ; p11 = ch3 GAIN
igr3    init    p11*(1-p12)         ; p12 = ch3 PAN
asig4   zar     p13                 ; p13 = ch4 IN
igl4    init    p14*p15             ; p14 = ch4 GAIN
igr4    init    p14*(1-p15)         ; p15 = ch4 PAN
asigl   =       asig1*igl1+asig2*igl2+asig3*igl3+asig4*igl4 
asigr   =       asig1*igr1+asig2*igr2+asig3*igr3+asig4*igr4 
        outs    asigl, asigr    
        zacl    0, 30   
        endin

;----------------------------------------------------------------------------------
; LARGE ROOM REVERB
;----------------------------------------------------------------------------------
          instr     27

idur      =         p3
iamp      =         p4
iinch     =         p5
idecay    =         p6
idense    =         p7
idense2   =         p8
ipreflt   =         p9
ihpfqc    =         p10
ilpfqc    =         p11
ioutch    =         p12

aout91    init      0
adel01    init      0
adel11    init      0
adel51    init      0
adel52    init      0
adel91    init      0
adel92    init      0
adel93    init      0

kdclick   linseg    0, .002, iamp, idur-.004, iamp, .002, 0

; INITIALIZE
asig0     zar       iinch
aflt01    butterlp  asig0, ipreflt         ; PRE-FILTER
aflt02    butterhp  .5*aout91, ihpfqc           ; FEED-BACK FILTER
aflt03    butterlp  aflt02, ilpfqc         ; FEED-BACK FILTER
asum01    =         aflt01+.5*idense2*aflt03   ; INITIAL MIX

; ALL-PASS 1
asub01    =         adel01-.3*idense*asum01               ; FEEDFORWARD
adel01    delay     asum01+.3*idense*asub01,.008*idecay  ; FEEDBACK

; ALL-PASS 2
asub11    =         adel11-.3*idense*asub01               ; FEEDFORWARD
adel11    delay     asub01+.3*idense*asub11,.012*idecay  ; FEEDBACK

adel21    delay     asub11, .004*idecay               ; DELAY 1
adel41    delay     adel21, .017*idecay               ; DELAY 2

; SINGLE NESTED ALL-PASS
asum51    =         adel52-.25*adel51*idense          ; INNER FEEDFORWARD
aout51    =         asum51-.50*adel41*idense          ; OUTER FEEDFORWARD
adel51    delay     adel41+.50*aout51*idense, .025*idecay ; OUTER FEEDBACK
adel52    delay     adel51+.25*asum51*idense, .062*idecay ; INNER FEEDBACK

adel61    delay     aout51, .031*idecay               ; DELAY 3
adel81    delay     adel61, .003*idecay               ; DELAY 4

; DOUBLE NESTED ALL-PASS
asum91    =         adel92-.25*adel91*idense          ; FIRST  INNER FEEDFORWARD
asum92    =         adel93-.25*asum91*idense          ; SECOND INNER FEEDFORWARD
aout91    =         asum92-.50*adel81*idense          ; OUTER FEEDFORWARD
adel91    delay     adel81+.50*aout91*idense, .120*idecay ; OUTER FEEDBACK
adel92    delay     adel91+.25*asum91*idense, .076*idecay ; FIRST  INNER FEEDBACK
adel93    delay     asum91+.25*asum92*idense, .030*idecay ; SECOND INNER FEEDBACK

aout      =         .8*aout91+.8*adel61+1.5*adel21 ; COMBINE OUTPUTS

          zaw       aout*kdclick, ioutch

          endin

;----------------------------------------------------------------------------------
; OUTPUT FOR REVERB
          instr     90

idur      =         p3
igain     =         p4
iinch     =         p5

kdclik    linseg    0, .002, igain, idur-.004, igain, .002, 0

ain       zar       iinch
          outs      ain*kdclik, -ain*kdclik  ; INVERTING ONE SIDE MAKES THE SOUND
          endin                             ; SEEM TO COME FROM ALL AROUND YOU.
                                       ; THIS MAY CAUSE SOME PROBLEMS WITH CERTAIN
                                       ; SURROUND SOUND SYSTEMS

;----------------------------------------------------------------------------------
; OUTPUT FOR REVERB
          instr     91

idur      =         p3
igain     =         p4
iinch1    =         p5
iinch2    =         p6

kdclik    linseg    0, .002, igain, idur-.004, igain, .002, 0

ain1      zar       iinch1
ain2      zar       iinch2
          outs      ain1*kdclik, ain2*kdclik

          endin

          instr     99
          zacl      0,10
          endin
          

