; ORCHESTRA
;----------------------------------------------------------------
; Biquadratic Equalizer Filter
; Coded by Hans Mikelson November 1998
; based on the following paper:
; The Equivalence of Various Methods of Computing Biquad Coefficients for
; Audio Parametric Equalizers by Robert Bristow-Johnson
; http://www.harmony-central.com/Effects/Articles/EQ_Coefficients/
;----------------------------------------------------------------
sr		=		44100
kr		=		4410
ksmps	=		10
nchnls	=		2

;----------------------------------------------------------------
; 1 BAND PARAMETRIC EQUALIZER
;----------------------------------------------------------------
		instr 1

ifc		=		p4					; CENTER FREQUENCY
ibw		=		p5					; BAND WIDTH IN OCTAVES
igain	=		p6					; GAIN/CUT IN dB

iomega0 =		2*taninv(ifc*6.5/2/sr) ; I SEEM TO HAVE TO MULTIPLY BY 6.5 TO GET Fc CORRECT?
igamma	=		sinh(log(2)/2*ibw*iomega0/sin(iomega0))*sin(iomega0) ; GAMMA AS DEFINED IN THE PAPER
ik		=		ampdb(igain)		; CONVERT dB TO AMPLITUDE

igrtk	=		igamma*sqrt(ik)		; CALCULATE IN ADVANCE
igortk	=		igamma/sqrt(ik)		; TO SAVE TIME

kb0		=		1+igrtk				; COMPUTE THE COEFFICIENTS
kb1		=		-2*cos(iomega0)
kb2		=		1-igrtk
ka0		=		1+igortk
ka1		=		kb1
ka2		=		1-igortk

asig	rand	10000				; RANDOM NUMBER SOURCE FOR TESTING

aout	biquad	asig, kb0, kb1, kb2, ka0, ka1, ka2 ; BIQUAD FILTER

		outs	aout, aout			; OUTPUT THE RESULTS

		endin
