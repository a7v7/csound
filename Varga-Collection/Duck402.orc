sr	=  44100
kr	=  44100
ksmps	=  1
nchnls	=  2
ga1L	init 0
gad1L	init 0
ga2L	init 0
gad2L	init 0
ga1R	init 0
gad1R	init 0
ga2R	init 0
gad2R	init 0

#define INPUTFILE1 # "infile1.sf" #
#define INPUTFILE2 # "infile2.sf" #

	instr 1

iamp	table	8,64
idel	table	9,64
idel1	table	4,64
ad1L,ad1R	soundin $INPUTFILE1,idel
a1L,a1R	soundin $INPUTFILE1,idel+idel1
gad1L	=  gad1L+ad1L*iamp
ga1L	=  ga1L+a1L*iamp
gad1R	=  gad1R+ad1R*iamp
ga1R	=  ga1R+a1R*iamp

	endin

	instr 2

iamp	table	10,64
idel	table	11,64
idel1	table	4,64
ad2L,ad2R	soundin $INPUTFILE2,idel
a2L,a2R	soundin $INPUTFILE2,idel+idel1
gad2L	=  gad2L+ad2L*iamp
ga2L	=  ga2L+a2L*iamp
gad2R	=  gad2R+ad2R*iamp
ga2R	=  ga2R+a2R*iamp

	endin

	instr 90

iamp	table	0,64	; output gain
imax1	table	1,64	; threshold level (RMS)
icomp1	table	2,64	; compression ratio below thr. level
icomp2	table	3,64	; compression ratio above thr. level
iatt	table	5,64	; RMS envelope attack speed
idec	table	6,64	; RMS envelope decay speed
ifrq1	table	7,64	; lowpass filter freq.
iduck1	table	12,64	; duck level
imin1	table	13,64	; min. thr. level
imin1	=  imin1*32768
imax1	=  imax1*32768
icomp1	=  icomp1-1
icomp2	=  icomp2-1
klvl	init 0
klvlx	init 0

ad1L	=  gad2L
a1L	=  ga2L
ad2L	=  gad1L
a2L	=  ga1L
gad1L	=  0
ga1L	=  0
gad2L	=  0
ga2L	=  0
ad1R	=  gad2R
a1R	=  ga2R
ad2R	=  gad1R
a2R	=  ga1R
gad1R	=  0
ga1R	=  0
gad2R	=  0
ga2R	=  0

atmp	=  (a2L*a2L+a2R*a2R)*iduck1*iduck1*0.5
ktmp	downsamp atmp
atmp	tone atmp,(ktmp>klvlx ? iatt:idec)
atmp	butterlp atmp,ifrq1
klvlx	downsamp atmp
kmax1	=  imax1-sqrt(klvlx<0.25 ? 0.25:klvlx)
kmax1	=  (kmax1<imin1 ? imin1:kmax1)

atmp	=  (a1L*a1L+a1R*a1R)*0.5
ktmp	downsamp atmp
atmp	tone atmp,(ktmp>klvl ? iatt:idec)
atmp	butterlp atmp,ifrq1
klvl	downsamp atmp
ktmp	=  sqrt(klvl<0.25 ? 0.25:klvl)/kmax1
ktmp	=  (ktmp<1 ? exp(log(ktmp)*icomp1):exp(log(ktmp)*icomp2))

	outs (ad1L*ktmp+ad2L)*iamp,(ad1R*ktmp+ad2R)*iamp

	endin

