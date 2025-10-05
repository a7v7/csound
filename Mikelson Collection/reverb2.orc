; 1. NOISE CLICK
; 2. DISK INPUT

sr		=		44100
kr		=		22050
ksmps	=		2
nchnls	=		2
zakinit 	30,30

;----------------------------------------------------------------------------------
; NOISE CLICK FOR TESTING THE DECAY CURVE OF THE REVERB.
	  	instr  1

idur	  	=	    	p3
iamp	  	=	  	p4
ioutch 	=	   	p5
ifco	  	=	    	p6

kamp	  	linseg 	0, .002, iamp, .002, 0, idur-.004, 0
aout	  	rand   	kamp

afilt  	butterlp 	aout, ifco
	  	zaw    	afilt, ioutch
	  	outs   	aout, aout

	  	endin

;---------------------------------------------------------------------
; DISK INPUT
	  	instr  2

iamp	  	=	    	p4
irate  	=	    	p5
isndin 	=	    	p6
ioutch 	=	    	p7

ain	  	diskin	isndin, irate
	  	zaw		ain*iamp, ioutch
	  	outs		ain*iamp, ain*iamp

	  	endin

;---------------------------------------------------------------------
; REVERB
	    	instr	10

idur	    	=	 	p3
irevtime 	=	 	p4
igain    	=	 	p5
iinch    	=	 	p6
ioutch   	=	 	p7

ain	    	zar	 	iinch		 ; READ THE CHANNEL
aout	    	reverb 	ain, irevtime	 ; DELAY FOR TIME
	    	outs	 	aout, -aout	 ; 

	    	endin

