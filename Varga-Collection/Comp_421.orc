sr	=  44100
kr	=  44100
ksmps	=  1
nchnls	=  1

#define INPUTFILE # "infile.sf" #

	instr 1

iamp	table	0,64	; output gain
iHPf	table	1,64	; min. frequency
iLPf	table	2,64	; max. frequency
imax1	table	3,64	; threshold level (RMS)
iampx	table	4,64	; compressed band gain
icomp1	table	5,64	; compression ratio below thr. level
icomp2	table	6,64	; compression ratio above thr. level
idel1	table	7,64	; time diff. between envelope and audio signal (sec.)
iatt	table	8,64	; RMS envelope attack speed
idec	table	9,64	; RMS envelope decay speed
ifrq1	table	10,64	; envelope lowpass filter frequency (Hz)
imax1	=  imax1*32768
icomp1	=  icomp1-1
icomp2	=  icomp2-1
klvl	init 0

ad1x	soundin $INPUTFILE		; sound input
ad1	butterhp ad1x,iHPf
ad1	butterlp ad1,iLPf
ad1x	=  ad1x-ad1
a1x	soundin $INPUTFILE,idel1
a1	butterhp a1x,iHPf
a1	butterlp a1,iLPf

atmp	=  a1*a1
ktmp	downsamp atmp
atmp	tone atmp,(ktmp>klvl ? iatt:idec)
atmp	butterlp atmp,ifrq1
klvl	downsamp atmp
ktmp	=  sqrt(klvl<0.25 ? 0.25:klvl)/imax1
ktmp	=  (ktmp<1 ? exp(log(ktmp)*icomp1):exp(log(ktmp)*icomp2))

	out (ktmp*iampx*ad1+ad1x)*iamp

	endin

