
;-------------------------------------------------------------
; Physical Models
; coded:		 1/22/97 Hans Mikelson
;-------------------------------------------------------------
sr		=		44100
kr		=		4410
ksmps	=		10
nchnls	=		1

;-------------------------------------------------------------
; CLARINET INSTRUMENT BASED ON PERRY COOK'S CLARINET
;-------------------------------------------------------------
						
		instr 4
areedbell init		0
ifqc		=		cpspch(p5)
ifco		=		p7
ibore	=		1/ifqc-15/sr

kenv1	linseg	0, .005, .55+.3*p6, p3-.015, .55+.3*p6, .01, 0
kenvibr	linseg	0, .1, 0, .9, 1, p3-1, 1 ; VIBRATO ENVELOPE
									
kemboff	=		p8					; CAN BE USED TO ADJUST REED STIFFNESS.

avibr	oscil	.1*kenvibr, 5, 3		; BREATH PRESSURE.
apressm	=		kenv1+avibr

arefilt	tone		areedbell, ifco		; REFLECTION FILTER FROM THE BELL IS LOWPASS.

abellreed delay	arefilt, ibore			; THE DELAY FROM BELL TO REED.

; BACK PRESSURE AND REED TABLE LOOK UP.

asum2	=		-apressm-.95*arefilt-kemboff
areedtab	tablei	asum2/4+.34, p9, 1, .5
amult1	=		asum2*areedtab

; FORWARD PRESSURE

asum1	=		apressm+amult1
areedbell delay	asum1, ibore
aofilt	atone	areedbell, ifco
		out	     aofilt*p4
		endin
