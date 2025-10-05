sr	=  44100
kr	=  44100
ksmps	=  1
nchnls	=  2

#define INPUTFILE # "infile.sf" #

	instr 1

iamp	table	0,64	; output gain
imax1	table	1,64	; threshold level (RMS)
icomp1	table	2,64	; compression ratio below thr. level
icomp2	table	3,64	; compression ratio above thr. level
idel1	table	4,64	; delay time in sec.
iatt	table	5,64	; RMS envelope attack speed
idec	table	6,64	; RMS envelope decay speed
ifrq1	table	7,64	; lowpass filter freq.
imax1	=  imax1*32768
icomp1	=  icomp1-1
icomp2	=  icomp2-1
klvl	init 0

ad1,ad2	soundin $INPUTFILE		; sound input
a1,a2	soundin $INPUTFILE,idel1

atmp	=  (a1*a1+a2*a2)*0.5
ktmp	downsamp atmp
atmp	tone atmp,(ktmp>klvl ? iatt:idec)
atmp	butterlp atmp,ifrq1
klvl	downsamp atmp
ktmp	=  sqrt(klvl<0.25 ? 0.25:klvl)/imax1
ktmp	=  (ktmp<1 ? exp(log(ktmp)*icomp1):exp(log(ktmp)*icomp2))

	outs ad1*iamp*ktmp,ad2*iamp*ktmp

	endin

