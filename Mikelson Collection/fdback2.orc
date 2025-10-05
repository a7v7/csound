;===========================================================================
; A MULTI-EFFECTS SYSTEM BY HANS MIKELSON
;===========================================================================

sr		=		44100
kr		=		22050
ksmps	=		2
nchnls	=		2

		zakinit 	30, 30

;---------------------------------------------------------------------------
; NOISE
;---------------------------------------------------------------------------
		instr 4

iamp  	init 	p4
izout 	init 	p5
kamp  	linseg 	0, .002, p4, p3-.004, p4, .002, 0

arnd1  	rand		kamp						    ;RANDOM GENERATOR
afilt  	tone		arnd1, 1000				    ;LOW PASS FILTER
	  	zawm		afilt, izout				    ;MIX TO ZAK CHANNEL

		endin


;---------------------------------------------------------------------------
; FEEDBACK GENERATOR
;---------------------------------------------------------------------------
	    	instr	  14

igaini   	=	  	p4		   ; PRE GAIN
igainf   	=	  	p5		   ; POST GAIN
iduty    	=	  	p6		   ; DUTY CYCLE SHIFT
itabd    	=	  	p7		   ; DISTORTION TABLE
iresfqc  	=	  	p8		   ; RESONANCE FREQUENCY
ideltim  	=	  	p9		   ; FEEDBACK DELAY TIME
ifeedbk  	=	  	p10	   	   ; FEEDBACK GAIN
itabc    	=	  	p11	   	   ; LIMITER TABLE
izin	    	=	  	p12	   	   ; INPUT CHANNEL
izout    	=	  	p13	   	   ; OUTPUT CHANNEL

asign    	init	  	0		   ; INITIALIZE LAST VALUE

kdclick  	linseg   	0, .1, 1, p3-.3, 1, .2, 0		; RAMP FEEDBACK IN AND OUT
kamp	    	linseg   	0, .002, 1, p3-.004, 1, .002, 0	; DECLICK

asig	    	zar	   	izin						 	; READ INPUT CHANNEL

afdbk    	=	   	asig/100					 	; REDUCE ORIGINAL SIGNAL
adel1    	delayr   	ideltim					 	; FEED BACK DELAY
afilt    	butterbp 	adel1, iresfqc, iresfqc/4		; FILTER THE DELAYED SIGNAL
kamprms  	rms	   	afilt						; FIND RMS LEVEL
kampn    	=	   	kamprms/30000					; NORMALIZE RMS LEVEL 0-1.
kcomp    	tablei   	kampn,itabc,1,0		 		; LOOK UP COMPRESSION VALUE IN TABLE
	    	delayw   	afdbk+kcomp*ifeedbk*afilt		; ADD LIMITED FEEDBACK

	    	zaw	  	adel1, izout				   	; WRITE TO THE OUTPUT CHANNELS

	    	endin

;---------------------------------------------------------------------------
; MIXER SECTION
;---------------------------------------------------------------------------
		instr 100

asig1	zar	 	p4			 ; READ INPUT CHANNEL 1
igl1		init	 	p5*p6		 ; LEFT GAIN
igr1		init	 	p5*(1-p6)	 	 ; RIGHT GAIN

asig2	zar	 	p7			 ; READ INPUT CHANNEL 2
igl2		init	 	p8*p9		 ; LEFT GAIN
igr2		init	 	p8*(1-p9)	 	 ; RIGHT GAIN

kdclick	linseg  	0, .001, 1, p3-.002, 1, .001, 0	 ; DECLICK

asigl	=	 	asig1*igl1 + asig2*igl2	 		 ; SCALE AND SUM
asigr	=	 	asig1*igr1 + asig2*igr2

		outs	 	kdclick*asigl, kdclick*asigr	  	 ; OUTPUT STEREO PAIR

		endin

;---------------------------------------------------------------------------
; CLEAR AUDIO & CONTROL CHANNELS
;---------------------------------------------------------------------------
		instr 110

		zacl	 	0, 30		 ; CLEAR AUDIO CHANNELS 0 TO 30
		zkcl	 	0, 30		 ; CLEAR CONTROL CHANNELS 0 TO 30

		endin
