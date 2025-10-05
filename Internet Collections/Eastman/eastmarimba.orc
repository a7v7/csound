; Eastman Intrument #1
; 1. Instrument marimba:
; CSOUND HEADER
sr		=		44100
kr		=		4410
ksmps	=		10
nchnls	=		1

; Function Needed: 100
; p fields:
; p6 attack time (c..01-.04)
; P7 attack hardness(1.  ord: range.75-1.5)
; p8 brightness (1. ord: range:.25-1.5)
	
		instr 30
p4		=		(p4>0?p4:(abs(p4))/100)	; FOR MICROTONES;-800.050 = QUARTER TONE ABOVE c
i1		=		(p4<13.01? cpspch(p4):p4)
i2		=		octcps(i1)
i99		=		1
p5		=		p5 *i99
p7		=		p7 * i99
p8		=		p8*i99
i3		=		(16.25-i2)*.12			; SCALAR	; ef3 = 96,ef3=1.08,ef5=.84.
i4		=		(i3+1)/2				; SCALAR

p6		=		p6*i3
i5		=		((12.15-i2)*.32*((p7+2)/3))+.12 ; DURATION & AMPLITUDE DEPEND UPON PITCH
p5		=		p5*((p7t1)/2)*(i3<1.?1.:i4)	; & HARDNESS OF ATTACK
i15		=		p7*p8*i3				; SCALAR BASED ON PITCH, ATTACK HARDNESS & BRIGHTNESS

p8		=		(i2<11?p8:p8 - (abs(i2-13)*.1)) ; PROTECTION AGAINST BOMB OUTS
a1		linseg	0,p6/p7,1,((2/(p7+1))*i4*.055)-p6,(3/(p7+2))*i4*.54,.1*i5,.27,.15 *i5,i4*.15,.25*i5,i4*.1,(.5 *i5)-.055,0,i5,0
a2		linseg	1,p3-.025,1,.025,0
a1		=		a2*a1*p5
		timout	(i5 < p3?  i5 : p3),p3, test
		goto		contin
test:	
k2		rms		a1
		if		k2 > 10 kgoto contin
turnoff

; RANDOM AMPLITUDE DEVIATION
contin: 
k1		expseg	p7 *.2,p6,p7 *.09,i2-p6,.06
k1		randi	k1,39/p7
a1		=		a1 + (k1*a1)			; TOTAL AMPLITUDE

;***ATTACK CHIFF***
k2		expseg	p7*p8*i4,((p7+1)/2)*(.77*p6),.002,p3,.001
k2		randi	k2*.5,999				; RANDOM FREQUENCY DEVIATION

k3		expseg	p7*p8 *i3*2.2,p7 *.8*p6,.001,p3,.001 ; ENVELOPE FOR 38 INDEX

; FREQUENCIES AND ENVELOPES OF THE INDIVIDUAL PARTIALS
		if		i2>7.75 igoto treble
; FREQUENCIES OF THE PARTIALS

; 6 PARTIALS FOR LOW TONES (a3 & BELOW)
i6		=		4.03
i7		=		10.1
i8		=		17.9
i9		=		24.2*i1
i10		=		33.5*i1
i11		=		42.9*i1
		if		i2 <6.75 igoto skip
i6		=		i6-((12-6.75)*.02)
i7		=		i7-((12-6.75)*.2)
i8		=		i8-((12-6.75)*1.)
	
skip:
i6		=		i6*i1
i7		=		i7*i1
i8		=		i8*i1
i12		=		1+(.8*(i2-6.75))
i13		=		1+(.33*(i2-6.75))
i14		=		1+(.6*i12)
i15		=		7.85-12

i16		=		.14
i17		=		.18
i18		=		.17
i19		=		.22
i20		=		.06
i21		=		.12
i22		=		 05.
i23		=		.06
i24		=		.02
		igoto	doit
; - - - MIDRANGE : 4 PARTIALS FOR TONES BETWEEN bf3 AND a5
treble: 
		if		i2 > 9.75 igoto veryhi
		if		i2> 8.75 goto higher
i6		=		(4.01+(.03*(i2-7.75)))*i1 ; PARTIAL FREQUENCIES FOR a3-a4
i7		=		(10. - (.9*(i2-7.75)))*i1
i8		=		(16.9-(3.*(i2-7.75)))*i1
i12		=		1+((i2-7.75)*.2)
i13		=		1-((i2-7.75)*.12)
		igoto	skip2
higher: 
i6		=		(4.04-(.74*(i2-8.75 )))*i1 ; PARTIAL FREQUENCIES FOR a4-a5
i7		=		(9.1-(2.7*(i2-8.75)))*i1
i8		=		(13.9-(2.8*(i2-8.75)))*i1
i12		=		1+((9.75-i2)*.2)
i13		=		.9
skip2:
i16		=		.15
i17		=		.13
i18		=		.13
i19		=		.09
i20		=		.07
i21		=		.04
		igoto	doit
; - - - - 3 PARTIALS FOR HIGHEST TONES (bfs AND ABOVE)
veryhi:								
i6		=		(3.3-((i2-9.75)*.3))*i1
i6		=		(i6<sr/2?i6:.75*(sr/2))	; FOLDOVER PROTECTION
i7		=		(6.4-((i2-9.75 )*.7))*i1
i7		= 		(i7<sr/2?i7:.85*(sr*2))	; FOLDOVER PROTECTION
i12		=		1
i13		=		1
il6		=		.14
i17		=		.14
i18		=		.11
i9		=		.09
 
doit:
a2		expseg	p8*i16,i3*i17*i5,p8*.005
a2		=		i12*a2*a1
a1		=		a1-a2
a2		oscili	a2,i6+(k2*i6),100,.05	; partial 2

a3		expseg	p8*i8,i5*i3*i19,p8*.004
a3		=		i13*a3*a1
a1		=		a1-a3
a3		oscili	a3,i7+(k2*i7),100,.11	; partial 3
a2		=		a2+a3
		if		i2 >9.75 kgoto fos
a3		expseg	i15*i20,i5*i15*i21,p8*.004
a3		=		i14*a3*a1
a1		=		a1-a3
a3		oscili	a3,i8+(k2*i8),100,.15	;partial4
a2		=		a2+a3
		if		i2 > 7.75 kgoto fos
a3		expseg	i15*i22,i5*i15*i23,p8*.003
a3		=		i15*a3*a1
a1		=		a1-a3
a3		oscili	a3,i9+(k2*i9),100,.21  ;partial 5
a2		=		a2+a3
		if		i2 > 7.5 kgoto fos
a4		expseg	i15 *i24,i5*i15*i24,p8*.003
a4		=		i15*a4*a1
al		=		a1-a4
a4		oscili	a4,i10+(k2*i10),100,.24 ;partial 6
a2		=		a2+a4

fos:
a1		foscili	al,i1+(k2*i1),1,((p7+i4)/2)*1.2,p7*p8*i3 *k3,100
a1		=		a1+a2


; STANDARD OUT STATEMENT
		out		a1
		endin
