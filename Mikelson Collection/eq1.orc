;----------------------------------------------------------------
; BIQUADRATIC EQUALIZER FILTER
; CODED BY HANS MIKELSON NOVEMBER 1998
;----------------------------------------------------------------
sr		=		44100
kr		=		4410
ksmps	=		10
nchnls	=		2

;----------------------------------------------------------------
; PARAMETRIC EQUALIZER OPCODE
;----------------------------------------------------------------
	   	instr 15
									
ifc	   	=	    	p4		    			; CENTER / SHELF
iq	   	=	    	p5		    			; QUALITY FACTOR SQRT(.5) IS MAXIMUM SLOPE WITH NO RESONANCE PEAK FOR SHELF
iv	   	=	    	ampdb(p6)	    			; GAIN/CUT IN dB
imode   	=	    	p7

kfc	   	linseg	ifc*2, p3, ifc/2

asig	   	rand  	5000				    	; RANDOM NUMBER SOURCE FOR TESTING

aout	   	pareq 	asig, kfc, iv, iq, imode
	   	outs  	aout, aout			; OUTPUT THE RESULTS

		endin
