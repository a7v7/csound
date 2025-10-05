; ORCHESTRA
;----------------------------------------------------------------
; Biquadratic Equalizer Filters
; Coded by Hans Mikelson November 1998
;----------------------------------------------------------------
sr		=		44100
kr		=		4410
ksmps	=		10
nchnls	=		2

;----------------------------------------------------------------
; Low Shelf by Chris Townsend converted to Csound by Hans Mikelson
;----------------------------------------------------------------
		instr 11

ifc	 	=	    	p4					; CENTER / SHELF
iq	   	=	    	p5					; QUALITY FACTOR SQRT(.5) IS NO RESONANCE
igain   	=	    	p6					; GAIN/CUT IN dB
i2pi	   	=	    	2*3.14159265

iomega0 	=	    	i2pi*ifc/sr
ik	   	=	    	tan(iomega0/2)
iv	   	=	    	ampdb(igain)			; CONVERT dB TO AMPLITUDE
	
kb0	   	=	    	1+sqrt(2*iv)*ik+iv*ik*ik	; COMPUTE THE COEFFICIENTS
kb1	   	=	    	2*(iv*ik*ik-1)
kb2	   	=	    	1-sqrt(2*iv)*ik+iv*ik*ik
ka0	   	=	    	1+ik/iq+ik*ik
ka1	   	=	    	2*(ik*ik-1)
ka2	   	=		1-ik/iq+ik*ik

asig	   	rand  	5000					; RANDOM NUMBER SOURCE FOR TESTING

aout	   	biquad 	asig, kb0, kb1, kb2, ka0, ka1, ka2	 ; BIQUAD FILTER

	   	outs		aout, aout			; OUTPUT THE RESULTS

		endin

;----------------------------------------------------------------
; High Shelf by Hans Mikelson derived from low shelf by Chris Townsend
;----------------------------------------------------------------
		instr 12

ifc		=	    	p4					; CENTER / SHELF
iq	   	=	    	p5					; QUALITY FACTOR SQRT(.5) IS NO RESONANCE
igain   	=	    	p6					; GAIN/CUT IN dB
ipi	   	=	    	3.14159265
i2pi	   	=	    	2*ipi
	
iomega0 	=	    	i2pi*ifc/sr
ik	   	=	    	tan((ipi-iomega0)/2)
iv	   	=	    	ampdb(igain)			; CONVERT dB TO AMPLITUDE

kb0	   	=	    	1+sqrt(2*iv)*ik+iv*ik*ik	; COMPUTE THE COEFFICIENTS
kb1	   	=	   	-2*(iv*ik*ik-1)
kb2	   	=	    	1-sqrt(2*iv)*ik+iv*ik*ik
ka0	   	=	    	1+ik/iq+ik*ik
ka1	   	=	   	-2*(ik*ik-1)
ka2	   	=	    	1-ik/iq+ik*ik

asig	   	rand  	5000					; RANDOM NUMBER SOURCE FOR TESTING
	
aout	   	biquad 	asig, kb0, kb1, kb2, ka0, ka1, ka2	 ; BIQUAD FILTER

	   	outs		aout, aout			; OUTPUT THE RESULTS

endin

;----------------------------------------------------------------
; Peaking EQ by Chris Townsend converted to Csound by Hans Mikelson
;----------------------------------------------------------------
	   	instr 13

ifc	   	=	    	p4					; CENTER / SHELF
iq	   	=	    	p5					; QUALITY FACTOR
igain   	=	    	p6					; GAIN/CUT IN dB
ipi	   	=	    	3.14159265
i2pi	   	=	    	2*ipi

iomega0 	=	    	i2pi*ifc/sr
ik	   	=	    	tan(iomega0/2)
iv	   	=		ampdb(igain)			; CONVERT dB TO AMPLITUDE

kb0	   	=	    1+iv*ik/iq+ik*ik		; COMPUTE THE COEFFICIENTS
kb1	   	=	    2*(ik*ik-1)
kb2	   	=	    1-iv*ik/iq+ik*ik
ka0	   	=	    1+ik/iq+ik*ik
ka1	   	=	    2*(ik*ik-1)
ka2	   	=	    1-ik/iq+ik*ik

asig	   	rand  	5000					; RANDOM NUMBER SOURCE FOR TESTING
	
aout	   	biquad 	asig, kb0, kb1, kb2, ka0, ka1, ka2	 ; BIQUAD FILTER

	   	outs		aout, aout			; OUTPUT THE RESULTS

		endin
