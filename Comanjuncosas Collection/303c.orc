sr        =         44100
kr        =         4410
ksmps     =         10
nchnls    =         1

		instr 1 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Roland TB-303 bassline emulator
; coded by Josep Mª Comajuncosas , Sept - Nov 1997
; send your comments (and money ;-)) to
; gelida@lix.intercom.es 
; (from January´98 to gelida@intercom.es)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; INITIAL SETTINGS; CONTROL THE OVERALL CHARACTER OF THE SOUND
imaxfreq	=		1000					; MAX.FILTER CUTOFF FREQ. WHEN ienvmod = 0
imaxsweep	=		10000				; sr/2... MAX.FILTER FREQ. AT kenvmod & kaccent= 1
ireson	=		1					; SCALE THE RESONANCE AS YOU LIKE (YOU CAN MAKE THE FILTER TO OSCILLATE...)

; INIT VARIABLES; DON´T TOUCH THIS!
itranspose =		p15					; 1 RAISE THE WHOLE SEQ. 1 OCTAVE, ETC.
iseqfn	=		p16
iaccfn	=		p17
idurfn	=		p18
imaxamp	=		p19					; MAXIMUM AMPLITUDE. MAX 32768 FOR 16 BIT OUTPUT
ibpm		=		p14					; 4/4 BARS PER MINUTE (OR BEATS?)
inotedur	=		15/ibpm
icount	init		0					; SEQUENCE COUNTER (FOR NOTES)
icount2	init		0					; ID. FOR DURATIONS
ipcount2	init		0
idecaydur	=		inotedur
imindecay	=		(idecaydur<.2 ? .2 : idecaydur) ; SET MINIMUM DECAY TO .2 OR inotedur
ipitch	table	0,iseqfn				; FIRST NOTE IN THE SEQUENCE
ipitch	=		cpspch(itranspose + 6 + ipitch/100)
kaccurve	init		0

; TWISTING THE KNOBS FROM THE SCORE
kfco		line		p4, p3, p5
kres		line		p6, p3, p7
kenvmod	line		p8, p3, p9
kdecay	line		p10, p3, p11
kaccent	line		p12, p3, p13

start:
; PITCH & PORTAMENTO FROM THE SEQUENCE
ippitch	=		ipitch
ipitch	table	ftlen(iseqfn)*frac(icount/ftlen(iseqfn)),iseqfn
ipitch	=		cpspch(itranspose + 6 + ipitch/100)

		if		ipcount2 != icount2 goto noslide
kpitch	linseg	ippitch, .06, ipitch, inotedur-.06, ipitch
		goto		next

noslide:
kpitch	=		ipitch

next:
ipcount2	=		icount2
		timout	0,inotedur,contin
icount	=		icount + 1
		reinit	start
		rireturn

contin:
; ACCENT DETECTOR
iacc		table	ftlen(iaccfn)*frac((icount-1)/ftlen(iaccfn)), iaccfn
		if		iacc == 0 goto noaccent
ienvdecay	=		0					; ACCENTED NOTES ARE THE SHORTEST ONES
iremacc	=		i(kaccurve)
kaccurve	oscil1i	0, 1, .4, 3
kaccurve	=		kaccurve+iremacc		; SUCCESSIVE ACCENTS CAUSE HYSTERICAL RAISING CUTOFF

		goto		sequencer

noaccent:
kaccurve	=		0					; NO ACCENT & "DISCHARGES" ACCENT CURVE
ienvdecay	=		i(kdecay)

sequencer:
aremovedc	init		0					; SET FEEDBACK TO 0 AT EVERY EVENT
imult	table	ftlen(idurfn)*frac(icount2/ftlen(idurfn)),idurfn
		if		imult != 0 goto noproblemo ; COMPENSATE FOR ZERO PADDING IN THE SEQUENCER
icount2	=		icount2 + 1
		goto		sequencer

noproblemo:
ieventdur	=		inotedur*imult

; TWO ENVELOPES
kmeg		expseg	1, imindecay+((ieventdur-imindecay)*ienvdecay), ienvdecay+.000001
kveg		linen	1, .01, ieventdur, .016	; ATTACK SHOULD BE 4 ms. BUT THERE WOULD BE CLICKS... 

; AMPLITUDE ENVELOPE
kamp		=		kveg*((1-i(kenvmod)) + kmeg*i(kenvmod)*(.5+.5*iacc*kaccent))

; FILTER ENVELOPE
ksweep	=		kveg * (imaxfreq + (.75*kmeg+.25*kaccurve*kaccent)*kenvmod*(imaxsweep-imaxfreq))
kfco		=		20 + kfco * ksweep		; CUTOFF ALWAYS GREATER THAN 20 Hz ...
kfco		=		(kfco > sr/2 ? sr/2 : kfco) ; COULD BE NECESSARY

		timout	0, ieventdur, out
icount2	=		icount2 + 1
		reinit	contin

out:
; GENERATE BANDLIMITED SAWTOOTH WAVE
abuzz	buzz		kamp, kpitch, sr/(2*kpitch), 1 ,0 ; BANDLIMITED PULSE
asaw		integ	abuzz,0
asawdc	atone	asaw,1

; RESONANT 4-POLE LPF
ainpt	=		asawdc - aremovedc*kres*ireson
alpf		tone		ainpt,kfco
alpf		tone		alpf,kfco
alpf		tone		alpf,kfco
alpf		tone		alpf,kfco

		aout		balance alpf,asawdc

; FINAL OUTPUT ... AT LAST!
aremovedc	atone	aout,10
		out		imaxamp*aremovedc
		endin

