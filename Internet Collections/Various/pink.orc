sr		=		44100
kr		=		4410
ksmps	=		10
nchnls	=		2

		instr	1
isc		=		.6	; SCALAR CHOSEN TO MATCH WHITE NOISE AMPLITUDE

ksw		expseg	30, p3, 18000 ; SWEEP FILTER FROM 30HZ TO 18000HZ

a1		init		0
a2		init		0
a3		init		0
a4		init		0
a5		init		0
a6		init		0
anz		trirand	30000				; WHITE NOISE
a1		=		.997 * a1 + isc * .029591 * anz
a2		=		.985 * a2 + isc * .032534 * anz
a3		=		.950 * a3 + isc * .048056 * anz
a4		=		.850 * a4 + isc * .090579 * anz
a5		=		.620 * a5 + isc * .108990 * anz
a6		=		.250 * a6 + isc * .255784 * anz
apnz		=		a1 + a2 + a3 + a4 + a5 + a6
apnz		butterbp	apnz, ksw, ksw * .05	; SWEEP FILTER
apnz		butterlp	apnz, ksw * 1.2		; REMOVE HIGH END WHICH PASSES THRU
		outs		apnz, apnz
		endin


; PINK NOISE INSTRUMENT
		instr	2

idur		=		p3
iamp		=		p4
ifqc		=		cpspch(p5)
ifctab	=		p6
iswrt	=		p7
ifade	=		p8

;krtrmp	expseg	.025, .1*idur, 2, .8*idur, 2, .1*idur, .025
;krtrmp	expseg	.025, idur, 2

kmaxf	expseg	.1, idur, 1

;kfc1	oscili	1, iswrt/idur*krtrmp, ifctab
kfc1		oscili	1, iswrt/idur, ifctab
kfc		=		kfc1*kmaxf*ifqc/440

isc		=		.6	 ; SCALAR CHOSEN TO MATCH WHITE NOISE AMPLITUDE

anz		trirand	iamp*20  ; WHITE NOISE

a1		pareq	anz, 625,	  .7079, .707, 2
a3		pareq	a1,	2500,  .3548, .707, 2
a5		pareq	a3,	10000, .1778, .707, 2
apnz		pareq	a5,	20000, .1259, .707, 2

apnz1	butterbp	apnz, kfc, kfc*.05			; SWEEP FILTER
apnz2	butterbp	apnz, kfc*1.502, kfc*.05		; SWEEP FILTER
apnz3	butterbp	apnz, kfc*1.498, kfc*.05		; SWEEP FILTER

adclk	linseg	0, ifade, 1, idur-2*ifade, 1, ifade, 0

		outs		(apnz1+apnz2)*adclk, (apnz1+apnz3)*adclk

		endin

; NOISE INSTRUMENT
		instr	3

idur		=		p3
iamp		=		p4
ifqc		=		cpspch(p5)
ifade	=		.1

isc		=		.6	 ; SCALAR CHOSEN TO MATCH WHITE NOISE AMPLITUDE

kfqc		expseg	ifqc, idur, 100*ifqc

anz		rand		iamp	  ; WHITE NOISE
kdi		oscili	.1, 4, 1
;anz		diskin	1, .7

a1		pareq	anz, ifqc*(1+kdi),	 .1, 20, 1

adclk	linseg	0, ifade, iamp, idur-2*ifade, iamp, ifade, 0

		outs		a1*adclk/1000, a1*adclk/1000

		endin

; NOISE INSTRUMENT
		instr	4

idur		=		p3
iamp		=		p4
ifqc		=		cpspch(p5)
ires		=		p6
ivol		=		p7
	
isc		=		.6	 	; SCALAR CHOSEN TO MATCH WHITE NOISE AMPLITUDE

kfqc1   	expseg	100*ifqc, idur, ifqc
kfqc2   	expseg	95*ifqc, idur, ifqc*1.05
kfqc3   	expseg	105*ifqc, idur, ifqc*.95

anz	 	rand		iamp	    ; WHITE NOISE
a1	 	pareq	anz, kfqc1, ivol, ires, 1
a2	 	pareq	anz, kfqc2, ivol, ires, 1
a3	 	pareq	anz, kfqc3, ivol, ires, 1

adclk 	expseg	1, .002, iamp, idur-.002, 1

	 	outs		(a1+a2)*adclk/3000, (a1+a3)*adclk/3000

	 	endin

; NOISE DRUM
	  	instr	5

idur	  	=		p3		   ; DURATION
iamp	  	=		p4		   ; AMPLITUDE
ifqc	  	=		cpspch(p5)   ; PITCH
iq	  	=		p6		   ; QUALITY FACTOR
ivol	  	=		p7		   ; VOLUME
iton	  	=		p8		   ; DRUM TONE

kfqcl   	expseg	 .1*ifqc, idur, 2*ifqc  	; LOW SHELF FREQUENCY
kq	   	expseg	 .1*ifqc, idur, 2*ifqc  	; EQ SWEEP QUALITY
kfqch   	expseg	 10*ifqc, idur, .5*ifqc 	; HIGH SHELF FREQUENCY

anz	 	rand		iamp	    				; WHITE NOISE

a1	 	pareq	anz, kfqcl, ivol,	iq, 1 	; LOW SHELF SWEEP
a2	 	pareq	anz, ifqc,  1/ivol, kq, 0 	; EQ SWEEP
a3	 	pareq	anz, kfqch, ivol,	iq, 2 	; HIGH SHELF SWEEP

adclk 	expseg	iamp/10, .002, iamp, idur-.002, iamp/100 ; AMPLITUDE ENVELOPE

aout	 	=		((a2-a3)+(a2-a1)*iton) 	; MIX IT UP TO SOUND NICE

	 	outs		aout*adclk/5000, aout*adclk/5000 ; SCALE, AMP AND OUTPUT

	 	endin

