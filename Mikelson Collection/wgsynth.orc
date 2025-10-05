;----------------------------------------------------------------------------------
; WGSYNTH BY HANS MIKELSON 1998
;----------------------------------------------------------------------------------
; THIS WAVE GUIDE SYNTHESIS INSTRUMENT SOUNDS SOMEWHAT LIKE A BOWED STRING UNDER
; CERTAIN CONDITIONS.  IT CONSISTS OF A TWO DELAY LINES WHOSE OUTPUTS ARE FILTERED
; , COMPRESSED AND THEN FEDBACK INTO THE DELAY LINES.  THE FILTERED OUTPUT IS ALSO
; INVERTED AND CROSS FEDBACK INTO THE OTHER DELAY LINE.
;----------------------------------------------------------------------------------

sr		=		44100
kr		=		22050
ksmps	=		2
nchnls	=		2
		zakinit 	30,30

       	instr  10

idur    	=        	p3                      							; Duration
iamp    	=        	p4                      							; Amplitude
itim1   	=        	1000/cpspch(p9)*(1+p12) 							; Time of primary waveguide delay
itim2   	=        	itim1*p10               							; Time of secondary waveguide delay
iacct   	=        	itim1*p6/4              							; Accent peak
ifco1   	=        	p7/itim1*15000          							; Cut off frequency is based on pitch & modifier
ifco2   	=        	ifco1*p8                							; Fco2 is based on Fco1 & modifier
ifdbk   	=        	(1+p5/sqrt(itim1))/2    							; Lower notes get more feedback sqrt(frequency)
ipan    	=        	p11                     							; Pan 0=left, .5=center, 1=right
idec    	=        	p13*sqrt(itim1)         							; Decay rate lower notes get longer decay to start
                                         							; the waveguide oscillating sooner.
itabc   	=        	5                       							; Compressor table

aflt1   	init     	0                       							; Used for feedback so they need to be inited here
aflt2   	init     	0

kamp    	linseg   	0, .005, iamp, idur-.015, iamp, .01, 0                         	; Declick envelope
kfdbk 	linseg   	ifdbk, .02, iacct*ifdbk, idec+.005, ifdbk, idur-.025-idec, ifdbk 	; Feedback accent envelope
kampr   	oscili   	1, cpspch(p9)/2.01, 2                  						; Pulses of noise are used to stimulate
asig    	rand     	2000*kampr                             						; The wave guide
kfco1   	linseg   	ifco1, .05, ifco1*1.2, .1, ifco1*.8, p3-.15, ifco1*.4  			; A frequency accent envelope

kramp2  	linseg   	0, .1, 0, .1, 1, idur-.2, 1  							; Fade in the vibrato
klfo2   	oscili  	kramp2, 1.5, 1               							; LFO2 adds some complexity to the vibrato rate
klfo1   	oscili   	.004*kramp2, 6+klfo2, 1      							; LFO1 is for the vibrato

ktim1    	=       	itim1*(1+klfo1)             							; Generate delay times
ktim2    	=       	itim2*(1+klfo1)    

; COMPRESSORS
karms1   	rms      	aflt1                      							; Find rms level
kampn1   	=        	karms1/60000               							; Normalize rms level 0-1.
kcomp1   	tablei   	kampn1,itabc,1,0           							; Look up compression value in table

karms2   	rms      	aflt2                      							; Find rms level
kampn2   	=        	karms2/60000               							; Normalize rms level 0-1.
kcomp2   	tablei   	kampn2,itabc,1,0           							; Look up compression value in table

; VARIABLE DELAY WAVEGUIDES
adel1   	vdelay    asig+kfdbk*aflt1*kcomp1-kfdbk*aflt2*kcomp2, ktim1, itim1*2 	; Loop 1
adel2   	vdelay    asig-kfdbk*aflt1*kcomp1+kfdbk*aflt2*kcomp2, ktim2, itim2*2 	; Loop 2

aflt1   	butterlp 	adel1, kfco1                							; Filter before feeding back
aflt2   	butterlp 	adel2, ifco2

aout    	butterhp 	aflt1/8, 40                 						; Take off the DC offset  I have seen noise related
                                             						; to this opcode on an SGI

        	outs     	aout*sqrt(ipan)*kamp, aout*sqrt(1-ipan)*kamp  		; Pan, Declick and output

        	endin
        
